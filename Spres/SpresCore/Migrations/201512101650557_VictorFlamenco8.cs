namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco8 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Benefits", "Code", c => c.String(nullable: false, maxLength: 4000));
            AddColumn("dbo.Budgets", "Reviewed", c => c.Boolean(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Budgets", "Reviewed");
            DropColumn("dbo.Benefits", "Code");
        }
    }
}
