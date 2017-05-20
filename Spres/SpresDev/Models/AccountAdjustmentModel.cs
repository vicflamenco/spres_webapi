using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SpresDev.Models
{
    public class AccountAdjustmentModel
    {
        public int SourceLineId { get; set; }
        public int SourceMonthNumber { get; set; }
        public int DestinationLineId { get; set; }
        public int DestinationMonthNumber { get; set; }
        public decimal Adjustment { get; set; }
    }
}