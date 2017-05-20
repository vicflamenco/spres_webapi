namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco5 : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Premises", "AccountId", "dbo.Accounts");
            DropIndex("dbo.Premises", new[] { "AccountId" });
            AddColumn("dbo.AccountBudgetSources", "PremiseTypeId", c => c.Int());
            CreateIndex("dbo.AccountBudgetSources", "PremiseTypeId");
            AddForeignKey("dbo.AccountBudgetSources", "PremiseTypeId", "dbo.PremiseTypes", "Id");
            DropColumn("dbo.Premises", "AccountId");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Premises", "AccountId", c => c.Int(nullable: false));
            DropForeignKey("dbo.AccountBudgetSources", "PremiseTypeId", "dbo.PremiseTypes");
            DropIndex("dbo.AccountBudgetSources", new[] { "PremiseTypeId" });
            DropColumn("dbo.AccountBudgetSources", "PremiseTypeId");
            CreateIndex("dbo.Premises", "AccountId");
            AddForeignKey("dbo.Premises", "AccountId", "dbo.Accounts", "Id", cascadeDelete: true);
        }
    }
}
