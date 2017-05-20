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
    public class CurrencyMap : EntityTypeConfiguration<Currency>
    {
        public CurrencyMap()
        {
            HasKey(c => c.Id).Property(c => c.Id).HasColumnType("nvarchar").HasMaxLength(3).IsRequired();
            Property(c => c.Name).HasColumnType("nvarchar").HasMaxLength(50).IsRequired();
        }
    }
}
