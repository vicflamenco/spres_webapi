using Spres.Infrastructure;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using Spres.Infrastructure.ErrorLog;
using Spres.Models;
using Spres.Infrastructure.Audit;
using System.Transactions;

namespace SpresDev.Controllers.Api
{
    [SpresSecurity("Consolidate", edit:true)]
    public class ImportController : ApiController
    {
        public async Task<IHttpActionResult> PostRealFile()
        {
            if (Request.Content.IsMimeMultipartContent())
            {
                try
                {
                    var multipart = new MultipartFormDataStreamProvider(Path.GetTempPath());
                    await Request.Content.ReadAsMultipartAsync(multipart);
                    var companyId = int.Parse(multipart.FormData["companyId"]);
                    var fiscalYear = int.Parse(multipart.FormData["fiscalYear"]);
                    var month = int.Parse(multipart.FormData["month"]);
                    var file = multipart.FileData[0];

                    var fileLines = File.ReadAllLines(file.LocalFileName);

                    if (fileLines.Length == 0)
                    {
                        return BadRequest("Empty file provided");
                    }

                    var realLines = new List<RealLine>();
                    foreach (var fileLine in fileLines)
                    {
                        var fields = fileLine.Split('|');
                        if (fields.Length > 1 && String.IsNullOrWhiteSpace(fields[1]))
                        {
                            try
                            {
                                
                                    realLines.Add(new RealLine
                                    {
                                        AccountCode = fields[4],
                                        Value = decimal.Parse(fields[19]),
                                        CostCenterCode = (String.IsNullOrWhiteSpace(fields[12])) ? fields[10] : fields[12]
                                    });
                                
                            }
                            catch (IndexOutOfRangeException ex)
                            {
                                ErrorLog.SaveError(ex);
                                return BadRequest("Invalid format file");
                            }
                        }
                    }

                    var finalLines = realLines.GroupBy(rl => new { rl.AccountCode, rl.CostCenterCode })
                        .Select(rl => new RealLine
                        {
                            AccountCode = rl.Key.AccountCode,
                            CostCenterCode = rl.Key.CostCenterCode,
                            Value = rl.Sum(v => v.Value)
                        }).OrderBy(rl => rl.CostCenterCode).ThenBy(rl => rl.AccountCode);


                    using (var model = new SpresContext())
                    {
                        var parentLineIds = new List<int>();
                        var costCenterCodes = finalLines.Select(fl => fl.CostCenterCode).Distinct();

                        var budgets = model.Budgets.Include("CostCenter").Where(b => b.CompanyId == companyId
                                && b.FiscalYear == fiscalYear && costCenterCodes.Contains(b.CostCenter.Code)).ToList();

                        foreach (var costcenterCode in costCenterCodes)
                        {
                            var budget = budgets.FirstOrDefault(b => b.CostCenter.Code == costcenterCode);

                            if (budget != null)
                            {
                                var costCenterLines = finalLines.Where(fl => fl.CostCenterCode == costcenterCode);
                                foreach (var costCenterLine in costCenterLines)
                                {
                                    var detail = model.BudgetMonthDetails.Include("Line")
                                        .FirstOrDefault(d => d.Line.Account.Code == costCenterLine.AccountCode &&
                                            d.Line.Sheet.BudgetId == budget.Id && d.Month == month);

                                    if (detail != null)
                                    {
                                        detail.Real =
                                            costCenterLine.Value;

                                        if (detail.Line.ParentId.HasValue && !parentLineIds.Contains(detail.Line.ParentId.Value))
                                        {
                                            parentLineIds.Add(detail.Line.ParentId.Value);
                                        }
                                    }
                                }
                            }
                        }

                        var parentDetails = model.BudgetMonthDetails.Include("Line").Where(d => parentLineIds.Contains(d.LineId) && d.Month == month).ToList();
                        foreach (var parentDetail in parentDetails)
                        {
                            parentDetail.Real = parentDetail.Line.Children.Select(ch => ch.MonthDetails.First(md => md.Month == month).Real).Sum();
                        }
                        model.SaveChanges();

                        this.RegisterEvent(String.Format("Importación de archivo de reales: {0}", (new DateTime(fiscalYear, month, 1)).ToString("MMM/yyyy")));

                        return Ok();
                    }
                    
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    return InternalServerError(ex);
                }
            }
            else
            {                
                return BadRequest("Invalid request data");
            }
        }



        [Route("api/Import/PostCommittedOrdersFile")]
        public async Task<IHttpActionResult> PostCommittedOrdersFile()
        {
            if (Request.Content.IsMimeMultipartContent())
            {
                var multipart = new MultipartFormDataStreamProvider(Path.GetTempPath());
                await Request.Content.ReadAsMultipartAsync(multipart);
                var companyId = int.Parse(multipart.FormData["companyId"]);
                var fiscalYear = int.Parse(multipart.FormData["fiscalYear"]);
                var month = int.Parse(multipart.FormData["month"]);
                var file = multipart.FileData[0];

                var fileLines = File.ReadAllLines(file.LocalFileName);

                if (fileLines.Length == 0)
                {
                    return BadRequest("Empty file provided");
                }


                var realLines = new List<RealLine>();
                foreach (var fileLine in fileLines)
                {
                    var fields = fileLine.Split('|');

                    if (fields.Length > 1 && fields[1] != "" && fields[1] != "*")
                    {
                        try
                        {
                            if (fields[8] == "USD ")
                            {
                                if (fields[7] != "0.00 ")
                                {

                                    realLines.Add(new RealLine
                                    {
                                        AccountCode = fields[2],
                                        Value = decimal.Parse(fields[7]),
                                        CostCenterCode = fields[1].Trim()
                                    });
                                }
                            }
                        }
                        catch (IndexOutOfRangeException)
                        {
                            return BadRequest("Invalid format file");
                        }
                    }
                }

                var finalLines = realLines.GroupBy(rl => new { rl.AccountCode, rl.CostCenterCode })
                    .Select(rl => new RealLine
                    {
                        AccountCode = rl.Key.AccountCode,
                        CostCenterCode = rl.Key.CostCenterCode,
                        Value = rl.Sum(v => v.Value)
                    }).OrderBy(rl => rl.CostCenterCode).ThenBy(rl => rl.AccountCode);

                using (var model = new SpresContext())
                {
                    foreach (var costcenterCode in finalLines.Select(fl => fl.CostCenterCode.Trim()).Distinct())
                    {
                        var budget = model.Budgets.FirstOrDefault(b => b.CompanyId == companyId
                            && b.FiscalYear == fiscalYear && b.CostCenter.Code == costcenterCode);

                        if (budget != null)
                        {
                            foreach (var accountCode in finalLines.Where(fl => fl.CostCenterCode == costcenterCode).Select(fl => fl.AccountCode))
                            {
                                var line = model.BudgetLines.FirstOrDefault(bl => bl.Account.Code == accountCode && bl.Sheet.BudgetId == budget.Id);
                                if (line != null)
                                {
                                    line.MonthDetails.First(md => md.Month == month).Forecast =
                                        finalLines.First(fl => fl.AccountCode == accountCode && fl.CostCenterCode == costcenterCode).Value;
                                }
                            }
                        }
                    }
                    model.SaveChanges();
                    return Ok();
                }
            }
            else
            {
                return BadRequest("Invalid request data");
            }
        }


        [Route("api/Import/PostCommittedCostCenterFile")]
        public async Task<IHttpActionResult> PostCommittedCostCenterFile()
        {
            if (Request.Content.IsMimeMultipartContent())
            {
                var multipart = new MultipartFormDataStreamProvider(Path.GetTempPath());
                await Request.Content.ReadAsMultipartAsync(multipart);
                var companyId = int.Parse(multipart.FormData["companyId"]);
                var fiscalYear = int.Parse(multipart.FormData["fiscalYear"]);
                var month = int.Parse(multipart.FormData["month"]);
                var file = multipart.FileData[0];

                var fileLines = File.ReadAllLines(file.LocalFileName);

                if (fileLines.Length == 0)
                {
                    return BadRequest("Empty file provided");
                }


                var realLines = new List<RealLine>();
                foreach (var fileLine in fileLines)
                {
                    var fields = fileLine.Split('|');

                    if (fields.Length > 1 && fields[1] != "" && fields[1] != "*")
                    {
                        try
                        {
                            if (fields[20] == "USD  ")
                            {
                                if (fields[4].Trim() != "0.00")
                                {

                                    realLines.Add(new RealLine
                                    {
                                        AccountCode = fields[2],
                                        Value = decimal.Parse(fields[4]),
                                        CostCenterCode = fields[1].Trim()
                                    });
                                }
                            }
                        }
                        catch (IndexOutOfRangeException)
                        {
                            return BadRequest("Invalid format file");
                        }
                    }
                }

                var finalLines = realLines.GroupBy(rl => new { rl.AccountCode, rl.CostCenterCode })
                    .Select(rl => new RealLine
                    {
                        AccountCode = rl.Key.AccountCode,
                        CostCenterCode = rl.Key.CostCenterCode,
                        Value = rl.Sum(v => v.Value)
                    }).OrderBy(rl => rl.CostCenterCode).ThenBy(rl => rl.AccountCode);

                using (var model = new SpresContext())
                {
                    foreach (var costcenterCode in finalLines.Select(fl => fl.CostCenterCode.Trim()).Distinct())
                    {
                        var budget = model.Budgets.FirstOrDefault(b => b.CompanyId == companyId
                            && b.FiscalYear == fiscalYear && b.CostCenter.Code == costcenterCode);

                        if (budget != null)
                        {
                            foreach (var accountCode in finalLines.Where(fl => fl.CostCenterCode == costcenterCode).Select(fl => fl.AccountCode))
                            {
                                var line = model.BudgetLines.FirstOrDefault(bl => bl.Account.Code == accountCode && bl.Sheet.BudgetId == budget.Id);
                                if (line != null)
                                {
                                    line.MonthDetails.First(md => md.Month == month).Forecast =
                                        finalLines.First(fl => fl.AccountCode == accountCode && fl.CostCenterCode == costcenterCode).Value;
                                }
                            }
                        }
                    }
                    model.SaveChanges();
                    return Ok();
                }
            }
            else
            {
                return BadRequest("Invalid request data");
            }
        }


        private class RealLine
        {
            public string AccountCode { get; set; }
            public string CostCenterCode { get; set; }
            public decimal Value { get; set; }
        }
    
    }
}
