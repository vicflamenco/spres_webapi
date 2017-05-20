using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Models
{
    public class AccountBudgetSource
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Source { get; set; }
        public string Formule { get; set; }


        public int? PremiseTypeId { get; set; }
        public virtual PremiseType PremiseType { get; set; }


        public int AccountId { get; set; }
        public virtual Account Account {get; set; }


        public BudgetExpenseType ExpenseType { get; set; }
        
    }
}
