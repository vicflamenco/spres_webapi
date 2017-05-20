using Spres.Infrastructure;
using Spres.Infrastructure.ErrorLog;
using SpresDev.Models;
using System;
using System.Linq;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    


    public class FormulesController : ApiController
    {
        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetFormules()
        {
            using (SpresContext db = new SpresContext())
            {
                try
                {
                    var list = db.Database.SqlQuery<Data>("SELECT object_id as Id, SCHEMA_NAME(schema_id) + '.' + name as Name FROM sys.objects WHERE type = 'FN'");
                    return Ok(list.ToList());
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
