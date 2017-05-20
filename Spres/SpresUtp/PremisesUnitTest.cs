using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SpresDev.Controllers.Api;
using Spres.Infrastructure;
namespace SpresUtp
{
    [TestClass]
    public class PremisesUnitTest
    {
        [TestMethod]
        public void RenderingTest()
        {
            PremisesController controller = new PremisesController();
            //controller.Rendering(1, 1);
            using (var dbContext = new SpresContext())
            {

            }
        }
    }
}

