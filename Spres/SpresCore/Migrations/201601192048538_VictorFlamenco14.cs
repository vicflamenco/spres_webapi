namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco14 : DbMigration
    {
        public override void Up()
        {
            DropColumn("dbo.Budgets", "Reviewed");
            DropColumn("dbo.Budgets", "Authorized");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Budgets", "Authorized", c => c.Boolean(nullable: false));
            AddColumn("dbo.Budgets", "Reviewed", c => c.Boolean(nullable: false));
        }
    }
}
