using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Microsoft.AspNet.Identity.EntityFramework;
using System.Data.Entity;

namespace Spres.Infrastructure.Security
{
    public class SpresIdentityDbContext : IdentityDbContext<User>{

        private RoleManager roleManager;
        private UserManager userManager;
        
        public SpresIdentityDbContext() : base("name=SpresContext"){
            Database.SetInitializer<SpresIdentityDbContext>(new SpresIdentityDbInitializer());
            roleManager = new RoleManager(new RoleStore<Role>(this));
            userManager = new UserManager(new UserStore<User>(this));
        }

        public static SpresIdentityDbContext Create()
        {
            return new SpresIdentityDbContext();
        }

        public RoleManager RoleManager
        {
            get
            {
                return roleManager;
            }
        }

        public UserManager UserManager
        {
            get
            {
                return userManager;
            }
        }
    }
}
