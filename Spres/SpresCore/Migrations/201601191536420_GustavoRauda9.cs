namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class GustavoRauda9 : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Events",
                c => new
                    {
                        Id = c.Long(nullable: false),
                        Type = c.Int(nullable: false),
                        UserId = c.String(nullable: false, maxLength: 128),
                        Source = c.String(),
                        Description = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.Events");
        }
    }
}
