using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Models
{
    public class Country
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string DefaultCurrencyId { get; set; }
        public virtual Currency DefaultCurrency { get; set; }
    }
}
