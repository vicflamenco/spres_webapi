using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;

namespace Spres.Mapping
{
   public  class CompanyMap :EntityTypeConfiguration<Company>
    {
       public CompanyMap()
       {
           HasKey(c => c.Id).Property(c => c.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
           Property(c => c.Name).HasColumnType("nvarchar").HasMaxLength(100).IsRequired();
           Property(c => c.Country).HasColumnType("nvarchar").HasMaxLength(2).IsRequired();
           HasMany(c => c.Authorizers);
       }
    }
}
