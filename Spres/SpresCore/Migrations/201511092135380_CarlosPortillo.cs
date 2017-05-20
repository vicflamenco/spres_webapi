namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class CarlosPortillo : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Accounts",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Code = c.String(nullable: false, maxLength: 50),
                        Name = c.String(nullable: false, maxLength: 100),
                        Parent_Id = c.Int(),
                        Package_Id = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Accounts", t => t.Parent_Id)
                .ForeignKey("dbo.Packages", t => t.Package_Id)
                .Index(t => t.Parent_Id)
                .Index(t => t.Package_Id);
            
            CreateTable(
                "dbo.Packages",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 50),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Benefits",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 50),
                        Target = c.Int(nullable: false),
                        Employee_Id = c.Int(),
                        Position_Id = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Employees", t => t.Employee_Id)
                .ForeignKey("dbo.Positions", t => t.Position_Id)
                .Index(t => t.Employee_Id)
                .Index(t => t.Position_Id);
            
            CreateTable(
                "dbo.BudgetLines",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        SheetId = c.Int(nullable: false),
                        Description = c.String(),
                        Item = c.Int(nullable: false),
                        Account_Id = c.Int(),
                        Parent_Id = c.Int(),
                        Premise_Id = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Accounts", t => t.Account_Id)
                .ForeignKey("dbo.BudgetLines", t => t.Parent_Id)
                .ForeignKey("dbo.Premises", t => t.Premise_Id)
                .ForeignKey("dbo.BudgetSheets", t => t.SheetId, cascadeDelete: true)
                .Index(t => t.SheetId)
                .Index(t => t.Account_Id)
                .Index(t => t.Parent_Id)
                .Index(t => t.Premise_Id);
            
            CreateTable(
                "dbo.BudgetMonthDetails",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        IdLine = c.Int(nullable: false),
                        Quantity = c.Int(nullable: false),
                        UnitCost = c.Decimal(nullable: false, precision: 18, scale: 2),
                        Target = c.Decimal(nullable: false, precision: 18, scale: 2),
                        Forecast = c.Decimal(nullable: false, precision: 18, scale: 2),
                        ExpenseDetail = c.String(storeType: "xml"),
                        Real = c.Decimal(nullable: false, precision: 18, scale: 2),
                        Month = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.BudgetLines", t => t.IdLine, cascadeDelete: true)
                .Index(t => t.IdLine);
            
            CreateTable(
                "dbo.Premises",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        Expenses = c.String(),
                        FiscalYear = c.Int(nullable: false),
                        AccountId = c.Int(nullable: false),
                        CompanyId = c.Int(nullable: false),
                        PremiseTypeId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Accounts", t => t.AccountId, cascadeDelete: true)
                .ForeignKey("dbo.Companies", t => t.CompanyId, cascadeDelete: true)
                .ForeignKey("dbo.Programmings", t => t.FiscalYear, cascadeDelete: true)
                .ForeignKey("dbo.PremiseTypes", t => t.PremiseTypeId, cascadeDelete: true)
                .Index(t => t.FiscalYear)
                .Index(t => t.AccountId)
                .Index(t => t.CompanyId)
                .Index(t => t.PremiseTypeId);
            
            CreateTable(
                "dbo.Companies",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 100),
                        Country = c.String(nullable: false, maxLength: 2),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Programmings",
                c => new
                    {
                        FiscalYear = c.Int(nullable: false),
                        BudgetStartDate = c.DateTime(nullable: false),
                        BudgetEndDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.FiscalYear);
            
            CreateTable(
                "dbo.PremiseTypes",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 100),
                        Definition = c.String(nullable: false, storeType: "xml"),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.BudgetSheets",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Package_Id = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Budgets", t => t.Id)
                .ForeignKey("dbo.Packages", t => t.Package_Id)
                .Index(t => t.Id)
                .Index(t => t.Package_Id);
            
            CreateTable(
                "dbo.Budgets",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        FiscalYear = c.Int(nullable: false),
                        Authorized = c.Boolean(nullable: false),
                        CostCenterId = c.Int(nullable: false),
                        CompanyId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Programmings", t => t.FiscalYear, cascadeDelete: true)
                .ForeignKey("dbo.Companies", t => t.CompanyId, cascadeDelete: true)
                .ForeignKey("dbo.CostCenters", t => t.CostCenterId, cascadeDelete: true)
                .Index(t => t.FiscalYear)
                .Index(t => t.CostCenterId)
                .Index(t => t.CompanyId);
            
            CreateTable(
                "dbo.CostCenters",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Code = c.String(nullable: false, maxLength: 50),
                        Name = c.String(nullable: false, maxLength: 50),
                        CompanyId = c.Int(nullable: false),
                        Parent_Id = c.Int(),
                        Responsible_Id = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.CostCenters", t => t.Parent_Id)
                .ForeignKey("dbo.Companies", t => t.CompanyId)
                .ForeignKey("dbo.Employees", t => t.Responsible_Id)
                .Index(t => t.CompanyId)
                .Index(t => t.Parent_Id)
                .Index(t => t.Responsible_Id);
            
            CreateTable(
                "dbo.Employees",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Code = c.String(nullable: false, maxLength: 20),
                        Name = c.String(nullable: false, maxLength: 100),
                        UserId = c.Int(),
                        PositionId = c.Int(nullable: false),
                        Active = c.Boolean(nullable: false),
                        Salary = c.Decimal(nullable: false, precision: 18, scale: 2),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Positions", t => t.PositionId, cascadeDelete: true)
                .Index(t => t.PositionId);
            
            CreateTable(
                "dbo.Positions",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        CompanyId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Companies", t => t.CompanyId, cascadeDelete: true)
                .Index(t => t.CompanyId);
            
            CreateTable(
                "dbo.Countries",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 2),
                        Name = c.String(nullable: false, maxLength: 50),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Equipments",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 50),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Providers",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 50),
                        ProviderType_Id = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.ProviderTypes", t => t.ProviderType_Id, cascadeDelete: true)
                .Index(t => t.ProviderType_Id);
            
            CreateTable(
                "dbo.ProviderTypes",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 50),
                        PremiseType_Id = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.PremiseTypes", t => t.PremiseType_Id, cascadeDelete: true)
                .Index(t => t.PremiseType_Id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Providers", "ProviderType_Id", "dbo.ProviderTypes");
            DropForeignKey("dbo.ProviderTypes", "PremiseType_Id", "dbo.PremiseTypes");
            DropForeignKey("dbo.BudgetSheets", "Package_Id", "dbo.Packages");
            DropForeignKey("dbo.BudgetLines", "SheetId", "dbo.BudgetSheets");
            DropForeignKey("dbo.BudgetSheets", "Id", "dbo.Budgets");
            DropForeignKey("dbo.Budgets", "CostCenterId", "dbo.CostCenters");
            DropForeignKey("dbo.CostCenters", "Responsible_Id", "dbo.Employees");
            DropForeignKey("dbo.Employees", "PositionId", "dbo.Positions");
            DropForeignKey("dbo.Positions", "CompanyId", "dbo.Companies");
            DropForeignKey("dbo.Benefits", "Position_Id", "dbo.Positions");
            DropForeignKey("dbo.Benefits", "Employee_Id", "dbo.Employees");
            DropForeignKey("dbo.CostCenters", "CompanyId", "dbo.Companies");
            DropForeignKey("dbo.CostCenters", "Parent_Id", "dbo.CostCenters");
            DropForeignKey("dbo.Budgets", "CompanyId", "dbo.Companies");
            DropForeignKey("dbo.Budgets", "FiscalYear", "dbo.Programmings");
            DropForeignKey("dbo.BudgetLines", "Premise_Id", "dbo.Premises");
            DropForeignKey("dbo.Premises", "PremiseTypeId", "dbo.PremiseTypes");
            DropForeignKey("dbo.Premises", "FiscalYear", "dbo.Programmings");
            DropForeignKey("dbo.Premises", "CompanyId", "dbo.Companies");
            DropForeignKey("dbo.Premises", "AccountId", "dbo.Accounts");
            DropForeignKey("dbo.BudgetMonthDetails", "IdLine", "dbo.BudgetLines");
            DropForeignKey("dbo.BudgetLines", "Parent_Id", "dbo.BudgetLines");
            DropForeignKey("dbo.BudgetLines", "Account_Id", "dbo.Accounts");
            DropForeignKey("dbo.Accounts", "Package_Id", "dbo.Packages");
            DropForeignKey("dbo.Accounts", "Parent_Id", "dbo.Accounts");
            DropIndex("dbo.ProviderTypes", new[] { "PremiseType_Id" });
            DropIndex("dbo.Providers", new[] { "ProviderType_Id" });
            DropIndex("dbo.Positions", new[] { "CompanyId" });
            DropIndex("dbo.Employees", new[] { "PositionId" });
            DropIndex("dbo.CostCenters", new[] { "Responsible_Id" });
            DropIndex("dbo.CostCenters", new[] { "Parent_Id" });
            DropIndex("dbo.CostCenters", new[] { "CompanyId" });
            DropIndex("dbo.Budgets", new[] { "CompanyId" });
            DropIndex("dbo.Budgets", new[] { "CostCenterId" });
            DropIndex("dbo.Budgets", new[] { "FiscalYear" });
            DropIndex("dbo.BudgetSheets", new[] { "Package_Id" });
            DropIndex("dbo.BudgetSheets", new[] { "Id" });
            DropIndex("dbo.Premises", new[] { "PremiseTypeId" });
            DropIndex("dbo.Premises", new[] { "CompanyId" });
            DropIndex("dbo.Premises", new[] { "AccountId" });
            DropIndex("dbo.Premises", new[] { "FiscalYear" });
            DropIndex("dbo.BudgetMonthDetails", new[] { "IdLine" });
            DropIndex("dbo.BudgetLines", new[] { "Premise_Id" });
            DropIndex("dbo.BudgetLines", new[] { "Parent_Id" });
            DropIndex("dbo.BudgetLines", new[] { "Account_Id" });
            DropIndex("dbo.BudgetLines", new[] { "SheetId" });
            DropIndex("dbo.Benefits", new[] { "Position_Id" });
            DropIndex("dbo.Benefits", new[] { "Employee_Id" });
            DropIndex("dbo.Accounts", new[] { "Package_Id" });
            DropIndex("dbo.Accounts", new[] { "Parent_Id" });
            DropTable("dbo.ProviderTypes");
            DropTable("dbo.Providers");
            DropTable("dbo.Equipments");
            DropTable("dbo.Countries");
            DropTable("dbo.Positions");
            DropTable("dbo.Employees");
            DropTable("dbo.CostCenters");
            DropTable("dbo.Budgets");
            DropTable("dbo.BudgetSheets");
            DropTable("dbo.PremiseTypes");
            DropTable("dbo.Programmings");
            DropTable("dbo.Companies");
            DropTable("dbo.Premises");
            DropTable("dbo.BudgetMonthDetails");
            DropTable("dbo.BudgetLines");
            DropTable("dbo.Benefits");
            DropTable("dbo.Packages");
            DropTable("dbo.Accounts");
        }
    }
}
