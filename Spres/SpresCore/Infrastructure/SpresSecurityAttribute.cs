using Spres.Infrastructure.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Results;
using System.Net.Http;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Spres.Models;

namespace Spres.Infrastructure
{
    [AttributeUsage(AttributeTargets.All)]
    public class SpresSecurityAttribute : AuthorizeAttribute
    {
        string permission;
        bool view, edit;
        int option;

        public SpresSecurityAttribute(string permission, bool view = false, bool edit = false)
        {
            this.permission = permission;
            this.view = view;
            this.edit = edit;
            this.option = GetOptionNumber(permission);
        }

        protected override bool IsAuthorized(HttpActionContext actionContext)
        {
            using (var identityDb = new SpresIdentityDbContext())
            using (var db = new SpresContext())
            {
                var username = actionContext.Request.GetOwinContext().Authentication.User.Identity.Name;
                if (!string.IsNullOrEmpty(username))
                {
                    var userManager = new UserManager<User>(new UserStore<User>(identityDb));
                    var rolesManager = new RoleManager<Role>(new RoleStore<Role>(identityDb));
                    var user = userManager.FindByName(username);
                    
                    if (user != null)
                    {
                        var combinedPermission = new Permissions()
                        {
                            AllCostCenters = false,
                            Edit = false,
                            Option = this.option,
                            View = false
                        };

                        if (user.Roles.Any())
                        {
                            foreach (var userRole in user.Roles.ToList())
                            {
                                var rolePermission = db.Permissions.FirstOrDefault(p => p.RolId == userRole.RoleId && p.Option == this.option);

                                if (rolePermission != null)
                                {
                                        combinedPermission.View |= rolePermission.View;
                                        combinedPermission.Edit |= rolePermission.Edit;
                                }
                            }

                            bool allowed = true;

                            if (this.view)
                            {
                                allowed &= combinedPermission.View;
                            }

                            if (this.edit)
                            {
                                allowed &= combinedPermission.Edit;
                            }

                            return allowed;
                        }
                        else
                        {
                            return false;
                        }
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    return false;
                }
            }
        }


        private int GetOptionNumber(string option)
        {
            switch (option)
            {
                case "Budgeting": return 1;
                case "Reporting": return 2;
                case "Consolidate": return 3;
                case "Authorization": return 4;
                case "Catalogs": return 5;
                case "Configuration": return 6;
                case "Security": return 7;
                case "PeopleBudgeting": return 8;
                default: return 0;
            }

        }
    }
}
