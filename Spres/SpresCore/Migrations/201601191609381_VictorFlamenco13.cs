namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco13 : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.BudgetAuthorizations",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        BudgetId = c.Int(nullable: false),
                        AuthorizerGUID = c.String(nullable: false, maxLength: 128),
                        RequestDate = c.DateTime(nullable: false),
                        Status = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Budgets", t => t.BudgetId, cascadeDelete: true)
                .Index(t => t.BudgetId);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.BudgetAuthorizations", "BudgetId", "dbo.Budgets");
            DropIndex("dbo.BudgetAuthorizations", new[] { "BudgetId" });
            DropTable("dbo.BudgetAuthorizations");
        }
    }
}
