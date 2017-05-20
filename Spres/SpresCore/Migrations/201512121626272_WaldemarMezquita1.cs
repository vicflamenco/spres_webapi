namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class WaldemarMezquita1 : DbMigration
    {
        public override void Up()
        {
            DropPrimaryKey("dbo.Permissions");
            AlterColumn("dbo.Permissions", "RolId", c => c.String(nullable: false, maxLength: 128));
            AddPrimaryKey("dbo.Permissions", new[] { "RolId", "Option" });
        }
        
        public override void Down()
        {
            DropPrimaryKey("dbo.Permissions");
            AlterColumn("dbo.Permissions", "RolId", c => c.Int(nullable: false));
            AddPrimaryKey("dbo.Permissions", new[] { "RolId", "Option" });
        }
    }
}
