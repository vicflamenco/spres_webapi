namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco17 : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.EmailTemplates",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        Subject = c.String(),
                        Body = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.EmailTemplates");
        }
    }
}
