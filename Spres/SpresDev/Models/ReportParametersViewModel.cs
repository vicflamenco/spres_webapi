using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SpresDev.Models
{
    public class ReportParametersViewModel
    {        
        public string ReportPath { get; set; }
        public int FiscalYear { get; set; }
        public int? Package { get; set; }
        public IEnumerable<int> CostCenters { get; set; }
        public IEnumerable<int> Accounts { get; set; }
        public bool IncludeLineDetails { get; set; }
        public bool CollapseGroupedData{get;set;}
        public bool HideNonBudgeted { get; set; }
    }

}