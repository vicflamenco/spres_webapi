using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using Spres.Infrastructure;

namespace Spres.Utilities.Forms
{
    public class Data
    {
        public string value { get; set; }
        public string text { get; set; }
    }

    public class Form
    {
        public static Data GetMonth(string month)
        {
            switch (month)
            {
                case "Jan": return new Data { value = "1", text = "Enero" };
                case "Feb": return new Data { value = "2", text = "Febrero" };
                case "Mar": return new Data { value = "3", text = "Marzo" };
                case "Apr": return new Data { value = "4", text = "Abril" };
                case "May": return new Data { value = "5", text = "Mayo" };
                case "Jun": return new Data { value = "6", text = "Junio" };
                case "Jul": return new Data { value = "7", text = "Julio" };
                case "Aug": return new Data { value = "8", text = "Agosto" };
                case "Sep": return new Data { value = "9", text = "Septiembre" };
                case "Oct": return new Data { value = "10", text = "Octubre" };
                case "Nov": return new Data { value = "11", text = "Noviembre" };
                case "Dec": return new Data { value = "12", text = "Diciembre" };
                default: return new Data { value = "", text = "" };
            }
        }

        public static int GetMonthValue(string month)
        {
            switch (month)
            {
                case "Jan": return 1;
                case "Feb": return 2;
                case "Mar": return 3;
                case "Apr": return 4;
                case "May": return 5;
                case "Jun": return 6;
                case "Jul": return 7;
                case "Aug": return 8;
                case "Sep": return 9;
                case "Oct": return 10;
                case "Nov": return 11;
                case "Dec": return 12;
                default: return 0;
            }
        }

        public static string RenderPremiseLineEditor(int id)
        {
            using (var db = new SpresContext())
            {
                var line = db.BudgetLines.Find(id);
                var premise = db.Premises.Find(line.PremiseId);
                string expenses = premise.Expenses;
                var expense = XDocument.Parse(expenses);
                string definition = db.PremiseTypes.Find(premise.PremiseTypeId).Definition;
                var document = XDocument.Parse(definition);
                var elements = document.Descendants("Definition").Descendants("Variables").Elements().ToList();
                var expenseElements = expense.Descendants("Premise").Descendants("Expense").Descendants("Variables").Elements().ToList();
                StringBuilder content = new StringBuilder();
                if (elements.Any())
                {
                    var hasConstraint = false;
                    var hasOnlyConstraint = false;
                    var constraintAttribute = document.Element("Definition").Attribute("Constraint");
                    var onlyConstraintAttribute = document.Element("Definition").Attribute("OnlyConstraint");
                    if (constraintAttribute != null)
                    {
                        hasConstraint = constraintAttribute.Value.ToBoolean();
                        hasOnlyConstraint = onlyConstraintAttribute.Value.ToBoolean();
                    }
                    var months = new List<XElement>();
                    string[] monthsList = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };

                    if (hasConstraint)
                    {
                        var lst = expense.Descendants("Premise").Descendants("Expense").Descendants("Constraints").FirstOrDefault().Descendants("Month").ToList();
                        if (lst.Any())
                        {
                            months = lst;
                        }
                        else
                        {
                            foreach (string item in monthsList)
                            {
                                months.Add(new XElement("Month", item));
                            }
                        }
                    }
                    else
                    {
                        foreach (string item in monthsList) months.Add(new XElement("Month", item));
                    }
                    content.Append("<div id='obj'>");
                    content.Append("<ul id='tabsList'>");
                    foreach (var month in months)
                    {
                        content.Append("<li>");
                        content.Append("<a href='#DynamicMonth" + GetMonthValue(month.Value) + "'>");
                        content.Append(month.Value);
                        content.Append("</a>");
                        content.Append("</li>");
                    }
                    content.Append("</ul>");
                    foreach (var month in months)
                    {
                        content.Append(RenderExpenseDetail(elements, expenseElements, GetMonthValue(month.Value), id, db, hasOnlyConstraint));
                    }
                    content.Append("</div>");
                }
                return content.ToString();
            }
        }

        public static string RenderExpenseDetail(List<XElement> elements, List<XElement> expenseElements, int monthNumber, int lineId, SpresContext db, bool hasOnlyConstraint)
        {
            StringBuilder content = new StringBuilder();

            content.Append("<div class='dynamicForm form-horizontal' id=\"DynamicMonth" + monthNumber + "\">");
            content.Append("<table width='100%'>");
            content.Append("<thead>");
            content.Append("<tr>");
            content.Append("<th>Variable</th>").Append("<th>Costo</th>").Append("<th>Cantidad</th>");
            content.Append("</tr>");
            content.Append("</thead>");
            content.Append("<tbody>");
            foreach (var element in elements)
            {
                string name = element.Attribute("Name").Value;
                string display = element.Attribute("Display").Value;
                string quantifiable = element.Attribute("Quantifiable").Value;

                if (quantifiable.ToBoolean())
                {
                    var monthValue = db.BudgetMonthDetails.Where(md => md.LineId.Equals(lineId) && md.Month.Equals(monthNumber)).FirstOrDefault();
                    content.Append("<tr>");
                    content.Append(string.Format("<td>{0}</td>", display));

                    if (hasOnlyConstraint)
                    {
                        content.Append("<td>");
                        if (monthValue != null)
                        {
                            content.Append(CreateCurrencyTextBox(name + monthNumber + "_Cost", monthValue.UnitCost.ToString()));
                        }
                        else
                        {
                            content.Append(CreateCurrencyTextBox(name + monthNumber + "_Cost", "0"));
                        }
                        content.Append("</td>");
                    }
                    else
                    {
                        var currentValue = expenseElements.FirstOrDefault(e => e.Attribute("Name").Value.Equals(name));
                        if (currentValue != null)
                        {
                            content.Append(string.Format("<td>${0}</td>", currentValue.Value));
                        }
                    }

                    content.Append("<td>");

                    if (hasOnlyConstraint)
                    {
                        if (monthValue != null)
                        {
                            content.Append(CreateNumericTextBox(name + monthNumber, monthValue.Quantity.ToString()));
                        }
                        else
                        {
                            content.Append(CreateNumericTextBox(name + monthNumber, "0"));
                        }
                    }
                    else
                    {
                        if (monthValue != null && monthValue.ExpenseDetail != null)
                        {
                            var doc = XDocument.Parse(monthValue.ExpenseDetail);
                            var variables = doc.Descendants("ExpenseDetail").Descendants("Quantities").Descendants("Variable").ToList();
                            var variable = variables.Where(v => v.Attribute("Name").Value.Equals(name)).FirstOrDefault();
                            content.Append(CreateNumericTextBox(name + monthNumber, variable.Value));
                        }
                        else
                        {
                            content.Append(CreateNumericTextBox(name + monthNumber, "0"));
                        }
                    }
                    content.Append("</td>");
                    content.Append("</tr>");
                }
            }
            content.Append("</tbody>");
            content.Append("</table>");
            content.Append("</div>");
            return content.ToString();
        }

        public static string RenderDetail(int parentLineId, int year, int costCenter, int company)
        {
            using (var dbContext = new SpresContext())
            {
                StringBuilder content = new StringBuilder();
                var parentLine = dbContext.BudgetLines.Find(parentLineId);
                int accountId = parentLine.AccountId;
                var accountBudgetSource = dbContext.AccountBudgetSources.FirstOrDefault(a => a.AccountId.Equals(accountId));
                int premiseType = accountBudgetSource.PremiseTypeId.Value;
                string source = accountBudgetSource.Source;

                content.Append("<div class='dynamicForm form-horizontal' id=\"DynamicFormDetail" + parentLineId + "\">");

                if (source != null)
                {
                    content.Append("<div>");
                    content.Append(string.Format("<label style='display:inline-block; width:150px;'>{0}</label>", "Origen"));
                    content.Append("<div style='display:inline-block;width:300px;'>");

                    string querySource = string.Empty;

                    switch (source)
                    {
                        case "Employees":
                            querySource = string.Format("SELECT CAST(Id AS VARCHAR) AS value, Name AS text FROM {0} WHERE Active=1 AND CostCenterId={1}", source, costCenter);
                            break;
                        case "Equipments":
                            querySource = string.Format("SELECT CAST(Id AS VARCHAR) AS value, Name AS text FROM {0}", source);
                            break;
                        default:
                            break;
                    }

                    var dataSource = dbContext.Database.SqlQuery<Data>(querySource).ToList();
                    content.Append(CreateDropDownList("Source", "Origen", dataSource, "", false, "", "100%", false));
                    content.Append("</div>").Append("</div>");
                }

                content.Append("<div>");
                content.Append(string.Format("<label style='display:inline-block; width:150px;'>{0}</label>", "Premisa"));
                content.Append("<div style='display:inline-block; width:300px;'>");

                string queryPremise = string.Format("SELECT CAST(Id AS VARCHAR) AS value, Name AS text FROM {0} WHERE FiscalYear={1} AND CompanyId={2} AND PremiseTypeId={3}",
                    "Premises", year, company, premiseType);
                var dataPremise = dbContext.Database.SqlQuery<Data>(queryPremise).ToList();
                content.Append(CreateDropDownList("PremiseList", "Premisa", dataPremise, "", false, /*"change:onChangePremise,"*/"", "100%", false));
                content.Append("</div>").Append("</div>");

                content.Append("</div>");
                return content.ToString();
            }
        }

        //TODO: Revisar si puedo mejorar el codigo y refactorizar
        public static string Render(int premiseId, int company)
        {
            using (var dbContext = new SpresContext())
            {

                var premiseEntity = dbContext.Premises.Find(premiseId);
                int premiseType = premiseEntity.PremiseTypeId;
                var content = new StringBuilder();
                bool hasConstraint = false;
                bool hasOnlyConstraint = false;
                string expenses = premiseEntity.Expenses;
                var expense = XDocument.Parse(expenses);
                string definition = dbContext.PremiseTypes.Find(premiseType).Definition;
                var document = XDocument.Parse(definition);

                content.Append("<div class='dynamicForm form-horizontal' id=\"DynamicForm" + premiseId + "\">");

                var elements = document.Descendants("Definition").Descendants("Variables").Elements().ToList();

                var constraintAttribute = document.Element("Definition").Attribute("Constraint");
                var onlyConstraintAttribute = document.Element("Definition").Attribute("OnlyConstraint");

                if (constraintAttribute != null)
                {
                    hasConstraint = constraintAttribute.Value.ToBoolean();
                }

                if (onlyConstraintAttribute != null)
                {
                    hasOnlyConstraint = onlyConstraintAttribute.Value.ToBoolean();
                }

                var expenseElements = expense.Descendants("Premise").Descendants("Expense").Descendants("Variables").Elements().ToList();
                var constraintsElements = expense.Descendants("Premise").Descendants("Expense").Descendants("Constraints").Elements().ToList();

                string periodicity = string.Empty;
                string monthsValues = string.Empty;

                if (constraintsElements.Any())
                {
                    periodicity = constraintsElements.FirstOrDefault().Attribute("Periodicity").Value;
                    var months = constraintsElements.FirstOrDefault().Elements().ToList();
                    if (months.Any())
                    {
                        foreach (var item in months)
                        {
                            if (!string.IsNullOrEmpty(item.Value))
                            {
                                monthsValues += item.Value + ",";
                            }
                        }
                    }
                }

                if (!hasOnlyConstraint && elements.Any())
                {
                    content.Append("<h5>");
                    content.Append("<strong>");

                    content.Append("VARIABLES DE PREMISA");

                    content.Append("</h5>");
                    content.Append("</strong>");

                    content.Append("<hr />");

                    foreach (var element in elements)
                    {
                        string value = string.Empty;
                        DataType dataType;
                        string name = element.Attribute("Name").Value;
                        string display = element.Attribute("Display").Value;
                        string type = element.Attribute("Type").Value;
                        var currentValue = expenseElements.FirstOrDefault(e => e.Attribute("Name").Value.Equals(name));
                        if (currentValue != null)
                        {
                            value = currentValue.Value;
                        }

                        if (Enum.TryParse(type, out dataType))
                        {
                            content.Append("<div>");
                            content.Append(string.Format("<div style='display:inline-block; width:150px; vertical-align: 10px; margin-right:20px; text-align:right;'>{0}:</div>", display));
                            content.Append("<div style='display:inline-block; width:350px;'>");

                            switch (dataType)
                            {
                                case DataType.Option:
                                    string source = string.Empty;
                                    if (element.Attribute("Source") != null)
                                    {
                                        source = element.Attribute("Source").Value;
                                    }

                                    if (!string.IsNullOrEmpty(source))
                                    {
                                        if (source == "Employees")
                                        {
                                            string query = string.Format("SELECT CAST(e.Id AS VARCHAR) AS value, e.Name AS text FROM {0} e Inner Join CostCenters c on e.CostCenterId = c.Id inner join Companies co on c.CompanyId = co.Id where e.Active=1 and co.id={1}", source, company);
                                            var dataQuery = dbContext.Database.SqlQuery<Data>(query).OrderBy(e => e.text).ToList();
                                            content.Append(CreateDropDownList(name, display, dataQuery, value, false, "", "350px", true));
                                        }
                                        else
                                        {
                                            string query = string.Format("SELECT CAST(Id AS VARCHAR) AS value, Name AS text FROM {0}", source);
                                            var dataQuery = dbContext.Database.SqlQuery<Data>(query).OrderBy(e => e.text).ToList();
                                            content.Append(CreateDropDownList(name, display, dataQuery, value, false, "", "350px", true));
                                        }
                                    }
                                    break;
                                case DataType.Money:
                                    value = !string.IsNullOrEmpty(value) ? value : "0";
                                    content.Append(CreateCurrencyTextBox(name, value));
                                    break;
                                case DataType.Quantity:
                                    value = !string.IsNullOrEmpty(value) ? value : "0";
                                    content.Append(CreateNumericTextBox(name, value));
                                    break;
                                case DataType.Text:
                                    content.Append(CreateTextBox(name, value));
                                    break;
                                case DataType.Any:
                                    break;
                            }
                            content.Append("</div>").Append("</div>");
                        }
                    }
                }

                if (hasConstraint)
                {
                    content.Append(CreateHtmlConstraint(periodicity, monthsValues));
                }
                content.Append("</div>");
                return content.ToString();
            }
        }

        private static string CreateHtmlConstraint(string periodicity, string monthValues)
        {
            var content = new StringBuilder();
            var periodicitis = new List<Data> {
                new Data { value="Annual",   text="Anual" },
                new Data { value="Monthly",  text="Mensual"} ,
                new Data { value="Bimonthly",text="Bimensual" },
                new Data { value="Quaterly", text="Trimestral" },
                new Data { value="Biannual", text="Semestral" } };


            var months = new List<Data> {
                new Data { value="Jan", text="Enero" },
                new Data { value="Feb", text="Febrero"} ,
                new Data { value="Mar", text="Marzo" },
                new Data { value="Apr", text="Abril" },
                new Data { value="May", text="Mayo" } ,
                new Data { value="Jun", text="Junio" },
                new Data { value="Jul", text="Julio"} ,
                new Data { value="Aug", text="Agosto" },
                new Data { value="Sep", text="Septiembre" },
                new Data { value="Oct", text="Octubre" },
                new Data { value="Nov", text="Noviembre"},
                new Data { value="Dec", text="Diciembre"}};

            content.Append("<br />");
            content.Append("<h5>");
            content.Append("<strong>");

            content.Append("PERIODICIDAD");

            content.Append("</h5>");
            content.Append("</strong>");

            content.Append("<hr />");

            content.Append("<div>");
            content.Append(string.Format("<div style='display:inline-block; width:150px; vertical-align: 10px; margin-right:20px; text-align:right;'>{0}</div>", "Frecuencia"));
            content.Append("<div>");

            content.Append(CreateDropDownList("PeriodicityType", "frecuencia", periodicitis, periodicity, false, "change: onChangePeriodicity,", "350px", true));
            content.Append("</div>").Append("</div>");

            content.Append("<div>");
            content.Append(string.Format("<div style='display:inline-block; width:150px; vertical-align: 10px; margin-right:20px; text-align:right;'>{0}</div>", "Meses"));
            content.Append("<div>");
            content.Append(CreateDropDownList("Month", "meses", months, monthValues, true, "checkChange: onCheckChangeMonth,", "350px", true));
            content.Append("</div>").Append("</div>");

            return content.ToString();
        }

        private static string CreateTextBox(string name, string value)
        {
            return "<input id=\"" + name + "\" name=\"" + name + "\"   value=\"" +
                             value + "\" type=\"text\" class='form-control'>";

        }

        private static string CreateNumericTextBox(string name, string value)
        {
            return "<input id=\"" + name + "\" name=\"" + name +
                             "\" type='text' data-bind='ejNumericTextbox: {width:\"100%\", showSpinButton: false, value:" +
                             value + "}' />";

        }

        private static string CreateCurrencyTextBox(string name, string value)
        {
            return "<input id=\"" + name + "\"  name=\"" + name +
                             "\"type='text' data-bind='ejCurrencyTextbox: { value:" + value +
                             ",showSpinButton: false,decimalPlaces: 2,width:\"100%\" }' />";

        }

        private static string CreateDropDownList(string name, string display, List<Data> dataQuery, string value, bool multiple, string functions, string width, bool inlineBlock)
        {
            string option = multiple ? "showCheckbox: true," : "";

            string input = "<input id=\"" + name + "\" name=\"" + name +
                             "\" data-bind='ejDropDownList:{[functions][multiple]width:\"" + width + "\",watermarkText:\"Seleccione " +
                             display.ToLower() + "\",dataSource:" + Newtonsoft.Json.JsonConvert.SerializeObject(dataQuery) +
                             ",value:\"" + value + "\"}' " + ((inlineBlock) ? "style='display:inline-block;'" : "") + "/>";

            input = input.Replace("[multiple]", option).Replace("[functions]", functions);

            return input;
        }


    }
}
