namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenc0 : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.BudgetLines", "Account_Id", "dbo.Accounts");
            DropForeignKey("dbo.BudgetSheets", "Id", "dbo.Budgets");
            DropForeignKey("dbo.BudgetSheets", "Package_Id", "dbo.Packages");
            DropForeignKey("dbo.Budgets", "CostCenterId", "dbo.CostCenters");
            DropForeignKey("dbo.Employees", "PositionId", "dbo.Positions");
            DropForeignKey("dbo.BudgetLines", "SheetId", "dbo.BudgetSheets");
            DropIndex("dbo.BudgetLines", new[] { "Account_Id" });
            DropIndex("dbo.BudgetSheets", new[] { "Id" });
            DropIndex("dbo.BudgetSheets", new[] { "Package_Id" });
            RenameColumn(table: "dbo.BudgetLines", name: "Account_Id", newName: "AccountId");
            RenameColumn(table: "dbo.BudgetLines", name: "Parent_Id", newName: "ParentId");
            RenameColumn(table: "dbo.BudgetLines", name: "Premise_Id", newName: "PremiseId");
            RenameColumn(table: "dbo.BudgetMonthDetails", name: "IdLine", newName: "LineId");
            RenameColumn(table: "dbo.BudgetSheets", name: "Package_Id", newName: "PackageId");
            RenameIndex(table: "dbo.BudgetLines", name: "IX_Parent_Id", newName: "IX_ParentId");
            RenameIndex(table: "dbo.BudgetLines", name: "IX_Premise_Id", newName: "IX_PremiseId");
            RenameIndex(table: "dbo.BudgetMonthDetails", name: "IX_IdLine", newName: "IX_LineId");
            DropPrimaryKey("dbo.BudgetSheets");
            AddColumn("dbo.BudgetSheets", "BudgetId", c => c.Int(nullable: false));
            AlterColumn("dbo.BudgetLines", "AccountId", c => c.Int(nullable: false));
            AlterColumn("dbo.BudgetSheets", "Id", c => c.Int(nullable: false, identity: true));
            AlterColumn("dbo.BudgetSheets", "PackageId", c => c.Int(nullable: false));
            AddPrimaryKey("dbo.BudgetSheets", "Id");
            CreateIndex("dbo.BudgetLines", "AccountId");
            CreateIndex("dbo.BudgetSheets", "BudgetId");
            CreateIndex("dbo.BudgetSheets", "PackageId");
            AddForeignKey("dbo.BudgetLines", "AccountId", "dbo.Accounts", "Id", cascadeDelete: true);
            AddForeignKey("dbo.BudgetSheets", "BudgetId", "dbo.Budgets", "Id", cascadeDelete: true);
            AddForeignKey("dbo.BudgetSheets", "PackageId", "dbo.Packages", "Id", cascadeDelete: true);
            AddForeignKey("dbo.Budgets", "CostCenterId", "dbo.CostCenters", "Id");
            AddForeignKey("dbo.Employees", "PositionId", "dbo.Positions", "Id");
            AddForeignKey("dbo.BudgetLines", "SheetId", "dbo.BudgetSheets", "Id", cascadeDelete: true);
            DropColumn("dbo.BudgetLines", "Item");
        }
        
        public override void Down()
        {
            AddColumn("dbo.BudgetLines", "Item", c => c.Int(nullable: false));
            DropForeignKey("dbo.BudgetLines", "SheetId", "dbo.BudgetSheets");
            DropForeignKey("dbo.Employees", "PositionId", "dbo.Positions");
            DropForeignKey("dbo.Budgets", "CostCenterId", "dbo.CostCenters");
            DropForeignKey("dbo.BudgetSheets", "PackageId", "dbo.Packages");
            DropForeignKey("dbo.BudgetSheets", "BudgetId", "dbo.Budgets");
            DropForeignKey("dbo.BudgetLines", "AccountId", "dbo.Accounts");
            DropIndex("dbo.BudgetSheets", new[] { "PackageId" });
            DropIndex("dbo.BudgetSheets", new[] { "BudgetId" });
            DropIndex("dbo.BudgetLines", new[] { "AccountId" });
            DropPrimaryKey("dbo.BudgetSheets");
            AlterColumn("dbo.BudgetSheets", "PackageId", c => c.Int());
            AlterColumn("dbo.BudgetSheets", "Id", c => c.Int(nullable: false));
            AlterColumn("dbo.BudgetLines", "AccountId", c => c.Int());
            DropColumn("dbo.BudgetSheets", "BudgetId");
            AddPrimaryKey("dbo.BudgetSheets", "Id");
            RenameIndex(table: "dbo.BudgetMonthDetails", name: "IX_LineId", newName: "IX_IdLine");
            RenameIndex(table: "dbo.BudgetLines", name: "IX_PremiseId", newName: "IX_Premise_Id");
            RenameIndex(table: "dbo.BudgetLines", name: "IX_ParentId", newName: "IX_Parent_Id");
            RenameColumn(table: "dbo.BudgetSheets", name: "PackageId", newName: "Package_Id");
            RenameColumn(table: "dbo.BudgetMonthDetails", name: "LineId", newName: "IdLine");
            RenameColumn(table: "dbo.BudgetLines", name: "PremiseId", newName: "Premise_Id");
            RenameColumn(table: "dbo.BudgetLines", name: "ParentId", newName: "Parent_Id");
            RenameColumn(table: "dbo.BudgetLines", name: "AccountId", newName: "Account_Id");
            CreateIndex("dbo.BudgetSheets", "Package_Id");
            CreateIndex("dbo.BudgetSheets", "Id");
            CreateIndex("dbo.BudgetLines", "Account_Id");
            AddForeignKey("dbo.BudgetLines", "SheetId", "dbo.BudgetSheets", "Id", cascadeDelete: true);
            AddForeignKey("dbo.Employees", "PositionId", "dbo.Positions", "Id", cascadeDelete: true);
            AddForeignKey("dbo.Budgets", "CostCenterId", "dbo.CostCenters", "Id", cascadeDelete: true);
            AddForeignKey("dbo.BudgetSheets", "Package_Id", "dbo.Packages", "Id");
            AddForeignKey("dbo.BudgetSheets", "Id", "dbo.Budgets", "Id");
            AddForeignKey("dbo.BudgetLines", "Account_Id", "dbo.Accounts", "Id");
        }
    }
}
