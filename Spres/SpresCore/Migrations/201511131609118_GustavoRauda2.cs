namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class GustavoRauda2 : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Benefits", "Employee_Id", "dbo.Employees");
            DropIndex("dbo.Benefits", new[] { "Employee_Id" });
            CreateTable(
                "dbo.EmployeeBenefits",
                c => new
                    {
                        Employee_Id = c.Int(nullable: false),
                        Benefit_Id = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.Employee_Id, t.Benefit_Id })
                .ForeignKey("dbo.Employees", t => t.Employee_Id, cascadeDelete: true)
                .ForeignKey("dbo.Benefits", t => t.Benefit_Id, cascadeDelete: true)
                .Index(t => t.Employee_Id)
                .Index(t => t.Benefit_Id);
            
            DropColumn("dbo.Benefits", "Employee_Id");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Benefits", "Employee_Id", c => c.Int());
            DropForeignKey("dbo.EmployeeBenefits", "Benefit_Id", "dbo.Benefits");
            DropForeignKey("dbo.EmployeeBenefits", "Employee_Id", "dbo.Employees");
            DropIndex("dbo.EmployeeBenefits", new[] { "Benefit_Id" });
            DropIndex("dbo.EmployeeBenefits", new[] { "Employee_Id" });
            DropTable("dbo.EmployeeBenefits");
            CreateIndex("dbo.Benefits", "Employee_Id");
            AddForeignKey("dbo.Benefits", "Employee_Id", "dbo.Employees", "Id");
        }
    }
}
