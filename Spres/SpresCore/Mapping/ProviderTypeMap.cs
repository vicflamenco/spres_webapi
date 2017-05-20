using Spres.Models;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace Spres.Mapping
{
    public class ProviderTypeMap : EntityTypeConfiguration<ProviderType>
    {
        public ProviderTypeMap()
        {
            HasKey(p => p.Id).Property(p => p.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
            Property(p => p.Name).IsRequired().HasColumnType("nvarchar").HasMaxLength(50);
            Property(p => p.PremiseTypeId).IsOptional();
            HasOptional(p => p.PremiseType).WithMany().HasForeignKey(p => p.PremiseTypeId);
            HasMany(p => p.Providers).WithRequired(pr => pr.ProviderType).HasForeignKey(pr => pr.ProviderTypeId);
        }
    }
}
