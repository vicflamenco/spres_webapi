namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco19 : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.ForecastProgrammings",
                c => new
                    {
                        FiscalYear = c.Int(nullable: false),
                        CompanyId = c.Int(nullable: false),
                        Item = c.Int(nullable: false),
                        StartDate = c.DateTime(),
                        EndDate = c.DateTime(),
                    })
                .PrimaryKey(t => new { t.FiscalYear, t.CompanyId, t.Item })
                .ForeignKey("dbo.Programmings", t => new { t.FiscalYear, t.CompanyId }, cascadeDelete: true)
                .Index(t => new { t.FiscalYear, t.CompanyId });
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.ForecastProgrammings", new[] { "FiscalYear", "CompanyId" }, "dbo.Programmings");
            DropIndex("dbo.ForecastProgrammings", new[] { "FiscalYear", "CompanyId" });
            DropTable("dbo.ForecastProgrammings");
        }
    }
}
