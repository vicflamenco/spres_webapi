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
    class EmailTemplateMap : EntityTypeConfiguration<EmailTemplate>
    {
        public EmailTemplateMap()
        {
            HasKey(et => et.Id).Property(et => et.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
            Property(et => et.Name).HasColumnType("nvarchar").HasMaxLength(128).IsRequired();
            Property(et => et.Subject).HasColumnType("nvarchar").HasMaxLength(256).IsRequired();
            Property(et => et.Body).HasColumnType("nvarchar").HasMaxLength(5000).IsRequired();
        }
    }
}
