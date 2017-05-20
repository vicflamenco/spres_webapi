using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;

namespace Spres.Mapping
{
   public class PositionMap : EntityTypeConfiguration<Position>
    {
       public PositionMap()
       {
           HasKey(p => p.Id).Property(p => p.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
           HasMany(p => p.Employees).WithRequired(e => e.Position).HasForeignKey(e => e.PositionId).WillCascadeOnDelete(false);
           HasMany(e => e.Equipments).WithMany(e => e.Positions);
           HasRequired(p => p.Company);
       }
    }
}
