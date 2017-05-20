using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Models;
using System;
using System.Linq;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class PackageAccountsController : ApiController
    {

        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetPackageAccounts(int id, bool attacheds)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    if (attacheds)
                    {
                        var Package = dbContext.Packages.Find(id);

                        if (Package == null)
                            return NotFound();

                        return Ok(Package.Accounts.Select(a => new Account { Id = a.Id, Name = a.Name, Code = a.Code, Type = a.Type }).ToList());
                    }
                 
                    var accounts = dbContext.Accounts.Where(a => !dbContext.Packages.Any(p => p.Id==id && p.Accounts.Any(a2 => a.Id == a2.Id))).ToList();

                    return Ok(accounts.Select(a => new Account { Id = a.Id, Name = a.Name, Code = a.Code, Type = a.Type }).ToList());
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        [Route("api/PackageAccounts/{PackageId}/{AccountId}")]
        public IHttpActionResult PostAssociateAccount(int PackageId, int AccountId)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var Package = dbContext.Packages.Find(PackageId);
                    var Account = dbContext.Accounts.Find(AccountId);

                    if (Package == null || Account == null)
                        return NotFound();

                    Package.Accounts.Add(Account);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se asoció la cuenta contable " + Account.Display + " al paquete " + Package.Name);
                    return Ok(new Account() { Id = Account.Id, Name = Account.Display, Code = Account.Code, Type = Account.Type });
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        [Route("api/PackageAccounts/{PackageId}/{AccountId}")]
        public IHttpActionResult DeleteDetatchAccount(int PackageId, int AccountId)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var account = dbContext.Accounts.Find(AccountId);
                    var package = dbContext.Packages.Find(PackageId); 

                    if (account == null || package == null)
                        return NotFound();

                    if (!package.Accounts.Contains(account))
                        return BadRequest("Account is not associated to specified package");

                    package.Accounts.Remove(account);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se desvinculó la cuenta contable " + account.Display + " del paquete " + package.Name);
                    return Ok(new Account() { Id = account.Id, Name = account.Display, Code = account.Code, Type = account.Type });
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
