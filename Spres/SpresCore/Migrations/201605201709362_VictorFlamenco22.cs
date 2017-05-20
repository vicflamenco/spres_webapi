namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco22 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.CostCenters", "Mirror", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.CostCenters", "Mirror");
        }
    }
}
