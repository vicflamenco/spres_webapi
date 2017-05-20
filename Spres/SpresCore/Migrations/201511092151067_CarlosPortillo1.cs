namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class CarlosPortillo1 : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.ProviderTypes", "PremiseType_Id", "dbo.PremiseTypes");
            DropIndex("dbo.ProviderTypes", new[] { "PremiseType_Id" });
            RenameColumn(table: "dbo.Providers", name: "ProviderType_Id", newName: "ProviderTypeId");
            RenameColumn(table: "dbo.ProviderTypes", name: "PremiseType_Id", newName: "PremiseTypeId");
            RenameIndex(table: "dbo.Providers", name: "IX_ProviderType_Id", newName: "IX_ProviderTypeId");
            AlterColumn("dbo.ProviderTypes", "PremiseTypeId", c => c.Int());
            CreateIndex("dbo.ProviderTypes", "PremiseTypeId");
            AddForeignKey("dbo.ProviderTypes", "PremiseTypeId", "dbo.PremiseTypes", "Id");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.ProviderTypes", "PremiseTypeId", "dbo.PremiseTypes");
            DropIndex("dbo.ProviderTypes", new[] { "PremiseTypeId" });
            AlterColumn("dbo.ProviderTypes", "PremiseTypeId", c => c.Int(nullable: false));
            RenameIndex(table: "dbo.Providers", name: "IX_ProviderTypeId", newName: "IX_ProviderType_Id");
            RenameColumn(table: "dbo.ProviderTypes", name: "PremiseTypeId", newName: "PremiseType_Id");
            RenameColumn(table: "dbo.Providers", name: "ProviderTypeId", newName: "ProviderType_Id");
            CreateIndex("dbo.ProviderTypes", "PremiseType_Id");
            AddForeignKey("dbo.ProviderTypes", "PremiseType_Id", "dbo.PremiseTypes", "Id", cascadeDelete: true);
        }
    }
}
