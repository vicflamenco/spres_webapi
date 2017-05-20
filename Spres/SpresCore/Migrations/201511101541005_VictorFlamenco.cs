namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Premises", "FiscalYear", "dbo.Programmings");
            DropForeignKey("dbo.Budgets", "FiscalYear", "dbo.Programmings");
            DropForeignKey("dbo.Premises", new[] { "FiscalYear", "CompanyId" }, "dbo.Programmings");
            DropForeignKey("dbo.Budgets", new[] { "FiscalYear", "CompanyId" }, "dbo.Programmings");
            DropIndex("dbo.Premises", new[] { "FiscalYear" });
            DropIndex("dbo.Premises", new[] { "CompanyId" });
            DropIndex("dbo.Budgets", new[] { "FiscalYear" });
            DropIndex("dbo.Budgets", new[] { "CompanyId" });
            DropPrimaryKey("dbo.Programmings");
            AddColumn("dbo.Programmings", "CompanyId", c => c.Int(nullable: false));
            AddPrimaryKey("dbo.Programmings", new[] { "FiscalYear", "CompanyId" });
            CreateIndex("dbo.Premises", new[] { "FiscalYear", "CompanyId" });
            CreateIndex("dbo.Programmings", "CompanyId");
            CreateIndex("dbo.Budgets", new[] { "FiscalYear", "CompanyId" });
            AddForeignKey("dbo.Programmings", "CompanyId", "dbo.Companies", "Id", cascadeDelete: true);
            AddForeignKey("dbo.Premises", new[] { "FiscalYear", "CompanyId" }, "dbo.Programmings", new[] { "FiscalYear", "CompanyId" }, cascadeDelete: false);
            AddForeignKey("dbo.Budgets", new[] { "FiscalYear", "CompanyId" }, "dbo.Programmings", new[] { "FiscalYear", "CompanyId" }, cascadeDelete: false);
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Budgets", new[] { "FiscalYear", "CompanyId" }, "dbo.Programmings");
            DropForeignKey("dbo.Premises", new[] { "FiscalYear", "CompanyId" }, "dbo.Programmings");
            DropForeignKey("dbo.Programmings", "CompanyId", "dbo.Companies");
            DropIndex("dbo.Budgets", new[] { "FiscalYear", "CompanyId" });
            DropIndex("dbo.Programmings", new[] { "CompanyId" });
            DropIndex("dbo.Premises", new[] { "FiscalYear", "CompanyId" });
            DropPrimaryKey("dbo.Programmings");
            DropColumn("dbo.Programmings", "CompanyId");
            AddPrimaryKey("dbo.Programmings", "FiscalYear");
            CreateIndex("dbo.Budgets", "CompanyId");
            CreateIndex("dbo.Budgets", "FiscalYear");
            CreateIndex("dbo.Premises", "CompanyId");
            CreateIndex("dbo.Premises", "FiscalYear");
            AddForeignKey("dbo.Budgets", new[] { "FiscalYear", "CompanyId" }, "dbo.Programmings", new[] { "FiscalYear", "CompanyId" }, cascadeDelete: true);
            AddForeignKey("dbo.Premises", new[] { "FiscalYear", "CompanyId" }, "dbo.Programmings", new[] { "FiscalYear", "CompanyId" }, cascadeDelete: true);
            AddForeignKey("dbo.Budgets", "FiscalYear", "dbo.Programmings", "FiscalYear", cascadeDelete: true);
            AddForeignKey("dbo.Premises", "FiscalYear", "dbo.Programmings", "FiscalYear", cascadeDelete: true);
        }
    }
}
