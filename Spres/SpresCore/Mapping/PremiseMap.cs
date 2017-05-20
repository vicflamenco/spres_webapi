using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;

namespace Spres.Mapping
{
    public class PremiseMap : EntityTypeConfiguration<Premise>
    {
        public PremiseMap()
        {
            HasKey(p => p.Id).Property(p => p.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
            HasRequired(p => p.Type);
            Property(p => p.Expenses).HasColumnType("xml");            
            HasRequired(p => p.Programming).WithMany().HasForeignKey(p => new {p.FiscalYear, p.CompanyId}).WillCascadeOnDelete(false);
        }
    }
}
