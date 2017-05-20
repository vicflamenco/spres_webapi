using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SpresDev.Models
{
    public class SummaryListViewModel
    {
        public List<SummaryViewModel> ParentLines { get; set; }
        public List<SummaryViewModel> ChildrenLines { get; set; }
        public List<SummaryViewModel> SubChildrenLines { get; set; }
    }
}