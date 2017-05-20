using Spres.Infrastructure;
using Spres.Models;
using System.Linq;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class CompaniesController : ApiController
    {
        public IHttpActionResult Get()
        {
            using (var db = new SpresContext())
            {
                return Ok(db.Companies.ToList().Select(c => new Company { Id = c.Id, Name = c.Name, Country = c.Country }).ToDataResult());
            }
        }
    }
}
