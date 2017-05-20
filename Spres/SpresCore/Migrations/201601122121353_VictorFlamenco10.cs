namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco10 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Packages", "HR", c => c.Boolean(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Packages", "HR");
        }
    }
}
