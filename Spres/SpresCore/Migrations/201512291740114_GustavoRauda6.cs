namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class GustavoRauda6 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Employees", "Variable", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AddColumn("dbo.Employees", "LifeInsurance", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AlterColumn("dbo.Benefits", "Code", c => c.String(nullable: false, maxLength: 30));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.Benefits", "Code", c => c.String(nullable: false, maxLength: 4000));
            DropColumn("dbo.Employees", "LifeInsurance");
            DropColumn("dbo.Employees", "Variable");
        }
    }
}
