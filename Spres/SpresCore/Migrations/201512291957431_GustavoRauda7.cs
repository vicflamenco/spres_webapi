namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class GustavoRauda7 : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Currencies",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 3),
                        Name = c.String(nullable: false, maxLength: 50),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.ExchangeRates",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        CurrencyId = c.String(nullable: false, maxLength: 3),
                        TradeDate = c.DateTime(nullable: false),
                        Rate = c.Decimal(nullable: false, precision: 18, scale: 2),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Currencies", t => t.CurrencyId, cascadeDelete: true)
                .Index(t => t.CurrencyId);
            
            AddColumn("dbo.Countries", "DefaultCurrencyId", c => c.String(nullable: false, maxLength: 3));
            CreateIndex("dbo.Countries", "DefaultCurrencyId");
            AddForeignKey("dbo.Countries", "DefaultCurrencyId", "dbo.Currencies", "Id", cascadeDelete: true);
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.ExchangeRates", "CurrencyId", "dbo.Currencies");
            DropForeignKey("dbo.Countries", "DefaultCurrencyId", "dbo.Currencies");
            DropIndex("dbo.ExchangeRates", new[] { "CurrencyId" });
            DropIndex("dbo.Countries", new[] { "DefaultCurrencyId" });
            DropColumn("dbo.Countries", "DefaultCurrencyId");
            DropTable("dbo.ExchangeRates");
            DropTable("dbo.Currencies");
        }
    }
}
