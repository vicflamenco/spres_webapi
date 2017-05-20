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
    public class PermissionsMap : EntityTypeConfiguration<Permissions>
    {
        public PermissionsMap()
        {
            HasKey(b => new { b.RolId, b.Option });
            Property(b => b.View).IsRequired();
            Property(b => b.Edit).IsRequired();
            Property(b => b.AllCostCenters).IsRequired();
        }
    }
}
