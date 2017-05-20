using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using SpresDev.Models;
using System.Web;

namespace SpresDev.Controllers.Api
{
    public class AnalysisController : ApiController
    {
        public IHttpActionResult PostReportParameters(ReportParametersViewModel parameters)
        {            
            HttpContext.Current.Session["ReportParameters"] = parameters;
            return Ok();
        }

        public IHttpActionResult DeleteReportParameters()
        {
            HttpContext.Current.Session["ReportParameters"] = null;
            return Ok();
        }
    }
}
