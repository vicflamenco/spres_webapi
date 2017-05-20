namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco6 : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Employees", "UserId", c => c.String(maxLength: 255));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.Employees", "UserId", c => c.Int());
        }
    }
}
