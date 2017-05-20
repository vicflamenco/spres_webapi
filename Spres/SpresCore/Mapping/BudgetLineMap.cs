using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;

namespace Spres.Mapping
{
   public  class BudgetLineMap : EntityTypeConfiguration<BudgetLine>
    {
       public BudgetLineMap()
       {
            Property(bl => bl.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
            Ignore(bl => bl.Item);
            Property(bl => bl.Description).IsOptional();
            Property(bl => bl.Tag).IsOptional();
            HasMany(bl => bl.Children).WithOptional(bl => bl.Parent);
            HasRequired(bl => bl.Account).WithMany().HasForeignKey(bl => bl.AccountId);
            HasOptional(bl => bl.Premise);
            HasMany(bl => bl.MonthDetails).WithRequired(bm => bm.Line).HasForeignKey(bm => bm.LineId);
       }
    }
}
