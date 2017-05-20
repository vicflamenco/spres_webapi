namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco16 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Benefits", "Value", c => c.Decimal(nullable: false, precision: 18, scale: 2));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Benefits", "Value");
        }
    }
}
