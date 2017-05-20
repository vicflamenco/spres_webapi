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
    public class ExchangeRateMap : EntityTypeConfiguration<ExchangeRate>
    {
        public ExchangeRateMap()
        {
            HasKey(e => e.Id).Property(e => e.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
            Property(e => e.CurrencyId).HasColumnType("nvarchar").HasMaxLength(3).IsRequired();
            HasRequired(e => e.Currency).WithMany().HasForeignKey(e => e.CurrencyId);
            Property(e => e.TradeDate).IsRequired();
            Property(e => e.Rate).HasColumnType("money").IsRequired();
        }
    }
}
