namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco7 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.BudgetLines", "Tag", c => c.Int());
        }
        
        public override void Down()
        {
            DropColumn("dbo.BudgetLines", "Tag");
        }
    }
}
