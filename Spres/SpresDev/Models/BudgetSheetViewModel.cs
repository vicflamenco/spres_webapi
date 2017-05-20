using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SpresDev.Models
{
    public class BudgetSheetViewModel
    {
        public List<BudgetLineViewModel> ParentLines { get; set; }
        public List<BudgetLineViewModel> ChildrenLines { get; set; }
        public List<BudgetLineViewModel> SubChildrenLines { get; set; }
    }
}