using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;

namespace Spres.Mapping
{
  public  class BudgetMonthHistoryMap : EntityTypeConfiguration<BudgetMonthHistory>
    {
      public BudgetMonthHistoryMap()
      {
          HasKey(bm => new { bm.BudgetMonthDetailId, bm.HistoricalDate });
          Property(bm => bm.ExpenseDetail).HasColumnType("xml");
          Property(bm => bm.Forecast).HasColumnType("money");
          Property(bm => bm.Real).HasColumnType("money");
          Property(bm => bm.Target).HasColumnType("money");
          Property(bm => bm.UnitCost).HasColumnType("money");
      }
    }
}
