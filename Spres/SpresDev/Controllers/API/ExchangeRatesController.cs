using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Models;
using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class ExchangeRatesController : ApiController
    {

        [SpresSecurityAttribute("Configuration", true, false)]
        public IHttpActionResult GetExchangeRates()
        {
            using (var db = new SpresContext())
            {
                return Ok(db.ExchangeRates.Select(e => new { e.Id, e.CurrencyId, e.TradeDate, e.Rate}).ToDataResult());
            }
        }

        [SpresSecurityAttribute("Configuration", true, false)]
        public IHttpActionResult GetExchangeRateById(int id)
        {
            using (var db = new SpresContext())
            {
                return Ok(db.ExchangeRates.Find(id));
            }
        }

        [SpresSecurityAttribute("Configuration", false, true)]
        public IHttpActionResult Post(ExchangeRate er)
        {
            using (var db = new SpresContext())
            {
                db.ExchangeRates.Add(er);
                db.SaveChanges();
                this.RegisterEvent("Se agregó la nueva tasa de cambio " + er.CurrencyId + " vigente desde "+ er.TradeDate.Day + "/" + er.TradeDate.Month + "/" + er.TradeDate.Year + " y la tasas de cambio con valor de " + er.Rate);
                return Ok();
            }
        }

        [SpresSecurityAttribute("Configuration", false, true)]
        public IHttpActionResult Put(ExchangeRate er)
        {
            using (var db = new SpresContext())
            {
                db.Entry(er).State = EntityState.Modified;
                db.SaveChanges();
                this.RegisterEvent("Se modificó la tasa de cambio para la moneda " + er.CurrencyId + " vigente desde " + er.TradeDate.Day + "/" + er.TradeDate.Month + "/" + er.TradeDate.Year + " y la tasas de cambio con valor de " + er.Rate);
                return Ok();
            }
        }

        [SpresSecurityAttribute("Configuration", false, true)]
        public IHttpActionResult Delete(int id)
        {
            using (var db = new SpresContext())
            {
                var er = db.ExchangeRates.Find(id);
                if (er == null)
                    return NotFound();
                db.ExchangeRates.Remove(er);
                db.SaveChanges();
                this.RegisterEvent("Se eliminó la tasa de cambio " + er.CurrencyId);
                return Ok();
            }
        }

        public static decimal Convert(decimal value, decimal rate)
        {
            if (rate == 1)
            {
                return value;
            }
            else
            {
                return Math.Round(value * rate, 4);
            }
        }

        public static decimal GetLatestExchangeRate(string fromCurrencyId, string toCurrencyId)
        {
            if (fromCurrencyId == toCurrencyId)
            {
                return 1;
            }
            else
            {
                using (var db = new SpresContext())
                {
                    var fromCurrency = db.Currencies.Find(fromCurrencyId);
                    var toCurrency = db.Currencies.Find(toCurrencyId);
                    var exchangeRates = db.ExchangeRates.Where(e => e.TradeDate <= DateTime.Now).OrderByDescending(e => e.TradeDate);

                    if (fromCurrency == null || toCurrency == null)
                    {
                        return 1;
                    }
                    else
                    {
                        if (fromCurrencyId == "USD")
                        {
                            var er = exchangeRates.FirstOrDefault(e => e.CurrencyId.Equals(toCurrencyId));
                            return (er == null) ? 1 : er.Rate;
                        }
                        else if (toCurrencyId == "USD")
                        {
                            var er = exchangeRates.FirstOrDefault(e => e.CurrencyId.Equals(fromCurrencyId));
                            return (er == null) ? 1 : 1 / er.Rate;
                        }
                        else
                        {
                            var toUSD = exchangeRates.FirstOrDefault(e => e.CurrencyId.Equals(fromCurrencyId));
                            var fromUSD = exchangeRates.FirstOrDefault(e => e.CurrencyId.Equals(toCurrencyId));

                            return (toUSD == null || fromUSD == null) ? 1 : fromUSD.Rate / toUSD.Rate;
                        }
                    }
                }
            }
        }
    }
}