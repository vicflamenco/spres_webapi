using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Spres.Infrastructure;
using Spres.Infrastructure.Security;
using Spres.Models;
using SpresDev.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using Spres.Infrastructure.Audit;

namespace SpresDev.Controllers.Api
{
    public class CompanyAuthorizersController : ApiController
    {
        [SpresSecurityAttribute("Security", true, false)]
        public IHttpActionResult Get(int companyId)
        {
            using (var identityDb = new SpresIdentityDbContext())
            using (var db = new SpresContext())
            {
                var result = new List<CompanyAuthorizersViewModel>();
                foreach (var authorizer in db.CompanyAuthorizers.Where(ca => ca.CompanyId == companyId).ToList())
                {
                    var user = identityDb.UserManager.FindById(authorizer.AuthorizerGUID);
                    if (user != null)
                    {
                        result.Add(new CompanyAuthorizersViewModel
                        {
                            AuthorizerGUID = authorizer.AuthorizerGUID,
                            Name = user.Name
                        });
                    }
                }
                return Ok(result.ToDataResult());
            }
        }

        [Route("api/CompanyAuthorizers/AvailableUsers/{companyId}")]
        [SpresSecurityAttribute("Security", true, false)]
        public IHttpActionResult GetAvailableUsers(int companyId)
        {
            using (var db = new SpresContext())
            using (var identityDb = new SpresIdentityDbContext())
            {
                var result = new List<User>();
                foreach (var availableAuthorizer in db.CompanyAuthorizers.Where(ca => ca.CompanyId != companyId).ToList())
                {
                    var user = identityDb.UserManager.FindById(availableAuthorizer.AuthorizerGUID);
                    if (user != null)
                    {
                        result.Add(new User()
                        {
                            Id = availableAuthorizer.AuthorizerGUID,
                            Name = user.Name
                        });
                    }
                }
                return Ok(result.ToDataResult());
            }
        }

        [SpresSecurityAttribute("Security", false, true)]
        public IHttpActionResult Post(CompanyAuthorizer authorizer)
        {
            using (var identityDb = new SpresIdentityDbContext())
            using (var db = new SpresContext())
            {
                var user = identityDb.UserManager.FindById(authorizer.AuthorizerGUID);
                var company = db.Companies.Find(authorizer.CompanyId);
                
                if (user == null || company == null)
                {
                    return BadRequest();
                }
                else
                {
                    bool found = db.CompanyAuthorizers.Find(authorizer.CompanyId, authorizer.AuthorizerGUID) != null;
                
                    if (found)
                    {
                        return BadRequest("El usuario seleccionado ya está asignado a la compañía seleccionada.");
                    }
                    else
                    {
                        db.CompanyAuthorizers.Add(authorizer);
                        db.SaveChanges();
                        this.RegisterEvent("Se asignó a " + user.UserName + " como responsable para autorizar presupuestos de la región " + company.Name);
                        return Ok();
                    }
                }
            }
        }

        [SpresSecurityAttribute("Security", false, true)]
        public IHttpActionResult Delete(CompanyAuthorizer authorizer)
        {
            using (var identityDb = new SpresIdentityDbContext())
            using (var db = new SpresContext())
            {
                var item = db.CompanyAuthorizers.Find(authorizer.CompanyId, authorizer.AuthorizerGUID);
                if (item == null)
                {
                    return BadRequest();
                }
                else
                {
                    var user = identityDb.UserManager.FindById(authorizer.AuthorizerGUID);
                    var company = db.Companies.Find(authorizer.CompanyId);
                    db.CompanyAuthorizers.Remove(item);
                    this.RegisterEvent("Se desasignó a " + user.UserName + " como responsable de autorizción de la región " + company.Name);
                    db.SaveChanges();
                    return Ok();
                }
            }
        }
    }
}
