using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Models
{
    public class BudgetAuthorization
    {  
        public int Id { get; set; }
        
        public int BudgetId { get; set; }

        public virtual Budget Budget { get; set; }

        public string AuthorizerGUID { get; set; }

        public DateTime RequestDate { get; set; }
        public AuthorizationStatus Status { get; set; }
    }
}
