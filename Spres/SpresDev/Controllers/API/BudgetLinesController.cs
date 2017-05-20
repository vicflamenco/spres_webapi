using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Models;
using SpresDev.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class BudgetLinesController : ApiController
    {
        [Route("api/BudgetLines/IsFreeLine/{id}")]
        [SpresSecurityAttribute("Budgeting", true, false)]
        public IHttpActionResult GetIsFreeLine(int id)
        {
            using (var db = new SpresContext())
            {
                BudgetLine line = db.BudgetLines.Find(id);
                if (line == null) return NotFound();
                AccountBudgetSource budgetSource = db.AccountBudgetSources.FirstOrDefault(bs => bs.AccountId == line.AccountId);
                return Json(budgetSource == null || budgetSource.ExpenseType == BudgetExpenseType.None);
            }
        }

        [Route("api/BudgetLines/IsDefinedByPremise/{id}")]
        [SpresSecurityAttribute("Budgeting", true, false)]
        public IHttpActionResult GetIsDefinedByPremise(int id)
        {
            using (var db = new SpresContext())
            {
                BudgetLine line = db.BudgetLines.Find(id);
                if (line == null) return NotFound();
                AccountBudgetSource budgetSource = db.AccountBudgetSources.FirstOrDefault(bs => bs.AccountId == line.AccountId);
                return Json(budgetSource != null && budgetSource.ExpenseType == BudgetExpenseType.Premise);
            }
        }

        [SpresSecurityAttribute("Budgeting", true, false)]
        public IHttpActionResult GetLines(int sheetId, int costCenterId, string toCurrencyId)
        {
            using (var db = new SpresContext())
            {
                var costCenter = db.CostCenters.Find(costCenterId);
                var country = db.Countries.Find(costCenter.Company.Country);
                var defaultCurrencyId = country.DefaultCurrencyId;
                var er = ExchangeRatesController.GetLatestExchangeRate(defaultCurrencyId, toCurrencyId);

                PropertyInfo[] properties = typeof(BudgetLineViewModel).GetProperties();
                var sheet = db.BudgetSheets.Find(sheetId);
                if (sheet == null || costCenter == null) return NotFound();

                var currentBudget = sheet.Budget;

                List<BudgetLineViewModel> lstParentLines = new List<BudgetLineViewModel>();
                List<BudgetLineViewModel> lstChildrenLines = new List<BudgetLineViewModel>();
                List<BudgetLineViewModel> lstSubChildrenLines = new List<BudgetLineViewModel>();
                foreach (var line in sheet.Lines.ToList())
                {
                    if (line.Account.Type.Split(',').Contains(costCenter.Type)) // Verificar que cualquiera de los Type de Account sea igual al Type de CostCenter
                    {
                        var budgetSource = db.AccountBudgetSources.FirstOrDefault(a => a.AccountId == line.AccountId);

                        var modelo = new BudgetLineViewModel { 
                            Id = line.Id,
                            ParentId = line.ParentId,
                            Description = line.Description,
                            AccountId = line.AccountId,
                            PremiseId = line.PremiseId,
                            ExpenseType = (budgetSource == null) ? BudgetExpenseType.None : budgetSource.ExpenseType
                        };

                        foreach (var monthDetail in line.MonthDetails)
                        {
                            switch (monthDetail.Month)
                            {
                                case 1:
                                    modelo.January_Quantity = monthDetail.Quantity;
                                    modelo.January_UnitCost = monthDetail.UnitCost;
                                    modelo.January_Target = monthDetail.Target;
                                    modelo.January_Forecast = monthDetail.Forecast;
                                    modelo.January_Real = monthDetail.Real;
                                    break;
                                case 2:
                                    modelo.February_Quantity = monthDetail.Quantity;
                                    modelo.February_UnitCost = monthDetail.UnitCost;
                                    modelo.February_Target = monthDetail.Target;
                                    modelo.February_Forecast = monthDetail.Forecast;
                                    modelo.February_Real = monthDetail.Real;
                                    break;
                                case 3:
                                    modelo.March_Quantity = monthDetail.Quantity;
                                    modelo.March_UnitCost = monthDetail.UnitCost;
                                    modelo.March_Target = monthDetail.Target;
                                    modelo.March_Forecast = monthDetail.Forecast;
                                    modelo.March_Real = monthDetail.Real;
                                    break;
                                case 4:
                                    modelo.April_Quantity = monthDetail.Quantity;
                                    modelo.April_UnitCost = monthDetail.UnitCost;
                                    modelo.April_Target = monthDetail.Target;
                                    modelo.April_Forecast = monthDetail.Forecast;
                                    modelo.April_Real = monthDetail.Real;
                                    break;
                                case 5:
                                    modelo.May_Quantity = monthDetail.Quantity;
                                    modelo.May_UnitCost = monthDetail.UnitCost;
                                    modelo.May_Target = monthDetail.Target;
                                    modelo.May_Forecast = monthDetail.Forecast;
                                    modelo.May_Real = monthDetail.Real;
                                    break;
                                case 6:
                                    modelo.June_Quantity = monthDetail.Quantity;
                                    modelo.June_UnitCost = monthDetail.UnitCost;
                                    modelo.June_Target = monthDetail.Target;
                                    modelo.June_Forecast = monthDetail.Forecast;
                                    modelo.June_Real = monthDetail.Real;
                                    break;
                                case 7:
                                    modelo.July_Quantity = monthDetail.Quantity;
                                    modelo.July_UnitCost = monthDetail.UnitCost;
                                    modelo.July_Target = monthDetail.Target;
                                    modelo.July_Forecast = monthDetail.Forecast;
                                    modelo.July_Real = monthDetail.Real;
                                    break;
                                case 8:
                                    modelo.August_Quantity = monthDetail.Quantity;
                                    modelo.August_UnitCost = monthDetail.UnitCost;
                                    modelo.August_Target = monthDetail.Target;
                                    modelo.August_Forecast = monthDetail.Forecast;
                                    modelo.August_Real = monthDetail.Real;
                                    break;
                                case 9:
                                    modelo.September_Quantity = monthDetail.Quantity;
                                    modelo.September_UnitCost = monthDetail.UnitCost;
                                    modelo.September_Target = monthDetail.Target;
                                    modelo.September_Forecast = monthDetail.Forecast;
                                    modelo.September_Real = monthDetail.Real;
                                    break;
                                case 10:
                                    modelo.October_Quantity = monthDetail.Quantity;
                                    modelo.October_UnitCost = monthDetail.UnitCost;
                                    modelo.October_Target = monthDetail.Target;
                                    modelo.October_Forecast = monthDetail.Forecast;
                                    modelo.October_Real = monthDetail.Real;
                                    break;
                                case 11:
                                    modelo.November_Quantity = monthDetail.Quantity;
                                    modelo.November_UnitCost = monthDetail.UnitCost;
                                    modelo.November_Target = monthDetail.Target;
                                    modelo.November_Forecast = monthDetail.Forecast;
                                    modelo.November_Real = monthDetail.Real;
                                    break;
                                case 12:
                                    modelo.December_Quantity = monthDetail.Quantity;
                                    modelo.December_UnitCost = monthDetail.UnitCost;
                                    modelo.December_Target = monthDetail.Target;
                                    modelo.December_Forecast = monthDetail.Forecast;
                                    modelo.December_Real = monthDetail.Real;
                                    break;
                                default:
                                    break;
                            }
                        }
                        modelo.Summary_YearTotal = modelo.January_Target + modelo.February_Target + modelo.March_Target + modelo.April_Target
                            + modelo.May_Target + modelo.June_Target + modelo.July_Target + modelo.August_Target
                            + modelo.September_Target + modelo.October_Target + modelo.November_Target + modelo.December_Target;

                        modelo.Summary_PreviousYear = 0;

                        var previousBudget = db.Budgets.FirstOrDefault(b => b.CompanyId == currentBudget.CompanyId
                            && b.CostCenterId == currentBudget.CostCenterId && b.FiscalYear == currentBudget.FiscalYear - 1);


                        if (previousBudget != null)
                        {
                            var previousSheet = previousBudget.Sheets.FirstOrDefault(bs => bs.PackageId == sheet.PackageId);
                            
                            if (previousSheet != null)
                            {
                                if (line.ParentId == null)
                                {
                                    var previousLine = previousSheet.Lines.FirstOrDefault(l => l.AccountId == line.AccountId);
                                    if (previousLine != null)
                                    {
                                        modelo.Summary_PreviousYear = previousLine.MonthDetails.Sum(m => m.Target);
                                    }
                                }
                                else if (lstParentLines.Any(p => p.Id == modelo.ParentId))
                                {
                                    var previousLine = previousSheet.Lines.FirstOrDefault(l => l.AccountId == line.AccountId && l.Tag == null);
                                    if (previousLine != null)
                                    {
                                        modelo.Summary_PreviousYear = previousLine.MonthDetails.Sum(m => m.Target);
                                    }
                                }
                                else if (lstChildrenLines.Any(c => c.Id == modelo.ParentId))
                                {
                                    var previousLine = previousSheet.Lines.FirstOrDefault(l => l.AccountId == line.AccountId && l.Tag != null && l.Tag != 0);
                                    if (previousLine != null)
                                    {
                                        modelo.Summary_PreviousYear = previousLine.MonthDetails.Sum(m => m.Target);
                                    }
                                }
                            }
                        }

                        modelo.Summary_DifferenceTotal = modelo.Summary_YearTotal - modelo.Summary_PreviousYear;
                        modelo.Summary_DifferencePercentage = (modelo.Summary_PreviousYear != 0) ? (modelo.Summary_YearTotal - modelo.Summary_PreviousYear) / modelo.Summary_PreviousYear : 0;
                        
                        if (defaultCurrencyId != toCurrencyId)
                        {
                            foreach (PropertyInfo property in properties)
                            {
                                if (property.PropertyType.Name.Equals("Decimal"))
                                {
                                    decimal value = Convert.ToDecimal(property.GetValue(modelo));
                                    if (value > 0)
                                    {
                                        property.SetValue(modelo, ExchangeRatesController.Convert(value, er));
                                    }
                                }
                            }
                        }

                        if (line.ParentId == null)
                        {
                            modelo.LevelOneId = modelo.Id;
                            lstParentLines.Add(modelo);
                        }
                        else if (lstParentLines.Any(p => p.Id == modelo.ParentId))
                        {
                            modelo.LevelOneId = modelo.ParentId;
                            modelo.LevelTwoId = modelo.Id;
                            lstChildrenLines.Add(modelo);
                        }
                        else if (lstChildrenLines.Any(c => c.Id == modelo.ParentId))
                        {
                            modelo.LevelTwoId = modelo.ParentId;
                            lstSubChildrenLines.Add(modelo);
                        }
                    }
                }

                return Ok(new BudgetSheetViewModel { ParentLines = lstParentLines, ChildrenLines = lstChildrenLines, SubChildrenLines = lstSubChildrenLines });
            }
        }

        [Route("api/BudgetLines/PostLine")]
        [SpresSecurityAttribute("Budgeting", false, true)]
        public IHttpActionResult PostLine (BudgetLineViewModel lineViewModel)
        {
            using (var db = new SpresContext())
            {
                BudgetLine parentLine = db.BudgetLines.Find(lineViewModel.ParentId);
                if (parentLine == null) return NotFound();
                List<BudgetMonthDetail> lstMonthDetails = new List<BudgetMonthDetail>();
                for (int i = 1; i <= 12; i++)
                {
                    BudgetMonthDetail monthDetail = new BudgetMonthDetail() { Month = i };
                    switch (i)
                    {
                        case 1:
                            monthDetail.Quantity = lineViewModel.January_Quantity;
                            monthDetail.UnitCost = lineViewModel.January_UnitCost;
                            monthDetail.Target = lineViewModel.January_Target;
                            monthDetail.Forecast = lineViewModel.January_Forecast;
                            monthDetail.Real = lineViewModel.January_Real;
                            break;
                        case 2:
                            monthDetail.Quantity = lineViewModel.February_Quantity;
                            monthDetail.UnitCost = lineViewModel.February_UnitCost;
                            monthDetail.Target = lineViewModel.February_Target;
                            monthDetail.Forecast = lineViewModel.February_Forecast;
                            monthDetail.Real = lineViewModel.February_Real;
                            break;
                        case 3:
                            monthDetail.Quantity = lineViewModel.March_Quantity;
                            monthDetail.UnitCost = lineViewModel.March_UnitCost;
                            monthDetail.Target = lineViewModel.March_Target;
                            monthDetail.Forecast = lineViewModel.March_Forecast;
                            monthDetail.Real = lineViewModel.March_Real;
                            break;
                        case 4:
                            monthDetail.Quantity = lineViewModel.April_Quantity;
                            monthDetail.UnitCost = lineViewModel.April_UnitCost;
                            monthDetail.Target = lineViewModel.April_Target;
                            monthDetail.Forecast = lineViewModel.April_Forecast;
                            monthDetail.Real = lineViewModel.April_Real;
                            break;
                        case 5:
                            monthDetail.Quantity = lineViewModel.May_Quantity;
                            monthDetail.UnitCost = lineViewModel.May_UnitCost;
                            monthDetail.Target = lineViewModel.May_Target;
                            monthDetail.Forecast = lineViewModel.May_Forecast;
                            monthDetail.Real = lineViewModel.May_Real;
                            break;
                        case 6:
                            monthDetail.Quantity = lineViewModel.June_Quantity;
                            monthDetail.UnitCost = lineViewModel.June_UnitCost;
                            monthDetail.Target = lineViewModel.June_Target;
                            monthDetail.Forecast = lineViewModel.June_Forecast;
                            monthDetail.Real = lineViewModel.June_Real;
                            break;
                        case 7:
                            monthDetail.Quantity = lineViewModel.July_Quantity;
                            monthDetail.UnitCost = lineViewModel.July_UnitCost;
                            monthDetail.Target = lineViewModel.July_Target;
                            monthDetail.Forecast = lineViewModel.July_Forecast;
                            monthDetail.Real = lineViewModel.July_Real;
                            break;
                        case 8:
                            monthDetail.Quantity = lineViewModel.August_Quantity;
                            monthDetail.UnitCost = lineViewModel.August_UnitCost;
                            monthDetail.Target = lineViewModel.August_Target;
                            monthDetail.Forecast = lineViewModel.August_Forecast;
                            monthDetail.Real = lineViewModel.August_Real;
                            break;
                        case 9:
                            monthDetail.Quantity = lineViewModel.September_Quantity;
                            monthDetail.UnitCost = lineViewModel.September_UnitCost;
                            monthDetail.Target = lineViewModel.September_Target;
                            monthDetail.Forecast = lineViewModel.September_Forecast;
                            monthDetail.Real = lineViewModel.September_Real;
                            break;
                        case 10:
                            monthDetail.Quantity = lineViewModel.October_Quantity;
                            monthDetail.UnitCost = lineViewModel.October_UnitCost;
                            monthDetail.Target = lineViewModel.October_Target;
                            monthDetail.Forecast = lineViewModel.October_Forecast;
                            monthDetail.Real = lineViewModel.October_Real;
                            break;
                        case 11:
                            monthDetail.Quantity = lineViewModel.November_Quantity;
                            monthDetail.UnitCost = lineViewModel.November_UnitCost;
                            monthDetail.Target = lineViewModel.November_Target;
                            monthDetail.Forecast = lineViewModel.November_Forecast;
                            monthDetail.Real = lineViewModel.November_Real;
                            break;
                        case 12:
                            monthDetail.Quantity = lineViewModel.December_Quantity;
                            monthDetail.UnitCost = lineViewModel.December_UnitCost;
                            monthDetail.Target = lineViewModel.December_Target;
                            monthDetail.Forecast = lineViewModel.December_Forecast;
                            monthDetail.Real = lineViewModel.December_Real;
                            break;
                        default:
                            break;
                    }
                    lstMonthDetails.Add(monthDetail);
                }
                BudgetLine line = new BudgetLine()
                {
                    AccountId = lineViewModel.AccountId,
                    PremiseId = lineViewModel.PremiseId,
                    Description = lineViewModel.Description,
                    ParentId = lineViewModel.ParentId,
                    SheetId = parentLine.SheetId,
                    MonthDetails = lstMonthDetails,
                    Tag = 0
                };

                db.BudgetLines.Add(line);
                var parent = db.BudgetLines.Find(lineViewModel.ParentId.Value);
                var grandParent = db.BudgetLines.Find(parent.ParentId.Value);
                RecalculateLineValues(parent.Id, db, grandParent.Id);
                db.SaveChanges();
                this.RegisterEvent("Se agregó la linea libre " + line.Description + " en la cuenta " + parentLine.Account.Display + " del paquete " + parentLine.Account.PackagesDescription + " en el centro de costo " +parentLine.Sheet.Budget.CostCenter.Display);
                return Ok(GetUpdatedLineValues(line, db));
            }
        }

        private List<BudgetLineViewModel> GetUpdatedLineValues(BudgetLine line, SpresContext db)
        {
            var parent = line.Parent;
            var grandParent = parent.Parent;
            var currentBudget = line.Sheet.Budget;
            var budgetLines = new List<BudgetLine>() { line, parent, grandParent };
            var result = new List<BudgetLineViewModel>();
            foreach (var budgetLine in budgetLines)
            {
                var budgetSource = db.AccountBudgetSources.FirstOrDefault(a => a.AccountId == budgetLine.AccountId);

                var modelo = new BudgetLineViewModel
                {
                    Id = budgetLine.Id,
                    ParentId = budgetLine.ParentId,
                    Description = budgetLine.Description,
                    AccountId = budgetLine.AccountId,
                    PremiseId = budgetLine.PremiseId,
                    ExpenseType = (budgetSource == null) ? BudgetExpenseType.None : budgetSource.ExpenseType
                };

                foreach (var monthDetail in budgetLine.MonthDetails)
                {
                    MonthDetailUpdating(modelo, monthDetail);
                }
                modelo.Summary_YearTotal = modelo.January_Target + modelo.February_Target + modelo.March_Target + modelo.April_Target
                    + modelo.May_Target + modelo.June_Target + modelo.July_Target + modelo.August_Target
                    + modelo.September_Target + modelo.October_Target + modelo.November_Target + modelo.December_Target;

                modelo.Summary_PreviousYear = 0;

                var previousBudget = db.Budgets.FirstOrDefault(b => b.CompanyId == currentBudget.CompanyId
                    && b.CostCenterId == currentBudget.CostCenterId && b.FiscalYear == currentBudget.FiscalYear - 1);

                switch (budgetLines.IndexOf(budgetLine))
                {
                    case 0:
                        modelo.LevelTwoId = modelo.ParentId;
                        break;
                    case 1:
                        modelo.LevelOneId = modelo.ParentId;
                        modelo.LevelTwoId = modelo.Id;
                        break;
                    case 2:
                        modelo.LevelOneId = modelo.Id;
                        break;
                }


                if (previousBudget != null)
                {
                    var previousSheet = previousBudget.Sheets.FirstOrDefault(bs => bs.PackageId == budgetLine.Sheet.PackageId);

                    if (previousSheet != null)
                    {
                        BudgetLine previousLine;
                        switch(budgetLines.IndexOf(budgetLine))
                        {
                            case 0:                                
                                previousLine = previousSheet.Lines.FirstOrDefault(l => l.AccountId == budgetLine.AccountId);
                                if (previousLine != null)
                                {
                                    modelo.Summary_PreviousYear = previousLine.MonthDetails.Sum(m => m.Target);
                                }
                                break;

                            case 1:                                
                                previousLine = previousSheet.Lines.FirstOrDefault(l => l.AccountId == budgetLine.AccountId && l.Tag == null);
                                if (previousLine != null)
                                {
                                    modelo.Summary_PreviousYear = previousLine.MonthDetails.Sum(m => m.Target);
                                }
                                break;

                            case 2:
                                
                                previousLine = previousSheet.Lines.FirstOrDefault(l => l.AccountId == budgetLine.AccountId && l.Tag != null && l.Tag != 0);
                                if (previousLine != null)
                                {
                                    modelo.Summary_PreviousYear = previousLine.MonthDetails.Sum(m => m.Target);
                                }
                                break;
                            default:
                                break;
                        }
                    }
                }
                modelo.Summary_DifferenceTotal = modelo.Summary_YearTotal - modelo.Summary_PreviousYear;
                modelo.Summary_DifferencePercentage = (modelo.Summary_PreviousYear != 0) ? (modelo.Summary_YearTotal - modelo.Summary_PreviousYear) / modelo.Summary_PreviousYear : 0;
                result.Add(modelo);
            }
            return result;
        }

        private void MonthDetailUpdating(BudgetLineViewModel modelo, BudgetMonthDetail monthDetail)
        {
            switch (monthDetail.Month)
            {
                case 1:
                    modelo.January_Quantity = monthDetail.Quantity;
                    modelo.January_UnitCost = monthDetail.UnitCost;
                    modelo.January_Target = monthDetail.Target;
                    modelo.January_Forecast = monthDetail.Forecast;
                    modelo.January_Real = monthDetail.Real;
                    break;
                case 2:
                    modelo.February_Quantity = monthDetail.Quantity;
                    modelo.February_UnitCost = monthDetail.UnitCost;
                    modelo.February_Target = monthDetail.Target;
                    modelo.February_Forecast = monthDetail.Forecast;
                    modelo.February_Real = monthDetail.Real;
                    break;
                case 3:
                    modelo.March_Quantity = monthDetail.Quantity;
                    modelo.March_UnitCost = monthDetail.UnitCost;
                    modelo.March_Target = monthDetail.Target;
                    modelo.March_Forecast = monthDetail.Forecast;
                    modelo.March_Real = monthDetail.Real;
                    break;
                case 4:
                    modelo.April_Quantity = monthDetail.Quantity;
                    modelo.April_UnitCost = monthDetail.UnitCost;
                    modelo.April_Target = monthDetail.Target;
                    modelo.April_Forecast = monthDetail.Forecast;
                    modelo.April_Real = monthDetail.Real;
                    break;
                case 5:
                    modelo.May_Quantity = monthDetail.Quantity;
                    modelo.May_UnitCost = monthDetail.UnitCost;
                    modelo.May_Target = monthDetail.Target;
                    modelo.May_Forecast = monthDetail.Forecast;
                    modelo.May_Real = monthDetail.Real;
                    break;
                case 6:
                    modelo.June_Quantity = monthDetail.Quantity;
                    modelo.June_UnitCost = monthDetail.UnitCost;
                    modelo.June_Target = monthDetail.Target;
                    modelo.June_Forecast = monthDetail.Forecast;
                    modelo.June_Real = monthDetail.Real;
                    break;
                case 7:
                    modelo.July_Quantity = monthDetail.Quantity;
                    modelo.July_UnitCost = monthDetail.UnitCost;
                    modelo.July_Target = monthDetail.Target;
                    modelo.July_Forecast = monthDetail.Forecast;
                    modelo.July_Real = monthDetail.Real;
                    break;
                case 8:
                    modelo.August_Quantity = monthDetail.Quantity;
                    modelo.August_UnitCost = monthDetail.UnitCost;
                    modelo.August_Target = monthDetail.Target;
                    modelo.August_Forecast = monthDetail.Forecast;
                    modelo.August_Real = monthDetail.Real;
                    break;
                case 9:
                    modelo.September_Quantity = monthDetail.Quantity;
                    modelo.September_UnitCost = monthDetail.UnitCost;
                    modelo.September_Target = monthDetail.Target;
                    modelo.September_Forecast = monthDetail.Forecast;
                    modelo.September_Real = monthDetail.Real;
                    break;
                case 10:
                    modelo.October_Quantity = monthDetail.Quantity;
                    modelo.October_UnitCost = monthDetail.UnitCost;
                    modelo.October_Target = monthDetail.Target;
                    modelo.October_Forecast = monthDetail.Forecast;
                    modelo.October_Real = monthDetail.Real;
                    break;
                case 11:
                    modelo.November_Quantity = monthDetail.Quantity;
                    modelo.November_UnitCost = monthDetail.UnitCost;
                    modelo.November_Target = monthDetail.Target;
                    modelo.November_Forecast = monthDetail.Forecast;
                    modelo.November_Real = monthDetail.Real;
                    break;
                case 12:
                    modelo.December_Quantity = monthDetail.Quantity;
                    modelo.December_UnitCost = monthDetail.UnitCost;
                    modelo.December_Target = monthDetail.Target;
                    modelo.December_Forecast = monthDetail.Forecast;
                    modelo.December_Real = monthDetail.Real;
                    break;
                default:
                    break;
            }
        }

        [Route("api/BudgetLines/PostEmptyLine/{parentLineId}/{premiseId}")]
        [SpresSecurityAttribute("Budgeting", false, true)]
        public IHttpActionResult PostEmptyLine(int parentLineId, int premiseId, [FromUri]string description = "")
        {
            using (var db = new SpresContext())
            {
                BudgetLine parentLine = db.BudgetLines.Find(parentLineId);
                List<BudgetMonthDetail> monthDetails = new List<BudgetMonthDetail>();
                for (int i = 1; i <= 12; i++)
                    monthDetails.Add(new BudgetMonthDetail { Forecast = 0, Month = i, Quantity = 0, Real = 0, Target = 0, UnitCost = 0 });
                BudgetLine newLine = new BudgetLine
                {
                    Description = description,
                    MonthDetails = monthDetails,
                    ParentId = parentLine.Id,
                    SheetId = parentLine.SheetId,
                    PremiseId = premiseId,
                    AccountId = parentLine.AccountId,
                    Tag = 0
                };
                parentLine.Children.Add(newLine);
                db.SaveChanges();
                this.RegisterEvent("Se agregó la línea por premisa " + newLine.Description + " en la cuenta " + parentLine.Account.Display + " para el periodo " + parentLine.Sheet.Budget.FiscalYear + " y paquete " + parentLine.Sheet.Package.Name + " en el centro de costo " + parentLine.Sheet.Budget.CostCenter.Display + " de la región " + parentLine.Sheet.Budget.Company.Name);
                return Json(newLine.Id);
            }
        }

        [Route("api/BudgetLines/PostGenerateLines/{costCenterId}/{budgetLineId}/{allCostCenters}")]
        // No agregar filtro de seguridad
        public async Task<IHttpActionResult> PostGenerateLines(int costCenterId, int budgetLineId, bool allCostCenters)
        {
            try
            {
                using (var db = new SpresContext())
                {
                    var line = db.BudgetLines.Find(budgetLineId);
                    var sheet = db.BudgetSheets.Find(line.SheetId);
                    var budget = line.Sheet.Budget;
                    var budgetSource = db.AccountBudgetSources.FirstOrDefault(a => a.AccountId == line.AccountId);

                    if (budgetSource.ExpenseType == BudgetExpenseType.Formule)
                    {
                        foreach (var childLine in line.Children.ToList())
                        {
                            db.BudgetLines.Remove(childLine);
                        }

                        if (allCostCenters)
                        {
                            await db.PeopleAllCostCentersCalculation(budget.CompanyId, budget.FiscalYear, sheet.PackageId, line.AccountId);
                        }
                        else
                        {
                            List<Employee> employees = db.Employees.Where(e => e.CostCenterId == costCenterId && e.Active).ToList();
                            foreach (Employee employee in employees)
                            {
                                List<BudgetMonthDetail> monthDetails = new List<BudgetMonthDetail>();
                                var calculations = await db.PeriodsBudgetCalculation(budgetLineId, employee.Id);
                                for (int i = 1; i <= 12; i++)
                                {
                                    decimal unitCost = calculations.First(c => c.BudgetMonth == i).Cost;
                                    monthDetails.Add(new BudgetMonthDetail { Forecast = 0, Month = i, Quantity = 1, Real = 0, Target = unitCost, UnitCost = unitCost });
                                }
                                sheet.Lines.Add(new BudgetLine
                                {
                                    Description = string.Format("{0} ({1})", employee.Name, employee.Position.Name),
                                    MonthDetails = monthDetails,
                                    ParentId = line.Id,
                                    SheetId = line.SheetId,
                                    PremiseId = line.PremiseId,
                                    AccountId = line.AccountId,
                                    Tag = employee.Id
                                });
                            }
                            RecalculateLineValues(budgetLineId, db, line.ParentId.Value);
                            db.SaveChanges();
                        }
                        this.RegisterEvent("Se generaron líneas de presupuestación automáticamente por medio de una fórmula en la cuenta " + line.Account.Display + " para el periodo " + line.Sheet.Budget.FiscalYear + " y paquete " + line.Account.PackagesDescription + " en el centro de costo " + line.Sheet.Budget.CostCenter.Display + " de la región " + line.Sheet.Budget.Company.Name);
                        return Ok();
                    }
                    else
                    {
                        return BadRequest();
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLog.SaveError(ex);
                return InternalServerError(ex);
            }
        }

        public void RecalculateLineValues(int id, SpresContext db, int parentId)
        {
            var childLine = db.BudgetLines.Find(id);
            var parentLine = db.BudgetLines.Find(parentId);

            for (int i = 1; i <= 12; i++)
            {
                decimal parentTotal = 0;
                foreach (var line in parentLine.Children)
                {
                    decimal lineTotal = 0;
                    foreach (var subLine in line.Children) lineTotal += subLine.MonthDetails.First(md => md.Month == i).Target;
                    var lineMonthDetail = line.MonthDetails.First(md => md.Month == i);
                    lineMonthDetail.Target = lineTotal;
                    parentTotal += lineTotal;
                    db.Entry(lineMonthDetail).State = EntityState.Modified;
                }
                var parentMonthDetail = parentLine.MonthDetails.First(md => md.Month == i);
                parentMonthDetail.Target = parentTotal;
                db.Entry(parentMonthDetail).State = EntityState.Modified;
            }
        }

        [Route("api/BudgetLines/PutLine")]
        [SpresSecurityAttribute("Budgeting", false, true)]
        public IHttpActionResult PutLine(BudgetLineViewModel lineViewModel)
        {
            using (var db = new SpresContext())
            {
                BudgetLine line = db.BudgetLines.Find(lineViewModel.Id);
                foreach (var monthDetail in line.MonthDetails)
                {
                    switch (monthDetail.Month)
                    {
                        case 1:
                            monthDetail.Quantity = lineViewModel.January_Quantity;
                            monthDetail.UnitCost = lineViewModel.January_UnitCost;
                            monthDetail.Target = lineViewModel.January_Target;
                            monthDetail.Forecast = lineViewModel.January_Forecast;
                            monthDetail.Real = lineViewModel.January_Real;
                            db.Entry(monthDetail).State = EntityState.Modified;
                            break;
                        case 2:
                            monthDetail.Quantity = lineViewModel.February_Quantity;
                            monthDetail.UnitCost = lineViewModel.February_UnitCost;
                            monthDetail.Target = lineViewModel.February_Target;
                            monthDetail.Forecast = lineViewModel.February_Forecast;
                            monthDetail.Real = lineViewModel.February_Real;
                            db.Entry(monthDetail).State = EntityState.Modified;
                            break;
                        case 3:
                            monthDetail.Quantity = lineViewModel.March_Quantity;
                            monthDetail.UnitCost = lineViewModel.March_UnitCost;
                            monthDetail.Target = lineViewModel.March_Target;
                            monthDetail.Forecast = lineViewModel.March_Forecast;
                            monthDetail.Real = lineViewModel.March_Real;
                            db.Entry(monthDetail).State = EntityState.Modified;
                            break;
                        case 4:
                            monthDetail.Quantity = lineViewModel.April_Quantity;
                            monthDetail.UnitCost = lineViewModel.April_UnitCost;
                            monthDetail.Target = lineViewModel.April_Target;
                            monthDetail.Forecast = lineViewModel.April_Forecast;
                            monthDetail.Real = lineViewModel.April_Real;
                            db.Entry(monthDetail).State = EntityState.Modified;
                            break;
                        case 5:
                            monthDetail.Quantity = lineViewModel.May_Quantity;
                            monthDetail.UnitCost = lineViewModel.May_UnitCost;
                            monthDetail.Target = lineViewModel.May_Target;
                            monthDetail.Forecast = lineViewModel.May_Forecast;
                            monthDetail.Real = lineViewModel.May_Real;
                            db.Entry(monthDetail).State = EntityState.Modified;
                            break;
                        case 6:
                            monthDetail.Quantity = lineViewModel.June_Quantity;
                            monthDetail.UnitCost = lineViewModel.June_UnitCost;
                            monthDetail.Target = lineViewModel.June_Target;
                            monthDetail.Forecast = lineViewModel.June_Forecast;
                            monthDetail.Real = lineViewModel.June_Real;
                            db.Entry(monthDetail).State = EntityState.Modified;
                            break;
                        case 7:
                            monthDetail.Quantity = lineViewModel.July_Quantity;
                            monthDetail.UnitCost = lineViewModel.July_UnitCost;
                            monthDetail.Target = lineViewModel.July_Target;
                            monthDetail.Forecast = lineViewModel.July_Forecast;
                            monthDetail.Real = lineViewModel.July_Real;
                            db.Entry(monthDetail).State = EntityState.Modified;
                            break;
                        case 8:
                            monthDetail.Quantity = lineViewModel.August_Quantity;
                            monthDetail.UnitCost = lineViewModel.August_UnitCost;
                            monthDetail.Target = lineViewModel.August_Target;
                            monthDetail.Forecast = lineViewModel.August_Forecast;
                            monthDetail.Real = lineViewModel.August_Real;
                            db.Entry(monthDetail).State = EntityState.Modified;

                            break;
                        case 9:
                            monthDetail.Quantity = lineViewModel.September_Quantity;
                            monthDetail.UnitCost = lineViewModel.September_UnitCost;
                            monthDetail.Target = lineViewModel.September_Target;
                            monthDetail.Forecast = lineViewModel.September_Forecast;
                            monthDetail.Real = lineViewModel.September_Real;
                            db.Entry(monthDetail).State = EntityState.Modified;
                            break;
                        case 10:
                            monthDetail.Quantity = lineViewModel.October_Quantity;
                            monthDetail.UnitCost = lineViewModel.October_UnitCost;
                            monthDetail.Target = lineViewModel.October_Target;
                            monthDetail.Forecast = lineViewModel.October_Forecast;
                            monthDetail.Real = lineViewModel.October_Real;
                            db.Entry(monthDetail).State = EntityState.Modified;
                            break;
                        case 11:
                            monthDetail.Quantity = lineViewModel.November_Quantity;
                            monthDetail.UnitCost = lineViewModel.November_UnitCost;
                            monthDetail.Target = lineViewModel.November_Target;
                            monthDetail.Forecast = lineViewModel.November_Forecast;
                            monthDetail.Real = lineViewModel.November_Real;
                            db.Entry(monthDetail).State = EntityState.Modified;
                            break;
                        case 12:
                            monthDetail.Quantity = lineViewModel.December_Quantity;
                            monthDetail.UnitCost = lineViewModel.December_UnitCost;
                            monthDetail.Target = lineViewModel.December_Target;
                            monthDetail.Forecast = lineViewModel.December_Forecast;
                            monthDetail.Real = lineViewModel.December_Real;
                            db.Entry(monthDetail).State = EntityState.Modified;
                            break;
                        default:
                            break;
                    }
                }
                var parent = db.BudgetLines.Find(lineViewModel.ParentId);
                var grandParent = db.BudgetLines.Find(parent.ParentId);
                line.Description = lineViewModel.Description;
                RecalculateLineValues(parent.Id, db, grandParent.Id);
                db.Entry(line).State = EntityState.Modified;
                db.SaveChanges();
                this.RegisterEvent("Se editó la línea de presupuestación " + line.Description + " de la cuenta " + line.Account.Display + " en el centro de costo " + line.Sheet.Budget.CostCenter.Display);
                return Ok(GetUpdatedLineValues(line, db));
            }
        }

        [SpresSecurityAttribute("Budgeting", false, true)]
        public IHttpActionResult DeleteLine(int id)
        {
            using (var db = new SpresContext())
            {
                BudgetLine line = db.BudgetLines.Find(id);
                
                if (line == null)
                    return NotFound();

                int parentId = line.ParentId.Value;
                var grandParent = db.BudgetLines.Find(parentId);
                
                var company = line.Sheet.Budget.Company.Name;
                var account = line.Account.Display;
                var package = line.Sheet.Package.Name;
                var costCenter = line.Sheet.Budget.CostCenter.Display;
                var fiscal = line.Sheet.Budget.FiscalYear;

                db.BudgetLines.Remove(line);
                RecalculateLineValues(parentId, db, grandParent.ParentId.Value);
                db.SaveChanges();
                this.RegisterEvent("Se eliminó la línea de presupuestación " + line.Description + " de la cuenta " + account + " para el periodo " + fiscal + " y paquete " + package + " en el centro de costo " + costCenter + " de la región " + company );
                return Ok();
            }
        }
    }
}
