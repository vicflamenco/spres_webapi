using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Models
{
    public class ForecastProgramming
    {
        public int FiscalYear { get; set; }
        public int CompanyId { get; set; }
        public virtual Programming Programming { get; set; }
        public int Item { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
    }
}
