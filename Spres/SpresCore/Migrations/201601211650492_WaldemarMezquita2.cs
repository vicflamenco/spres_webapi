namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class WaldemarMezquita2 : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Events", "Source", c => c.String(storeType: "xml"));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.Events", "Source", c => c.String());
        }
    }
}
