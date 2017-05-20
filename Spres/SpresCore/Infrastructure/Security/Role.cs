
using Microsoft.AspNet.Identity.EntityFramework;
namespace Spres.Infrastructure.Security
{
    public class Role : IdentityRole
    {
        public Role() : base() { }
        public Role(string name) : base(name) { }
    }
}
