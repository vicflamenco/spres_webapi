using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Spres.Infrastructure;
using Spres.Infrastructure.ErrorLog;
using Spres.Infrastructure.Security;
using Spres.Models;
using SpresDev.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Threading;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class ForecastsController : ApiController
    {
        [Route("api/Forecasts/BudgetingLineAdjustment/{lineId}")]
        public IHttpActionResult GetBudgetingLineAdjustment(int lineId)
        {
            using (var db = new SpresContext())
            {
                var line = db.BudgetLines.Find(lineId);
                if (line == null)
                {
                    return NotFound();
                }
                else
                {
                    var budgetVersion = BudgetsController.GetBudgetVersion(line.Sheet.Budget);
                    if (budgetVersion <= 0)
                    {
                        return BadRequest("Los períodos de forecast no se encuentran habilitados.");
                    }
                    else
                    {
                        var monthDetails = GetMonthDetailsLatestAdjustment(line);
                        return Ok(new
                        {
                            Display = line.Description,
                            MonthDetails = monthDetails,
                            Total = monthDetails.Sum(),
                            CurrencyId = db.Countries.Find(line.Sheet.Budget.Company.Country).DefaultCurrencyId
                        });
                    }
                }
            }
        }

        [Route("api/Forecasts/IncreasesModifications/{lineId}")]
        public IHttpActionResult GetIncreasesModifications(int lineId)
        {
            using (var db = new SpresContext())
            {
                var line = db.BudgetLines.Find(lineId);
                if (line == null)
                {
                    return NotFound();
                }
                else
                {
                    var budgetVersion = BudgetsController.GetBudgetVersion(line.Sheet.Budget);
                    if (budgetVersion <= 0)
                    {
                        return BadRequest("Los períodos de forecast no se encuentran habilitados.");
                    }
                    else
                    {
                        var monthDetails = GetMonthDetailsLatestAdjustment(line);
                        return Ok(new
                        {
                            Display = line.Description,
                            MonthDetails = monthDetails,
                            Total = monthDetails.Sum(),
                            CurrencyId = db.Countries.Find(line.Sheet.Budget.Company.Country).DefaultCurrencyId
                        });
                    }
                }
            }
        }

        private List<decimal> GetMonthDetailsLatestAdjustment(BudgetLine line)
        {
            var result = new List<decimal>();
            foreach (var monthDetail in line.MonthDetails.OrderBy(md => md.Month))
            {
                var orderedHistories = monthDetail.Histories.OrderByDescending(h => h.HistoricalDate).ToList();
                var forecast1 = orderedHistories.FirstOrDefault(h => h.Version == 1);
                var forecast2 = orderedHistories.FirstOrDefault(h => h.Version == 2);
                var forecast3 = orderedHistories.FirstOrDefault(h => h.Version == 3);
                result.Add((forecast3 != null) ? forecast3.Forecast : (forecast2 != null) ? forecast2.Forecast : (forecast1 != null) ? forecast1.Forecast : monthDetail.Target);
            }
            return result;
        }

        private decimal GetLatestAccountAdjustment(BudgetMonthDetail monthDetail)
        {
            decimal result = 0;
            var orderedHistories = monthDetail.Histories.OrderByDescending(h => h.HistoricalDate).ToList();
            var forecast1 = orderedHistories.FirstOrDefault(h => h.Version == 1);
            var forecast2 = orderedHistories.FirstOrDefault(h => h.Version == 2);
            var forecast3 = orderedHistories.FirstOrDefault(h => h.Version == 3);
            result = (forecast3 != null) ? forecast3.Forecast : (forecast2 != null) ? forecast2.Forecast : (forecast1 != null) ? forecast1.Forecast : monthDetail.Target;
            return result;
        }

        [Route("api/Forecasts/AccountAdjustment/{lineId}")]
        public IHttpActionResult GetAccountAdjustment(int lineId)
        {
            using(var db = new SpresContext())
            {
                var line = db.BudgetLines.Find(lineId);
                if (line == null)
                {
                    return NotFound();
                }
                else
                {
                    var budgetVersion = BudgetsController.GetBudgetVersion(line.Sheet.Budget);
                    if (budgetVersion <= 0)
                    {
                        return BadRequest("Los períodos de forecast no se encuentran habilitados");
                    }
                    else
                    {
                        var costCenter = line.Sheet.Budget.CostCenter;
                        return Ok(new
                        {
                            Display = line.Account.Display,
                            ChildAccounts = line.Sheet.Lines.Where(bl => bl.ParentId != null && bl.Tag == null && bl.Account.Type.Split(',').Contains(costCenter.Type))
                            .ToList().Select(bl => new
                            {
                                Id = bl.Id,
                                Name = bl.Description
                            }),
                            CurrencyId = db.Countries.Find(line.Sheet.Budget.Company.Country).DefaultCurrencyId
                        });
                    }
                    
                }
            }
        }

        [Route("api/Forecasts/SavingsTransfer/{lineId}")]
        public IHttpActionResult GetSavingsTransfer(int lineId)
        {
            using (var db = new SpresContext())
            {
                var line = db.BudgetLines.Find(lineId);
                if (line == null)
                {
                    return NotFound();
                }
                else
                {
                    var budgetVersion = BudgetsController.GetBudgetVersion(line.Sheet.Budget);
                    if (budgetVersion <= 0)
                    {
                        return BadRequest("Los períodos de forecast no se encuentran habilitados");
                    }
                    else if (DateTime.Now.Month > 1)
                    {
                        var monthDetail = line.MonthDetails.FirstOrDefault(md => md.Month == DateTime.Now.Month - 1);
                        if (monthDetail == null)
                        {
                            return InternalServerError();
                        }
                        else
                        {
                            var costCenter = line.Sheet.Budget.CostCenter;
                            return Ok(new
                            {
                                Display = line.Account.Display,
                                ChildAccounts = line.Sheet.Lines.Where(bl => bl.ParentId != null && bl.Tag == null && bl.Account.Type.Split(',').Contains(costCenter.Type))
                                .ToList().Select(bl => new
                                {
                                    Id = bl.Id,
                                    Name = bl.Description
                                }),
                                Savings = GetLatestSavingsAmount(monthDetail),
                                CurrencyId = db.Countries.Find(line.Sheet.Budget.Company.Country).DefaultCurrencyId,
                                MonthNumber = DateTime.Now.Month - 1
                            });
                        }
                    }
                    else
                    {
                        return BadRequest("Los ahorros solamente pueden ser trasladados a partir del mes de febrero.");
                    }
                }
            }
        }

        private decimal GetLatestSavingsAmount(BudgetMonthDetail monthDetail)
        {
            var orderedHistories = monthDetail.Histories.OrderByDescending(h => h.HistoricalDate).ToList();
            var forecast1 = orderedHistories.FirstOrDefault(h => h.Version == 1);
            var forecast2 = orderedHistories.FirstOrDefault(h => h.Version == 2);
            var forecast3 = orderedHistories.FirstOrDefault(h => h.Version == 3);

            decimal forecastValue = (forecast3 != null) ? forecast3.Forecast : (forecast2 != null) ? forecast2.Forecast
                : (forecast1 != null) ? forecast1.Forecast : monthDetail.Target;

            return (forecastValue - monthDetail.Real) > 0 ? (forecastValue - monthDetail.Real) : 0; 
        }

        public IHttpActionResult GetChildAccounts(int lineId, int monthNumber)
        {
            using (var db = new SpresContext())
            {
                var line = db.BudgetLines.Find(lineId);
                if (line == null)
                {
                    return NotFound();
                }
                else
                {
                    var monthDetail = line.MonthDetails.FirstOrDefault(md => md.Month == monthNumber);
                    if (monthDetail == null)
                    {
                        return InternalServerError();
                    }
                    else
                    {
                        return Ok(new
                        {
                            Target = GetLatestAccountAdjustment(monthDetail).ToString("0,0.00")
                        });
                    }
                }
            }
        }

        [Route("api/Forecasts/IncreasedPackages/{fiscalYear}/{companyId}/{costCenterId}")]
        public IHttpActionResult GetIncreasedPackages(int costCenterId, int fiscalYear, int companyId)
        {
            using (SpresContext db = new SpresContext())
            {
                try
                {
                    var budget = db.Budgets.FirstOrDefault(b => b.CostCenterId == costCenterId && b.FiscalYear == fiscalYear && b.CompanyId == companyId);

                    if (budget == null)
                    {
                        return NotFound();
                    }
                    else
                    {
                        var budgetVersion = BudgetsController.GetBudgetVersion(budget);

                        if (budgetVersion <= 0)
                        {
                            return BadRequest("Los períodos de forecast no se encuentran habilitados");
                        }
                        else
                        {
                            var sheets = new List<Data>();

                            foreach (var sheet in budget.Sheets)
                            {
                                var found = false;

                                foreach (var line in sheet.Lines)
                                {
                                    foreach (var monthDetail in line.MonthDetails)
                                    {
                                        var last = monthDetail.Histories.OrderByDescending(h => h.HistoricalDate).FirstOrDefault();

                                        if (last != null && last.Reason == BudgetMonthHistoryReasons.Increase)
                                        {
                                            if (!sheets.Any(s => s.Id == sheet.PackageId))
                                            {
                                                sheets.Add(new Data() { Id = sheet.PackageId, Name = sheet.Package.Name });
                                                found = true;
                                                break;
                                            }

                                        }
                                    }

                                    if (found)
                                    {
                                        break;
                                    }
                                }
                            }
                            return Ok(sheets);
                        }
                    }
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
        }

        [Route("api/Forecasts/ComparisonData/{companyId}/{fiscalYear}/{costCenterId}/{packageId}")]
        public IHttpActionResult GetComparisonData(int companyId, int fiscalYear, int costCenterId, int packageId)
        {
            try
            {
                using (var db = new SpresContext())
                {
                    var budget = db.Budgets.FirstOrDefault(b => b.CompanyId == companyId && b.FiscalYear == fiscalYear && b.CostCenterId == costCenterId);
                    
                    if (budget == null)
                    {
                        return NotFound();
                    }
                    else
                    {
                        var budgetVersion = BudgetsController.GetBudgetVersion(budget);
                        if (budgetVersion <= 0)
                        {
                            return BadRequest("Los períodos de forecast no se encuentran habilitados");
                        }
                        else
                        {
                            var sheet = budget.Sheets.FirstOrDefault(bs => bs.PackageId == packageId);

                            if (sheet == null)
                            {
                                return NotFound();
                            }
                            else
                            {
                                var increasedChildLines = new List<BudgetLine>();

                                foreach (var line in sheet.Lines)
                                {
                                    foreach (var monthDetail in line.MonthDetails)
                                    {
                                        var last = monthDetail.Histories.OrderByDescending(h => h.HistoricalDate).FirstOrDefault();

                                        if (last != null && last.Reason == BudgetMonthHistoryReasons.Increase && !increasedChildLines.Contains(line))
                                        {
                                            increasedChildLines.Add(line);
                                            break;
                                        }
                                    }
                                }

                                var result = CreateComparisonViewModel(increasedChildLines, db);
                                return Ok(result);
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

        private List<BudgetSheetViewModel> CreateComparisonViewModel(List<BudgetLine> lines, SpresContext db)
        {
            
            var lstCurrentParentLines = new List<BudgetLineViewModel>();
            var lstCurrentChildrenLines = new List<BudgetLineViewModel>();
            var lstCurrentSubChildrenLines = new List<BudgetLineViewModel>();

            var lstHistoricalParentLines = new List<BudgetLineViewModel>();
            var lstHistoricalChildrenLines = new List<BudgetLineViewModel>();
            var lstHistoricalSubChildrenLines = new List<BudgetLineViewModel>();

            foreach (var line in lines)
            {
                var budgetSource = db.AccountBudgetSources.FirstOrDefault(a => a.AccountId == line.AccountId);

                var currentModel = new BudgetLineViewModel
                {
                    Id = line.Id,
                    ParentId = line.ParentId,
                    Description = line.Description,
                    AccountId = line.AccountId,
                    PremiseId = line.PremiseId,
                    ExpenseType = (budgetSource == null) ? BudgetExpenseType.None : budgetSource.ExpenseType
                };

                var historicalModel = new BudgetLineViewModel
                {
                    Id = line.Id,
                    ParentId = line.ParentId,
                    Description = line.Description,
                    AccountId = line.AccountId,
                    PremiseId = line.PremiseId,
                    ExpenseType = (budgetSource == null) ? BudgetExpenseType.None : budgetSource.ExpenseType
                };

                foreach (var monthDetail in line.MonthDetails)
                {
                    var orderedHistories = monthDetail.Histories.OrderByDescending(h => h.HistoricalDate);
                    var last = orderedHistories.FirstOrDefault();
                    var secondLast = orderedHistories.Skip(1).Take(1).FirstOrDefault();

                    if (last != null)
                    {
                        switch (monthDetail.Month)
                        {
                            case 1:
                                currentModel.January_Quantity = last.Quantity;
                                currentModel.January_UnitCost = last.UnitCost;
                                currentModel.January_Target = last.Target;
                                currentModel.January_Forecast = last.Forecast;
                                currentModel.January_Real = last.Real;
                                break;
                            case 2:
                                currentModel.February_Quantity = last.Quantity;
                                currentModel.February_UnitCost = last.UnitCost;
                                currentModel.February_Target = last.Target;
                                currentModel.February_Forecast = last.Forecast;
                                currentModel.February_Real = last.Real;
                                break;
                            case 3:
                                currentModel.March_Quantity = last.Quantity;
                                currentModel.March_UnitCost = last.UnitCost;
                                currentModel.March_Target = last.Target;
                                currentModel.March_Forecast = last.Forecast;
                                currentModel.March_Real = last.Real;
                                break;
                            case 4:
                                currentModel.April_Quantity = last.Quantity;
                                currentModel.April_UnitCost = last.UnitCost;
                                currentModel.April_Target = last.Target;
                                currentModel.April_Forecast = last.Forecast;
                                currentModel.April_Real = last.Real;
                                break;
                            case 5:
                                currentModel.May_Quantity = last.Quantity;
                                currentModel.May_UnitCost = last.UnitCost;
                                currentModel.May_Target = last.Target;
                                currentModel.May_Forecast = last.Forecast;
                                currentModel.May_Real = last.Real;
                                break;
                            case 6:
                                currentModel.June_Quantity = last.Quantity;
                                currentModel.June_UnitCost = last.UnitCost;
                                currentModel.June_Target = last.Target;
                                currentModel.June_Forecast = last.Forecast;
                                currentModel.June_Real = last.Real;
                                break;
                            case 7:
                                currentModel.July_Quantity = last.Quantity;
                                currentModel.July_UnitCost = last.UnitCost;
                                currentModel.July_Target = last.Target;
                                currentModel.July_Forecast = last.Forecast;
                                currentModel.July_Real = last.Real;
                                break;
                            case 8:
                                currentModel.August_Quantity = last.Quantity;
                                currentModel.August_UnitCost = last.UnitCost;
                                currentModel.August_Target = last.Target;
                                currentModel.August_Forecast = last.Forecast;
                                currentModel.August_Real = last.Real;
                                break;
                            case 9:
                                currentModel.September_Quantity = last.Quantity;
                                currentModel.September_UnitCost = last.UnitCost;
                                currentModel.September_Target = last.Target;

                                currentModel.September_Forecast = last.Forecast;
                                currentModel.September_Real = last.Real;
                                break;
                            case 10:
                                currentModel.October_Quantity = last.Quantity;
                                currentModel.October_UnitCost = last.UnitCost;
                                currentModel.October_Target = last.Target;
                                currentModel.October_Forecast = last.Forecast;
                                currentModel.October_Real = last.Real;
                                break;
                            case 11:
                                currentModel.November_Quantity = last.Quantity;
                                currentModel.November_UnitCost = last.UnitCost;
                                currentModel.November_Target = last.Target;
                                currentModel.November_Forecast = last.Forecast;
                                currentModel.November_Real = last.Real;
                                break;
                            case 12:
                                currentModel.December_Quantity = last.Quantity;
                                currentModel.December_UnitCost = last.UnitCost;
                                currentModel.December_Target = last.Target;
                                currentModel.December_Forecast = last.Forecast;
                                currentModel.December_Real = last.Real;
                                break;
                            default:
                                break;
                        }
                    }
                    else
                    {
                        switch (monthDetail.Month)
                        {
                            case 1:
                                currentModel.January_Quantity = monthDetail.Quantity;
                                currentModel.January_UnitCost = monthDetail.UnitCost;
                                currentModel.January_Target = monthDetail.Target;
                                currentModel.January_Forecast = monthDetail.Forecast;
                                currentModel.January_Real = monthDetail.Real;
                                break;
                            case 2:
                                currentModel.February_Quantity = monthDetail.Quantity;
                                currentModel.February_UnitCost = monthDetail.UnitCost;
                                currentModel.February_Target = monthDetail.Target;
                                currentModel.February_Forecast = monthDetail.Forecast;
                                currentModel.February_Real = monthDetail.Real;
                                break;
                            case 3:
                                currentModel.March_Quantity = monthDetail.Quantity;
                                currentModel.March_UnitCost = monthDetail.UnitCost;
                                currentModel.March_Target = monthDetail.Target;
                                currentModel.March_Forecast = monthDetail.Forecast;
                                currentModel.March_Real = monthDetail.Real;
                                break;
                            case 4:
                                currentModel.April_Quantity = monthDetail.Quantity;
                                currentModel.April_UnitCost = monthDetail.UnitCost;
                                currentModel.April_Target = monthDetail.Target;
                                currentModel.April_Forecast = monthDetail.Forecast;
                                currentModel.April_Real = monthDetail.Real;
                                break;
                            case 5:
                                currentModel.May_Quantity = monthDetail.Quantity;
                                currentModel.May_UnitCost = monthDetail.UnitCost;
                                currentModel.May_Target = monthDetail.Target;
                                currentModel.May_Forecast = monthDetail.Forecast;
                                currentModel.May_Real = monthDetail.Real;
                                break;
                            case 6:
                                currentModel.June_Quantity = monthDetail.Quantity;
                                currentModel.June_UnitCost = monthDetail.UnitCost;
                                currentModel.June_Target = monthDetail.Target;
                                currentModel.June_Forecast = monthDetail.Forecast;
                                currentModel.June_Real = monthDetail.Real;
                                break;
                            case 7:
                                currentModel.July_Quantity = monthDetail.Quantity;
                                currentModel.July_UnitCost = monthDetail.UnitCost;
                                currentModel.July_Target = monthDetail.Target;
                                currentModel.July_Forecast = monthDetail.Forecast;
                                currentModel.July_Real = monthDetail.Real;
                                break;
                            case 8:
                                currentModel.August_Quantity = monthDetail.Quantity;
                                currentModel.August_UnitCost = monthDetail.UnitCost;
                                currentModel.August_Target = monthDetail.Target;
                                currentModel.August_Forecast = monthDetail.Forecast;
                                currentModel.August_Real = monthDetail.Real;
                                break;
                            case 9:
                                currentModel.September_Quantity = monthDetail.Quantity;
                                currentModel.September_UnitCost = monthDetail.UnitCost;
                                currentModel.September_Target = monthDetail.Target;

                                currentModel.September_Forecast = monthDetail.Forecast;
                                currentModel.September_Real = monthDetail.Real;
                                break;
                            case 10:
                                currentModel.October_Quantity = monthDetail.Quantity;
                                currentModel.October_UnitCost = monthDetail.UnitCost;
                                currentModel.October_Target = monthDetail.Target;
                                currentModel.October_Forecast = monthDetail.Forecast;
                                currentModel.October_Real = monthDetail.Real;
                                break;
                            case 11:
                                currentModel.November_Quantity = monthDetail.Quantity;
                                currentModel.November_UnitCost = monthDetail.UnitCost;
                                currentModel.November_Target = monthDetail.Target;
                                currentModel.November_Forecast = monthDetail.Forecast;
                                currentModel.November_Real = monthDetail.Real;
                                break;
                            case 12:
                                currentModel.December_Quantity = monthDetail.Quantity;
                                currentModel.December_UnitCost = monthDetail.UnitCost;
                                currentModel.December_Target = monthDetail.Target;
                                currentModel.December_Forecast = monthDetail.Forecast;
                                currentModel.December_Real = monthDetail.Real;
                                break;
                            default:
                                break;
                        }
                    }

                    if (secondLast != null)
                    {
                        switch (monthDetail.Month)
                        {
                            case 1:
                                historicalModel.January_Quantity = secondLast.Quantity;
                                historicalModel.January_UnitCost = secondLast.UnitCost;
                                historicalModel.January_Target = secondLast.Target;
                                historicalModel.January_Forecast = secondLast.Forecast;
                                historicalModel.January_Real = secondLast.Real;
                                break;
                            case 2:
                                historicalModel.February_Quantity = secondLast.Quantity;
                                historicalModel.February_UnitCost = secondLast.UnitCost;
                                historicalModel.February_Target = secondLast.Target;
                                historicalModel.February_Forecast = secondLast.Forecast;
                                historicalModel.February_Real = secondLast.Real;
                                break;
                            case 3:
                                historicalModel.March_Quantity = secondLast.Quantity;
                                historicalModel.March_UnitCost = secondLast.UnitCost;
                                historicalModel.March_Target = secondLast.Target;
                                historicalModel.March_Forecast = secondLast.Forecast;
                                historicalModel.March_Real = secondLast.Real;
                                break;
                            case 4:
                                historicalModel.April_Quantity = secondLast.Quantity;
                                historicalModel.April_UnitCost = secondLast.UnitCost;
                                historicalModel.April_Target = secondLast.Target;
                                historicalModel.April_Forecast = secondLast.Forecast;
                                historicalModel.April_Real = secondLast.Real;
                                break;
                            case 5:
                                historicalModel.May_Quantity = secondLast.Quantity;
                                historicalModel.May_UnitCost = secondLast.UnitCost;
                                historicalModel.May_Target = secondLast.Target;
                                historicalModel.May_Forecast = secondLast.Forecast;
                                historicalModel.May_Real = secondLast.Real;
                                break;
                            case 6:
                                historicalModel.June_Quantity = secondLast.Quantity;
                                historicalModel.June_UnitCost = secondLast.UnitCost;
                                historicalModel.June_Target = secondLast.Target;
                                historicalModel.June_Forecast = secondLast.Forecast;
                                historicalModel.June_Real = secondLast.Real;
                                break;
                            case 7:
                                historicalModel.July_Quantity = secondLast.Quantity;
                                historicalModel.July_UnitCost = secondLast.UnitCost;
                                historicalModel.July_Target = secondLast.Target;
                                historicalModel.July_Forecast = secondLast.Forecast;
                                historicalModel.July_Real = secondLast.Real;
                                break;
                            case 8:
                                historicalModel.August_Quantity = secondLast.Quantity;
                                historicalModel.August_UnitCost = secondLast.UnitCost;
                                historicalModel.August_Target = secondLast.Target;
                                historicalModel.August_Forecast = secondLast.Forecast;
                                historicalModel.August_Real = secondLast.Real;
                                break;
                            case 9:
                                historicalModel.September_Quantity = secondLast.Quantity;
                                historicalModel.September_UnitCost = secondLast.UnitCost;
                                historicalModel.September_Target = secondLast.Target;

                                historicalModel.September_Forecast = secondLast.Forecast;
                                historicalModel.September_Real = secondLast.Real;
                                break;
                            case 10:
                                historicalModel.October_Quantity = secondLast.Quantity;
                                historicalModel.October_UnitCost = secondLast.UnitCost;
                                historicalModel.October_Target = secondLast.Target;
                                historicalModel.October_Forecast = secondLast.Forecast;
                                historicalModel.October_Real = secondLast.Real;
                                break;
                            case 11:
                                historicalModel.November_Quantity = secondLast.Quantity;
                                historicalModel.November_UnitCost = secondLast.UnitCost;
                                historicalModel.November_Target = secondLast.Target;
                                historicalModel.November_Forecast = secondLast.Forecast;
                                historicalModel.November_Real = secondLast.Real;
                                break;
                            case 12:
                                historicalModel.December_Quantity = secondLast.Quantity;
                                historicalModel.December_UnitCost = secondLast.UnitCost;
                                historicalModel.December_Target = secondLast.Target;
                                historicalModel.December_Forecast = secondLast.Forecast;
                                historicalModel.December_Real = secondLast.Real;
                                break;
                            default:
                                break;
                        }
                    }
                    else
                    {
                        switch (monthDetail.Month)
                        {
                            case 1:
                                historicalModel.January_Quantity = monthDetail.Quantity;
                                historicalModel.January_UnitCost = monthDetail.UnitCost;
                                historicalModel.January_Target = monthDetail.Target;
                                historicalModel.January_Forecast = monthDetail.Forecast;
                                historicalModel.January_Real = monthDetail.Real;
                                break;
                            case 2:
                                historicalModel.February_Quantity = monthDetail.Quantity;
                                historicalModel.February_UnitCost = monthDetail.UnitCost;
                                historicalModel.February_Target = monthDetail.Target;
                                historicalModel.February_Forecast = monthDetail.Forecast;
                                historicalModel.February_Real = monthDetail.Real;
                                break;
                            case 3:
                                historicalModel.March_Quantity = monthDetail.Quantity;
                                historicalModel.March_UnitCost = monthDetail.UnitCost;
                                historicalModel.March_Target = monthDetail.Target;
                                historicalModel.March_Forecast = monthDetail.Forecast;
                                historicalModel.March_Real = monthDetail.Real;
                                break;
                            case 4:
                                historicalModel.April_Quantity = monthDetail.Quantity;
                                historicalModel.April_UnitCost = monthDetail.UnitCost;
                                historicalModel.April_Target = monthDetail.Target;
                                historicalModel.April_Forecast = monthDetail.Forecast;
                                historicalModel.April_Real = monthDetail.Real;
                                break;
                            case 5:
                                historicalModel.May_Quantity = monthDetail.Quantity;
                                historicalModel.May_UnitCost = monthDetail.UnitCost;
                                historicalModel.May_Target = monthDetail.Target;
                                historicalModel.May_Forecast = monthDetail.Forecast;
                                historicalModel.May_Real = monthDetail.Real;
                                break;
                            case 6:
                                historicalModel.June_Quantity = monthDetail.Quantity;
                                historicalModel.June_UnitCost = monthDetail.UnitCost;
                                historicalModel.June_Target = monthDetail.Target;
                                historicalModel.June_Forecast = monthDetail.Forecast;
                                historicalModel.June_Real = monthDetail.Real;
                                break;
                            case 7:
                                historicalModel.July_Quantity = monthDetail.Quantity;
                                historicalModel.July_UnitCost = monthDetail.UnitCost;
                                historicalModel.July_Target = monthDetail.Target;
                                historicalModel.July_Forecast = monthDetail.Forecast;
                                historicalModel.July_Real = monthDetail.Real;
                                break;
                            case 8:
                                historicalModel.August_Quantity = monthDetail.Quantity;
                                historicalModel.August_UnitCost = monthDetail.UnitCost;
                                historicalModel.August_Target = monthDetail.Target;
                                historicalModel.August_Forecast = monthDetail.Forecast;
                                historicalModel.August_Real = monthDetail.Real;
                                break;
                            case 9:
                                historicalModel.September_Quantity = monthDetail.Quantity;
                                historicalModel.September_UnitCost = monthDetail.UnitCost;
                                historicalModel.September_Target = monthDetail.Target;

                                historicalModel.September_Forecast = monthDetail.Forecast;
                                historicalModel.September_Real = monthDetail.Real;
                                break;
                            case 10:
                                historicalModel.October_Quantity = monthDetail.Quantity;
                                historicalModel.October_UnitCost = monthDetail.UnitCost;
                                historicalModel.October_Target = monthDetail.Target;
                                historicalModel.October_Forecast = monthDetail.Forecast;
                                historicalModel.October_Real = monthDetail.Real;
                                break;
                            case 11:
                                historicalModel.November_Quantity = monthDetail.Quantity;
                                historicalModel.November_UnitCost = monthDetail.UnitCost;
                                historicalModel.November_Target = monthDetail.Target;
                                historicalModel.November_Forecast = monthDetail.Forecast;
                                historicalModel.November_Real = monthDetail.Real;
                                break;
                            case 12:
                                historicalModel.December_Quantity = monthDetail.Quantity;
                                historicalModel.December_UnitCost = monthDetail.UnitCost;
                                historicalModel.December_Target = monthDetail.Target;
                                historicalModel.December_Forecast = monthDetail.Forecast;
                                historicalModel.December_Real = monthDetail.Real;
                                break;
                            default:
                                break;
                        }
                    }
                }
                currentModel.Summary_YearTotal = currentModel.January_Target + currentModel.February_Target + currentModel.March_Target + currentModel.April_Target
                    + currentModel.May_Target + currentModel.June_Target + currentModel.July_Target + currentModel.August_Target
                    + currentModel.September_Target + currentModel.October_Target + currentModel.November_Target + currentModel.December_Target;

                historicalModel.Summary_YearTotal = historicalModel.January_Target + historicalModel.February_Target + historicalModel.March_Target + historicalModel.April_Target
                    + historicalModel.May_Target + historicalModel.June_Target + historicalModel.July_Target + historicalModel.August_Target
                    + historicalModel.September_Target + historicalModel.October_Target + historicalModel.November_Target + historicalModel.December_Target;

                if (line.ParentId == null)
                {
                    currentModel.LevelOneId = currentModel.Id;
                    historicalModel.LevelOneId = historicalModel.Id;

                    lstCurrentParentLines.Add(currentModel);
                    lstHistoricalParentLines.Add(historicalModel);
                }
                else if (lstCurrentParentLines.Any(p => p.Id == currentModel.ParentId))
                {
                    currentModel.LevelOneId = currentModel.ParentId;
                    currentModel.LevelTwoId = currentModel.Id;

                    historicalModel.LevelOneId = historicalModel.ParentId;
                    historicalModel.LevelTwoId = historicalModel.Id;

                    lstCurrentChildrenLines.Add(currentModel);
                    lstHistoricalChildrenLines.Add(historicalModel);
                }
                else if (lstCurrentChildrenLines.Any(c => c.Id == currentModel.ParentId))
                {
                    currentModel.LevelTwoId = currentModel.ParentId;
                    historicalModel.LevelTwoId = historicalModel.ParentId;

                    lstCurrentSubChildrenLines.Add(currentModel);
                    lstHistoricalSubChildrenLines.Add(historicalModel);
                }
            }

            return new List<BudgetSheetViewModel>() {
                new BudgetSheetViewModel { ParentLines = lstCurrentParentLines, ChildrenLines = lstCurrentChildrenLines, SubChildrenLines = lstCurrentSubChildrenLines },
                new BudgetSheetViewModel { ParentLines = lstHistoricalParentLines, ChildrenLines = lstHistoricalChildrenLines, SubChildrenLines = lstHistoricalSubChildrenLines }
            };
        }

        [Route("api/Forecasts/AuthorizeIncrease/{companyId}/{fiscalYear}/{costCenterId}/{packageId}")]
        public IHttpActionResult PutAuthorizeIncrease(int companyId, int fiscalYear, int costCenterId, int packageId)
        {
            try
            {
                using (var db = new SpresContext())
                {
                    var budget = db.Budgets.FirstOrDefault(b => b.CompanyId == companyId && b.FiscalYear == fiscalYear && b.CostCenterId == costCenterId);
                    
                    if (budget == null)
                    {
                        return NotFound();
                    }
                    else
                    {
                        var sheet = budget.Sheets.FirstOrDefault(bs => bs.PackageId == packageId);
                        if (sheet == null)
                        {
                            return NotFound();
                        }
                        else
                        {
                            var budgetVersion = BudgetsController.GetBudgetVersion(sheet.Budget);

                            if (budgetVersion <= 0)
                            {
                                return BadRequest("Los períodos de forecast no se encuentran habilitados.");
                            }
                            else
                            {
                                foreach (var line in sheet.Lines)
                                {
                                    foreach (var monthDetail in line.MonthDetails)
                                    {
                                        var last = monthDetail.Histories.OrderByDescending(h => h.HistoricalDate).FirstOrDefault();
                                        if (last != null && last.Reason == BudgetMonthHistoryReasons.Increase)
                                        {
                                            monthDetail.Histories.Add(new BudgetMonthHistory()
                                            {
                                                BudgetStatus = last.BudgetStatus,
                                                ExpenseDetail = last.ExpenseDetail,
                                                Forecast = last.Forecast,
                                                HistoricalDate = DateTime.Now,
                                                Month = last.Month,
                                                Quantity = last.Quantity,
                                                Real = last.Real,
                                                Reason = BudgetMonthHistoryReasons.Adjustment,
                                                Target = last.Target,
                                                UnitCost = last.UnitCost,
                                                Version = budgetVersion
                                            });
                                        }
                                    }
                                }
                                return Ok(db.SaveChanges());
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


        [Route("api/Forecasts/RejectIncrease/{companyId}/{fiscalYear}/{costCenterId}/{packageId}")]
        public IHttpActionResult PutRejectIncrease(int companyId, int fiscalYear, int costCenterId, int packageId)
        {
            try
            {
                using (var db = new SpresContext())
                {
                    var budget = db.Budgets.FirstOrDefault(b => b.CompanyId == companyId && b.FiscalYear == fiscalYear && b.CostCenterId == costCenterId);

                    if (budget == null)
                    {
                        return NotFound();
                    }
                    else
                    {
                        var sheet = budget.Sheets.FirstOrDefault(bs => bs.PackageId == packageId);
                        if (sheet == null)
                        {
                            return NotFound();
                        }
                        else
                        {
                            var budgetVersion = BudgetsController.GetBudgetVersion(sheet.Budget);

                            if (budgetVersion <= 0)
                            {
                                return BadRequest("Los períodos de forecast no se encuentran habilitados.");
                            }
                            else
                            {
                                foreach (var line in sheet.Lines)
                                {
                                    foreach (var monthDetail in line.MonthDetails)
                                    {
                                        var orderedHistories = monthDetail.Histories.OrderByDescending(h => h.HistoricalDate);
                                        
                                        var last = orderedHistories.FirstOrDefault();

                                        if (last != null && last.Reason == BudgetMonthHistoryReasons.Increase)
                                        {
                                            var secondLast = orderedHistories.Skip(1).FirstOrDefault();

                                            if (secondLast != null)
                                            {
                                                monthDetail.Histories.Add(new BudgetMonthHistory()
                                                {
                                                    BudgetStatus = secondLast.BudgetStatus,
                                                    ExpenseDetail = secondLast.ExpenseDetail,
                                                    Forecast = secondLast.Forecast,
                                                    HistoricalDate = DateTime.Now,
                                                    Month = secondLast.Month,
                                                    Quantity = secondLast.Quantity,
                                                    Real = secondLast.Real,
                                                    Reason = BudgetMonthHistoryReasons.Adjustment,
                                                    Target = secondLast.Target,
                                                    UnitCost = secondLast.UnitCost,
                                                    Version = budgetVersion
                                                });
                                            }
                                            else
                                            {
                                                monthDetail.Histories.Add(new BudgetMonthHistory()
                                                {
                                                    BudgetStatus = 0,
                                                    ExpenseDetail = monthDetail.ExpenseDetail,
                                                    Forecast = monthDetail.Forecast,
                                                    HistoricalDate = DateTime.Now,
                                                    Month = monthDetail.Month,
                                                    Quantity = monthDetail.Quantity,
                                                    Real = monthDetail.Real,
                                                    Reason = BudgetMonthHistoryReasons.Adjustment,
                                                    Target = monthDetail.Target,
                                                    UnitCost = monthDetail.UnitCost,
                                                    Version = budgetVersion
                                                });
                                            }
                                        }
                                    }
                                }
                                return Ok(db.SaveChanges());
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


        public IHttpActionResult PutAccountAdjustment(AccountAdjustmentModel model)
        {
            if (model.SourceMonthNumber > 12 || model.DestinationMonthNumber > 12 || model.SourceMonthNumber < DateTime.Now.Month 
                || model.DestinationMonthNumber < DateTime.Now.Month || model.Adjustment <= 0)
            {
                return BadRequest("Parámetros no válidos");
            }
            else if (model.DestinationLineId == model.SourceLineId && model.SourceMonthNumber == model.DestinationMonthNumber)
            {
                return BadRequest("Seleccione un mes de destino distinto al mes de origen");
            }
            else
            {
                using (var db = new SpresContext())
                {
                    var sourceLine = db.BudgetLines.FirstOrDefault(bl => bl.Id == model.SourceLineId);
                    var destinationLine = db.BudgetLines.FirstOrDefault(bl => bl.Id == model.DestinationLineId);

                    var sourceParentLine = db.BudgetLines.Find(sourceLine.ParentId);

                    var destinationParentLine = db.BudgetLines.Find(destinationLine.ParentId);

                    if (sourceLine == null || destinationLine == null || sourceParentLine == null || destinationParentLine == null)
                    {
                        return NotFound();
                    }
                    else
                    {
                        var budgetVersion = BudgetsController.GetBudgetVersion(sourceLine.Sheet.Budget);

                        if (budgetVersion <= 0)
                        {
                            return BadRequest("Los períodos de forecast no se encuentran habilitados.");
                        }
                        else
                        {
                            var sourceMonthDetail = sourceLine.MonthDetails.FirstOrDefault(md => md.Month == model.SourceMonthNumber);
                            var destinationMonthDetail = destinationLine.MonthDetails.FirstOrDefault(md => md.Month == model.DestinationMonthNumber);

                            if (sourceMonthDetail == null || destinationMonthDetail == null)
                            {
                                return InternalServerError();
                            }
                            else if (!NewHistoryCanBeAdded(sourceMonthDetail) || !NewHistoryCanBeAdded(destinationMonthDetail))
                            {
                                return BadRequest("El período de origen o el período de destino se encuentran en proceso de incremento de presupuesto por lo que no puede realizarse otro ajuste.");
                            }
                            else if (SaveBudgetMonthHistories(budgetVersion, sourceMonthDetail, destinationMonthDetail, model.Adjustment, sourceParentLine, destinationParentLine, sourceLine, destinationLine, db))
                            {
                                return Ok(db.SaveChanges());
                            }
                            else
                            {
                                return InternalServerError();
                            }
                        }
                    }
                }
            }
        }

        [Route("api/Forecasts/{lineId}")]
        public IHttpActionResult PutBudgetingLineAdjustment(int lineId, [FromBody]List<MonthItem> monthValues)
        {
            using(var db = new SpresContext())
            {
                var line = db.BudgetLines.Find(lineId);
                var parentLine = db.BudgetLines.Find(line.ParentId);
                var grandparentLine = db.BudgetLines.Find(parentLine.ParentId);
                if (line == null || parentLine == null || grandparentLine == null)
                {
                    return NotFound();
                }
                else
                {
                    var budgetVersion = BudgetsController.GetBudgetVersion(line.Sheet.Budget);

                    if (budgetVersion <= 0)
                    {
                        return BadRequest("Los períodos de forecast no se encuentran habilitados.");
                    }
                    else
                    {
                        foreach (var monthValue in monthValues)
                        {
                            var monthDetail = line.MonthDetails.FirstOrDefault(md => md.Month == monthValue.MonthNumber);
                            if (monthDetail != null)
                            {
                                if (!NewHistoryCanBeAdded(monthDetail))
                                {
                                    return BadRequest("La línea presupuestaria seleccionada se encuentra actualmente en proceso de incremento de presupuesto por lo que no se puede realizar otros ajustes.");
                                }
                                else
                                {
                                    SaveBudgetingLineAdjustment(monthDetail, monthValue.Target, budgetVersion, grandparentLine, parentLine);
                                }
                            }
                        }
                        return Ok(db.SaveChanges());
                    }
                }
            }
        }


        [Route("api/Forecasts/IncreasesModifications/{lineId}")]
        public IHttpActionResult PutIncreasesModifications(int lineId, [FromBody]List<MonthItem> monthValues)
        {
            using (var db = new SpresContext())
            {
                var line = db.BudgetLines.Find(lineId);
                var parentLine = db.BudgetLines.Find(line.ParentId);
                if (line == null || parentLine == null)
                {
                    return NotFound();
                }
                else
                {
                    var budget = line.Sheet.Budget;
                    var budgetVersion = BudgetsController.GetBudgetVersion(budget);

                    if (budgetVersion <= 0)
                    {
                        return BadRequest("Los períodos de forecast no se encuentran habilitados.");
                    }
                    else
                    {
                        foreach (var monthValue in monthValues)
                        {
                            if (monthValue.Target > 0)
                            {
                                var monthDetail = line.MonthDetails.FirstOrDefault(md => md.Month == monthValue.MonthNumber);
                                if (monthDetail != null)
                                {
                                    if (!NewHistoryCanBeAdded(monthDetail))
                                    {
                                        return BadRequest("La línea presupuestaria seleccionada se encuentra actualmente en proceso de incremento de presupuesto por lo que no se puede realizar otros ajustes.");
                                    }
                                    else
                                    {
                                        RequestIncrease(monthDetail, monthValue.Target, budgetVersion, parentLine, line);
                                    }
                                }
                            }
                        }

                        try
                        {
                            int increasesCount = db.SaveChanges();

                            int emailsCount = SendRequestEmails(
                                budget.Company.Authorizers.ToList(),
                                User.Identity.GetUserId(),
                                budget.Company.Name,
                                budget.FiscalYear.ToString(),
                                string.Format("{0} - {1}", budget.CostCenter.Code, budget.CostCenter.Name));

                            if (emailsCount <= 0)
                            {
                                return BadRequest("Los autorizadores de la región no han sido configurados.");
                            }
                            else
                            {
                                return Ok(increasesCount);
                            }
                        }
                        catch (SmtpException ex)
                        {
                            ErrorLog.SaveError(ex);
                            return InternalServerError(new Exception("El incremento se realizó satisfactoriamente. Sin embargo, ocurrió un error al intentar enviar notificación por correo electrónico a los responsables de autorización"));
                        }
                        catch(Exception ex)
                        {
                            ErrorLog.SaveError(ex);
                            return InternalServerError(new Exception("Ocurrió un error interno al intentar realizar el incremento"));
                        }
                    }
                }
            }
        }


        public int SendRequestEmails(List<CompanyAuthorizer> companyAuthorizers, string userId, string company, string fiscalYear, string costCenter)
        {
            var recipients = new List<string>();
            using (var identityDb = new SpresIdentityDbContext())
            {
                var roleManager = new RoleManager<Role>(new RoleStore<Role>(identityDb));
                var userManager = new UserManager<User>(new UserStore<User>(identityDb));

                foreach (var companyAuthorizer in companyAuthorizers)
                {
                    if (companyAuthorizer.AuthorizerGUID != null)
                    {
                        var user = userManager.FindById(companyAuthorizer.AuthorizerGUID);
                        if (user != null && !string.IsNullOrEmpty(user.Email))
                        {
                            recipients.Add(user.Email);
                        }
                    }
                }
                if (recipients.Any())
                {
                    var userItem = userManager.FindById(userId);
                    var parameters = new List<string>() { (userItem == null) ? string.Empty : userItem.Name, company, fiscalYear, costCenter };
                    EmailHelper.Send("IncreaseRequested", parameters, recipients);
                }
                return recipients.Count;
            }
        }

        [Route("api/Forecasts/SavingsTransfer")]
        public IHttpActionResult PutSavingsTransfer(AccountAdjustmentModel model)
        {
            if (model.DestinationMonthNumber > 12 || model.DestinationMonthNumber < DateTime.Now.Month || model.Adjustment <= 0)
            {
                return BadRequest("Parámetros no válidos");
            }
            else if (model.DestinationLineId == model.SourceLineId && model.SourceMonthNumber == model.DestinationMonthNumber)
            {
                return BadRequest("Seleccione un mes de destino distinto al mes de origen");
            }
            else
            {
                using (var db = new SpresContext())
                {
                    var sourceLine = db.BudgetLines.FirstOrDefault(bl => bl.Id == model.SourceLineId);
                    var destinationLine = db.BudgetLines.FirstOrDefault(bl => bl.Id == model.DestinationLineId);

                    var sourceParentLine = db.BudgetLines.Find(sourceLine.ParentId);
                    var destinationParentLine = db.BudgetLines.Find(destinationLine.ParentId);

                    if (sourceLine == null || destinationLine == null || sourceParentLine == null || destinationParentLine == null)
                    {
                        return NotFound();
                    }
                    else
                    {
                        var budgetVersion = BudgetsController.GetBudgetVersion(sourceLine.Sheet.Budget);

                        if (budgetVersion <= 0)
                        {
                            return BadRequest("Los períodos de forecast no se encuentran habilitados.");
                        }
                        else
                        {
                            var sourceMonthDetail = sourceLine.MonthDetails.FirstOrDefault(md => md.Month == DateTime.Now.Month - 1);
                            var destinationMonthDetail = destinationLine.MonthDetails.FirstOrDefault(md => md.Month == model.DestinationMonthNumber);

                            if (sourceMonthDetail == null || destinationMonthDetail == null)
                            {
                                return InternalServerError();
                            }
                            else
                            {
                                if (!NewHistoryCanBeAdded(sourceMonthDetail) || !NewHistoryCanBeAdded(destinationMonthDetail))
                                {
                                    return BadRequest("La línea presupuestaria seleccionada se encuentra actualmente en proceso de incremento de presupuesto por lo que no se puede realizar otros ajustes.");
                                }
                                if (SaveBudgetMonthHistories(budgetVersion, sourceMonthDetail, destinationMonthDetail, model.Adjustment, sourceParentLine, destinationParentLine, sourceLine, destinationLine, db))
                                {
                                    db.SaveChanges();
                                    return Ok();
                                }
                                else
                                {
                                    return InternalServerError();
                                }
                                
                            }
                        }
                    }
                }
            }
        }

        private bool SaveBudgetMonthHistories(int budgetVersion, BudgetMonthDetail sourceMonthDetail, BudgetMonthDetail destinationMonthDetail, decimal adjustment, BudgetLine sourceGrandparentLine, BudgetLine destinationGranparentLine, BudgetLine sourceParentLine, BudgetLine destinationParentLine, SpresContext db)
        {
            var sourceOrderedHistories = sourceMonthDetail.Histories.OrderByDescending(h => h.HistoricalDate).ToList();
            var sourceForecast1 = sourceOrderedHistories.FirstOrDefault(h => h.Version == 1);
            var sourceForecast2 = sourceOrderedHistories.FirstOrDefault(h => h.Version == 2);
            var sourceForecast3 = sourceOrderedHistories.FirstOrDefault(h => h.Version == 3);

            var destinationOrderedHistories = destinationMonthDetail.Histories.OrderByDescending(h => h.HistoricalDate).ToList();
            var destinationForecast1 = destinationOrderedHistories.FirstOrDefault(h => h.Version == 1);
            var destinationForecast2 = destinationOrderedHistories.FirstOrDefault(h => h.Version == 2);
            var destinationForecast3 = destinationOrderedHistories.FirstOrDefault(h => h.Version == 3);

            switch (budgetVersion)
            {
                case 1:

                    if (sourceForecast1 != null)
                    {
                        AddForecastHistory(sourceMonthDetail, null, sourceForecast1, adjustment, false, budgetVersion, sourceGrandparentLine, sourceParentLine, db);
                    }
                    else
                    {
                        AddForecastHistory(sourceMonthDetail, sourceMonthDetail, null, adjustment, false, budgetVersion, sourceGrandparentLine, sourceParentLine, db);
                    }

                    if (destinationForecast1 != null)
                    {
                        AddForecastHistory(destinationMonthDetail, null, destinationForecast1, adjustment, true, budgetVersion, destinationGranparentLine, destinationParentLine, db);
                    }
                    else
                    {
                        AddForecastHistory(destinationMonthDetail, destinationMonthDetail, null, adjustment, true, budgetVersion, destinationGranparentLine, destinationParentLine, db);
                    }
                    return true;

                case 2:

                    if (sourceForecast2 != null)
                    {
                        AddForecastHistory(sourceMonthDetail, null, sourceForecast2, adjustment, false, budgetVersion, sourceGrandparentLine, sourceParentLine, db);
                    }
                    else if (sourceForecast1 != null)
                    {
                        AddForecastHistory(sourceMonthDetail, null, sourceForecast1, adjustment, false, budgetVersion, sourceGrandparentLine, sourceParentLine, db);
                    }
                    else
                    {
                        AddForecastHistory(sourceMonthDetail, sourceMonthDetail, null, adjustment, false, budgetVersion, sourceGrandparentLine, sourceParentLine, db);
                    }
                            
                    if (destinationForecast2 != null)
                    {
                        AddForecastHistory(destinationMonthDetail, null, destinationForecast2, adjustment, true, budgetVersion, destinationGranparentLine, destinationParentLine, db);
                    }
                    else if (destinationForecast1 != null)
                    {
                        AddForecastHistory(destinationMonthDetail, null, destinationForecast1, adjustment, true, budgetVersion, destinationGranparentLine, destinationParentLine, db);
                    }
                    else
                    {
                        AddForecastHistory(destinationMonthDetail, destinationMonthDetail, null, adjustment, true, budgetVersion, destinationGranparentLine, destinationParentLine, db);
                    }
                    return true;

                case 3:

                    if (sourceForecast3 != null)
                    {
                        AddForecastHistory(sourceMonthDetail, null, sourceForecast3, adjustment, false, budgetVersion, sourceGrandparentLine, sourceParentLine, db);
                    }
                    else if (sourceForecast2 != null)
                    {
                        AddForecastHistory(sourceMonthDetail, null, sourceForecast2, adjustment, false, budgetVersion, sourceGrandparentLine, sourceParentLine, db);
                    }
                    else if (sourceForecast1 != null)
                    {
                        AddForecastHistory(sourceMonthDetail, null, sourceForecast1, adjustment, false, budgetVersion, sourceGrandparentLine, sourceParentLine, db);
                    }
                    else
                    {
                        AddForecastHistory(sourceMonthDetail, sourceMonthDetail, null, adjustment, false, budgetVersion, sourceGrandparentLine, sourceParentLine, db);
                    }

                    if (destinationForecast3 != null)
                    {
                        AddForecastHistory(destinationMonthDetail, null, destinationForecast3, adjustment, true, budgetVersion, destinationGranparentLine, destinationParentLine, db);
                    }
                    else if (destinationForecast2 != null)
                    {
                        AddForecastHistory(destinationMonthDetail, null, destinationForecast2, adjustment, true, budgetVersion, destinationGranparentLine, destinationParentLine, db);
                    }
                    else if (destinationForecast1 != null)
                    {
                        AddForecastHistory(destinationMonthDetail, null, destinationForecast1, adjustment, true, budgetVersion, destinationGranparentLine, destinationParentLine, db);
                    }
                    else
                    {
                        AddForecastHistory(destinationMonthDetail, destinationMonthDetail, null, adjustment, true, budgetVersion, destinationGranparentLine, destinationParentLine, db);
                    }
                    return true;

                default:
                    return false;
            }
        }

        private void RequestIncrease(BudgetMonthDetail monthDetail, decimal newValue, int budgetVersion, BudgetLine parentLine, BudgetLine subAccountLine)
        {
            monthDetail.Histories.Add(new BudgetMonthHistory()
            {
                BudgetStatus = 0,
                ExpenseDetail = monthDetail.ExpenseDetail,
                Forecast = newValue,
                HistoricalDate = DateTime.Now,
                Month = monthDetail.Month,
                Quantity = monthDetail.Quantity,
                Real = monthDetail.Real,
                Target = monthDetail.Target,
                UnitCost = monthDetail.UnitCost,
                Version = budgetVersion,
                Reason = BudgetMonthHistoryReasons.Increase
            });

            monthDetail.Forecast = newValue;

            RecalculateParentLinesForecast(monthDetail, budgetVersion, parentLine, subAccountLine);
        }

        private void SaveBudgetingLineAdjustment(BudgetMonthDetail monthDetail, decimal newValue, int budgetVersion, BudgetLine grandParentLine, BudgetLine subAccountLine)
        {
            monthDetail.Histories.Add(new BudgetMonthHistory()
            {
                BudgetStatus = 0,
                ExpenseDetail = monthDetail.ExpenseDetail,
                Forecast = newValue,
                HistoricalDate = DateTime.Now,
                Month = monthDetail.Month,
                Quantity = monthDetail.Quantity,
                Real = monthDetail.Real,
                Target = monthDetail.Target,
                UnitCost = monthDetail.UnitCost,
                Version = budgetVersion,
                Reason = BudgetMonthHistoryReasons.Adjustment
            });

            monthDetail.Forecast = newValue;

            RecalculateParentAndGrandparentLinesForecast(monthDetail, budgetVersion, grandParentLine, subAccountLine);
        }


        private void RecalculateParentLinesForecast(BudgetMonthDetail monthDetail, int budgetVersion, BudgetLine parentLine, BudgetLine subAccountLine)
        {
            decimal parentLineTotal = 0;
            foreach (var childLine in parentLine.Children.ToList())
            {
                var md = childLine.MonthDetails.FirstOrDefault(m => m.Month == monthDetail.Month);
                if (md != null)
                {
                    parentLineTotal += md.Forecast;
                }
            
                if (childLine.Id == subAccountLine.Id)
                {
                    var parentLineMonthDetail = parentLine.MonthDetails.FirstOrDefault(mdetail => mdetail.Month == monthDetail.Month);
                    if (parentLineMonthDetail != null)
                    {
                        parentLineMonthDetail.Forecast = parentLineTotal;
                        parentLineMonthDetail.Histories.Add(new BudgetMonthHistory()
                        {
                            BudgetStatus = 0,
                            ExpenseDetail = parentLineMonthDetail.ExpenseDetail,
                            Forecast = parentLineTotal,
                            HistoricalDate = DateTime.Now,
                            Month = parentLineMonthDetail.Month,
                            Quantity = parentLineMonthDetail.Quantity,
                            Real = parentLineMonthDetail.Real,
                            Target = parentLineMonthDetail.Target,
                            UnitCost = parentLineMonthDetail.UnitCost,
                            Version = budgetVersion,
                            Reason = BudgetMonthHistoryReasons.Increase
                        });
                    }
                }
            }
        }

        private void RecalculateParentAndGrandparentLinesForecast(BudgetMonthDetail monthDetail, int budgetVersion, BudgetLine grandparentLine, BudgetLine subAccountLine)
        {
            decimal grandParentLineTotal = 0;
            foreach (var parentLine in grandparentLine.Children.ToList())
            {
                decimal parentLineTotal = 0;
                foreach (var childLine in parentLine.Children.ToList())
                {
                    var md = childLine.MonthDetails.FirstOrDefault(m => m.Month == monthDetail.Month);
                    if (md != null)
                    {
                        parentLineTotal += md.Forecast;
                    }
                }

                if (parentLine.Id == subAccountLine.Id)
                {
                    var parentLineMonthDetail = parentLine.MonthDetails.FirstOrDefault(md => md.Month == monthDetail.Month);
                    if (parentLineMonthDetail != null)
                    {
                        parentLineMonthDetail.Forecast = parentLineTotal;
                        parentLineMonthDetail.Histories.Add(new BudgetMonthHistory()
                        {
                            BudgetStatus = 0,
                            ExpenseDetail = parentLineMonthDetail.ExpenseDetail,
                            Forecast = parentLineTotal,
                            HistoricalDate = DateTime.Now,
                            Month = parentLineMonthDetail.Month,
                            Quantity = parentLineMonthDetail.Quantity,
                            Real = parentLineMonthDetail.Real,
                            Target = parentLineMonthDetail.Target,
                            UnitCost = parentLineMonthDetail.UnitCost,
                            Version = budgetVersion,
                            Reason = BudgetMonthHistoryReasons.Adjustment
                        });
                    }
                }
                
                grandParentLineTotal += parentLineTotal;
            }

            var grandparentLineMonthDetail = grandparentLine.MonthDetails.FirstOrDefault(md => md.Month == monthDetail.Month);
            if (grandparentLineMonthDetail != null)
            {
                grandparentLineMonthDetail.Forecast = grandParentLineTotal;
                grandparentLineMonthDetail.Histories.Add(new BudgetMonthHistory()
                {
                    BudgetStatus = 0,
                    ExpenseDetail = grandparentLineMonthDetail.ExpenseDetail,
                    Forecast = grandParentLineTotal,
                    HistoricalDate = DateTime.Now,
                    Month = grandparentLineMonthDetail.Month,
                    Quantity = grandparentLineMonthDetail.Quantity,
                    Real = grandparentLineMonthDetail.Real,
                    Target = grandparentLineMonthDetail.Target,
                    UnitCost = grandparentLineMonthDetail.UnitCost,
                    Version = budgetVersion,
                    Reason = BudgetMonthHistoryReasons.Adjustment
                });
            }
        }

        private void AddForecastHistory(BudgetMonthDetail monthDetail, BudgetMonthDetail copyFromMonthDetail, BudgetMonthHistory copyFromMonthHistory, decimal adjustment, bool addAdjustment, int budgetVersion, BudgetLine grandparentLine, BudgetLine subAccountLine, SpresContext db)
        {
            decimal forecast = 0;

            if (copyFromMonthDetail != null)
            {
                forecast = (addAdjustment) ? copyFromMonthDetail.Target + adjustment : copyFromMonthDetail.Target - adjustment;
                monthDetail.Histories.Add(new BudgetMonthHistory()
                {
                    BudgetStatus = 0,
                    ExpenseDetail = copyFromMonthDetail.ExpenseDetail,
                    Forecast = forecast,
                    HistoricalDate = DateTime.Now,
                    Month = copyFromMonthDetail.Month,
                    Quantity = copyFromMonthDetail.Quantity,
                    Real = copyFromMonthDetail.Real,
                    Target = copyFromMonthDetail.Target,
                    UnitCost = copyFromMonthDetail.UnitCost,
                    Version = budgetVersion,
                    Reason = BudgetMonthHistoryReasons.Adjustment
                });
            }
            else if (copyFromMonthHistory != null)
            {

                forecast = (addAdjustment) ? copyFromMonthHistory.Forecast + adjustment : copyFromMonthHistory.Forecast - adjustment;
                monthDetail.Histories.Add(new BudgetMonthHistory()
                {
                    BudgetStatus = copyFromMonthHistory.BudgetStatus,
                    ExpenseDetail = copyFromMonthHistory.ExpenseDetail,
                    Forecast = forecast,
                    HistoricalDate = DateTime.Now,
                    Month = copyFromMonthHistory.Month,
                    Quantity = copyFromMonthHistory.Quantity,
                    Real = copyFromMonthHistory.Real,
                    Target = copyFromMonthHistory.Target,
                    UnitCost = copyFromMonthHistory.UnitCost,
                    Version = budgetVersion,
                    Reason = BudgetMonthHistoryReasons.Adjustment
                });
            }
            monthDetail.Forecast = forecast;
            RecalculateAccountAdjustmentParentLineValues(grandparentLine, monthDetail, budgetVersion, db);
            
        }

        private void RecalculateAccountAdjustmentParentLineValues(BudgetLine grandParentLine, BudgetMonthDetail monthDetail, int budgetVersion, SpresContext db)
        {
            decimal grandparentTotal = 0;
            foreach (var parentLine in grandParentLine.Children.ToList())
            {
                decimal parentTotal = 0;
                foreach (var childLine in parentLine.Children.ToList())
                {
                    var md = childLine.MonthDetails.FirstOrDefault(m => m.Month == monthDetail.Month);
                    if (md != null)
                    {
                        parentTotal += md.Forecast;
                    }
                }
                grandparentTotal += parentTotal;
            }
            var grandparentMonthDetail = grandParentLine.MonthDetails.FirstOrDefault(md => md.Month == monthDetail.Month);
            var history = db.BudgetMonthHistories.Find(grandparentMonthDetail.Id, DateTime.Now);

            if (grandparentMonthDetail != null)
            {
                grandparentMonthDetail.Forecast = grandparentTotal;

                if (history == null)
                {
                    grandparentMonthDetail.Histories.Add(new BudgetMonthHistory()
                    {
                        BudgetStatus = 0,
                        ExpenseDetail = grandparentMonthDetail.ExpenseDetail,
                        Forecast = grandparentTotal,
                        HistoricalDate = DateTime.Now,
                        Month = grandparentMonthDetail.Month,
                        Quantity = grandparentMonthDetail.Quantity,
                        Real = grandparentMonthDetail.Real,
                        Target = grandparentMonthDetail.Target,
                        UnitCost = grandparentMonthDetail.UnitCost,
                        Version = budgetVersion,
                        Reason = BudgetMonthHistoryReasons.Adjustment
                    });
                }
                else
                {
                    history.Forecast = grandparentTotal;
                }
            }
        }

        private bool NewHistoryCanBeAdded(BudgetMonthDetail monthDetail)
        {
            var latestHistory =  monthDetail.Histories.OrderByDescending(md => md.HistoricalDate).FirstOrDefault();
            return (latestHistory != null) ? latestHistory.Reason != BudgetMonthHistoryReasons.Increase : true;
        }

    }
}