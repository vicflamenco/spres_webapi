namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class GustavoRauda1 : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Accounts", "Package_Id", "dbo.Packages");
            DropIndex("dbo.Accounts", new[] { "Package_Id" });
            CreateTable(
                "dbo.PackageAccounts",
                c => new
                    {
                        Package_Id = c.Int(nullable: false),
                        Account_Id = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.Package_Id, t.Account_Id })
                .ForeignKey("dbo.Packages", t => t.Package_Id, cascadeDelete: true)
                .ForeignKey("dbo.Accounts", t => t.Account_Id, cascadeDelete: true)
                .Index(t => t.Package_Id)
                .Index(t => t.Account_Id);
            
            DropColumn("dbo.Accounts", "Package_Id");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Accounts", "Package_Id", c => c.Int());
            DropForeignKey("dbo.PackageAccounts", "Account_Id", "dbo.Accounts");
            DropForeignKey("dbo.PackageAccounts", "Package_Id", "dbo.Packages");
            DropIndex("dbo.PackageAccounts", new[] { "Account_Id" });
            DropIndex("dbo.PackageAccounts", new[] { "Package_Id" });
            DropTable("dbo.PackageAccounts");
            CreateIndex("dbo.Accounts", "Package_Id");
            AddForeignKey("dbo.Accounts", "Package_Id", "dbo.Packages", "Id");
        }
    }
}
