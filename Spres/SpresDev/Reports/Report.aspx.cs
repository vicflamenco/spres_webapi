using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using SpresDev.Models;

namespace SpresDev.Views.Reporting
{
    public partial class Report : System.Web.UI.Page
    {
        protected readonly Uri reportserverurl = new Uri(ConfigurationManager.AppSettings["ReportServerUrl"]);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["ReportParameters"] != null)
            {
                var parameters = (ReportParametersViewModel)Session["ReportParameters"];
                
                Viewer.ServerReport.ReportServerUrl = reportserverurl;
                Viewer.ServerReport.ReportPath = parameters.ReportPath;

                if (parameters.Package.HasValue)
                {
                    Viewer.ServerReport.SetParameters(new ReportParameter[] {
                        new ReportParameter("FiscalYear", parameters.FiscalYear.ToString()),
                        new ReportParameter("Package", parameters.Package.ToString()),
                        new ReportParameter("CostCenters", (parameters.CostCenters == null) ? null : string.Join(",", parameters.CostCenters)),
                        new ReportParameter("Accounts", (parameters.Accounts == null) ? null : string.Join(",", parameters.Accounts)),
                        new ReportParameter("IncludeLineDetails", parameters.IncludeLineDetails.ToString()),
                        new ReportParameter("CollapseGroupedData",parameters.CollapseGroupedData.ToString()),
                        new ReportParameter("HideNonBudgeted",parameters.HideNonBudgeted.ToString())
                    });
                }
                else
                {
                    Viewer.ServerReport.SetParameters(new ReportParameter[] {
                        new ReportParameter("FiscalYear", parameters.FiscalYear.ToString()),                        
                        new ReportParameter("CostCenters", (parameters.CostCenters == null) ? null : string.Join(",", parameters.CostCenters)),
                        new ReportParameter("Accounts", (parameters.Accounts == null) ? null : string.Join(",", parameters.Accounts)),
                        new ReportParameter("IncludeLineDetails", parameters.IncludeLineDetails.ToString()),
                        new ReportParameter("CollapseGroupedData",parameters.CollapseGroupedData.ToString()),
                        new ReportParameter("HideNonBudgeted",parameters.HideNonBudgeted.ToString())
                    });
                }
                Viewer.ServerReport.Refresh();
            }            
        }
    }
}