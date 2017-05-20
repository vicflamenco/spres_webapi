using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Infrastructure.Security;
using Spres.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;


namespace SpresDev.Controllers.Api
{
    public class RolesController : ApiController
    {

        [SpresSecurityAttribute("Security", true, false)]
        public IHttpActionResult GetAllRoles()
        {
            try
            {
                return Ok(SecurityManager.GetRoles()
                    .Select(e => new Role { Id = e.Id, Name = e.Name })
                    .ToDataResult());
            }
            catch (Exception ex)
            {
                ErrorLog.SaveError(ex);
                return InternalServerError(ex);
            }
        }

        [SpresSecurityAttribute("Security", true, false)]
        public IHttpActionResult GetRolById(int id)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var equipment = dbContext.Equipments.Find(id);
                    if (equipment == null)
                        return NotFound();
                    return Ok(equipment);
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Security", false, true)]
        public IHttpActionResult PostRole(Role role)
        {
            using (var context = new SpresIdentityDbContext())
            {
                try
                {
                    var RoleManager = new RoleManager<Role>(new RoleStore<Role>(context));
                    IdentityResult roleResult;
                    
                    Role newRole = null;
                    
                    if (!RoleManager.RoleExists(role.Name))
                    {
                        newRole = new Role(role.Name);
                        roleResult = RoleManager.Create(newRole);
                    }

                    if (newRole != null && CreateNewRolePermissions(newRole.Id))
                    {
                        this.RegisterEvent("Se agregó " + newRole.Name + " como nuevo rol");
                        return Ok(new { result = new[] { role } });
                    }
                    return InternalServerError();
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        private bool CreateNewRolePermissions(string roleId)
        {
            using (var dbContext = new SpresContext())
            {
                try
                {
                    dbContext.Permissions.AddRange(new List<Permissions>{
                        new Permissions{
                            //Budgeting
                            RolId = roleId,
                            Option = 1,
                            View = false,
                            Edit = false,
                            AllCostCenters = false
                        },

                        new Permissions{
                            //Reporting
                            RolId = roleId,
                            Option = 2,
                            View = false,
                            Edit = false,
                            AllCostCenters = false
                        },
                        new Permissions{
                            //Consolidate
                            RolId = roleId,
                            Option = 3,
                            View = false,
                            Edit = false,
                            AllCostCenters = false
                        },
                        new Permissions{
                            //Authorization
                            RolId = roleId,
                            Option = 4,
                            View = false,
                            Edit = false,
                            AllCostCenters = false
                        },
                        new Permissions{
                            //Catalogs
                            RolId = roleId,
                            Option = 5,
                            View = false,
                            Edit = false,
                            AllCostCenters = false
                        },
                        new Permissions{
                            //Configuration
                            RolId = roleId,
                            Option = 6,
                            View = false,
                            Edit = false,
                            AllCostCenters = false
                        },
                        new Permissions{
                            //Security
                            RolId = roleId,
                            Option = 7,
                            View = false,
                            Edit = false,
                            AllCostCenters = false
                        },
                        new Permissions{
                            //PeopleBudgeting
                            RolId = roleId,
                            Option = 8,
                            View = false,
                            Edit = false,
                            AllCostCenters = false
                        }
                    });
                    dbContext.SaveChanges();
                    return true;
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return false;
                }
            }
        }

        [SpresSecurityAttribute("Security", false, true)]
        public IHttpActionResult PutRole(Role role)
        {
            using (SpresIdentityDbContext dbContext = new SpresIdentityDbContext())
            {
                try
                {
                    if (!dbContext.Roles.Any(ro => ro.Name == role.Name))
                    {
                        var result = SecurityManager.UpdateRole(role);
                        if (result)
                        {
                            this.RegisterEvent("Se modificó el rol " + role.Name);
                            return Ok(role);
                        }
                        else
                        {
                            throw new ApplicationException("Error: no se puede actualizar el rol");
                        }
                    }
                    else
                    {
                        return Ok(role);
                    }

                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Security", false, true)]
        public IHttpActionResult DeleteRole(string id)
        {
            using (var spres = new SpresContext())
            using(SpresIdentityDbContext dbContext = new SpresIdentityDbContext())
            {
                try
                {
                    var role = dbContext.Roles.Find(id);
                    if (role.Users.Any())
                    {
                        return BadRequest("No se puede eliminar. El Rol tiene usuarios asignados.");
                    }

                    var result = SecurityManager.DeleteRole(id);
                    var permissions = spres.Permissions.Where(p => p.RolId == id);
                    spres.Permissions.RemoveRange(permissions);
                    spres.SaveChanges();
                    this.RegisterEvent("Se eliminó el rol " + role.Name);
                    return Ok(id);
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
