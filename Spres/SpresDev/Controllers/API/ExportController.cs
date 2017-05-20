using ClosedXML.Excel;
using Spres.Infrastructure;
using Spres.Infrastructure.ErrorLog;
using Spres.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web.Http;
using System.Xml.Linq;

namespace SpresDev.Controllers.Api
{
    public class ExportController : ApiController
    {
        private string GetSheetName(string packageName)
        {
            if (packageName.Length > 30) 
            {
                packageName = packageName.Substring(0, 30);
            }
            return new Regex("[^a-zA-Z0-9 ]").Replace(packageName, "");
        }

        [Route("api/Export/AOP/{fiscalYear}/{companyId}/{toCurrencyId}")]
        public HttpResponseMessage GetAOP(int fiscalYear, int companyId, string toCurrencyId)
        {
            try
            {
                using (var db = new SpresContext())
                {
                    var country = db.Companies.Find(companyId).Country;
                    var defaultCurrencyId = db.Countries.Find(country).DefaultCurrencyId;
                    var er = ExchangeRatesController.GetLatestExchangeRate(defaultCurrencyId, toCurrencyId);
                    var currency = db.Currencies.Find(toCurrencyId);
                    var currencyName = (currency != null) ? currency.Name : "Moneda";
                    var company = db.Companies.Find(companyId);
                    var companyName = (company == null) ? "DIVISIÓN" : company.Name;
                    var budgets = db.Budgets.Where(b => b.FiscalYear == fiscalYear && b.CompanyId == companyId);
                    var packages = db.Packages.Where(p => p.HR);
                    var workbook = new XLWorkbook();
                    var employees = db.Employees.Include("Position").Where(e => e.CostCenter.CompanyId == companyId).ToList();

                    foreach (var package in packages.ToList())
                    {
                        var sheetName = GetSheetName(package.Name);
                        var worksheet = workbook.Worksheets.Add(sheetName);

                        for (int i = 1; i < 3; i++)
                        {
                            string value = string.Empty;
                            switch (i)
                            {
                                case 1: value = "PRESUPUESTO " + fiscalYear; break;
                                case 2: value = "DIVISIÓN: " + companyName; break;
                                default: break;
                            }
                            worksheet.Cell(i, 2).Value = value;
                            worksheet.Range(i, 2, i, 3).Merge();
                        }

                        var columnHeaders = new List<string> { "Tipo", "CECO", "Id", "Cuenta", "Descripción", "Nombre del puesto", "Salario", 
                        "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre",
                        "Total Anual", "", "Meta " + (fiscalYear - 1).ToString(), "Dif (Monto)", "Dif (%)"};

                        int headerRow = 4;

                        for (int i = 0; i < columnHeaders.Count; i++)
                        {
                            worksheet.Cell(headerRow, i + 2).Value = columnHeaders[i];
                        }
                        worksheet.Row(4).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                        int row = 6;
                        var parentAccounts = package.Accounts.Where(a => a.ParentId == null && a.Type.Split(',').Contains("A")).ToList();
                        // Administración -> Tipo "A"
                        var lstParentLines = new List<BudgetLine>();

                        foreach (var parentAccount in parentAccounts)
                        {
                            var parentLinesToSum = db.BudgetLines.Include("MonthDetails").Where(bl =>
                                (bl.AccountId == parentAccount.Id || bl.Account.Code.Contains(parentAccount.Code.Substring(1)))
                                && bl.Sheet.Budget.FiscalYear == fiscalYear
                                && bl.Sheet.Budget.CompanyId == companyId
                                && bl.ParentId == null).ToList();

                            var parentLineMonthDetails = new List<BudgetMonthDetail>();

                            for (int i = 1; i <= 12; i++)
                            {
                                decimal targetSum = 0;
                                foreach (var line in parentLinesToSum)
                                {
                                    var monthDetail = line.MonthDetails.FirstOrDefault(md => md.Month == i);
                                    if (monthDetail != null)
                                    {
                                        targetSum += monthDetail.Target;
                                    }
                                }
                                parentLineMonthDetails.Add(new BudgetMonthDetail { Month = i, Target = targetSum });
                            }

                            var parentLine = new BudgetLine()
                            {
                                AccountId = parentAccount.Id,
                                Description = parentAccount.Display,
                                MonthDetails = parentLineMonthDetails
                            };
                            lstParentLines.Add(parentLine);

                            AddLineAOP(ref worksheet, row, parentLine, fiscalYear, companyId, package.Id, db, XLColor.YellowGreen, parentAccount.Name, "", "", "", parentAccount.Code, "", false, 0);

                            foreach (var childAccount in parentAccount.Children.ToList())
                            {
                                row++;

                                var childrenLinesToSum = db.BudgetLines.Include("MonthDetails").Where(bl =>
                                        (bl.AccountId == childAccount.Id || bl.Account.Code.Contains(childAccount.Code.Substring(1)))
                                        && bl.Sheet.Budget.FiscalYear == fiscalYear
                                        && bl.Sheet.Budget.CompanyId == companyId
                                        && bl.Tag == null).ToList();

                                var childLineMonthDetails = new List<BudgetMonthDetail>();

                                for (int i = 1; i <= 12; i++)
                                {
                                    decimal targetSum = 0;
                                    foreach (var line in childrenLinesToSum)
                                    {
                                        var monthDetail = line.MonthDetails.FirstOrDefault(md => md.Month == i);
                                        if (monthDetail != null)
                                        {
                                            targetSum += monthDetail.Target;
                                        }
                                    }
                                    childLineMonthDetails.Add(new BudgetMonthDetail { Month = i, Target = targetSum });
                                }

                                var childLine = new BudgetLine()
                                {
                                    AccountId = childAccount.Id,
                                    Description = childAccount.Display,
                                    MonthDetails = childLineMonthDetails
                                };

                                AddLineAOP(ref worksheet, row, childLine, fiscalYear, companyId, package.Id, db, XLColor.TangerineYellow, childAccount.Name, "", "", "", childAccount.Code, "", false, 0);

                                var startChildrenGroup = row;
                                var endChildrenGroup = row;

                                var subChildrenLines = db.BudgetLines.Include("MonthDetails").Include("Account").Include("Sheet.Budget.CostCenter").Where(bl =>
                                    (bl.AccountId == childAccount.Id || bl.Account.Code.Contains(childAccount.Code.Substring(1)))
                                    && bl.Sheet.Budget.FiscalYear == fiscalYear
                                    && bl.Sheet.Budget.CompanyId == companyId
                                    && bl.Tag != null).ToList();

                                if (subChildrenLines.Any())
                                {
                                    var startSubChildrenGroup = row + 1;
                                    var endSubChildrenGroup = row + 1;

                                    var AOPCalculationResult = db.GetAOPCalculation(fiscalYear, companyId, childAccount.Id);
                                    
                                    if (!string.IsNullOrEmpty(AOPCalculationResult))
                                    {
                                        var document = XDocument.Parse(AOPCalculationResult);
                                        var filas = document.Root.Descendants("Fila").ToList();
                                        foreach (var fila in filas)
                                        {
                                            row++;
                                            endChildrenGroup = row;
                                            endSubChildrenGroup = row;
                                            var costCenterCode = fila.Attribute("CECO").Value;
                                            var costCenterType = fila.Attribute("Type").Value;
                                            var employeeId = fila.Attribute("EmployeeId").Value;
                                            var employeeName = fila.Attribute("Description").Value;
                                            var employeePosition = (fila.Attribute("Position") != null) ? fila.Attribute("Position").Value : "";
                                            var employeeSalary = (fila.Attribute("Salary") != null) ? decimal.Parse(fila.Attribute("Salary").Value) : 0.0M;
                                            var accountCode = fila.Attribute("AccountCode").Value;

                                            var lstMonthDetails = new List<BudgetMonthDetail>()
                                            {
                                                new BudgetMonthDetail() { Month = 1, Target = decimal.Parse(fila.Attribute("January").Value) },
                                                new BudgetMonthDetail() { Month = 2, Target = decimal.Parse(fila.Attribute("February").Value) },
                                                new BudgetMonthDetail() { Month = 3, Target = decimal.Parse(fila.Attribute("March").Value) },
                                                new BudgetMonthDetail() { Month = 4, Target = decimal.Parse(fila.Attribute("April").Value) },
                                                new BudgetMonthDetail() { Month = 5, Target = decimal.Parse(fila.Attribute("May").Value) },
                                                new BudgetMonthDetail() { Month = 6, Target = decimal.Parse(fila.Attribute("June").Value) },
                                                new BudgetMonthDetail() { Month = 7, Target = decimal.Parse(fila.Attribute("July").Value) },
                                                new BudgetMonthDetail() { Month = 8, Target = decimal.Parse(fila.Attribute("August").Value) },
                                                new BudgetMonthDetail() { Month = 9, Target = decimal.Parse(fila.Attribute("September").Value) },
                                                new BudgetMonthDetail() { Month = 10, Target = decimal.Parse(fila.Attribute("October").Value) },
                                                new BudgetMonthDetail() { Month = 11, Target = decimal.Parse(fila.Attribute("November").Value) },
                                                new BudgetMonthDetail() { Month = 12, Target = decimal.Parse(fila.Attribute("December").Value) }
                                            };
                                            var subChildLine = new BudgetLine() { MonthDetails = lstMonthDetails };
                                            AddLineAOP(ref worksheet, row, subChildLine, fiscalYear, companyId, package.Id, db, XLColor.YellowProcess, employeeName, costCenterType, costCenterCode, employeeId, accountCode, employeePosition, false, employeeSalary, true);
                                        }
                                    }
                                    worksheet.Rows(startSubChildrenGroup, endSubChildrenGroup).Group();
                                }
                                worksheet.Rows(startChildrenGroup, endChildrenGroup).Group();
                            }
                            row++;
                        }
                        row = 5;
                        var totalLine = new BudgetLine() { Description = "TOTAL " + sheetName };
                        for (int i = 1; i <= 12; i++)
                        {
                            totalLine.MonthDetails.Add(new BudgetMonthDetail() { Target = 0, Month = i });
                        }

                        foreach (var line in lstParentLines)
                        {
                            foreach (var monthDetail in line.MonthDetails.ToList())
                            {
                                totalLine.MonthDetails.FirstOrDefault(m => m.Month == monthDetail.Month).Target += monthDetail.Target;
                            }
                        }

                        AddLineAOP(ref worksheet, row, totalLine, fiscalYear, companyId, package.Id, db, XLColor.YellowGreen,
                            totalLine.Description, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, true, 0);

                        worksheet.Outline.SummaryVLocation = XLOutlineSummaryVLocation.Top;
                        worksheet.CollapseRows();
                        var lastRow = worksheet.LastRowUsed().RowNumber();
                        var lastColumn = worksheet.LastColumnUsed().ColumnNumber();
                        worksheet.Columns(1, lastColumn).AdjustToContents();
                        worksheet.Range(4, 2, 4, lastColumn).Style.Fill.BackgroundColor = XLColor.BabyBlueEyes;

                        worksheet.Range(4, 2, lastRow, lastColumn).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                        worksheet.Range(4, 2, lastRow, lastColumn).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

                        if (defaultCurrencyId != toCurrencyId)
                        {
                            for (int i = 6; i <= lastRow; i++)
                            {
                                for (int j = 8; j <= lastColumn; j++)
                                {
                                    var value = worksheet.Cell(i, j).Value.ToString();

                                    if (!string.IsNullOrEmpty(value))
                                    {
                                        worksheet.Cell(i, j).Value = ExchangeRatesController.Convert(Convert.ToDecimal(value), er);
                                    }
                                }
                            }
                        }
                    }

                    MemoryStream ms = new MemoryStream();
                    workbook.SaveAs(ms);
                    var fileName = string.Format("AOP_{0} {1} ({2}).xlsx", fiscalYear, companyName, toCurrencyId);
                    return DownloadContent(ms, "application/vnd.ms-excel", fileName);
                }
            }
            catch (Exception ex)
            {
                ErrorLog.SaveError(ex);
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex);
            }
        }

        public async Task<HttpResponseMessage> GetConsolidatedBudget(int fiscal, int company, string toCurrencyId)
        {
            using (var db = new SpresContext())
            {
                try
                {
                    var country = db.Countries.Find(db.Companies.Find(company).Country);
                    var defaultCurrencyId = country.DefaultCurrencyId;
                    var er = ExchangeRatesController.GetLatestExchangeRate(defaultCurrencyId, toCurrencyId);
                    var result = await db.GetXMLConsolidatedBudget(fiscal, company);
                    XDocument xml = XDocument.Parse( (result != string.Empty) ? result : "<Filas></Filas>" );
                    var workbook = new XLWorkbook();
                    var currency = db.Currencies.Find(toCurrencyId);
                    var currencyName = (currency == null) ? "Moneda" : currency.Name;
                    var sheetName = string.Format("Consolidado", fiscal, currencyName);
                    var fileName = string.Format("{0} {1} ({2}).xlsx", sheetName, fiscal, toCurrencyId);
                    var worksheet = workbook.Worksheets.Add(sheetName);

                    var row = 1;
                    var col = 1;

                    var headers = new List<string> { "CECO", "Cuenta", "Match", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" };
                    foreach (var header in headers)
                    {
                        worksheet.Cell(row, col).Value = header;
                       
                            col++;
                        
                    }

                    row++;

                    //col = 4;

                    //for (int i = 0; i < 12; i++)
                    //{
                    //    worksheet.Cell(row, col).Value = "Meta";
                    //    col++;
                    //    worksheet.Cell(row, col).Value = "Forecast";
                    //    col++;
                    //    worksheet.Cell(row, col).Value = "Dif";
                    //    col++;
                    //}

                    //row++;

                    col = 1;
                    var filas = xml.Descendants("Filas").Descendants("Fila");
                    
                    if (filas.Any())
                    {
                        foreach (var fila in filas)
                        {
                            var values = fila.Descendants().ToList();
                            col = 1;
                            foreach (var value in values)
                            {
                                worksheet.Cell(row, col).Value = value.Value;
                                if (col > 3)
                                {
                                    worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
                                }
                                col++;
                            }
                            row++;
                        }
                    }

                    if (defaultCurrencyId != toCurrencyId)
                    {
                        var lastRow = worksheet.LastRowUsed().RowNumber();
                        var lastColumn = worksheet.LastColumnUsed().ColumnNumber();

                        for (int i = 2; i <= lastRow; i++)
                        {
                            for (int j = 4; j <= lastColumn; j++)
                            {
                                var val = worksheet.Cell(i, j).Value;
                                decimal value = Convert.ToDecimal(val);
                                if (value > 0)
                                {
                                    worksheet.Cell(i,j).Value = ExchangeRatesController.Convert(value, er);
                                }
                            }
                        }
                    }
                    MemoryStream ms = new MemoryStream();
                    workbook.SaveAs(ms);
                    return DownloadContent(ms, "application/vnd.ms-excel", fileName);
                }
                catch (Exception ex)
                {
                    ErrorLog.SaveError(ex);
                    throw;
                }
            }
        }

        public HttpResponseMessage GetReport(int fiscal, int company, int costCenter, string toCurrencyId, DateTime? historicalDate = null, int? reportType = null)
        {
            using (var db = new SpresContext())
            {
                var budget = db.Budgets.FirstOrDefault(b => b.FiscalYear.Equals(fiscal) && b.CompanyId.Equals(company) && b.CostCenterId.Equals(costCenter));

                if (budget != null)
                {
                    var cost = db.CostCenters.Find(costCenter);
                    var country = db.Countries.Find(cost.Company.Country);
                    var defaultCurrencyId = country.DefaultCurrencyId;
                    var er = ExchangeRatesController.GetLatestExchangeRate(defaultCurrencyId, toCurrencyId);
                    var workbook = new XLWorkbook();
                    var currency = db.Currencies.Find(toCurrencyId);
                    string forecast = (reportType >= 1 && reportType <= 3) ? "Forecast " + reportType.ToString() : string.Empty;

                    foreach (var sheet in budget.Sheets.OrderBy(bs => bs.PackageId).ToList())
                    {
                        var sheetName = GetSheetName(sheet.Package.Name);
                        
                        var worksheet = workbook.Worksheets.Add(sheetName);

                        for (int i = 1; i < 4; i++)
                        {
                            string value = string.Empty;
                            switch (i)
                            {
                                case 1: value = "PRESUPUESTO " + fiscal + " - " + forecast.ToUpper(); break;
                                case 2: value = "DIVISIÓN: " + budget.Company.Name.ToUpper(); break;
                                case 3: value = "CENTRO DE COSTO: " + budget.CostCenter.Name.ToUpper(); break;
                                default: break;
                            }
                            worksheet.Cell(i, 2).Value = value;
                            worksheet.Range(i, 2, i, 3).Merge();
                        }

                        var stackedHeaders = new List<string> { "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto",
                                                            "Septiembre", "Octubre", "Noviembre", "Diciembre" };

                        var columnHeaders = new List<string> { "Descripción" };
                        var strings = new List<string> { "Costo Unitario", "Cantidad", "Meta", "Forecast", "Real", "Dif Meta-Real", "Dif Meta-Real %", "Dif Meta-Forecast", "Dif Meta-Forecast %", "Dif Forecast-Real", "Dif Forecast-Real %" };
                        for (int i = 0; i < 12; i++) columnHeaders.AddRange(strings);
                        var strings2 = new List<string> { string.Empty, string.Empty, string.Empty, "Monto", "%", " ","Monto", "%" };
                        columnHeaders.AddRange(strings2);

                        int headerRow = 5;

                        for (int i = 0; i < stackedHeaders.Count; i++)
                        {
                            if (i == 0)
                            {
                                worksheet.Cell(headerRow, 3 * (i + 1)).Value = stackedHeaders[i];
                                worksheet.Range(headerRow, 3 * (i + 1), headerRow, 3 * (i + 1) + 10).Merge();
                            }
                            else
                            {
                                worksheet.Cell(headerRow, 11 * i + 3).Value = stackedHeaders[i];
                                worksheet.Range(headerRow, 11 * i + 3, headerRow, 11 * i + 13).Merge();
                            }
                        }
                        worksheet.Cell(headerRow, 136).Value = "Total Año";//88
                        worksheet.Cell(headerRow, 137).Value = "Forecast Anterior";//89
                        worksheet.Cell(headerRow, 138).Value = "Variación Total vs Forecast";//90
                        worksheet.Cell(headerRow, 140).Value = "Real Anterior";//92
                        worksheet.Cell(headerRow, 141).Value = "Variación Total vs Real";//93
                        worksheet.Range(headerRow, 138, headerRow, 139).Merge();//90 91
                        worksheet.Range(headerRow, 141, headerRow, 142).Merge();//93 94

                        headerRow = 6;
                        for (int i = 0; i < columnHeaders.Count; i++)
                            worksheet.Cell(headerRow, i + 2).Value = columnHeaders[i];

                        worksheet.Rows(5,6).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;

                        int row = 7;
                        foreach (var parentLine in sheet.Lines.Where(bl => bl.ParentId == null).ToList())
                        {
                            AddLine(ref worksheet, row, parentLine, fiscal, db, XLColor.YellowGreen, historicalDate, reportType);
                            foreach (var childrenLine in parentLine.Children.ToList())
                            {
                                row ++;
                                AddLine(ref worksheet, row, childrenLine, fiscal, db, XLColor.TangerineYellow, historicalDate, reportType);

                                var startChildrenGroup = row;
                                var endChildrenGroup = row;

                                if (childrenLine.Children.Any())
                                {
                                    var startSubChildrenGroup = row + 1;
                                    var endSubChildrenGroup = row + 1;

                                    foreach (var subChildrenLine in childrenLine.Children.ToList())
                                    {
                                        row++;
                                        endChildrenGroup = row;
                                        endSubChildrenGroup = row;
                                        AddLine(ref worksheet, row, subChildrenLine, fiscal, db, XLColor.YellowProcess, historicalDate, reportType);
                                    }
                                    worksheet.Rows(startSubChildrenGroup, endSubChildrenGroup).Group();
                                }
                                worksheet.Rows(startChildrenGroup, endChildrenGroup).Group();
                            }
                            row++;
                        }
                        worksheet.Outline.SummaryVLocation = XLOutlineSummaryVLocation.Top;
                        worksheet.CollapseRows();
                        worksheet.Columns(1, 142).AdjustToContents();
                        worksheet.Range(5, 2, 6, 142).Style.Fill.BackgroundColor = XLColor.BabyBlueEyes;

                        var lastRow = worksheet.LastRowUsed().RowNumber();
                        var lastColumn = worksheet.LastColumnUsed().ColumnNumber();

                        worksheet.Range(5, 2, lastRow, 142).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                        worksheet.Range(5, 2, lastRow, 142).Style.Border.InsideBorder = XLBorderStyleValues.Thin;

                        if (defaultCurrencyId != toCurrencyId)
                        {
                            for (int i = 7; i <= lastRow; i++)
                            {
                                for (int j = 3; j <= lastColumn; j++)
                                {
                                    var value = worksheet.Cell(i, j).Value.ToString();

                                    if (!string.IsNullOrEmpty(value))
                                    {
                                        worksheet.Cell(i, j).Value = ExchangeRatesController.Convert(Convert.ToDecimal(value), er);
                                    }
                                }
                            }
                        }
                    }
                    MemoryStream ms = new MemoryStream();
                    workbook.SaveAs(ms);
                    
                    var text = (historicalDate != null) ? string.Format("[{0}] ", historicalDate.Value.Date.ToString("yyyyMMdd")) : string.Empty;
                    
                    var fileName = string.Format("Reporte_{0}_{1}{2} {3}({4}).xlsx", budget.CostCenter.Code, fiscal, "_" + forecast, text, toCurrencyId);


                    if (historicalDate != null)
                    {
                        fileName = fileName.Replace("Reporte", "Historico");
                    }

                    return DownloadContent(ms, "application/vnd.ms-excel", fileName);
                }
                return new HttpResponseMessage(HttpStatusCode.InternalServerError);
            }
        }

        private string currencyFormat = "#,##0.0000";

        private void AddLineAOP(ref IXLWorksheet worksheet, int row, BudgetLine line, int fiscal, int companyId, int packageId, 
            SpresContext db, XLColor lineColor, string description, string costCenterType, string costCenterCode,  string employeeId,
            string accountCode, string position, bool isTotalLine, decimal salary = 0, bool IsSubChildLine = false)
        {
            int col = 2;
            
            worksheet.Cell(row, col).Value = costCenterType;
            col++;
            
            worksheet.Cell(row, col).Value = costCenterCode;
            col++;
            
            worksheet.Cell(row, col).Value = employeeId;
            col++;
            
            worksheet.Cell(row, col).Value = accountCode;
            col++;
            
            worksheet.Cell(row, col).Value = description;
            col++;
            
            worksheet.Cell(row, col).Value = position;
            col++;

            worksheet.Cell(row, col).Value = salary;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            decimal currentTarget = 0;
            var monthDetails = line.MonthDetails;

            foreach (var monthDetail in monthDetails)
            {
                worksheet.Cell(row, col).Value = monthDetail.Target;
                worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
                col++;
                
                currentTarget += monthDetail.Target;
            }
            worksheet.Cell(row, col).Value = currentTarget;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;
            col++;

            decimal previousTarget = 0;

            if (isTotalLine)
            {
                var linesPreviousYear = db.BudgetLines
                        .Where(bl =>
                            bl.Tag == null
                            && bl.ParentId == null
                            && bl.Sheet.PackageId == packageId
                            && bl.Sheet.Budget.FiscalYear == fiscal - 1
                            && bl.Sheet.Budget.CompanyId == companyId).ToList();

                foreach (var linePreviousYear in linesPreviousYear)
                {
                    previousTarget += linePreviousYear.MonthDetails.Sum(md => md.Target);
                }
            }
            else
            {
                //if (costCenterId > 0) // Lineas de presupuestación (detalle)
                //{
                //    var linePreviousYear = db.BudgetLines
                //        .FirstOrDefault(bl =>
                //            bl.Tag != null
                //            && bl.AccountId == line.AccountId
                //            && bl.Sheet.PackageId == packageId
                //            && bl.Sheet.Budget.CostCenterId == costCenterId
                //            && bl.Sheet.Budget.FiscalYear == fiscal - 1
                //            && bl.Sheet.Budget.CompanyId == companyId);

                //    if (linePreviousYear != null)
                //    {
                //        previousTarget = linePreviousYear.MonthDetails.Sum(md => md.Target);
                //    }
                //}

                if (!IsSubChildLine) //(costCenterId <= 0) // Lineas de cuentas contables (padres e hijos)
                {
                    var linesPreviousYear = db.BudgetLines
                        .Where(bl => 
                            bl.Tag == null
                            && bl.AccountId == line.AccountId
                            && bl.Sheet.PackageId == packageId
                            && bl.Sheet.Budget.FiscalYear == fiscal - 1
                            && bl.Sheet.Budget.CompanyId == companyId).ToList();

                    foreach (var linePreviousYear in linesPreviousYear)
                    {
                        previousTarget += linePreviousYear.MonthDetails.Sum(md => md.Target);
                    }
                }
            }
            // Meta Anterior
            worksheet.Cell(row, col).Value = previousTarget;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;
            // Diferencia (Monto)
            worksheet.Cell(row, col).Value = previousTarget - currentTarget;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;
            // Diferencia (Porcentaje)
            worksheet.Cell(row, col).Value = (previousTarget != 0) ? (previousTarget - currentTarget) / previousTarget : 0;
            worksheet.Cell(row, col).Style.NumberFormat.NumberFormatId = 10;

            worksheet.Range(row, 2, row, col).Style.Fill.BackgroundColor = lineColor;
        }

        private void AddLine(ref IXLWorksheet worksheet, int row, BudgetLine line, int fiscal, SpresContext db, XLColor lineColor, DateTime? historicalDate = null, int? reportType = null)
        {
            int col = 2;
            worksheet.Cell(row, col).Value = line.Description;
            
            col++;
            decimal Total = 0;
            decimal Forecast = 0;
            var monthDetails = line.MonthDetails;

            foreach (var monthDetail in monthDetails)
            {
                var targetMonthDetail = monthDetail;

                if (monthDetail.Histories.Any())
                {
                    if (historicalDate != null)
                    {
                        var history = monthDetail.Histories.Where(md => md.HistoricalDate.Date <= historicalDate.Value.Date).OrderByDescending(md => md.HistoricalDate).FirstOrDefault();

                        if (history != null)
                        {
                            targetMonthDetail = new BudgetMonthDetail()
                            {
                                UnitCost = history.UnitCost,
                                Quantity = history.Quantity,
                                Target = history.Target,
                                Forecast = history.Forecast,
                                Real = history.Real
                            };
                        }
                    }
                    else if (reportType != null)
                    {
                        var orderedHistories = monthDetail.Histories.OrderByDescending(md => md.HistoricalDate);
                        var forecast1 = orderedHistories.FirstOrDefault(h => h.Version == 1);
                        var forecast2 = orderedHistories.FirstOrDefault(h => h.Version == 2);
                        var forecast3 = orderedHistories.FirstOrDefault(h => h.Version == 3);

                        BudgetMonthHistory history = null;

                        switch (reportType)
                        {
                            case 1:
                                history = forecast1;
                                break;

                            case 2:
                                history = (forecast2 != null) ? forecast2 : forecast1;
                                break;

                            case 3:
                                history = (forecast3 != null) ? forecast3 : (forecast2 != null) ? forecast2 : forecast1;
                                break;

                            default:
                                break;
                        }
                        if (history != null)
                        {
                            targetMonthDetail = new BudgetMonthDetail()
                            {
                                UnitCost = history.UnitCost,
                                Quantity = history.Quantity,
                                Target = history.Target,
                                Forecast = history.Forecast,
                                Real = history.Real
                            };
                        }
                    }
                }

                worksheet.Cell(row, col).Value = targetMonthDetail.UnitCost;
                worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
                col++;
                worksheet.Cell(row, col).Value = targetMonthDetail.Quantity;
                worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
                col++;
                worksheet.Cell(row, col).Value = targetMonthDetail.Target;
                worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
                col++;
                worksheet.Cell(row, col).Value = targetMonthDetail.Forecast;
                worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
                col++;
                worksheet.Cell(row, col).Value = targetMonthDetail.Real;
                worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
                col++;
                var dif = monthDetail.Target - targetMonthDetail.Real;
                worksheet.Cell(row, col).Value = dif;
                worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
                col++;
                worksheet.Cell(row, col).Value = (targetMonthDetail.Target == 0) ? 0 : (dif / targetMonthDetail.Target);
                worksheet.Cell(row, col).Style.NumberFormat.NumberFormatId = 10;
                col++;

                var difMF = monthDetail.Target - targetMonthDetail.Forecast;
                worksheet.Cell(row, col).Value = difMF;
                worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
                col++;
                worksheet.Cell(row, col).Value = (targetMonthDetail.Target == 0) ? 0 : (difMF / targetMonthDetail.Target);
                worksheet.Cell(row, col).Style.NumberFormat.NumberFormatId = 10;
                col++;

                var difFR = monthDetail.Forecast - targetMonthDetail.Real;
                worksheet.Cell(row, col).Value = difFR;
                worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
                col++;
                worksheet.Cell(row, col).Value = (targetMonthDetail.Forecast == 0) ? 0 : (difFR / targetMonthDetail.Forecast);
                worksheet.Cell(row, col).Style.NumberFormat.NumberFormatId = 10;
                col++;

                Total += targetMonthDetail.Target;
                Forecast += targetMonthDetail.Forecast;
            }
            col++;
            worksheet.Cell(row, col).Value = Total;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;
            var linePreviousYear = db.BudgetLines
                .Where(bl => bl.AccountId == line.AccountId && bl.Sheet.Budget.FiscalYear == fiscal - 1)
                .FirstOrDefault();
            // Calculos Forecast Anterior y Real Anterior
            decimal previousForecast = 0;
            decimal previousReal = 0;
            if (linePreviousYear != null)
            {
                previousForecast = linePreviousYear.MonthDetails.Sum(md => md.Forecast);
                previousReal = linePreviousYear.MonthDetails.Sum(md => md.Real);
            }
            // Forecast Anterior
            worksheet.Cell(row, col).Value = previousForecast;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;
            // Variacion Forecast Monto
            worksheet.Cell(row, col).Value = Total - previousForecast;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;
            // Variacion Forecast Porcentaje
            worksheet.Cell(row, col).Value = (previousForecast == 0) ? 0 : Total / previousForecast;
            worksheet.Cell(row, col).Style.NumberFormat.NumberFormatId = 10;
            col++;
            // Real Anterior
            worksheet.Cell(row, col).Value = previousReal;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;
            // Variacion Real Anterior Monto
            worksheet.Cell(row, col).Value = Total - previousReal;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;
            // Variacion Forecast Porcentaje
            worksheet.Cell(row, col).Value = (previousReal == 0) ? 0 : Total / previousReal;
            worksheet.Cell(row, col).Style.NumberFormat.NumberFormatId = 10;
            col++;

            worksheet.Range(row, 2, row, 142).Style.Fill.BackgroundColor = lineColor;
        }

        private void AddLineSummary(ref IXLWorksheet worksheet, int row, Package line, int fiscal, int costCenter, int company, SpresContext db)
        {
            int col = 2;

            worksheet.Cell(row, col).Value = line.Name;
            col++;
            var budgtMnthDetail = db.BudgetMonthDetails.Where(bm => bm.Line.Sheet.PackageId == line.Id && bm.Line.Sheet.Budget.CompanyId == company && bm.Line.Sheet.Budget.FiscalYear == fiscal && bm.Line.Sheet.Budget.CostCenterId == costCenter && bm.Line.Account.ParentId == null).ToList();
            var LastBudMnthDetail = db.BudgetMonthDetails.Where(bm => bm.Line.Sheet.PackageId == line.Id && bm.Line.Sheet.Budget.CompanyId == company && bm.Line.Sheet.Budget.FiscalYear == fiscal - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenter && bm.Line.Account.ParentId == null).ToList();
            decimal currentTotal = 0;
            var total = budgtMnthDetail;
            
            if (total != null)
            {
                currentTotal = total.Sum(t => t.Target);
            }
            // Columna de separación
            col++;

            // Total
            worksheet.Cell(row, col).Value = currentTotal;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            decimal previousForecast = 0;
            
            // Calculos Forecast Anterior y Real Anterior
            var forecasts = LastBudMnthDetail;

            if (forecasts != null)
            {
                previousForecast = forecasts.Sum(bm => bm.Forecast);
            }


            decimal previousReal = 0;

            var real = LastBudMnthDetail;

            if (real != null)
            {
                previousReal = real.Sum(r => r.Real);
            }

            // Forecast Anterior
            worksheet.Cell(row, col).Value = previousForecast;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            // Variacion Forecast Monto
            worksheet.Cell(row, col).Value = currentTotal - previousForecast;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            // Variacion Forecast Porcentaje
            worksheet.Cell(row, col).Value = (previousForecast == 0) ? 0 : currentTotal / previousForecast;
            worksheet.Cell(row, col).Style.NumberFormat.NumberFormatId = 10;
            col++;

            // Real Anterior
            worksheet.Cell(row, col).Value = previousReal;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            // Variacion Real Anterior Monto
            worksheet.Cell(row, col).Value = currentTotal - previousReal;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            // Variacion Forecast Porcentaje
            worksheet.Cell(row, col).Value = (previousReal == 0) ? 0 : currentTotal / previousReal;
            worksheet.Cell(row, col).Style.NumberFormat.NumberFormatId = 10;
            col++;
        }

        private void AddLineSummaryAccounts(ref IXLWorksheet worksheet, int row, Account line, int fiscal, int costCenter, int company, SpresContext db)
        {
           
            int col = 2;
            worksheet.Cell(row, col).Value = line.Display;
            col++;

           
            var budgtMnthDetail = db.BudgetMonthDetails.Where(bm => bm.Line.Account.Id == line.Id && bm.Line.Sheet.Budget.CompanyId == company && bm.Line.Sheet.Budget.FiscalYear == fiscal && bm.Line.Sheet.Budget.CostCenterId == costCenter).ToList();
            var LastBudMnthDetail = db.BudgetMonthDetails.Where(bm => bm.Line.Account.Id == line.Id && bm.Line.Sheet.Budget.CompanyId == company && bm.Line.Sheet.Budget.FiscalYear == fiscal - 1 && bm.Line.Sheet.Budget.CostCenterId == costCenter).ToList();
            decimal currentTotalChildren = budgtMnthDetail.Sum(t => t.Target);

            // Columna de separación
            col++;

            // Total
            worksheet.Cell(row, col).Value = currentTotalChildren;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            decimal previousForecastChildren = LastBudMnthDetail.Sum(bm => bm.Forecast);

            decimal previousRealChildren = 0;

            var realChildren = LastBudMnthDetail;

            if (realChildren != null)
            {
                previousRealChildren = realChildren.Sum(r => r.Real);
            }

            // Forecast Anterior
            worksheet.Cell(row, col).Value = previousForecastChildren;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            // Variacion Forecast Monto
            worksheet.Cell(row, col).Value = currentTotalChildren - previousForecastChildren;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            // Variacion Forecast Porcentaje
            worksheet.Cell(row, col).Value = (previousForecastChildren == 0) ? 0 : currentTotalChildren / previousForecastChildren;
            worksheet.Cell(row, col).Style.NumberFormat.NumberFormatId = 10;
            col++;

            // Real Anterior
            worksheet.Cell(row, col).Value = previousRealChildren;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            // Variacion Real Anterior Monto
            worksheet.Cell(row, col).Value = currentTotalChildren - previousRealChildren;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            // Variacion Forecast Porcentaje
            worksheet.Cell(row, col).Value = (previousRealChildren == 0) ? 0 : currentTotalChildren / previousRealChildren;
            worksheet.Cell(row, col).Style.NumberFormat.NumberFormatId = 10;
            col++;
        }
        
        private void AddLineSummarySubAccounts(ref IXLWorksheet worksheet, int row, Account subAccount, int fiscal, int costCenter, int company, SpresContext db)
        {

            int col = 2;
            worksheet.Cell(row, col).Value = subAccount.Display;
            col++;

            var budgtMnthDetail = db.BudgetMonthDetails.Where(bm =>
                bm.Line.Account.Id == subAccount.Id 
                && bm.Line.Sheet.Budget.CompanyId == company 
                && bm.Line.Sheet.Budget.FiscalYear == fiscal 
                && bm.Line.Sheet.Budget.CostCenterId == costCenter
                && bm.Line.Tag == null
                ).ToList();


            var LastBudMnthDetail = db.BudgetMonthDetails.Where(bm => 
                bm.Line.Account.Id == subAccount.Id 
                && bm.Line.Sheet.Budget.CompanyId == company 
                && bm.Line.Sheet.Budget.FiscalYear == fiscal - 1
                && bm.Line.Tag == null
                && bm.Line.Sheet.Budget.CostCenterId == costCenter).ToList();

            decimal currentTotalChildren = budgtMnthDetail.Sum(t => t.Target);

            // Columna de separación
            col++;

            // Total
            worksheet.Cell(row, col).Value = currentTotalChildren;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            decimal previousForecastChildren = LastBudMnthDetail.Sum(bm => bm.Forecast);
            // Calculos Forecast Anterior y Real Anterior

            decimal previousRealChildren = 0;

            var realChildren = LastBudMnthDetail;

            if (realChildren != null)
            {
                previousRealChildren = realChildren.Sum(r => r.Real);
            }

            // Forecast Anterior
            worksheet.Cell(row, col).Value = previousForecastChildren;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            // Variacion Forecast Monto
            worksheet.Cell(row, col).Value = currentTotalChildren - previousForecastChildren;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            // Variacion Forecast Porcentaje
            worksheet.Cell(row, col).Value = (previousForecastChildren == 0) ? 0 : currentTotalChildren / previousForecastChildren;
            worksheet.Cell(row, col).Style.NumberFormat.NumberFormatId = 10;
            col++;

            // Real Anterior
            worksheet.Cell(row, col).Value = previousRealChildren;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            // Variacion Real Anterior Monto
            worksheet.Cell(row, col).Value = currentTotalChildren - previousRealChildren;
            worksheet.Cell(row, col).Style.NumberFormat.Format = currencyFormat;
            col++;

            // Variacion Forecast Porcentaje
            worksheet.Cell(row, col).Value = (previousRealChildren == 0) ? 0 : currentTotalChildren / previousRealChildren;
            worksheet.Cell(row, col).Style.NumberFormat.NumberFormatId = 10;
            col++;
        }

        [Route("api/Export/Summary/{fiscal}/{company}/{costCenter}/{toCurrencyId}")]
        public HttpResponseMessage GetSummary(int fiscal, int company, int costCenter, string toCurrencyId) {
            using (var db = new SpresContext())
            {
                var packages = db.BudgetMonthDetails
                    .FirstOrDefault(b => b.Line.Sheet.Budget.FiscalYear == fiscal && b.Line.Sheet.Budget.CompanyId == company && b.Line.Sheet.Budget.CostCenterId == costCenter);

                if (packages != null)
                {
                    var companyObj = db.Companies.Find(company);
                    var companyName = (companyObj != null) ? companyObj.Name : string.Empty;
                    var cost = db.CostCenters.Find(costCenter);
                    var country = db.Countries.Find(cost.Company.Country);
                    var defaultCurrencyId = country.DefaultCurrencyId;

                    var er = ExchangeRatesController.GetLatestExchangeRate(defaultCurrencyId, toCurrencyId);

                    var currency = db.Currencies.Find("USD");
                    var currencyName = (currency == null) ? "Moneda" : currency.Name;

                    var workbook = new XLWorkbook();
                    var sheetName = "Resumen";
                    var fileName = string.Format("{0} {1}_{2} ({3}).xlsx", sheetName, cost.Code, fiscal, toCurrencyId);
                    var worksheet = workbook.Worksheets.Add(sheetName);

                    for (int i = 1; i < 4; i++)
                    {
                        string value = string.Empty;
                        switch (i)
                        {
                            case 1: value = "PRESUPUESTO " + fiscal; break;
                            case 2: value = "DIVISIÓN: " + packages.Line.Sheet.Budget.Company.Name.ToUpper(); break;
                            case 3: value = "CENTRO DE COSTO: " + packages.Line.Sheet.Budget.CostCenter.Name.ToUpper(); break;
                            default: break;
                        }
                        worksheet.Cell(i, 2).Value = value;
                        worksheet.Range(i, 2, i, 3).Merge();
                    }
                    var columnHeaders = new List<string> { "Descripción" };
                    var strings2 = new List<string> { string.Empty, string.Empty, string.Empty, "Monto", "%", string.Empty, "Monto", "%" };
                    columnHeaders.AddRange(strings2);
                    int headerRow = 5;

                    worksheet.Cell(headerRow, 4).Value = "Total Año";
                    worksheet.Cell(headerRow, 5).Value = "Forecast Anterior";
                    worksheet.Cell(headerRow, 6).Value = "Variación Total vs Forecast";
                    worksheet.Cell(headerRow, 8).Value = "Real Anterior";
                    worksheet.Cell(headerRow, 9).Value = "Variación Total vs Real";

                    worksheet.Range(headerRow, 6, headerRow, 7).Merge();
                    worksheet.Range(headerRow, 9, headerRow, 10).Merge();

                    headerRow = 6;
                    for (int i = 0; i < columnHeaders.Count; i++)
                    {
                        worksheet.Cell(headerRow, i + 2).Value = columnHeaders[i];
                    }

                    worksheet.Rows(5, 6).Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;

                    int row = 7;
                    var costCenterType = db.CostCenters.Where(cc => cc.Id == costCenter).Select(c => c.Type).FirstOrDefault();
                    foreach (var parentLine in db.Packages.ToList())
                    {
                            
                        AddLineSummary(ref worksheet, row, parentLine, fiscal, costCenter, company, db);
                        
                        if (parentLine.Accounts.Any())
                        {
                            List<Account> lstParents = new List<Account>();
                            switch (costCenterType)
                            {
                                case "A":
                                    lstParents = parentLine.Accounts.Where(ac => ac.Parent == null && ac.Type.Equals("M,A")).ToList();
                                    break;
                                case "M":
                                    lstParents = parentLine.Accounts.Where(ac => ac.Parent == null && ac.Type.Equals("M,A")).ToList();
                                    break;
                                case "P":
                                    lstParents = parentLine.Accounts.Where(ac => ac.Parent == null && ac.Type.Equals("P")).ToList();
                                    break;
                                default:
                                    lstParents = parentLine.Accounts.Where(ac => ac.Parent == null && ac.Type.Equals(costCenterType)).ToList();
                                    break;
                            }

                            foreach (var childrenLine in lstParents)
                            {
                                row++;
                                AddLineSummaryAccounts(ref worksheet, row, childrenLine, fiscal, costCenter, company, db);

                                var startChildrenGroup = row;
                                var endChildrenGroup = row;
                                if (childrenLine.Children.Any())
                                {
                                    var startSubchildrenGroup = row + 1;
                                    var endSubChildrenGroup = row + 1;

                                    foreach (var subchildren in childrenLine.Children.ToList())
                                    {
                                        row++;
                                        endChildrenGroup = row;
                                        endSubChildrenGroup = row;
                                        AddLineSummarySubAccounts(ref worksheet, row, subchildren, fiscal, costCenter, company, db);
                                    }
                                    worksheet.Rows(startSubchildrenGroup, endSubChildrenGroup).Group();
                                }
                                worksheet.Rows(startChildrenGroup, endChildrenGroup).Group();
                            }
                        }
                        row++;
                    }
                    worksheet.Outline.SummaryVLocation = XLOutlineSummaryVLocation.Top;
                    worksheet.CollapseRows();
                    worksheet.Columns(1, 10).AdjustToContents();
                    worksheet.Rows(8, 9).Group(2, true);
                    worksheet.Columns(1, 94).AdjustToContents();

                    if (defaultCurrencyId != toCurrencyId)
                    {
                        for (int i = 7; i <= worksheet.LastRowUsed().RowNumber(); i++)
                        {
                            for (int j = 4; j <= worksheet.LastColumnUsed().ColumnNumber(); j++)
                            {
                                var value = worksheet.Cell(i, j).Value.ToString();

                                if (!string.IsNullOrEmpty(value))
                                {
                                    worksheet.Cell(i, j).Value = ExchangeRatesController.Convert(Convert.ToDecimal(value), er);
                                }
                            }
                        }
                    }

                    MemoryStream ms = new MemoryStream();
                    workbook.SaveAs(ms);
                    return DownloadContent(ms, "application/vnd.ms-excel", fileName);
                }
                return new HttpResponseMessage(HttpStatusCode.InternalServerError);
            }
        }


        private HttpResponseMessage DownloadContent(MemoryStream ms, string contentType, string fileName)
        {
            ms.Position = 0;
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            response.Content = new StreamContent(ms);
            response.Content.Headers.ContentType = new MediaTypeHeaderValue(contentType);
            response.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment") { FileName = fileName };
            return response;
        }
    }
}
