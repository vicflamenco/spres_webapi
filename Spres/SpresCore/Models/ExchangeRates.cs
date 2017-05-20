using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Models
{
    public class ExchangeRate
    {
        public int Id { get; set; }
        public string CurrencyId { get; set; }
        public virtual Currency Currency { get; set; }
        public DateTime TradeDate { get; set; }
        public decimal Rate { get; set; }
    }
}
