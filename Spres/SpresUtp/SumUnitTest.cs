using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Linq;
namespace SpresUtp
{
    [TestClass]
    public class SumUnitTest
    {
        [TestMethod]
        public void TestSumPackage()
        {
            using (var dbContext = new Spres.Infrastructure.SpresContext())
            {
                var sumPackage = dbContext.BudgetMonthDetails.Where(bm => bm.Line.Sheet.PackageId == 11).Sum(bm => (decimal?)bm.Forecast) ?? 0;

                var sumParentAccount = dbContext.BudgetMonthDetails.Where(bm => bm.Line.AccountId == 1).Sum(bm => (decimal?)bm.Forecast) ?? 0;
                
                Console.WriteLine("Suma= " + sumPackage);
            }
        }
    }
}
