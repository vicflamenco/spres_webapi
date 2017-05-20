
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;

namespace Spres.Infrastructure.Security
{
    public class RoleManager : RoleManager<Role>
    {
        public RoleManager(RoleStore<Role> roleSpres) : base(roleSpres) { }
        public static RoleManager Create(
            IdentityFactoryOptions<RoleManager> options,
            IOwinContext context)
        {
            return new RoleManager(new RoleStore<Role>(context.Get<SpresIdentityDbContext>()));
        }
    }
}
