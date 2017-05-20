using System.Web.Mvc;

namespace SpresDev.Controllers.Mvc
{
    public class ReportingController : Controller
    {        

        public ActionResult _Container()
        {
            return PartialView();
        }

        public ActionResult FilteredCostCenterView()
        {
            return View();
        }

        public ActionResult FilteredAccountView()
        {
            return View();
        }
    }
}