using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Spres.Infrastructure;
using Spres.Infrastructure.Security;
using Spres.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class ForecastProgrammingsController : ApiController
    {
        public IHttpActionResult Put(ForecastProgramming fp)
        {
            using (var db = new SpresContext())
            {
                var programming = db.ForecastProgrammings.Find(fp.FiscalYear, fp.CompanyId, fp.Item);
                if (programming == null)
                {
                    return NotFound();
                }
                else
                {
                    programming.StartDate = fp.StartDate;
                    programming.EndDate = fp.EndDate;
                    db.Entry(programming).State = System.Data.Entity.EntityState.Modified;
                    return Ok(db.SaveChanges());
                }
            }
        }

        public IHttpActionResult PutSendEmails(int fiscalYear, int companyId, int item)
        {
            using (var db = new SpresContext())
            using (var appContext = new SpresIdentityDbContext())
            {
                var forecastProgramming = db.ForecastProgrammings.Find(fiscalYear, companyId, item);
                if (forecastProgramming == null)
                {
                    return NotFound();
                }
                else
                {
                    var userManager = new UserManager<User>(new UserStore<User>(appContext));
                    var emailAddresses = new List<string>();

                    var companyCostCenters = db.CostCenters.Where(cc => cc.CompanyId == forecastProgramming.CompanyId).ToList();
                    foreach (var costCenter in companyCostCenters)
                    {
                        var responsibleGUID = costCenter.ResponsibleGUID;

                        if (!string.IsNullOrEmpty(responsibleGUID))
                        {
                            var responsibleUser = userManager.FindById(responsibleGUID);

                            if (responsibleUser != null && !string.IsNullOrEmpty(responsibleUser.Email))
                            {
                                emailAddresses.Add(responsibleUser.Email);
                            }
                        }
                    }

                    var emailParameters = new List<string>()
                    {
                        forecastProgramming.FiscalYear.ToString(),
                        forecastProgramming.Item.ToString(),
                        forecastProgramming.StartDate.Value.ToShortDateString(),
                        forecastProgramming.EndDate.Value.ToShortDateString()
                    };

                    try
                    {
                        EmailHelper.Send("ForecastProgrammingChanged", emailParameters, emailAddresses);
                        return Ok(true);
                    }
                    catch (SmtpException)
                    {
                        return InternalServerError();
                    }
                }
            }
        }
    }
}