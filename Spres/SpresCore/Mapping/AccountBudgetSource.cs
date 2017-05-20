using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;
namespace Spres.Mapping
{
    public class AccountBudgetSourceMap : EntityTypeConfiguration<AccountBudgetSource>
    {
        public AccountBudgetSourceMap()
        {
            HasKey(p => p.Id).Property(p => p.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);

            Property(p => p.Name).HasColumnType("nvarchar").HasMaxLength(100).IsRequired();

            Property(p => p.Source).HasColumnName("nvarchar").HasMaxLength(100).IsOptional();

            Property(p => p.Formule).HasColumnName("nvarchar").HasMaxLength(100).IsOptional();

            HasRequired(p => p.Account).WithRequiredPrincipal();

            HasOptional(p => p.PremiseType).WithRequired();
        }
    }
}
