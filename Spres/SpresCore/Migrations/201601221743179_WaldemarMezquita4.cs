namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class WaldemarMezquita4 : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Packages", "EmployeeId", "dbo.Employees");
            DropIndex("dbo.Packages", new[] { "EmployeeId" });
            AddColumn("dbo.Packages", "ManagerGUID", c => c.String());
            DropColumn("dbo.Packages", "EmployeeId");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Packages", "EmployeeId", c => c.Int());
            DropColumn("dbo.Packages", "ManagerGUID");
            CreateIndex("dbo.Packages", "EmployeeId");
            AddForeignKey("dbo.Packages", "EmployeeId", "dbo.Employees", "Id");
        }
    }
}
