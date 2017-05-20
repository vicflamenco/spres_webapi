using Spres.Models;
using System.Data.Entity.ModelConfiguration;

namespace Spres.Mapping
{
   public  class ProgrammingMap :EntityTypeConfiguration<Programming>
    {
       public ProgrammingMap()
       {
           HasKey(p => new { p.FiscalYear, p.CompanyId });
           Property(c => c.BudgetStartDate).IsRequired();
           Property(c => c.BudgetEndDate).IsRequired();
           HasRequired(c => c.Company).WithMany().HasForeignKey(c => c.CompanyId).WillCascadeOnDelete(false);
       }
    }
}
