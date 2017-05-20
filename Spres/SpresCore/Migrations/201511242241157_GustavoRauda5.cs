namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class GustavoRauda5 : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.AccountBudgetSources",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        Source = c.String(),
                        Formule = c.String(),
                        AccountId = c.Int(nullable: false),
                        ExpenseType = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Accounts", t => t.AccountId, cascadeDelete: true)
                .Index(t => t.AccountId);
            
            DropColumn("dbo.Premises", "LineSource");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Premises", "LineSource", c => c.Int(nullable: false));
            DropForeignKey("dbo.AccountBudgetSources", "AccountId", "dbo.Accounts");
            DropIndex("dbo.AccountBudgetSources", new[] { "AccountId" });
            DropTable("dbo.AccountBudgetSources");
        }
    }
}
