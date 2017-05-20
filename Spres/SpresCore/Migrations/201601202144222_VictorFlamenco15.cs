namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco15 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.BudgetMonthHistories", "BudgetStatus", c => c.Int(nullable: false));
            DropColumn("dbo.BudgetMonthHistories", "AuthorizationStatus");
        }
        
        public override void Down()
        {
            AddColumn("dbo.BudgetMonthHistories", "AuthorizationStatus", c => c.Int(nullable: false));
            DropColumn("dbo.BudgetMonthHistories", "BudgetStatus");
        }
    }
}
