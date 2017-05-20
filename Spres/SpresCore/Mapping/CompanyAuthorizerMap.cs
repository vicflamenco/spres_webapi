using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;

namespace Spres.Mapping
{
   public class CompanyAuthorizerMap :EntityTypeConfiguration<CompanyAuthorizer>
    {
       public CompanyAuthorizerMap()
       {
           HasKey(p => new { p.CompanyId, p.AuthorizerGUID });

           Property(c => c.AuthorizerGUID).HasColumnType("nvarchar").HasMaxLength(128).IsRequired();           
       }
    }
}
