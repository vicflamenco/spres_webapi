using System.Web;
using System.Web.Mvc;
using System.Linq;

namespace Spres.Infrastructure.Security
{
    public class SpresAuthorizeAttribute: AuthorizeAttribute
    {
        string[] roles;

        public SpresAuthorizeAttribute(params string[] roles)
        {
            this.roles = roles;
        }
        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            var authenticationManager = httpContext.GetOwinContext().Authentication;
            if (authenticationManager.User == null)
            {
                return false;
            }
            else
            {
                if (roles.Count() == 0)
                {
                    return true;
                }
                else
                {
                    foreach (var role in roles)
                    {
                        if (authenticationManager.User.IsInRole(role))
                        {
                            return true;
                        }
                    }
                    return false;
                }
            }
        }

        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            filterContext.Result = new RedirectResult("~/Home/Login");
        }
    }
}
