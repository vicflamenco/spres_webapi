using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;

namespace Spres.Infrastructure.Security
{
    public class UserManager : UserManager<User>
    {
        public UserManager(IUserStore<User> usr) : base(usr) { }

        public static UserManager Create(IdentityFactoryOptions<UserManager> options, IOwinContext context)
        {
            SpresIdentityDbContext dbContext = context.Get<SpresIdentityDbContext>();
            UserManager manager = new UserManager(new UserStore<User>(dbContext));
            return manager;
        }

        public static User GetUser(string username)
        {
            SpresIdentityDbContext dbContext = new SpresIdentityDbContext();
            UserManager manager = new UserManager(new UserStore<User>(dbContext));
            return manager.FindByName(username);
        }
    }
}