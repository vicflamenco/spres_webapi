using System.Web.Mvc;

namespace SpresDev.Controllers.Mvc
{
    public class ConfigurationController : Controller
    {
        // GET: Configuration
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Packages()
        {
            return View();
        }

        public ActionResult Programmings()
        {
            return View();
        }

        public ActionResult CostCenters()
        {
            return View();
        }

        public ActionResult Accounts()
        {
            return View();
        }

        public ActionResult Positions()
        {
            return View();
        }

        public ActionResult Employees()
        {
            return View();
        }

        public ActionResult Premises()
        {
            return View();
        }

        public ActionResult Benefits()
        {
            return View();
        }

        public ActionResult Equipments()
        {
            return View();
        }

        public ActionResult Providers()
        {
            return View();
        }

        public ActionResult ExchangeRates()
        {
            return View();
        }

        public ActionResult _ExpenseDetail(int parentLineId, int company, int year, int cost)
        {
            ViewBag.ParentLineId = parentLineId;
            ViewBag.CompanyId = company;
            ViewBag.Year = year;
            ViewBag.CostCenter = cost;
            return PartialView();
        }
    }
}