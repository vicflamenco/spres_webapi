using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;

namespace Spres.Mapping
{
   public class PackageMap : EntityTypeConfiguration<Package>
    {
       public PackageMap()
       {
           HasKey(p => p.Id).Property(p => p.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
           Property(p => p.Name).HasColumnType("nvarchar").HasMaxLength(50).IsRequired();
           Property(p => p.HR).IsRequired();
           Property(p => p.ManagerGUID).IsOptional();
           HasMany(p => p.Accounts).WithMany(p => p.Packages);
       }
    }
}
