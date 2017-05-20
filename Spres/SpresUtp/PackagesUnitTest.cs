using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SpresDev.Controllers.Api;
using Spres.Infrastructure;
using System.Net.Http;
namespace SpresUtp
{
    [TestClass]
    public class PackagesUnitTest
    {
        [TestMethod]
        public void PackagesTest()
        {
            PackagesController controller = new PackagesController();
            var result = controller.GetPackageById(1) as HttpResponseMessage;            
        }
    }
}

