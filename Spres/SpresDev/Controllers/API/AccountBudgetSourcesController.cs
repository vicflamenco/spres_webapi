using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Models;
using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Http;
namespace SpresDev.Controllers.Api
{
    public class AccountBudgetSourcesController : ApiController
    {
        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetAll()
        {
            try
            {
                using (SpresContext dbContext = new SpresContext())
                {
                    return Ok(dbContext.AccountBudgetSources
                        .OrderBy(e => e.Name)
                        .ToList().Select(e => new AccountBudgetSource()
                        {
                            Id = e.Id,
                            Name = e.Name,
                            Source = e.Source,
                            Formule = e.Formule,
                            AccountId = e.AccountId,
                            ExpenseType = e.ExpenseType,
                            PremiseType = e.PremiseType
                        }).ToDataResult());
                }
            }
            catch (Exception ex)
            {
                ErrorLog.SaveError(ex);
                return InternalServerError(ex);
            }
        }


        [SpresSecurityAttribute("Catalogs", true, false)]
        public IHttpActionResult GetById(int id)
        {
            try
            {
                using (SpresContext dbContext = new SpresContext())
                {
                    return Ok(dbContext.AccountBudgetSources
                        .OrderBy(e => e.Name)
                        .Where(e => e.AccountId == id)
                        .ToList().Select(e => new AccountBudgetSource()
                        {
                            Id = e.Id,
                            Name = e.Name,
                            Source = e.Source,
                            Formule = e.Formule,
                            AccountId = e.AccountId,
                            ExpenseType = e.ExpenseType,
                            PremiseType = e.PremiseType
                        }).ToDataResult());
                }
            }
            catch (Exception ex)
            {
                ErrorLog.SaveError(ex);
                return InternalServerError(ex);
            }
            
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PostAccountBudgetSource(AccountBudgetSource accountBS)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    dbContext.AccountBudgetSources.Add(accountBS);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se agregó " + accountBS.Name + " como nuevo origen de presupuestación");
                    return Ok(new AccountBudgetSource
                    {
                        Id = accountBS.Id,
                        Name = accountBS.Name,
                        Source = accountBS.Source,
                        Formule = accountBS.Formule,
                        AccountId = accountBS.AccountId,
                        ExpenseType = accountBS.ExpenseType,
                        PremiseTypeId = accountBS.PremiseTypeId
                    });
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [SpresSecurityAttribute("Catalogs", false, true)]
        public IHttpActionResult PutAccountBudgetSource(AccountBudgetSource accountBS)
        {
            using (SpresContext dbContext = new SpresContext())
            {
                try
                {
                    dbContext.Entry(accountBS).State = EntityState.Modified;
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se editó el origen de presupuestación " + accountBS.Name);

                    return Ok(new AccountBudgetSource
                    {
                        Id = accountBS.Id,
                        Source = accountBS.Source,
                        Name = accountBS.Name,
                        Formule = accountBS.Formule,
                        AccountId = accountBS.AccountId,
                        ExpenseType = accountBS.ExpenseType,
                        PremiseTypeId = accountBS.PremiseTypeId
                    });
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
