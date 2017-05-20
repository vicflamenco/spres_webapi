//using System.Threading.Tasks;

using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.OAuth;
using System;


namespace Spres.Infrastructure.Security
{
    public class StoreAuthProvider : OAuthAuthorizationServerProvider{
        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            UserManager storeUserMgr = context.OwinContext.Get<UserManager>("AspNet.Identity.Owin:" + typeof(UserManager).AssemblyQualifiedName);
            User user = await storeUserMgr.FindAsync(context.UserName, context.Password);
            if (user == null)
            {
                context.SetError("invalid_grant", "The username or password is incorrect");
            }
            else
            {
                
                ClaimsIdentity ident = await storeUserMgr.CreateIdentityAsync(user, "Custom");
                AuthenticationTicket ticket = new AuthenticationTicket(ident, new AuthenticationProperties());
                context.Validated(ticket);
                var newTime = DateTime.UtcNow.AddHours(2);

                context.Ticket.Properties.ExpiresUtc = newTime;
                context.Request.Context.Authentication.SignIn(ident);
            }
        }

        public override Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            context.Validated();
            return Task.FromResult<object>(null);
        }
    }
}
