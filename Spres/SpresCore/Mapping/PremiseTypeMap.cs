using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;

namespace Spres.Mapping
{
   public class PremiseTypeMap : EntityTypeConfiguration<PremiseType>
    {
       public PremiseTypeMap()
       {
           HasKey(p => p.Id).Property(p => p.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
           Property(p => p.Name).HasColumnType("nvarchar").HasMaxLength(100).IsRequired();
           Property(p => p.Definition).HasColumnType("xml").IsRequired();
       }
    }
}
