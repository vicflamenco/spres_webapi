namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class CarlosPortillo4 : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Premises", "Expenses", c => c.String(storeType: "xml"));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.Premises", "Expenses", c => c.String());
        }
    }
}
