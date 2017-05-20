using Spres.Infrastructure;
using Spres.Models;
using System;
using System.Linq;
using System.Web.Http;


namespace SpresDev.Controllers.Api
{
    public class ExpenseTypesController : ApiController
    {

        [Route("api/ExpenseTypes/Types")]
        public IHttpActionResult GetExpenseTypes()
        {
            var names = Enum.GetNames(typeof(BudgetExpenseType));
            var types = names.Select(n => new { Id = Array.IndexOf(names, n) + 1, Name = n });
            return Ok(types.ToDataResult());
        }
    }
        
}
