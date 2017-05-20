using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;

namespace Spres.Mapping
{
   public  class BudgetSheetMap : EntityTypeConfiguration<BudgetSheet>
    {
       public BudgetSheetMap()
       {
           HasKey(bs => bs.Id).Property(bs => bs.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
           HasRequired(bs => bs.Package).WithMany().HasForeignKey(bs => bs.PackageId);
           
           HasMany(bs => bs.Lines).WithRequired(bl => bl.Sheet).HasForeignKey(bl => bl.SheetId);

       }
    }
}
