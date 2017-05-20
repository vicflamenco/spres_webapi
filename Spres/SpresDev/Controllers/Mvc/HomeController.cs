using System.Web.Mvc;
using Spres.Infrastructure;
using Spres.Infrastructure.Security;
using System.Net.Mail;

namespace SpresDev.Controllers.Mvc
{
    public class HomeController : Controller
    {
        // GET: Home        
        public ActionResult Index()
        {
            return View();
        }

        [ChildActionOnly]
        public PartialViewResult _Budget()
        {
            return PartialView();
        }

        public PartialViewResult _Summary()
        {
            return PartialView();
        }
        public PartialViewResult _IncreasesRequest()
        {
            return PartialView();
        }
        public ActionResult Summary()
        {
            return View();
        }

        public ActionResult _AddPackage()
        {
            return PartialView();
        }

        public ActionResult _DeleteLine()
        {
            return PartialView();
        }

        public ActionResult _AuthorizeBudget()
        {
            return PartialView();
        }

        public ActionResult _GenerateLinesConfirmation()
        {
            return PartialView();
        }

        public ActionResult _ChangePasswordSuccess()
        {
            return PartialView();
        }
        public ActionResult _EditPremiseLine()
        {
            return PartialView();
        }

        public ActionResult _ExportHistoricalReport()
        {
            return PartialView();
        }

        public ActionResult _EnableBudgetChanges()
        {
            return PartialView();
        }

        public ActionResult _RequestAuthorization()
        {
            return PartialView();
        }

        public ActionResult _InformationDialog()
        {
            return PartialView();
        }

        public ActionResult AccountAdjustment()
        {
            return PartialView();
        }

        public ActionResult BudgetingLineAdjustment()
        {
            return PartialView();
        }
        public ActionResult SavingsTransfer()
        {
            return PartialView();
        }

        public ActionResult IncreasesModifications()
        {
            return PartialView();
        }

        public ActionResult Login()
        {
            return View();
        }

        public ActionResult Logout()
        {
            return View("Login");
        }

        public ActionResult PasswordChange()
        {
            return View();
        }

        public ActionResult Resumen()
        {
            return View();
        }

        public ActionResult Unauthorized()
        {
            return View();
        }

        public ActionResult _ImportFile()
        {
            return PartialView();
        }
        
    }
}