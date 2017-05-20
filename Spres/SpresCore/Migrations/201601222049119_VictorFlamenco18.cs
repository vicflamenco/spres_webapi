namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco18 : DbMigration
    {
        public override void Up()
        {
            DropColumn("dbo.Permissions", "Process");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Permissions", "Process", c => c.Boolean(nullable: false));
        }
    }
}
