namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco12 : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.BudgetMonthDetails", "UnitCost", c => c.Decimal(nullable: false, storeType: "money"));
            AlterColumn("dbo.BudgetMonthDetails", "Target", c => c.Decimal(nullable: false, storeType: "money"));
            AlterColumn("dbo.BudgetMonthDetails", "Forecast", c => c.Decimal(nullable: false, storeType: "money"));
            AlterColumn("dbo.BudgetMonthDetails", "Real", c => c.Decimal(nullable: false, storeType: "money"));
            AlterColumn("dbo.ExchangeRates", "Rate", c => c.Decimal(nullable: false, storeType: "money"));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.ExchangeRates", "Rate", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AlterColumn("dbo.BudgetMonthDetails", "Real", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AlterColumn("dbo.BudgetMonthDetails", "Forecast", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AlterColumn("dbo.BudgetMonthDetails", "Target", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AlterColumn("dbo.BudgetMonthDetails", "UnitCost", c => c.Decimal(nullable: false, precision: 18, scale: 2));
        }
    }
}
