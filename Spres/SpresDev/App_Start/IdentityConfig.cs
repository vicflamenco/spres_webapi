using Owin;
using Microsoft.Owin;
using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security.Cookies;
using Spres.Infrastructure.Security;
using System;
using Microsoft.Owin.Security.OAuth;

[assembly: OwinStartup(typeof(SpresDev.IdentityConfig))]
 namespace SpresDev
{
    public class IdentityConfig
    {
        public void Configuration(IAppBuilder app)
        {
            app.CreatePerOwinContext<SpresIdentityDbContext>(SpresIdentityDbContext.Create);
            app.CreatePerOwinContext<UserManager>(UserManager.Create);
            app.CreatePerOwinContext<RoleManager>(RoleManager.Create);

            //app.UseCookieAuthentication(new CookieAuthenticationOptions
            //{
            //    AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie
            //});
            app.UseOAuthBearerTokens(new OAuthAuthorizationServerOptions
            {                             
                Provider = new StoreAuthProvider(),
                AllowInsecureHttp = true,
                TokenEndpointPath = new PathString("/Authenticate"),
                RefreshTokenProvider = new ApplicationRefreshTokenProvider(),
                AccessTokenExpireTimeSpan = TimeSpan.FromHours(2)
            });            
        }
    }
}