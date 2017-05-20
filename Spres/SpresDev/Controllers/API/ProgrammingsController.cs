using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Infrastructure.Security;
using Spres.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net.Mail;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class ProgrammingsController : ApiController
    {
        public IHttpActionResult GetProgrammings(int companyId = 0)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    if (companyId == 0)
                    {
                        var result = new List<Programming>();

                        var data = dbContext.Programmings.ToList();

                        foreach (var p in data)
                        {
                            if (!result.Any(i => i.FiscalYear.Equals(p.FiscalYear)))
                            {
                                result.Add(new Programming
                                {
                                    FiscalYear = p.FiscalYear,
                                    CompanyId = p.CompanyId,
                                    BudgetStartDate = p.BudgetStartDate,
                                    BudgetEndDate = p.BudgetEndDate
                                });
                            }
                        }
                        return Ok(result.ToDataResult());
                    }
                    else
                    {
                        var data = dbContext.Programmings.Where(p => p.CompanyId == companyId).ToList()
                            .Select(p => new Programming
                            {
                                FiscalYear = p.FiscalYear,
                                CompanyId = p.CompanyId,
                                BudgetStartDate = p.BudgetStartDate,
                                BudgetEndDate = p.BudgetEndDate,
                                ForecastProgrammings = p.ForecastProgrammings.ToList().Select(fp => new ForecastProgramming
                                {
                                    Item = fp.Item,
                                    StartDate = fp.StartDate,
                                    EndDate = fp.EndDate
                                }).ToList()
                            });
                        return Ok(data.ToDataResult());
                    }
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Configuration", true, false)]
        public IHttpActionResult GetProgrammingById(int id, int companyId)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    var programming = dbContext.Programmings.Find(id, companyId);

                    if (programming == null)
                    {
                        return NotFound();
                    }
                    else
                    {
                        return Ok(new
                        {
                            FiscalYear = programming.FiscalYear,
                            CompanyId = programming.CompanyId,
                            BudgetStartDate = programming.BudgetStartDate,
                            BudgetEndDate = programming.BudgetEndDate,
                            ForecastProgrammings = programming.ForecastProgrammings.ToList().Select(fp => new
                            {
                                FiscalYear = fp.FiscalYear,
                                CompanyId = fp.CompanyId,
                                Item = fp.Item,
                                Display = string.Format("Forecast {0}", fp.Item),
                                StartDate = fp.StartDate,
                                EndDate = fp.EndDate
                            })
                        });
                    }
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Configuration", false, true)]
        public IHttpActionResult PostProgramming(Programming programming)
        {
            using (var appContext = new SpresIdentityDbContext())
            using (var db = new SpresContext())
            {
                try
                {
                    if (db.Programmings.Find(programming.FiscalYear, programming.CompanyId) == null)
                    {
                        db.Programmings.Add(programming);

                        for (int i = 1; i < 4; i++)
                        {
                            db.ForecastProgrammings.Add(new ForecastProgramming()
                            {
                                Item = i,
                                CompanyId = programming.CompanyId,
                                FiscalYear = programming.FiscalYear
                            });
                        }
                        db.SaveChanges();
                        this.RegisterEvent("Se agregó el periodo de presupuestación " + programming.FiscalYear);
                        return Ok(new Programming { FiscalYear = programming.FiscalYear, CompanyId = programming.CompanyId, BudgetStartDate = programming.BudgetStartDate, BudgetEndDate = programming.BudgetEndDate });
                    }
                    return BadRequest("-1");
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Configuration", false, true)]
        public IHttpActionResult PutProgramming(Programming programming)
        {
            using (SpresContext db = new SpresContext())
            {
                try
                {
                    db.Entry(programming).State = EntityState.Modified;
                    db.SaveChanges();
                    this.RegisterEvent("Se modificó el periodo de presupuestación " + programming.FiscalYear);
                    return Ok(new
                    {
                        FiscalYear = programming.FiscalYear,
                        CompanyId = programming.CompanyId,
                        BudgetStartDate = programming.BudgetStartDate,
                        BudgetEndDate = programming.BudgetEndDate,
                    });
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }


        public IHttpActionResult PutSendEmail(int fiscalYear, int companyId)
        {
            using (var db = new SpresContext())
            using (var appContext = new SpresIdentityDbContext())
            {
                var programming = db.Programmings.Find(fiscalYear, companyId);

                if (programming == null)
                {
                    return NotFound();
                }
                else
                {
                    var userManager = new UserManager<User>(new UserStore<User>(appContext));
                    var emailAddresses = new List<string>();

                    var companyCostCenters = db.CostCenters.Where(cc => cc.CompanyId == programming.CompanyId).ToList();
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
                        programming.FiscalYear.ToString(),
                        programming.BudgetStartDate.ToShortDateString(),
                        programming.BudgetEndDate.ToShortDateString()
                    };

                    try
                    {
                        EmailHelper.Send("ProgrammingChanged", emailParameters, emailAddresses);
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
