namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class WaldemarMezquita3 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Events", "EventDate", c => c.DateTime(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Events", "EventDate");
        }
    }
}
