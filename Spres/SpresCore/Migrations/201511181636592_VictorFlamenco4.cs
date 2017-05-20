namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco4 : DbMigration
    {
        public override void Up()
        {
            //RenameColumn(table: "dbo.Packages", name: "Manager_Id", newName: "EmployeeId");
            //RenameIndex(table: "dbo.Packages", name: "IX_Manager_Id", newName: "IX_EmployeeId");
        }
        
        public override void Down()
        {
            //RenameIndex(table: "dbo.Packages", name: "IX_EmployeeId", newName: "IX_Manager_Id");
            //RenameColumn(table: "dbo.Packages", name: "EmployeeId", newName: "Manager_Id");
        }
    }
}
