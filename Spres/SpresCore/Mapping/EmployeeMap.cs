using Spres.Models;
using System.Data.Entity.ModelConfiguration;
using System.ComponentModel.DataAnnotations.Schema;

namespace Spres.Mapping
{
  public  class EmployeeMap : EntityTypeConfiguration<Employee>
    {
      public EmployeeMap()
      {
          HasKey(e => e.Id).Property(e => e.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);
          Property(e => e.Code).HasColumnType("nvarchar").HasMaxLength(20).IsRequired();
          Property(e => e.Name).HasColumnType("nvarchar").HasMaxLength(100).IsRequired();
          Property(e => e.UserId).IsOptional().HasColumnType("nvarchar").HasMaxLength(255);
          Property(e => e.Active).IsRequired();
          
          HasOptional(e => e.CostCenter).WithMany().HasForeignKey(e => e.CostCenterId);
          HasMany(e => e.Benefits).WithMany();
      }
    }
}
