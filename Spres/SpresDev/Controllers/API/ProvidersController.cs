using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Models;
using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class ProvidersController : ApiController
    {

        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetAllProviders()
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    return Ok(dbContext.Providers.OrderBy(p => p.Name).ToDataResult());
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetProviderById(int id)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var provider = dbContext.Providers.Find(id);

                    if (provider == null)
                        return NotFound();

                    return Ok(provider);
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PostProvider(Provider provider)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    dbContext.Providers.Add(provider);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se agregó " + provider.Name + " como nuevo proveedor");
                    return Ok(provider);
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PutProvider(Provider provider)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    dbContext.Entry(provider).State = EntityState.Modified;
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se modificó el proveedor " + provider.Name);
                    return Ok(provider);
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }

            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult DeleteProvider(int id)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    Provider provider = dbContext.Providers.Find(id);

                    if (provider == null)
                        return NotFound();

                    dbContext.Providers.Remove(provider);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se eliminó el proveedor " + provider.Name);
                    return Ok(provider);

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
