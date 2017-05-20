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
    public class ProviderMap : EntityTypeConfiguration<Provider>
    {
        public ProviderMap()
        {
            HasKey(p => p.Id).Property(p => p.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
            Property(p => p.Name).IsRequired().HasColumnType("nvarchar").HasMaxLength(50);
            HasRequired(p => p.ProviderType);
        }
    }
}
