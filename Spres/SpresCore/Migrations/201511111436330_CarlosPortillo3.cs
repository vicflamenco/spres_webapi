namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class CarlosPortillo3 : DbMigration
    {
        public override void Up()
        {
            RenameColumn(table: "dbo.Accounts", name: "Parent_Id", newName: "ParentId");
            RenameIndex(table: "dbo.Accounts", name: "IX_Parent_Id", newName: "IX_ParentId");
        }
        
        public override void Down()
        {
            RenameIndex(table: "dbo.Accounts", name: "IX_ParentId", newName: "IX_Parent_Id");
            RenameColumn(table: "dbo.Accounts", name: "ParentId", newName: "Parent_Id");
        }
    }
}
