using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity;
using Spres.Models;

namespace Spres.Infrastructure.Security
{
    class SpresIdentityDbInitializer : CreateDatabaseIfNotExists<SpresIdentityDbContext>
    {
        protected override void Seed(SpresIdentityDbContext context)
        {
            using (var dbContext = new SpresContext())
            {
                UserManager userMgr = new UserManager(new UserStore<User>(context));

                RoleManager roleMgr = new RoleManager(new RoleStore<Role>(context));

                string[] roles = { "Administrador", "Responsable OBZ", "Gerente Financiero", "Responsable de CECO", "Responsable de Gente" };

                foreach (var role in roles)
                {
                    if (!roleMgr.RoleExists(role))
                    {
                        var roleTmp = new Role(role);
                        roleMgr.Create(roleTmp);
                        switch (role)
                        {
                            case "Administrador":
                                //INSERT INTO Permissions(RolId, [Option], [View], Edit,Process, CostCenterFilter)
                                dbContext.Permissions.AddRange( new List<Permissions>{
                                new Permissions{
                                    //Budgeting
                                    RolId = roleTmp.Id,
                                    Option = 1,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },

                                new Permissions{
                                    //Reporting
                                    RolId = roleTmp.Id,
                                    Option = 2,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Consolidate
                                    RolId = roleTmp.Id,
                                    Option = 3,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Authorization
                                    RolId = roleTmp.Id,
                                    Option = 4,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Catalogs
                                    RolId = roleTmp.Id,
                                    Option = 5,
                                    View = true,
                                    Edit = true,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Configuration
                                    RolId = roleTmp.Id,
                                    Option = 6,
                                    View = true,
                                    Edit = true,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Security
                                    RolId = roleTmp.Id,
                                    Option = 7,
                                    View = true,
                                    Edit = true,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //PeopleBudgeting
                                    RolId = roleTmp.Id,
                                    Option = 8,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                }

                            });
                                dbContext.SaveChanges();
                                break;
                            case "Responsable OBZ":
                                dbContext.Permissions.AddRange( new List<Permissions>{
                                new Permissions{
                                    //Budgeting
                                    RolId = roleTmp.Id,
                                    Option = 1,
                                    View = true,
                                    Edit = false,
                                    AllCostCenters = false
                                },

                                new Permissions{
                                    //Reporting
                                    RolId = roleTmp.Id,
                                    Option = 2,
                                    View = true,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Consolidate
                                    RolId = roleTmp.Id,
                                    Option = 3,
                                    View = true,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Authorization
                                    RolId = roleTmp.Id,
                                    Option = 4,
                                    View = true,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Catalogs
                                    RolId = roleTmp.Id,
                                    Option = 5,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Configuration
                                    RolId = roleTmp.Id,
                                    Option = 6,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Security
                                    RolId = roleTmp.Id,
                                    Option = 7,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //PeopleBudgeting
                                    RolId = roleTmp.Id,
                                    Option = 8,
                                    View = true,
                                    Edit = false,
                                    AllCostCenters = false
                                }

                            });
                        dbContext.SaveChanges();
                                break;
                            case "Gerente Financiero":
                                dbContext.Permissions.AddRange( new List<Permissions>{
                                new Permissions{
                                    //Budgeting
                                    RolId = roleTmp.Id,
                                    Option = 1,
                                    View = true,
                                    Edit = false,
                                    AllCostCenters = false
                                },

                                new Permissions{
                                    //Reporting
                                    RolId = roleTmp.Id,
                                    Option = 2,
                                    View = true,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Consolidate
                                    RolId = roleTmp.Id,
                                    Option = 3,
                                    View = true,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Authorization
                                    RolId = roleTmp.Id,
                                    Option = 4,
                                    View = true,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Catalogs
                                    RolId = roleTmp.Id,
                                    Option = 5,
                                    View = true,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Configuration
                                    RolId = roleTmp.Id,
                                    Option = 6,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Security
                                    RolId = roleTmp.Id,
                                    Option = 7,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //PeopleBudgeting
                                    RolId = roleTmp.Id,
                                    Option = 8,
                                    View = true,
                                    Edit = false,
                                    AllCostCenters = false
                                }

                            });
                        dbContext.SaveChanges();
                                break;
                            case "Responsable de CECO":
                                dbContext.Permissions.AddRange( new List<Permissions>{
                                new Permissions{
                                    //Budgeting
                                    RolId = roleTmp.Id,
                                    Option = 1,
                                    View = true,
                                    Edit = true,
                                    AllCostCenters = true
                                },

                                new Permissions{
                                    //Reporting
                                    RolId = roleTmp.Id,
                                    Option = 2,
                                    View = true,
                                    Edit = true,
                                    AllCostCenters = true
                                },
                                new Permissions{
                                    //Consolidate
                                    RolId = roleTmp.Id,
                                    Option = 3,
                                    View = true,
                                    Edit = true,
                                    AllCostCenters = true
                                },
                                new Permissions{
                                    //Authorization
                                    RolId = roleTmp.Id,
                                    Option = 4,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Catalogs
                                    RolId = roleTmp.Id,
                                    Option = 5,
                                    View = true,
                                    Edit = true,
                                    AllCostCenters = true
                                },
                                new Permissions{
                                    //Configuration
                                    RolId = roleTmp.Id,
                                    Option = 6,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Security
                                    RolId = roleTmp.Id,
                                    Option = 7,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //PeopleBudgeting
                                    RolId = roleTmp.Id,
                                    Option = 8,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                }

                            });
                        dbContext.SaveChanges();
                                break;
                            case "Responsable de Gente":
                                dbContext.Permissions.AddRange( new List<Permissions>{
                                new Permissions{
                                    //Budgeting
                                    RolId = roleTmp.Id,
                                    Option = 1,
                                    View = true,
                                    Edit = true,
                                    AllCostCenters = true
                                },
                                new Permissions{
                                    //Reporting
                                    RolId = roleTmp.Id,
                                    Option = 2,
                                    View = true,
                                    Edit = true,
                                    AllCostCenters = true
                                },
                                new Permissions{
                                    //Consolidate
                                    RolId = roleTmp.Id,
                                    Option = 3,
                                    View = true,
                                    Edit = false,
                                    AllCostCenters = true
                                },
                                new Permissions{
                                    //Authorization
                                    RolId = roleTmp.Id,
                                    Option = 4,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Catalogs
                                    RolId = roleTmp.Id,
                                    Option = 5,
                                    View = true,
                                    Edit = true,
                                    AllCostCenters = true
                                },
                                new Permissions{
                                    //Configuration
                                    RolId = roleTmp.Id,
                                    Option = 6,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //Security
                                    RolId = roleTmp.Id,
                                    Option = 7,
                                    View = false,
                                    Edit = false,
                                    AllCostCenters = false
                                },
                                new Permissions{
                                    //PeopleBudgeting
                                    RolId = roleTmp.Id,
                                    Option = 8,
                                    View = true,
                                    Edit = true,
                                    AllCostCenters = true
                                }

                            });
                        dbContext.SaveChanges();
                                break;
                        }
                    }
                }

                string userName = "Admin";

                User user = userMgr.FindByName(userName);
                if (user == null)
                {
                    userMgr.Create(new User { UserName = userName, Email = "spres.livsmart@gmail.com", Status = 1,PasswordTemp = "secret",Name = "Administrador" }, "secret");
                    user = userMgr.FindByName(userName);
                }

                if (!userMgr.IsInRole(user.Id, "Administrador"))
                    userMgr.AddToRole(user.Id, "Administrador");

                base.Seed(context);
            }
        }
    }
}
