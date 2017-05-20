namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class GustavoRauda8 : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.CompanyAuthorizers",
                c => new
                    {
                        CompanyId = c.Int(nullable: false),
                        AuthorizerGUID = c.String(nullable: false, maxLength: 128),
                    })
                .PrimaryKey(t => new { t.CompanyId, t.AuthorizerGUID })
                .ForeignKey("dbo.Companies", t => t.CompanyId, cascadeDelete: true)
                .Index(t => t.CompanyId);
            
            CreateTable(
                "dbo.BudgetMonthHistories",
                c => new
                    {
                        BudgetMonthDetailId = c.Int(nullable: false),
                        HistoricalDate = c.DateTime(nullable: false),
                        Month = c.Int(nullable: false),
                        Quantity = c.Int(nullable: false),
                        UnitCost = c.Decimal(nullable: false, storeType: "money"),
                        Target = c.Decimal(nullable: false, storeType: "money"),
                        Forecast = c.Decimal(nullable: false, storeType: "money"),
                        ExpenseDetail = c.String(storeType: "xml"),
                        Real = c.Decimal(nullable: false, storeType: "money"),
                        AuthorizationStatus = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.BudgetMonthDetailId, t.HistoricalDate })
                .ForeignKey("dbo.BudgetMonthDetails", t => t.BudgetMonthDetailId, cascadeDelete: true)
                .Index(t => t.BudgetMonthDetailId);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.BudgetMonthHistories", "BudgetMonthDetailId", "dbo.BudgetMonthDetails");
            DropForeignKey("dbo.CompanyAuthorizers", "CompanyId", "dbo.Companies");
            DropIndex("dbo.BudgetMonthHistories", new[] { "BudgetMonthDetailId" });
            DropIndex("dbo.CompanyAuthorizers", new[] { "CompanyId" });
            DropTable("dbo.BudgetMonthHistories");
            DropTable("dbo.CompanyAuthorizers");
        }
    }
}
