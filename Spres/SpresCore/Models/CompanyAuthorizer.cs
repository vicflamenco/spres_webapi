using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Models
{
    public class CompanyAuthorizer
    {
        public int CompanyId { get; set; }        
        public virtual Company Company { get; set; }
        public string AuthorizerGUID { get; set; }
    }
}
