using System;
namespace Spres.Models
{

    public class BudgetMonthHistory
    {
        public BudgetMonthHistory()
        {
            this.Version = 0;
            this.Reason = 0;
        }
        public int BudgetMonthDetailId { get; set; }

        public virtual BudgetMonthDetail BudgetMonthDetail { get; set; }
        public DateTime HistoricalDate { get; set; }        

        public int Month { get; set; }
        public int Quantity { get; set; }
        public decimal UnitCost { get; set; }
        public decimal Target { get; set; }
        public decimal Forecast { get; set; }
        //XML
        public string ExpenseDetail { get; set; }
        public decimal Real { get; set; }

        public int Version { get; set; }
        public BudgetMonthHistoryReasons Reason { get; set; }
        public BudgetStatus BudgetStatus { get; set; }
    }
}

