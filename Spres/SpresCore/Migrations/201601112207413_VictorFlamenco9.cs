namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco9 : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.CostCenters", "Responsible_Id", "dbo.Employees");
            DropIndex("dbo.CostCenters", new[] { "Responsible_Id" });
            AddColumn("dbo.CostCenters", "ResponsibleGUID", c => c.String(maxLength: 128));
            DropColumn("dbo.CostCenters", "Responsible_Id");
        }
        
        public override void Down()
        {
            AddColumn("dbo.CostCenters", "Responsible_Id", c => c.Int());
            DropColumn("dbo.CostCenters", "ResponsibleGUID");
            CreateIndex("dbo.CostCenters", "Responsible_Id");
            AddForeignKey("dbo.CostCenters", "Responsible_Id", "dbo.Employees", "Id");
        }
    }
}
