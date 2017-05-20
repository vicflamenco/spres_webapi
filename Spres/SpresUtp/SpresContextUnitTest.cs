using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Spres.Infrastructure;
using System.Linq;
using System.Threading.Tasks;

namespace SpresUtp
{
    [TestClass]
    public class SpresContextUnitTest
    {
        [TestMethod]
        public void PeriodsBudgetCalculationTest()
        {
            using (var db = new SpresContext())
            {
                
                    var result = db.PeriodsBudgetCalculation(8, 1);
                    //Console.WriteLine(result.ElementAt(0).Cost);
                
                               
                
            }
        }
    }
}
