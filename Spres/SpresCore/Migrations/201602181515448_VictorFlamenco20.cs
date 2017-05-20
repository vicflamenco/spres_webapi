namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco20 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.BudgetMonthHistories", "Version", c => c.Int(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.BudgetMonthHistories", "Version");
        }
    }
}
