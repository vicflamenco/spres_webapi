using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;

namespace Spres.Mapping
{
   public class CostCenterMap: EntityTypeConfiguration<CostCenter>
    {
       public CostCenterMap()
       {
           HasKey(c => c.Id).Property(c => c.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);

           Property(c => c.Code).HasColumnType("nvarchar").HasMaxLength(50).IsRequired();
           
           Property(c => c.Name).HasColumnType("nvarchar").HasMaxLength(50).IsRequired();
           
           HasMany(c => c.Children).WithOptional(c => c.Parent);
           
           Ignore(c => c.Display);
           
           Ignore(p => p.TypeDescription);

           Property(c => c.ResponsibleGUID).HasColumnType("nvarchar").HasMaxLength(128).IsOptional();
           
           HasRequired(c => c.Company).WithMany().HasForeignKey(c=> c.CompanyId).WillCascadeOnDelete(false);
           
       }
    }
}
