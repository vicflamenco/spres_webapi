using Spres.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Mapping
{
    public class ForecastProgrammingMap : EntityTypeConfiguration<ForecastProgramming>
    {
        public ForecastProgrammingMap()
        {
            HasKey(fp => new { fp.FiscalYear, fp.CompanyId, fp.Item });
            HasRequired(fp => fp.Programming).WithMany(p => p.ForecastProgrammings).HasForeignKey(fp => new { fp.FiscalYear, fp.CompanyId }).WillCascadeOnDelete(true);
        }
    }
}
