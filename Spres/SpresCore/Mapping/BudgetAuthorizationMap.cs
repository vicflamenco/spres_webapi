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
    class BudgetAuthorizationMap : EntityTypeConfiguration<BudgetAuthorization>
    {
        public BudgetAuthorizationMap()
        {
            HasKey(ba => ba.Id).Property(ba => ba.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);

            //HasRequired(ba => ba.Budget).WithMany().HasForeignKey(ba => ba.BudgetId);

            Property(p => p.AuthorizerGUID).HasColumnType("nvarchar").HasMaxLength(128).IsRequired();

            Property(ba => ba.RequestDate).IsRequired();

            Property(ba => ba.Status).IsRequired();

        }
    }
}
