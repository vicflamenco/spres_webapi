namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco21 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.BudgetMonthHistories", "Reason", c => c.Int(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.BudgetMonthHistories", "Reason");
        }
    }
}
