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
    public class BudgetsController : ApiController
    {

        [Route("api/Budgets/IsAuthorized/{costCenterId}/{fiscalYear}/{companyId}")]
        [SpresSecurityAttribute("Budgeting", true, false)]
        public IHttpActionResult GetIsAuthorized(int costCenterId, int fiscalYear, int companyId)
        {
            using (var db = new SpresContext())
            {
                var budget = db.Budgets.FirstOrDefault(b => b.CompanyId == companyId && b.CostCenterId == costCenterId && b.FiscalYear == fiscalYear);
                var programming = db.Programmings.Find(fiscalYear, companyId);
                var programmingIsActive = false;
                if (programming != null)
                {
                    programmingIsActive = programming.BudgetStartDate <= DateTime.Now && DateTime.Now <= programming.BudgetEndDate;
                }
                
                if (budget == null)
                {
                    return Ok(new
                    {
                        Status = BudgetStatus.None,
                        IsProtected = false,
                        IsTracked = false,
                        ProgrammingIsActive = programmingIsActive
                    });
                }
                else
                {
                    return Ok(new
                    {
                        Status = budget.Status,
                        IsProtected = budget.IsProtected,
                        IsTracked = budget.IsTracked,
                        ProgrammingIsActive = programmingIsActive
                    });
                }
            }
        }

        [SpresSecurityAttribute("Budgeting", true, false)]
        [Route("api/Budgets/Total/{costCenterId}/{fiscalYear}/{companyId}")]
        public IHttpActionResult GetBudgetTotal(int costCenterId, int companyId, int fiscalYear)
        {
            decimal Total = 0;

            using (var db = new SpresContext())
            {
                var budget = db.Budgets.FirstOrDefault(b => b.CostCenterId.Equals(costCenterId) && b.CompanyId.Equals(companyId) && b.FiscalYear.Equals(fiscalYear));

                var country = db.Companies.Find(companyId).Country;
                var currency = db.Countries.Find(country).DefaultCurrency.Name;

                if (budget == null)
                {
                    return NotFound();
                }
                
                foreach (var sheet in budget.Sheets.ToList())
                {
                    foreach (var parentLine in sheet.Lines.Where(bl => bl.ParentId == null).ToList())
                    {
                        foreach (var monthDetail in parentLine.MonthDetails.ToList())
                        {
                            Total += monthDetail.Target;
                        }
                    }
                }
                var userGuid = User.Identity.GetUserId();

                return Ok(new { 
                    Total = Total.ToString("C") + " (" + currency + ")",
                    IsProtected = budget.IsProtected,
                    HasAuthorization = budget.Authorizations.Any(b => b.AuthorizerGUID == userGuid)
                });
            }
        }

        [Route("api/BudgetAvailablePackages/{costCenterId}/{fiscalYear}/{companyId}")]
        [SpresSecurityAttribute("Budgeting", true, false)]
        public IHttpActionResult GetBudgetAvailablePackages(int costCenterId, int fiscalYear, int companyId)
        {
            var username = User.Identity.Name;
            using (var dbContext = new SpresContext())
            {
                var result = new List<Package>();
                var combinedPermissions = PermissionsController.GetCombinedPermissions(username);

                var budget = dbContext.Budgets.FirstOrDefault(b => b.CostCenterId == costCenterId && b.FiscalYear == fiscalYear && b.CompanyId == companyId);

                if (budget == null)
                {
                    budget = new Budget(); // No se debe de guardar en la base de datos.
                }
                var createdPackages = budget.Sheets.Select(s => s.PackageId).ToList();
                if (combinedPermissions[0].Edit)
                {
                    result.AddRange(dbContext.Packages.Where(p => !createdPackages.Contains(p.Id) && !p.HR).ToList()
                        .Select(p => new Package { Id = p.Id, Name = p.Name }));
                }

                if (combinedPermissions[1].Edit)
                {
                    result.AddRange(dbContext.Packages.Where(p => !createdPackages.Contains(p.Id) && p.HR).ToList()
                        .Select(p => new Package { Id = p.Id, Name = p.Name }));
                }
                return Ok(result.OrderBy(p => p.Name).ToDataResult());
            }

        }

        [SpresSecurityAttribute("Budgeting", false, true)]

        public IHttpActionResult PutBudget(int costCenterId, int fiscalYear, int companyId, int status)
        {
            try
            {
                using (var identityDb = new SpresIdentityDbContext())
                using (var db = new SpresContext())
                {
                    var budget = db.Budgets.FirstOrDefault(b => b.CompanyId == companyId && b.CostCenterId == costCenterId && b.FiscalYear == fiscalYear);

                    if (budget == null)
                    {
                        return NotFound();
                    }
                    else
                    {
                        var userManager = identityDb.UserManager;
                        var username = User.Identity.Name;
                        var user = userManager.FindByName(username);

                        if (user == null)
                        {
                            return InternalServerError();
                        }
                        else
                        {
                            var authorization = budget.Authorizations.FirstOrDefault(ba => ba.AuthorizerGUID == user.Id);

                            if (authorization == null)
                            {
                                return BadRequest(); 
                                // El responsable de centros de costos aún no ha enviado una solicitud de revisión de presupuesto.
                            }
                            else
                            {
                                switch(status)
                                {
                                    case 0:
                                        authorization.Status = AuthorizationStatus.Pending;
                                        break;
                                    case 1:
                                        authorization.Status = AuthorizationStatus.Reviewed;
                                        break;
                                    case 2:
                                        authorization.Status = AuthorizationStatus.Authorized;
                                        break;
                                    case 3:
                                        authorization.Status = AuthorizationStatus.Enabled;
                                        break;
                                    default:
                                        break;
                                }

                                db.Entry(authorization).State = EntityState.Modified;
                                SaveHistory(budget, db);
                                db.SaveChanges();
                                
                                var costCenterResponsibleId = budget.CostCenter.ResponsibleGUID;

                                if (authorization.Status == AuthorizationStatus.Authorized && !string.IsNullOrEmpty(costCenterResponsibleId))
                                {
                                    var ccResponsible = userManager.FindById(costCenterResponsibleId);

                                    if (ccResponsible != null)
                                    {
                                        var emailParameters = new List<string>()
                                        {
                                            budget.Company.Name,
                                            budget.FiscalYear.ToString(),
                                            string.Format("{0} - {1}", budget.CostCenter.Code, budget.CostCenter.Name),
                                            user.Name
                                        };
                                        EmailHelper.Send("BudgetAuthorized", emailParameters, new List<string> { ccResponsible.Email });
                                    }
                                }
                                this.RegisterEvent("Se modificó la autorización del presupuesto " + budget.FiscalYear + " del centro de costo " + budget.CostCenter.Display);
                                return Ok();
                            }
                        }
                    }
                }   
            }
            catch (Exception ex)
            {
                ErrorLog.SaveError(ex);
                return InternalServerError(ex);
            }
        }

        [Route("api/Budgets/RequestAuthorization/{companyId}/{fiscalYear}/{costCenterId}")]
        [SpresSecurityAttribute("Budgeting", false, true)]
        public IHttpActionResult PostRequestAuthorization(int companyId, int fiscalYear, int costCenterId)
        {
            try
            {
                using (var db = new SpresContext())
                using (var identityDb = new SpresIdentityDbContext())
                {
                    var budget = db.Budgets.FirstOrDefault(b => b.CompanyId == companyId && b.CostCenterId == costCenterId && b.FiscalYear == fiscalYear);
                    var company = db.Companies.Find(companyId);
                    var userManager = identityDb.UserManager;

                    var currentUser = userManager.FindByName(User.Identity.Name);

                    if (budget == null || company == null || currentUser == null)
                    {
                        return NotFound();
                    }
                    else
                    {
                        var authorizers = company.Authorizers.ToList();
                        if (authorizers.Any())
                        {
                            var emailAddresses = new List<string>();
                            
                            foreach (var authorizer in authorizers)
                            {
                                var authorizerUser = userManager.FindById(authorizer.AuthorizerGUID);
                                if (authorizerUser != null)
                                {
                                    emailAddresses.Add(authorizerUser.Email);

                                    if (!budget.Authorizations.Any(ba => ba.AuthorizerGUID == authorizer.AuthorizerGUID))
                                    {
                                        budget.Authorizations.Add(new BudgetAuthorization()
                                        {
                                            AuthorizerGUID = authorizer.AuthorizerGUID,
                                            RequestDate = DateTime.Now,
                                            Status = AuthorizationStatus.Pending
                                        });
                                    }
                                }
                            }
                            this.RegisterEvent("Se envió solicitud de autorización de presupuesto " + budget.FiscalYear + " del centro de costo " + budget.CostCenter.Display);
                            SaveHistory(budget, db);

                            db.SaveChanges();

                            var emailParameters = new List<string>()
                            {
                                currentUser.Name,
                                budget.Company.Name,
                                budget.FiscalYear.ToString(),
                                string.Format("{0} - {1}", budget.CostCenter.Code, budget.CostCenter.Name)
                            };
                            
                            EmailHelper.Send("AuthorizationRequested", emailParameters, emailAddresses);
                            
                            return Ok();
                        }
                        string texto = "No se encontró ningún responsable de autorización para la región.";
                        return InternalServerError(new Exception(texto));
                    }
                }
            }
            catch (SmtpException ex)
            {
                string texto = "Ocurrió un error al intentar enviar los correos electrónicos a los responsables de autorización. Intente nuevamente o contacte al administrador del sistema.";
                ErrorLog.SaveError(ex);
                return InternalServerError(new Exception(texto));
            }
            catch (Exception ex)
            {
                string texto = "Ocurrió un error interno al intentar completar la operación.";
                ErrorLog.SaveError(ex);
                return InternalServerError(new Exception(texto));
            }
        }
        
        public static void SaveHistory(Budget budget, SpresContext db)
        {
            foreach (var sheet in budget.Sheets.ToList())
            {
                foreach (var line in sheet.Lines.ToList())
                {
                    foreach (var monthDetail in line.MonthDetails.ToList())
                    {
                        monthDetail.Histories.Add(new BudgetMonthHistory()
                        {
                            ExpenseDetail = monthDetail.ExpenseDetail,
                            Forecast = monthDetail.Forecast,
                            HistoricalDate = DateTime.Now,
                            Month = monthDetail.Month,
                            Quantity = monthDetail.Quantity,
                            Real = monthDetail.Real,
                            Target = monthDetail.Target,
                            UnitCost = monthDetail.UnitCost
                        });
                    }
                }
            }     
        }

        public static int GetBudgetVersion(Budget budget)
        {
            var programming = budget.BudgetProgramming;
            var forecastProgrammings = programming.ForecastProgrammings;
            var forecast1 = forecastProgrammings.FirstOrDefault(fp => fp.Item == 1);
            var forecast2 = forecastProgrammings.FirstOrDefault(fp => fp.Item == 2);
            var forecast3 = forecastProgrammings.FirstOrDefault(fp => fp.Item == 3);

            if (programming.BudgetStartDate <= DateTime.Now && DateTime.Now <= programming.BudgetEndDate)
            {
                return 0;
            }
            else if (forecast1 != null && forecast1.StartDate <= DateTime.Now && DateTime.Now <= forecast1.EndDate)
            {
                return 1;
            }
            else if (forecast2 != null && forecast2.StartDate <= DateTime.Now && DateTime.Now <= forecast2.EndDate)
            {
                return 2;
            }
            else if (forecast3 != null && forecast3.StartDate <= DateTime.Now && DateTime.Now <= forecast3.EndDate)
            {
                return 3;
            }
            else
            {
                return -1;
            }
        }
    }
}

