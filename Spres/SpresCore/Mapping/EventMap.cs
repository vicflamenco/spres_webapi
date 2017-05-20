using Spres.Infrastructure.Audit;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;

namespace Spres.Mapping
{
   public class EventMap :EntityTypeConfiguration<Event>
    {
       public EventMap()
       {
           HasKey(c => c.Id).Property(c => c.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.None);
           Property(c => c.UserId).HasColumnType("nvarchar").HasMaxLength(128).IsRequired();
           Property(c => c.Source).HasColumnType("xml");
       }
    }
}
