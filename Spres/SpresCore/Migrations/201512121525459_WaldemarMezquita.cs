namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class WaldemarMezquita : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Permissions",
                c => new
                    {
                        RolId = c.Int(nullable: false),
                        Option = c.Int(nullable: false),
                        View = c.Boolean(nullable: false),
                        Edit = c.Boolean(nullable: false),
                        Process = c.Boolean(nullable: false),
                        CostCenterFilter = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => new { t.RolId, t.Option });
            
        }
        
        public override void Down()
        {
            DropTable("dbo.Permissions");
        }
    }
}
