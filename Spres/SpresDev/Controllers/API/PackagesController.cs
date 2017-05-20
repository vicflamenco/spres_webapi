using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Infrastructure.Security;
using Spres.Models;
using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class PackagesController : ApiController
    {

        //[SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetAllPackages()
        {
            using(SpresContext dbContext = new SpresContext())
            {
                try
                {
                    return Ok(dbContext.Packages
                        .OrderBy(p => p.Name)
                        .ToList()
                        .Select(p => new Package { Id = p.Id, Name = p.Name, ManagerGUID = p.ManagerGUID, HR = p.HR })
                        .ToDataResult());
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }
        

        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetPackageById(int id)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var Package = dbContext.Packages.Find(id);

                    if (Package == null)
                        return NotFound();

                    return Ok(new { Id = Package.Id, Name = Package.Name, ManagerId = Package.ManagerGUID, HR = Package.HR });
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        
        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PostPackage(Package package)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    dbContext.Packages.Add(package);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se agregó " + package.Name  + " como nuevo paquete");
                    return Ok(package);
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PutPackageManager([FromUri]int id, [FromUri] string managerId)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var package = dbContext.Packages.Find(id);

                    if (package == null)
                    {
                        return NotFound();
                    }
                    else
                    {
                        dbContext.Entry(package).State = EntityState.Modified;
                        dbContext.SaveChanges();
                        var uname = SecurityManager.GetUsername(managerId);
                        package.ManagerGUID = managerId;
                        dbContext.Entry(package).State = EntityState.Modified;
                        dbContext.SaveChanges();
                        this.RegisterEvent("Se asignó a " + uname + " como administrador del paquete " + package.Name);
                        return Ok(new { Id = package.Id, Name = package.Name, ManagerId = package.ManagerGUID, HR = package.HR });
                    }

                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PutPackage(Package package)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    dbContext.Entry(package).State = EntityState.Modified;
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se modificó el paquete " + package.Name);
                    return Ok(new { Id = package.Id, Name = package.Name, ManagerId = package.ManagerGUID, HR = package.HR });
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
                
            }
        }
        
        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult DeletePackage(int id)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    Package package = dbContext.Packages.Find(id);

                    if (package == null)
                        return NotFound();

                    if (package.Accounts.Any())
                        return InternalServerError(new InvalidOperationException("Package has associated accounts."));

                    dbContext.Packages.Remove(package);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se eliminó el paquete " + package.Name );
                    return Ok(new { Id = package.Id, Name = package.Name, ManagerId = package.ManagerGUID, HR = package.HR });
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