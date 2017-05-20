using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;

namespace Spres.Mapping
{
   public class BudgetMap : EntityTypeConfiguration<Budget>
    {
       public BudgetMap()
       {
           HasKey(b => b.Id).Property(b => b.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
           HasRequired(b => b.CostCenter).WithMany().HasForeignKey(b => b.CostCenterId).WillCascadeOnDelete(false);
           HasRequired(b => b.Company).WithMany().HasForeignKey(b => b.CompanyId);
           HasRequired(b => b.BudgetProgramming);
           HasMany(b => b.Sheets).WithRequired(bs => bs.Budget);
           HasMany(b => b.Authorizations).WithRequired(bs => bs.Budget);
           
       }
    }
}
