using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;
using Microsoft.Owin.Security;

namespace Spres.Infrastructure.Security
{
    public class SpresSignInManager : SignInManager<User, string>
    {
        public SpresSignInManager(UserManager userManager, IAuthenticationManager authenticationManager)
            : base(userManager, authenticationManager)
        {
        }

        public override Task<ClaimsIdentity> CreateUserIdentityAsync(User user)
        {
            return user.GenerateUserIdentityAsync((UserManager)UserManager);
        }

        public static SpresSignInManager Create(IdentityFactoryOptions<SpresSignInManager> options, IOwinContext context)
        {
            return new SpresSignInManager(context.GetUserManager<UserManager>(), context.Authentication);
        }
    }
}
