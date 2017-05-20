namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco11 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Permissions", "AllCostCenters", c => c.Boolean(nullable: false));
            DropColumn("dbo.Permissions", "CostCenterFilter");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Permissions", "CostCenterFilter", c => c.Boolean(nullable: false));
            DropColumn("dbo.Permissions", "AllCostCenters");
        }
    }
}
