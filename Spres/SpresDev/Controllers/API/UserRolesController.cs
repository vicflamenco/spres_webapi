using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Infrastructure.Security;
using System;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class UserRolesController : ApiController
    {
        [SpresSecurityAttribute("Security", true, false)]
        public IHttpActionResult GetUserRoles(string id, bool attacheds)
        {
            using (SpresIdentityDbContext dbContext = new SpresIdentityDbContext())
            {
                try
                {
                    if (attacheds)
                    {
                        var User = dbContext.Roles.Find(id);

                        if (User == null)
                            return NotFound();

                        var users = dbContext.Users.ToList();
                        return Ok(User.Users.Select(u=> new {Id = u.UserId, UserName = users.FirstOrDefault(us=> us.Id == u.UserId).UserName ?? string.Empty}));
                    }
                 
                    var roles = dbContext.Users.Where(a => !dbContext.Roles.Any(p => p.Id==id && p.Users.Any(a2 => a.Id == a2.UserId))).ToList();

                    return Ok(roles.Select(a => new User { Id = a.Id, UserName = a.UserName}).ToList());
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Security", false, true)]
        [Route("api/UserRoles/{userId}/{roleName}")]
        public async Task<IHttpActionResult> PostAssociateRole(string userId, string roleName)
        {
            using (SpresIdentityDbContext dbContext = new SpresIdentityDbContext())
            {
                try
                {
                    var user = SecurityManager.GetUsername(userId);
                    await dbContext.UserManager.AddToRoleAsync(userId, roleName);
                    await dbContext.SaveChangesAsync();
                    this.RegisterEvent("Se asoció el usuario " + user + " al rol " + roleName);
                    return Ok();
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
                
            }
        }

        [SpresSecurityAttribute("Security", false, true)]
        [Route("api/UserRoles/{userId}/{roleId}")]
        public IHttpActionResult DeleteUserFromRole(string userId, string roleId)
        {
            using (var context = new SpresIdentityDbContext())
            {
                try
                {
                    var userManager = new UserManager<User>(new UserStore<User>(context));
                    var roleManager = new RoleManager<Role>(new RoleStore<Role>(context));
                    var role = roleManager.FindById(roleId);
                    var user = userManager.FindById(userId);
                    var result = userManager.RemoveFromRole(userId, role.Name);
                    
                    if (result.Succeeded)
                    {
                        this.RegisterEvent("Se disoció el usuario " + user.UserName + " del rol " + role.Name);
                        return Ok();
                    }
                    return InternalServerError();
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }
    }
}
