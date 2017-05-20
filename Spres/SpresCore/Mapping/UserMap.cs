using Spres.Infrastructure.Security;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Spres.Mapping
{
    class UserMap : EntityTypeConfiguration<User>
    {
        public UserMap()
        {
            HasKey(u => u.Id).Property(u => u.Id);
            Property(u => u.Status).IsRequired();
            Property(u => u.Name).IsRequired();
            
        }
    }
}
