using Spres.Infrastructure;
using Spres.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class CurrenciesController : ApiController
    {
        [SpresSecurityAttribute("Configuration", true, false)]
        public IHttpActionResult GetCurrencies()
        {
            using (var db = new SpresContext())
            {
                return Ok(db.Currencies.ToDataResult());
            }
        }

        public IHttpActionResult GetLocalCurrency(int id)
        {
            using (var db = new SpresContext())
            {
                var country = db.Companies.Find(id).Country;
                var currency = db.Countries.Find(country).DefaultCurrency;
                return Ok(new { currency.Id, currency.Name });
            }
        }

        
        [Route("api/Currencies/OrderedList/{companyId}")]
        [SpresSecurityAttribute("Budgeting", true, false)]
        // Obtiene las monedas, colocando en la primera posición de la lista a la moneda local de la compañía especificada.
        public IHttpActionResult GetCurrenciesOrderedList(int companyId)
        {
            using (var db = new SpresContext())
            {

                var company = db.Companies.Find(companyId);
                if (company == null)
                {
                    return NotFound();
                }
                else
                {
                    var result = new List<Currency>();
                    var currency = db.Countries.Find(company.Country).DefaultCurrency;
                    result.Add(currency);
                    result.AddRange(db.Currencies.Where(c => !c.Id.Equals(currency.Id)).OrderBy(c => c.Name).ToList());
                    return Ok(result);
                }
            }
        }
    }
}