using Newtonsoft.Json.Linq;
using Spres.Infrastructure;
using Spres.Infrastructure.Audit;
using Spres.Infrastructure.ErrorLog;
using Spres.Models;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Http;
using System.Xml.Linq;
namespace SpresDev.Controllers.Api
{
    public class PremisesController : ApiController
    {

        public class MyObj
        {
            public int MonthId { get; set; }
            public JToken Data { get; set; }
        }

        [SpresSecurityAttribute("Configuration", true, false)]
        public IHttpActionResult Get(int company, int type, int year)
        {
            using (var model = new SpresContext())
            {
                var data = model.Premises
                   .Where(p => p.CompanyId == company && p.PremiseTypeId == type && p.FiscalYear == year)
                   .ToList()
                   .Select(p => new Premise
                   {
                       Id = p.Id,
                       Name = p.Name,
                       CompanyId = company,
                       PremiseTypeId = type,
                       FiscalYear = year,
                       Expenses = p.Expenses
                   }).OrderByDescending(p=> p.Id).
                   ToList();

                return Ok(data.ToDataResult());
            }
        }

        [SpresSecurityAttribute("Configuration", true, false)]
        public IHttpActionResult Get(int id)
        {
            using (var model = new SpresContext())
            {
                var premise = model.Premises.Find(id);
                if (premise != null)
                    return Ok(premise.Expenses);
                else
                    return NotFound();
            }
        }

        [SpresSecurityAttribute("Configuration", false, true)]
        public IHttpActionResult Post(Premise premise)
        {
            using (var db = new SpresContext())
            {
                
                var programming = db.Programmings.Find(premise.FiscalYear, premise.CompanyId);

                if (programming == null)
                {
                    return NotFound();
                }
                else
                {
                    premise.Expenses = PremiseDefinition(premise.PremiseTypeId, db);
                    var company = db.Companies.Find(premise.CompanyId);
                    var type = db.PremiseTypes.Find(premise.PremiseTypeId);
                    db.Premises.Add(premise);
                    db.SaveChanges();
                    this.RegisterEvent("Se creó la premisa " + premise.Name + " de tipo " + type.Name + " para el periodo " + premise.FiscalYear + " en la región " + company.Name);
                    return Ok(premise.Name);
                }
            }
        }

        [Route("api/Premises/Copy/{fiscalYear}/{companyId}/{premiseTypeId}")]
        [SpresSecurityAttribute("Configuration", false, true)]
        public IHttpActionResult PostCopyPremises(int fiscalYear, int companyId, int premiseTypeId)
        {
            using (var db = new SpresContext())
            {
                var premType = db.PremiseTypes.Find(premiseTypeId);
                var company = db.Companies.Find(companyId);
                var previousPremises = db.Premises.Where(p => p.CompanyId.Equals(companyId) 
                                                    && p.FiscalYear.Equals(fiscalYear - 1)
                                                    && p.PremiseTypeId.Equals(premiseTypeId)).ToList();

                if (previousPremises.Any())
                {

                    var currentPremises = db.Premises.Where(p => p.CompanyId.Equals(companyId)
                                                    && p.FiscalYear.Equals(fiscalYear)
                                                    && p.PremiseTypeId.Equals(premiseTypeId)).ToList();

                    if (currentPremises.Any())
                    {
                        db.Premises.RemoveRange(currentPremises);
                    }

                    foreach (var previousPremise in previousPremises)
                    {
                        db.Premises.Add(new Premise
                        {
                            CompanyId = companyId,
                            Expenses = previousPremise.Expenses,
                            FiscalYear = fiscalYear,
                            Name = previousPremise.Name,
                            PremiseTypeId = premiseTypeId
                        });
                    }
                    db.SaveChanges();
                    this.RegisterEvent("Se copió la premisa de tipo " + premType.Name + " del periodo " + (fiscalYear - 1) + " al periodo actual " + " en la región " + company.Name );
                    return Ok(true);
                }
                else
                {
                    return Ok(false);
                }
                
            }
        }

        private static string PremiseDefinition(int type, SpresContext db)
        {
            string definition = db.PremiseTypes.Find(type).Definition;
            bool hasConstraint = false;
            var document = XDocument.Parse(definition);
            StringBuilder expenses = new StringBuilder();

            var constraintAttribute = document.Element("Definition").Attribute("Constraint");
            if (constraintAttribute != null)
            {
                hasConstraint = constraintAttribute.Value.ToBoolean();
            }

            expenses.Append("<Premise>")
                    .Append("<Expense>")
                    .Append("<Variables>");

            document.Descendants("Definition")
                    .Descendants("Variables")
                    .Elements().ToList()
                    .ForEach(element => expenses.Append("<Variable Name=\"" + element.Attribute("Name").Value + "\"></Variable>"));
            expenses.Append("</Variables>");

            if (hasConstraint)
            {
                expenses.Append("<Constraints>")
                        .Append("<Constraint Type=\"Frecuency\" Periodicity=\"\">")
                        .Append("</Constraint>")
                        .Append("</Constraints>");

            }
            expenses.Append("</Expense>")
                    .Append("</Premise>");
            return expenses.ToString();
        }

        [SpresSecurityAttribute("Configuration", false, true)]
        public IHttpActionResult Put(Premise premise)
        {
            using (var db = new SpresContext())
            {
                var type = db.PremiseTypes.Find(premise.PremiseTypeId);
                var company = db.Companies.Find(premise.CompanyId);
                db.Entry(premise).State = EntityState.Modified;
                db.SaveChanges();
                this.RegisterEvent("Se modificó la premisa " + premise.Name + " de tipo " + type.Name + " del periodo " + premise.FiscalYear + " en la región " + company.Name);
                return Ok(premise.Id);
            }
        }

        [SpresSecurityAttribute("Configuration", false, true)]
        public IHttpActionResult Delete(int id)
        {
            using (var db = new SpresContext())
            {
                var premise = db.Premises.Find(id);
                var type = db.PremiseTypes.Find(premise.PremiseTypeId);
                var company = db.Companies.Find(premise.CompanyId);
                if(db.BudgetLines.Any(bl => bl.PremiseId == id))
                {
                    return BadRequest("No se puede eliminar debido a que existen líneas de presupuestación asociadas a esta premisa");
                }

                db.Premises.Remove(premise);
                db.SaveChanges();
                this.RegisterEvent("Se eliminó la premisa " + premise.Name + " de tipo " + type.Name + " del periodo " + premise.FiscalYear + " en la región " + company.Name);
                return Ok();
            }
        }

        [SpresSecurityAttribute("Configuration", false, true)]
        [Route("api/Rendering/{id}/{comp}")]
        public HttpResponseMessage Rendering(int id, int comp)
        {

            var response = new HttpResponseMessage
            {
                Content = new StringContent(Spres.Utilities.Forms.Form.Render(id,comp))
            };
            response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
            return response;
        }

        [SpresSecurityAttribute("Budgeting", false, true)]
        [Route("api/RenderPremiseLineEditor/{id}")]
        public HttpResponseMessage GetRenderPremiseLineEditor(int id)
        {
            var response = new HttpResponseMessage
            {
                Content = new StringContent(Spres.Utilities.Forms.Form.RenderPremiseLineEditor(id))
            };
            response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
            return response;
        }

        
        [Route("api/RenderDetail/{id}/{year}/{costCenter}/{company}")]
        public HttpResponseMessage GetRenderDetail(int id, int year, int costCenter, int company)
        {
            var response = new HttpResponseMessage
            {
                Content = new StringContent(Spres.Utilities.Forms.Form.RenderDetail(id,year,costCenter,company))
            };
            response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
            return response;
        }

        [SpresSecurityAttribute("Budgeting", false, true)]
        [Route("api/UpdateExpenseDetail/{line}")]
        public IHttpActionResult PostUpdateExpenseDetail([FromBody]List<MyObj> obj, int line)
        {

            try
            {
                using (var dbContext = new SpresContext())
                {

                    var budgetLine = dbContext.BudgetLines.Find(line);
                    var parentLine = dbContext.BudgetLines.Find(budgetLine.ParentId);
                    var premise = dbContext.Premises.Find(budgetLine.PremiseId);

                    var company = dbContext.Companies.Find(premise.CompanyId);
                    var type = dbContext.PremiseTypes.Find(premise.PremiseTypeId);

                    string expense = premise.Expenses;
                    var documentExpense = XDocument.Parse(expense);
                    var expenseElements = documentExpense.Descendants("Premise").Descendants("Expense").Descendants("Variables").Elements().ToList();

                    foreach (var objItem in obj)
                    {
                        int month = objItem.MonthId;
                        var jToken = objItem.Data;

                        var values = jToken.Select(j => new { Name = j["name"].ToString(), Value = j["value"].ToString() }).ToList();
                        var monthDetail = dbContext.BudgetMonthDetails.FirstOrDefault(md => md.LineId.Equals(line) && md.Month.Equals(month));

                        decimal target = 0;

                        bool onlyConstraint = values.Any(v => v.Name.Split('_').Count() == 2);

                        if (onlyConstraint)
                        {
                            decimal cost = 0;
                            int quantity = 0;

                            decimal.TryParse(values[0].Value, out cost);
                            int.TryParse(values[1].Value, out quantity);

                            monthDetail.UnitCost = cost;
                            monthDetail.Quantity = quantity;
                            monthDetail.Target = quantity * cost;
                            monthDetail.ExpenseDetail = null;
                        }
                        else
                        {

                            foreach (var item in values)
                            {
                                var itemName = item.Name;
                                itemName = Regex.Replace(itemName, @"[\d-]", string.Empty);
                                var element = expenseElements.FirstOrDefault(e => e.Attribute("Name").Value == itemName);
                                if (element != null)
                                {
                                    int value = 0;
                                    if (int.TryParse(item.Value, out value))
                                    {
                                        decimal cost = 0;
                                        if (decimal.TryParse(element.Value, out cost))
                                        {
                                            target += value * cost;
                                        }
                                    }
                                }
                            }


                            if (monthDetail != null)
                            {
                                var expenseDetail = monthDetail.ExpenseDetail;
                                if (!string.IsNullOrEmpty(expenseDetail))
                                {
                                    var document = XDocument.Parse(expenseDetail);
                                    var quantities = document.Descendants("ExpenseDetail").Descendants("Quantities").Elements().ToList();

                                    foreach (var item in values.Where(v => !v.Name.Equals("Month")))
                                    {
                                        var itemName = item.Name;
                                        itemName = Regex.Replace(itemName, @"[\d-]", string.Empty);

                                        var element = quantities.FirstOrDefault(e => e.Attribute("Name").Value.Equals(itemName));
                                        if (element != null)
                                        {
                                            element.SetValue(item.Value);
                                        }
                                    }

                                    monthDetail.ExpenseDetail = document.ToString();
                                    monthDetail.Target = target;
                                }
                                else
                                {
                                    StringBuilder content = new StringBuilder();
                                    content.Append("<ExpenseDetail id=\"" + monthDetail.Id + "\">");
                                    content.Append("<Quantities>");

                                    foreach (var item in values.Where(v => !v.Name.Equals("Month")))
                                    {

                                        var itemName = item.Name;
                                        itemName = Regex.Replace(itemName, @"[\d-]", string.Empty);
                                        content.Append(string.Format("<Variable Name=\"{0}\">{1}</Variable>", itemName, item.Value));
                                    }
                                    content.Append("</Quantities>")
                                           .Append("</ExpenseDetail>");

                                    monthDetail.ExpenseDetail = content.ToString();
                                    monthDetail.Target = target;
                                }
                                
                            }
                        }
                        dbContext.Entry(monthDetail).State = EntityState.Modified;
                    }
                    var controller = new BudgetLinesController();
                    controller.RecalculateLineValues(parentLine.Id, dbContext, parentLine.ParentId.Value);
                    dbContext.SaveChanges();
                    this.RegisterEvent("Se modificó la línea por premisa " + premise.Name + " en la cuenta " + budgetLine.Account.Display + " para el periodo " + premise.FiscalYear + " y paquete " + budgetLine.Sheet.Package.Name + " en el centro de costo " + budgetLine.Sheet.Budget.CostCenter.Display + " de la región " + company.Name);
                    return Ok(1);
                }
            }
            catch (System.Exception ex)
            {
                ErrorLog.SaveError(ex);
                return InternalServerError(ex);
            }
            
        }

        [SpresSecurityAttribute("Configuration", false, true)]
        [Route("api/UpdateExpense/{premiseId}")]
        public IHttpActionResult PostUpdateExpense([FromBody]JToken jToken, int premiseId)
        {
            var values = jToken.Select(j => new { Name = j["name"].ToString(), Value = j["value"].ToString() }).ToList();

            using (var dbContext = new SpresContext())
            {
                var premise = dbContext.Premises.Find(premiseId);
                var company = dbContext.Companies.Find(premise.CompanyId);
                var type = dbContext.PremiseTypes.Find(premise.PremiseTypeId);

                string expenses = premise.Expenses;
                var document = XDocument.Parse(expenses);
                var expenseElements = document.Descendants("Premise").Descendants("Expense");
                var variablesElements = expenseElements.Descendants("Variables").Elements().ToList();
                var constraintsElements = expenseElements.Descendants("Constraints").Elements().ToList();

                foreach (var item in values.Where(v => !v.Name.Equals("PeriodicityType") && !v.Name.Equals("Month")))
                {
                    var element = variablesElements.FirstOrDefault(e => e.Attribute("Name").Value.Equals(item.Name));
                    if (element != null)
                    {
                        element.SetValue(item.Value);
                    }
                }

                if (constraintsElements.Any())
                {
                    var periodicityElement = constraintsElements.FirstOrDefault();
                    if (periodicityElement != null)
                    {
                        periodicityElement.Attribute("Periodicity").Value = values.FirstOrDefault(v=> v.Name.Equals("PeriodicityType")).Value;
                        var monthElements = periodicityElement.Elements();
                        var newMonths = values.Where(v => v.Name.Equals("Month"));
                        periodicityElement.Elements().Remove();
                        newMonths.ToList().ForEach(val => periodicityElement.Add(new XElement("Month", val.Value)));
                    }
                }
                premise.Expenses = document.ToString();
                this.RegisterEvent("Se configuró la premisa " + premise.Name + " de tipo " + type.Name + " para el periodo " + premise.FiscalYear + " en la región " + company.Name);
                return Ok(dbContext.SaveChanges());
            }
        }
    }
}
