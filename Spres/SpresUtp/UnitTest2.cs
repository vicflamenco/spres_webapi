using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Spres.Infrastructure;
using System.Text;
using System.Collections.Generic;
using System.Xml.Linq;
using System.Xml;
using System.Linq;


namespace SpresUtp
{
    [TestClass]
    public class UnitTest2
    {
        [TestMethod]
        public static string Test()
        {
            int id = 1;

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
                    foreach (var element in elements)
                    {

                    }

                    content.Append("<div id='obj'>");

                    content.Append("<ul id='tabsList'>");

                    content.Append("<li>");
                    content.Append("<a href='#id'>");

                    content.Append("</a>");
                    content.Append("</li>");

                    content.Append("</ul>");


                    content.Append("<div id='id'>");


                    content.Append("</div>");

                    content.Append("</div>");
                }




                return content.ToString();
            }
        }

        [TestMethod]
        public static string RenderExpenseDetail(List<XElement> elements, List<XElement> expenseElements, int monthNumber)
        {
            using (var dbContext = new SpresContext())
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
                    string value = string.Empty;
                    string name = element.Attribute("Name").Value;
                    string display = element.Attribute("Display").Value;
                    string quantifiable = element.Attribute("Quantifiable").Value;

                    var currentValue = expenseElements.FirstOrDefault(e => e.Attribute("Name").Value.Equals(name));
                    if (currentValue != null)
                    {
                        value = currentValue.Value;
                    }

                    if (quantifiable.ToBoolean())
                    {
                        content.Append("<tr>");
                        content.Append(string.Format("<td>{0}</td>", display));
                        content.Append(string.Format("<td>${0}</td>", value));
                        content.Append("<td>");
                        content.Append(CreateNumericTextBox(name + monthNumber, "0"));
                        content.Append("</td>");
                        content.Append("</tr>");
                    }
                }

                content.Append("</tbody>");
                content.Append("</table>");
                content.Append("</div>");
                return content.ToString();
            }
        }

        [TestMethod]
        private static string CreateNumericTextBox(string name, string value)
        {
            return "<input id=\"" + name + "\" name=\"" + name +
                             "\" type='text' data-bind='ejNumericTextbox: {width:\"100%\",showSpinButton: false,value:" +
                             value + "}' />";

        }

    }
}
