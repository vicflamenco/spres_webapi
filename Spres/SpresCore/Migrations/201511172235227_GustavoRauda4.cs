namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class GustavoRauda4 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Accounts", "Type", c => c.String());
            AddColumn("dbo.CostCenters", "Type", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.CostCenters", "Type");
            DropColumn("dbo.Accounts", "Type");
        }
    }
}
