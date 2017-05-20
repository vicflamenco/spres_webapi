namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class GustavoRauda : DbMigration
    {
        public override void Up()
        {
            RenameColumn(table: "dbo.CostCenters", name: "Parent_Id", newName: "ParentId");
            RenameIndex(table: "dbo.CostCenters", name: "IX_Parent_Id", newName: "IX_ParentId");
        }
        
        public override void Down()
        {
            RenameIndex(table: "dbo.CostCenters", name: "IX_ParentId", newName: "IX_Parent_Id");
            RenameColumn(table: "dbo.CostCenters", name: "ParentId", newName: "Parent_Id");
        }
    }
}
