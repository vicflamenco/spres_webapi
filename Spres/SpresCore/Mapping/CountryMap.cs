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
    public class CountryMap : EntityTypeConfiguration<Country>
    {
        public CountryMap()
        {
            HasKey(c => c.Id).Property(p => p.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.None);
            Property(c => c.Id).HasColumnType("nvarchar").HasMaxLength(2).IsRequired();
            Property(p => p.Name).HasColumnType("nvarchar").HasMaxLength(50).IsRequired();
            HasRequired(c => c.DefaultCurrency).WithMany().HasForeignKey(c => c.DefaultCurrencyId);
        }
    }
}
