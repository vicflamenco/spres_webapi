namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco1 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Employees", "CostCenterId", c => c.Int());
            CreateIndex("dbo.Employees", "CostCenterId");
            AddForeignKey("dbo.Employees", "CostCenterId", "dbo.CostCenters", "Id");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Employees", "CostCenterId", "dbo.CostCenters");
            DropIndex("dbo.Employees", new[] { "CostCenterId" });
            DropColumn("dbo.Employees", "CostCenterId");
        }
    }
}
