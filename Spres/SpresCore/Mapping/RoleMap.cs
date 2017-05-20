using Spres.Infrastructure.Security;
using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Mapping
{
    class RoleMap : EntityTypeConfiguration<Role>
    {
        public RoleMap()
        {
            HasKey(r => r.Id);
        }
    }
}
