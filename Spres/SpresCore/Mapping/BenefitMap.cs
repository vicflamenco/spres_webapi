using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;

namespace Spres.Mapping
{
   public  class BenefitMap :EntityTypeConfiguration<Benefit>
    {
       public BenefitMap()
       {
           HasKey(b => b.Id).Property(b => b.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
           Property(b => b.Name).HasColumnType("nvarchar").HasMaxLength(50).IsRequired();
           Property(b => b.Target).HasColumnType("int").IsRequired();
           Property(b => b.Code).HasColumnType("nvarchar").HasMaxLength(30).IsRequired();
       }
    }
}
