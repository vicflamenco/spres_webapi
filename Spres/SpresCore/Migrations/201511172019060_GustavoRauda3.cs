namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class GustavoRauda3 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Packages", "EmployeeId", c => c.Int());
            CreateIndex("dbo.Packages", "EmployeeId");
            AddForeignKey("dbo.Packages", "EmployeeId", "dbo.Employees", "Id");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Packages", "EmployeeId", "dbo.Employees");
            DropIndex("dbo.Packages", new[] { "EmployeeId" });
            DropColumn("dbo.Packages", "EmployeeId");
        }
    }
}
