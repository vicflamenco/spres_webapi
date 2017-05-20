using Spres.Infrastructure;
using Spres.Infrastructure.ErrorLog;
using Spres.Models;
using System;
using System.Linq;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class ProviderTypesController : ApiController
    {

        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetAllProviderTypes()
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    return Ok(dbContext.ProviderTypes.ToList().Select(p=> new ProviderType { Id = p.Id, Name = p.Name, PremiseTypeId = p.PremiseTypeId}));
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
