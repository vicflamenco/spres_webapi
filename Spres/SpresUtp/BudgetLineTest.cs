using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Spres.Infrastructure;
using Spres.Models;
using System.Collections.Generic;
using System.Linq;
using SpresDev.Models;
using System.Data.Entity;

namespace SpresUtp
{
    [TestClass]
    public class BudgetLineTest
    {
        [TestMethod]
        public void TestMethod1()
        {
            var budgetLineId = 1;
            var costCenterId = 1;

            using (var db = new SpresContext())
            {
                BudgetLine line = db.BudgetLines.Find(budgetLineId);
                Premise premise = line.Premise;
                BudgetSheet sheet = db.BudgetSheets.Find(line.SheetId);
                var sourceType = ""; //(premise != null) ? premise.LineSource : BudgetSourceType.None;

                switch (sourceType)
                {
                    case "Employees":

                        List<Employee> employees = db.Employees.Where(e => e.CostCenterId == costCenterId).ToList();

                        foreach (Employee employee in employees)
                        {
                            List<BudgetMonthDetail> monthDetails = new List<BudgetMonthDetail>();
                            for (int i = 1; i <= 12; i++)
                                monthDetails.Add(new BudgetMonthDetail
                                {
                                    Forecast = 0,
                                    Month = i,
                                    Quantity = 0,
                                    Real = 0,
                                    Target = 0,
                                    UnitCost = 0
                                });

                            BudgetLine childrenLine = new BudgetLine
                            {
                                Description = string.Format("{0} ({1})", employee.Name, employee.Position.Name),
                                ParentId = line.Id,
                                SheetId = line.SheetId,
                                PremiseId = line.PremiseId,
                                AccountId = line.AccountId,
                                MonthDetails = monthDetails
                            };
                            line.Children.Add(childrenLine);
                        }
                        db.SaveChanges();
                        break;

                    default:
                        
                        break;
                }
            }



        }

        [TestMethod]
        public void TestMethod2()
        {
            BudgetLineViewModel lineViewModel = new BudgetLineViewModel
            {
                Id = 3,
                January_Forecast = 111,
                January_Real = 111,
                January_Target = 111,
                January_UnitCost = 111,
                January_Quantity = 111,

                February_Forecast = 222,
                February_Quantity = 222,
                February_Real = 222,
                February_Target = 222,
                February_UnitCost = 222,

                March_Forecast = 333,
                March_Quantity = 333,
                March_Real = 333,
                March_Target = 333,
                March_UnitCost = 333,
                
                April_Forecast = 444,
                April_Quantity = 444,
                April_Real = 444,
                April_Target = 444,
                April_UnitCost = 444,
                
                May_Forecast = 555,
                May_Quantity = 555,
                May_Real = 555,
                May_Target = 555,
                May_UnitCost = 555,
                
                June_Forecast = 666,
                June_Quantity = 666,
                June_Real = 666,
                June_Target = 666,
                June_UnitCost = 666,
                
                July_Forecast = 777,
                July_Quantity = 777,
                July_Real = 777,
                July_Target = 777,
                July_UnitCost = 777,
                
                August_Forecast = 888,
                August_Quantity = 888,
                August_Real = 888,
                August_Target = 888,
                August_UnitCost = 888,

                September_Forecast = 999,
                September_Quantity = 999,
                September_Real = 999,
                September_Target = 999,
                September_UnitCost = 999,

                October_Forecast = 1010,
                October_Quantity = 1010,
                October_Real = 1010,
                October_Target = 1010,
                October_UnitCost = 1010,

                November_Forecast = 1111,
                November_Quantity = 1111,
                November_Real = 1111,
                November_Target = 1111,
                November_UnitCost = 1111,

                December_Forecast = 1212,
                December_Quantity = 1212,
                December_Real = 1212,
                December_Target = 1212,
                December_UnitCost = 1212
            };
            
            
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
                
                try
                {
                    db.SaveChanges();
                    //return Ok();
                }
                catch (Exception)
                {
                    //return InternalServerError(ex);
                }

            }
        }


    }
}
