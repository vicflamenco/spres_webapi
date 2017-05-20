using Spres.Infrastructure;
using Spres.Infrastructure.ErrorLog;
using SpresDev.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web.Http;

namespace SpresDev.Controllers.Api
{
    public class SummariesController : ApiController
    {

        [SpresSecurityAttribute("Budgeting", true, false)]
        [Route("api/Summaries/GetSummary/{fiscalYear}/{companyId}/{costCenterId}/{toCurrencyId}")]
        public IHttpActionResult GetSummary(int fiscalYear, int companyId, int costCenterId, string toCurrencyId)
        {
            using (var dbContext = new SpresContext())
            {
                var costCenter = dbContext.CostCenters.Find(costCenterId);
                var country = dbContext.Countries.Find(costCenter.Company.Country);
                var defaultCurrencyId = country.DefaultCurrencyId;
                var er = ExchangeRatesController.GetLatestExchangeRate(defaultCurrencyId, toCurrencyId);
                PropertyInfo[] properties = typeof(SummaryViewModel).GetProperties();

                List<SummaryViewModel> lstParentLines = new List<SummaryViewModel>();
                List<SummaryViewModel> lstChildrenLines = new List<SummaryViewModel>();
                List<SummaryViewModel> lstSubChildrenLines = new List<SummaryViewModel>();

                var budgMonthDetails = dbContext.BudgetMonthDetails;
                var costCenterType = costCenter.Type;

                if (costCenterType == "A" || costCenterType == "M")
                {
                    lstParentLines = dbContext.Packages.Select(p => new SummaryViewModel
                    {
                        Id = p.Id,
                        Package = p.Name,
                        LevelOneId = p.Id,
                        CurrentTotal = budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0,
                        PreviousForecast = budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Forecast) ?? 0,
                        VarTotalVSFrcst = (decimal?)(budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => bm.Forecast))) ?? 0,
                        VarTotalVSFrcstCoin = (budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Forecast) ?? 0)),
                        PreviousReal = budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Real) ?? 0,
                        VarTotalVSPreviousReal = (decimal?)(budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => bm.Real))) ?? 0,
                        VarTotalVSPreviousRealCoin = (budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Real) ?? 0)),

                    }).ToList();

                    lstChildrenLines = dbContext.Packages.SelectMany(p => p.Accounts.Where(a => a.Parent == null && a.Type == "M,A").Select(a => new SummaryViewModel
                    {
                        Id = a.Id,
                        Code = a.Code,
                        Description = a.Name,
                        LevelOneId = p.Id,
                        LevelTwoId = a.Id,
                        CurrentTotal = budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0,
                        PreviousForecast = budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Forecast) ?? 0,
                        PreviousReal = budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Real) ?? 0,
                        VarTotalVSFrcst = (decimal?)(budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => bm.Forecast))) ?? 0,
                        VarTotalVSFrcstCoin = (budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Forecast) ?? 0)),
                        VarTotalVSPreviousReal = (decimal?)(budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => bm.Real))) ?? 0,
                        VarTotalVSPreviousRealCoin = (budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Real) ?? 0)),

                    })).ToList();
                    lstSubChildrenLines = dbContext.Accounts.Where(a => a.Parent != null && a.Type == "M,A").Select(ac => new SummaryViewModel
                    {
                        Id = ac.Id,
                        Code = ac.Code,
                        Description = ac.Name,
                        LevelTwoId = ac.ParentId,
                        CurrentTotal = budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0,
                        PreviousForecast = budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Forecast) ?? 0,
                        PreviousReal = budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Real) ?? 0,
                        VarTotalVSFrcst = (decimal?)(budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => bm.Forecast))) ?? 0,
                        VarTotalVSFrcstCoin = (budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Forecast) ?? 0)),
                        VarTotalVSPreviousReal = (decimal?)(budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => bm.Real))) ?? 0,
                        VarTotalVSPreviousRealCoin = (budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Real) ?? 0)),
                    }).ToList();
                }
                else if (costCenterType == "P")
                {
                    lstParentLines = dbContext.Packages.Select(p => new SummaryViewModel
                    {
                        Id = p.Id,
                        Package = p.Name,
                        LevelOneId = p.Id,
                        CurrentTotal = budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0,
                        PreviousForecast = budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Forecast) ?? 0,
                        VarTotalVSFrcst = (decimal?)(budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => bm.Forecast))) ?? 0,
                        VarTotalVSFrcstCoin = (budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Forecast) ?? 0)),
                        PreviousReal = budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Real) ?? 0,
                        VarTotalVSPreviousReal = (decimal?)(budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => bm.Real))) ?? 0,
                        VarTotalVSPreviousRealCoin = (budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Real) ?? 0)),

                    }).ToList();

                    lstChildrenLines = dbContext.Packages.SelectMany(p => p.Accounts.Where(a => a.Parent == null && a.Type == "P").Select(a => new SummaryViewModel
                    {
                        Id = a.Id,
                        Code = a.Code,
                        Description = a.Name,
                        LevelOneId = p.Id,
                        LevelTwoId = a.Id,
                        CurrentTotal = budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0,
                        PreviousForecast = budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Forecast) ?? 0,
                        PreviousReal = budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Real) ?? 0,
                        VarTotalVSFrcst = (decimal?)(budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => bm.Forecast))) ?? 0,
                        VarTotalVSFrcstCoin = (budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Forecast) ?? 0)),
                        VarTotalVSPreviousReal = (decimal?)(budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => bm.Real))) ?? 0,
                        VarTotalVSPreviousRealCoin = (budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Real) ?? 0)),

                    })).ToList();
                    lstSubChildrenLines = dbContext.Accounts.Where(a => a.Parent != null && a.Type == "P").Select(ac => new SummaryViewModel
                    {
                        Id = ac.Id,
                        Code = ac.Code,
                        Description = ac.Name,
                        LevelTwoId = ac.ParentId,
                        CurrentTotal = budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0,
                        PreviousForecast = budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Forecast) ?? 0,
                        PreviousReal = budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Real) ?? 0,
                        VarTotalVSFrcst = (decimal?)(budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => bm.Forecast))) ?? 0,
                        VarTotalVSFrcstCoin = (budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Forecast) ?? 0)),
                        VarTotalVSPreviousReal = (decimal?)(budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => bm.Real))) ?? 0,
                        VarTotalVSPreviousRealCoin = (budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Real) ?? 0)),
                    }).ToList();
                }
                else
                {
                    lstParentLines = dbContext.Packages.Select(p => new SummaryViewModel
                    {
                        Id = p.Id,
                        Package = p.Name,
                        LevelOneId = p.Id,
                        CurrentTotal = budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0,
                        PreviousForecast = budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Forecast) ?? 0,
                        VarTotalVSFrcst = (decimal?)(budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => bm.Forecast))) ?? 0,
                        VarTotalVSFrcstCoin = (budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Forecast) ?? 0)),
                        PreviousReal = budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Real) ?? 0,
                        VarTotalVSPreviousReal = (decimal?)(budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => bm.Real))) ?? 0,
                        VarTotalVSPreviousRealCoin = (budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.Sheet.PackageId == p.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId && bm.Line.Account.ParentId == null).Sum(bm => (decimal?)bm.Real) ?? 0)),

                    }).ToList();

                    lstChildrenLines = dbContext.Packages.SelectMany(p => p.Accounts.Where(a => a.Parent == null && a.Type == costCenterType).Select(a => new SummaryViewModel
                    {
                        Id = a.Id,
                        Code = a.Code,
                        Description = a.Name,
                        LevelOneId = p.Id,
                        LevelTwoId = a.Id,
                        CurrentTotal = budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0,
                        PreviousForecast = budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Forecast) ?? 0,
                        PreviousReal = budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Real) ?? 0,
                        VarTotalVSFrcst = (decimal?)(budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => bm.Forecast))) ?? 0,
                        VarTotalVSFrcstCoin = (budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Forecast) ?? 0)),
                        VarTotalVSPreviousReal = (decimal?)(budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => bm.Real))) ?? 0,
                        VarTotalVSPreviousRealCoin = (budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.AccountId == a.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Real) ?? 0)),

                    })).ToList();
                    lstSubChildrenLines = dbContext.Accounts.Where(a => a.Parent != null && a.Type == costCenterType).Select(ac => new SummaryViewModel
                    {
                        Id = ac.Id,
                        Code = ac.Code,
                        Description = ac.Name,
                        LevelTwoId = ac.ParentId,
                        CurrentTotal = budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0,
                        PreviousForecast = budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Forecast) ?? 0,
                        PreviousReal = budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Real) ?? 0,
                        VarTotalVSFrcst = (decimal?)(budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => bm.Forecast))) ?? 0,
                        VarTotalVSFrcstCoin = (budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Forecast) ?? 0)),
                        VarTotalVSPreviousReal = (decimal?)(budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0) / ((budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => bm.Real))) ?? 0,
                        VarTotalVSPreviousRealCoin = (budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.FiscalYear == fiscalYear && bm.Line.Sheet.Budget.CostCenterId == costCenterId && dbContext.BudgetLines.Any(bchild => bchild.ParentId == bm.LineId)).Sum(bm => (decimal?)bm.Target) ?? 0) - ((budgMonthDetails.Where(bm => bm.Line.AccountId == ac.Id && bm.Line.Sheet.Budget.FiscalYear == fiscalYear - 1 && bm.Line.Sheet.Budget.CompanyId == companyId && bm.Line.Sheet.Budget.CostCenterId == costCenterId).Sum(bm => (decimal?)bm.Real) ?? 0)),
                    }).ToList();
                    
                }

                if (defaultCurrencyId != toCurrencyId)
                {
                    foreach (PropertyInfo property in properties)
                    {
                        if (property.PropertyType.Name.Equals("Decimal"))
                        {
                            foreach (var item in lstParentLines)
                            {
                                decimal value = Convert.ToDecimal(property.GetValue(item));
                                if (value > 0)
                                {
                                    property.SetValue(item, ExchangeRatesController.Convert(value, er));
                                }
                                
                            }
                            foreach (var item in lstChildrenLines)
                            {
                                decimal value = Convert.ToDecimal(property.GetValue(item));
                                if (value > 0)
                                {
                                    property.SetValue(item, ExchangeRatesController.Convert(value, er));
                                }
                            }
                            foreach (var item in lstSubChildrenLines)
                            {
                                decimal value = Convert.ToDecimal(property.GetValue(item));
                                if (value > 0)
                                {
                                    property.SetValue(item, ExchangeRatesController.Convert(value, er));
                                }
                            }
                        }
                    }
                }

                return Ok(new SummaryListViewModel { ParentLines = lstParentLines, ChildrenLines = lstChildrenLines, SubChildrenLines = lstSubChildrenLines });
            }
        }

        [SpresSecurityAttribute("Budgeting", true, false)]
        [Route("api/Summaries/Total/{company}/{year}")]
        public IHttpActionResult GetTotal(int company, int year)
        {
            try
            {
                using (SpresContext dbContext = new SpresContext())
                {
                    var sum = dbContext.BudgetMonthDetails.Where(bm => bm.Line.Sheet.Budget.FiscalYear == year && bm.Line.Sheet.Budget.Company.Id == company).Sum(bm => (decimal?)bm.Forecast) ?? 0;
                    return Ok(sum);
                }
            }
            catch (Exception e)
            {
                ErrorLog.SaveError(e);
                return InternalServerError(e);
            }
        }

    }

}



