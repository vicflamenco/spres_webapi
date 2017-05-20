using Spres.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Mapping
{
    public class EquipmentMap : EntityTypeConfiguration<Equipment>
    {
        public EquipmentMap()
        {
            HasKey(e => e.Id).Property(e => e.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
            Property(e => e.Name).IsRequired().HasColumnType("nvarchar").HasMaxLength(50);
        }
    }
}
