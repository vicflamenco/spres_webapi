using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;
namespace Spres.Mapping
{
    public class AccountMap : EntityTypeConfiguration<Account>
    {
        public AccountMap()
        {
            HasKey(p => p.Id).Property(p => p.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);

            Property(p => p.Code).HasColumnType("nvarchar").HasMaxLength(50).IsRequired();

            Property(p => p.Name).HasColumnType("nvarchar").HasMaxLength(100).IsRequired();

            Ignore(p => p.Display);

            Ignore(p => p.TypeDescription);

            Ignore(p => p.PackagesDescription);

            HasMany(a => a.Children).WithOptional(a => a.Parent);
            
                    
        }
    }
}
