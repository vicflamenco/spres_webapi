namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco3 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Premises", "LineSource", c => c.Int(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Premises", "LineSource");
        }
    }
}
