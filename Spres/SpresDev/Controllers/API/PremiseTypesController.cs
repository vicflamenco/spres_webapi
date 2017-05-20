using Spres.Infrastructure;
using Spres.Models;
using System.Linq;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class PremiseTypesController : ApiController
    {
        public IHttpActionResult GetPremiseTypes()
        {
            using(var model = new SpresContext())
            {
                return Ok(model.PremiseTypes.ToList().Select(pt => new PremiseType
                {
                    Id = pt.Id,
                    Name = pt.Name
                }).ToList());
            }
        }

        public IHttpActionResult Get(int id)
        {
            using (var model = new SpresContext())
            {
                return Ok(model.PremiseTypes.Find(id));
            }
        }
    }
}
