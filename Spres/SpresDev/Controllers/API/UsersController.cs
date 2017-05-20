using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Infrastructure.Security;
using Spres.Models;
using SpresDev.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net.Mail;
using System.Threading.Tasks;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class UsersController : ApiController
    {

        [Route("api/Users/StatusTypes")]
        public IHttpActionResult GetStatusTypes()
        {
            var names = Enum.GetNames(typeof(UserStatus));
            var types = names.Select(n => new { Id = Array.IndexOf(names, n) + 1, Name = n });
            return Ok(types.ToDataResult());
        }


        [SpresSecurityAttribute("Security", true, false)]
        public IHttpActionResult GetAllUsers()
        {
                try
                {
                    return Ok(SecurityManager.GetUsers()
                        .Select(e => new User { Id = e.Id, UserName = e.UserName, Email = e.Email, PasswordHash = e.PasswordHash,Status=e.Status, Name = e.Name})
                        .ToDataResult());
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
        }

        [Route("api/Users/GetUserByName/{user}")]
        public IHttpActionResult GetUserByName(string user)
        {
            using (SpresIdentityDbContext dbContext = new SpresIdentityDbContext())
            {
                try
                {
                    var userManager = new UserManager<User>(new UserStore<User>(dbContext));
                    var userItem = userManager.FindByName(user);

                    if (userItem != null)
                    {
                        return Ok(new
                        {
                            Id = userItem.Id,
                            User = userItem.UserName,
                            PasswordTemp = userItem.PasswordTemp,
                            Name = userItem.Name
                        });
                    }
                    else
                    {
                        return NotFound();
                    }
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Security", false, true)]
        public async Task<IHttpActionResult> PostUsers(User user)
        {
            using(SpresIdentityDbContext dbContext = new SpresIdentityDbContext()){
            
                try
                {
                    if (dbContext.Users.Any(u => u.UserName == user.UserName || u.Email == user.Email))
                    {
                        return BadRequest("El nombre de usuario o correo electrónico ya existen");
                    }
                    else
                    {
                        var result = SecurityManager.CreateUser(user);
                        if (result)
                        {
                            UserStore<User> store = new UserStore<User>(dbContext);
                            UserManager<User> UserManager = new UserManager<User>(store);
                            String userId = user.Id;
                            User cUser = await store.FindByIdAsync(userId);
                            cUser.Status = 1;
                            await dbContext.SaveChangesAsync();
                            this.RegisterEvent("Se creó el usuario " + cUser.UserName);
                            SendEmail(user, true);
                            cUser.Status = 2;
                            cUser.Name = user.Name;
                            await dbContext.SaveChangesAsync();
                            return Ok(new { result = new[] { user } });

                        }
                        else
                        {
                            throw new ApplicationException("Error: no se puede crear usuario");
                        }
                    }
                }
                catch (SmtpException ex)
                {
                    string texto = "El usuario se creó correctamente. Sin embargo, ocurrió un error al intentar enviar un correo electrónico con su contraseña temporal. Intente reenviar el correo electrónico";
                    
                    ErrorLog.SaveError(ex);
                    return InternalServerError(new Exception(texto));
                }
                catch (Exception ex)
                {
                    string texto = "Ocurrió un error al intentar crear un usuario";
                    ErrorLog.SaveError(ex);
                    return InternalServerError(new Exception(texto));
                }
            }
        }

        [SpresSecurityAttribute("Security", false, true)]
        public async Task<IHttpActionResult> PutUser(User user)
        {
            using(var dbContext = new SpresIdentityDbContext())
            {
                try
                {
                    UserStore<User> store = new UserStore<User>(dbContext);
                    UserManager<User> UserManager = new UserManager<User>(store);
                    String userId = user.Id;
                    User cUser = await store.FindByIdAsync(userId);
                        if (cUser.UserName.ToLower() == "admin")
                        {
                            return InternalServerError(new ApplicationException("El nombre de usuario [Admin] no puede ser modificado"));
                        }

                        cUser.UserName = user.UserName;
                        cUser.Name = user.Name;
                        await store.SetEmailAsync(cUser, user.Email);
                        await store.UpdateAsync(cUser);
                        this.RegisterEvent("Se editó el usuario " + cUser.UserName);
                        return Ok(cUser.UserName);
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }


        [Route("api/Users/ChangePassword")]
        public async Task<IHttpActionResult> PutPassword(ChangePasswordViewModel model)
        {
            using (var context = new SpresIdentityDbContext())
            {
                try
                {
                    UserStore<User> store = new UserStore<User>(context);
                    UserManager<User> UserManager = new UserManager<User>(store);
                    String userId = model.id;
                    String hashedNewPassword = UserManager.PasswordHasher.HashPassword(model.newPassword);
                    User cUser = await store.FindByIdAsync(userId);

                    if (cUser.PasswordTemp == model.currentPassword)
                    {
                        await store.SetPasswordHashAsync(cUser, hashedNewPassword);
                        cUser.PasswordTemp = null;
                        cUser.Status = 3;
                        await store.UpdateAsync(cUser);
                        //this.RegisterEvent("Se modificó la contraseña del usuario " + cUser.UserName);
                        return Ok(cUser.UserName);
                    }
                    else
                    {
                        return BadRequest("La contraseña actual especificada es incorrecta.");
                    }
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Security", false, true)]
        [Route("api/Users/ResetPassowrd/{userId}")]
        public async Task<IHttpActionResult> PutResetPassword(string userId)
        {
            using (var dbContext = new SpresIdentityDbContext())
            {
                try
                {
                    UserStore<User> store = new UserStore<User>(dbContext);
                    UserManager<User> UserManager = new UserManager<User>(store);
                    String user = userId;
                    User cUser = await store.FindByIdAsync(userId);
                    var passwordTemp = GeneratePasswordTemp();
                    cUser.PasswordTemp = passwordTemp;
                    cUser.Status = 1;
                    await store.UpdateAsync(cUser);
                    this.RegisterEvent("Se reestableció la contraseña del usuario " + cUser.UserName);
                    SendEmail(cUser, false);
                    cUser.Status = 2;
                    await store.UpdateAsync(cUser);
                    
                    return Ok(cUser.UserName);
                }
                catch (SmtpException ex)
                {
                    string texto = "La contraseña temporal se generó correctamente. Sin embargo, ocurrió un error al intentar enviar un correo electrónico con su contraseña temporal. Intente reenviar el correo electrónico";
                    ErrorLog.SaveError(ex);
                    return InternalServerError(new Exception(texto));
                }
                catch (Exception ex)
                {
                    string texto = "La contraseña temporal no se generó";
                    ErrorLog.SaveError(ex);
                    return InternalServerError(new Exception(texto));
                }
            }
        }

        [SpresSecurityAttribute("Security", false, true)]
        public async Task<IHttpActionResult> DeleteUser(string id)
        {
            using (SpresContext db = new SpresContext())
            using(SpresIdentityDbContext identityDb = new SpresIdentityDbContext())
            {
                try
                {
                    if (id == User.Identity.GetUserId())
                    {
                        return BadRequest("El usuario actualmente logueado no puede ser eliminado.");
                    }
                    else
                    {
                        db.BudgetAuthorizations.RemoveRange(await db.BudgetAuthorizations.Where(ba => ba.AuthorizerGUID == id).ToListAsync());
                        db.CompanyAuthorizers.RemoveRange(await db.CompanyAuthorizers.Where(ca => ca.AuthorizerGUID == id).ToListAsync());
                        await db.Packages.Where(p => p.ManagerGUID == id).ForEachAsync(p => p.ManagerGUID = null);
                        await db.CostCenters.Where(cc => cc.ResponsibleGUID == id).ForEachAsync(cc => cc.ResponsibleGUID = null);
                        await db.SaveChangesAsync();

                        var user = identityDb.UserManager.FindById(id);
                        if (user != null)
                        {
                            var username = user.UserName.ToLower();
                            if (username == "admin")
                            {
                                return BadRequest("El usuario [Admin] no puede ser eliminado");
                            }
                            await identityDb.UserManager.DeleteAsync(user);
                            await identityDb.SaveChangesAsync();
                            this.RegisterEvent("Se eliminó el usuario " + username);
                            return Ok(id);
                        }
                        else
                        {
                            return NotFound();
                        }
                    }
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        private string GeneratePasswordTemp()
        {
            var guidtemp = Guid.NewGuid().ToString();
            return guidtemp.Split('-')[0];
        }

        private void SendEmail(User user, bool newUser)
        {
            var emailParameters = new List<string>()
            {
                user.Name,
                user.UserName,
                user.PasswordTemp
            };

            EmailHelper.Send((newUser) ? "UserCreated" : "PasswordChanged", emailParameters, new List<string> { user.Email });
        }
    }
}
