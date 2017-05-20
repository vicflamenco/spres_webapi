using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Infrastructure.Security;
using Spres.Models;
using SpresDev.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class PermissionsController : ApiController
    {

        public static string GetPermissionsTypes(int id, int language) // 0 ingles, 1 español
        {
            var names = Enum.GetNames(typeof(Options));
            var types = names.Select(n => new { Id = Array.IndexOf(names, n) + 1, Name = n }).Where(n => n.Id == id).FirstOrDefault();
            return (language == 0) ? types.Name : translateOption(types.Name);
        }


        [Route("api/Permissions/GetByRole/{roleId}")]
        [SpresSecurityAttribute("Security", true, false)]
        public IHttpActionResult GetAllPermissions(string roleId)
        {
            return Ok(GetRolePermissions(roleId));
        }

        private List<Object> GetRolePermissions(string roleId)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var permissions = dbContext.Permissions.ToList();
                    return permissions.Where(p => p.RolId == roleId).Select(p => new
                    {
                        RolId = p.RolId,
                        OptionId = p.Option,
                        Option = GetPermissionsTypes(p.Option, 0),
                        Display = GetPermissionsTypes(p.Option, 1),
                        View = p.View,
                        Edit = p.Edit,
                        AllCostCenters = p.AllCostCenters
                    }).ToList<Object>();
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return new List<Object>();
                }
            }
        }

        public static List<Permissions> GetCombinedPermissions(string username)
        {
            using (var identityContext = new SpresIdentityDbContext())
            using (var db = new SpresContext())
            {
                var userManager = identityContext.UserManager;
                var rolesManager = identityContext.RoleManager;
                var userId = userManager.FindByName(username).Id;
                var userRoles = userManager.GetRoles(userId);

                Permissions combinedPeopleBudgetingPermissions = new Permissions()
                {
                    AllCostCenters = false,
                    Edit = false,
                    View = false
                };

                Permissions combinedBudgetingPermissions = new Permissions()
                {
                    AllCostCenters = false,
                    Edit = false,
                    View = false
                };

                foreach (var role in userRoles)
                {
                    var roleItem = rolesManager.FindByName(role);
                    var permissions = db.Permissions.Where(p => p.RolId == roleItem.Id);

                    var peopleBudgetingPermission = permissions.Where(p => p.Option.Equals(8)).FirstOrDefault();
                    var budgetingPermission = permissions.Where(p => p.Option.Equals(1)).FirstOrDefault();

                    combinedPeopleBudgetingPermissions.View |= peopleBudgetingPermission.View;
                    combinedBudgetingPermissions.View |= budgetingPermission.View;

                    combinedPeopleBudgetingPermissions.Edit |= peopleBudgetingPermission.Edit;
                    combinedBudgetingPermissions.Edit |= budgetingPermission.Edit;

                    combinedPeopleBudgetingPermissions.AllCostCenters |= peopleBudgetingPermission.AllCostCenters;
                    combinedBudgetingPermissions.AllCostCenters |= budgetingPermission.AllCostCenters;
                }
                return new List<Permissions>() { combinedBudgetingPermissions, combinedPeopleBudgetingPermissions };
            }
        }

        public static bool HasAllCostCentersPermission(User user)
        {
            using (var db = new SpresContext())
            {
                foreach (var role in user.Roles.ToList())
                {
                    foreach (var option in db.Permissions.Where(p => p.RolId == role.RoleId).ToList())
                    {
                        if (option.AllCostCenters)
                        {
                            return true;
                        }
                    }
                }
                return false;
            }
        }

        public IHttpActionResult GetUserPermissions()
        {
            using (var identityContext = new SpresIdentityDbContext())
            using (var db = new SpresContext())
            {
                try
                {
                    var combinedPermissions = new List<PermissionViewModel>();
                    for (int i = 1; i <= 8; i++)
                    {
                        combinedPermissions.Add(new PermissionViewModel(i));
                    }
                    var userId = User.Identity.GetUserId();
                    var userRoles = identityContext.UserManager.GetRoles(userId).ToList();

                    foreach (var userRole in userRoles)
                    {
                        var roleItem = identityContext.RoleManager.FindByName(userRole);
                        var rolePermissions = db.Permissions.Where(p => p.RolId == roleItem.Id).ToList();

                        foreach (var rolePermission in rolePermissions)
                        {
                            var combinedPermission = combinedPermissions.FirstOrDefault(cp => cp.OptionId == rolePermission.Option);

                            if (combinedPermission != null)
                            {
                                combinedPermission.View |= rolePermission.View;
                                combinedPermission.Edit |= rolePermission.Edit;
                                combinedPermission.AllCostCenters |= rolePermission.AllCostCenters;
                            }
                        }
                    }
                    if (combinedPermissions.Any(cp => cp.AllCostCenters))
                    {
                        foreach (var combinedPermission in combinedPermissions)
                        {
                            combinedPermission.AllCostCenters = true;
                        }
                    }
                    return Ok(combinedPermissions.ToDataResult());
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }
        
        public static string translateOption(string option) {
            switch (option)
            {
                case "Budgeting": return "Presupuestación";
                case "Reporting": return "Reportes";
                case "Consolidate": return "Consolidado";
                case "Authorization": return "Autorización";
                case "Catalogs": return "Catálogos";
                case "Configuration": return "Configuración";
                case "Security": return "Seguridad";
                case "PeopleBudgeting": return "Presupuestación Gente";
                default: return string.Empty;
            }
        }

        [SpresSecurityAttribute("Security", false, true)]
        public IHttpActionResult PutPermission(Permissions permissions)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                using (SpresIdentityDbContext db = new SpresIdentityDbContext())
                {
                try
                {
                        var rolName = db.RoleManager.FindById(permissions.RolId);
                        
                        dbContext.Entry(permissions).State = EntityState.Modified;
                        dbContext.SaveChanges();
                        this.RegisterEvent("Se modificaron los permisos del rol  " + rolName.Name);
                        return Ok(new Permissions
                        {
                        RolId = permissions.RolId,
                        Option = permissions.Option,
                        View = permissions.View,
                        Edit = permissions.Edit,
                        AllCostCenters = permissions.AllCostCenters
                    });
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }
        }

    }
}
