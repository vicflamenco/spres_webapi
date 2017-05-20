using Spres.Infrastructure;
using Spres.Infrastructure.ErrorLog;
using System;
using System.Linq;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    class Source
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
    public class SourcesController : ApiController
    {

        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetAllSources()
        {
           
            using (SpresContext bdContext = new SpresContext())
            {
                try
                {
                    var list = bdContext.Database.SqlQuery<Source>("SELECT object_id as Id, name as Name FROM sys.tables");
                    return Ok(list.Where(item => item.Name != "__MigrationHistory" && !item.Name.StartsWith("AspNet")).ToList());
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
