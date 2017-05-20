using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Spres.Infrastructure.Security;
using System.Linq;

namespace SpresUtp
{
    [TestClass]
    public class SecurityUnitTest
    {
        [TestMethod]
        public void GetUsersTest()
        {
            var users = SecurityManager.GetUsers();
            Console.Write(users.Count());
        }
    }
}
