using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SpresDev.Controllers.Mvc
{
    public class SecurityController : Controller
    {
        // GET: Security
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Roles()
        {
            return View();
        }

        public ActionResult Users()
        {
            return View();
        }

        public ActionResult Options()
        {
            return View();
        }

        public ActionResult CompanyAuthorizers()
        {
            return View();
        }

        public ActionResult Events()
        {
            return View();
        }

    }
}