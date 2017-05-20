namespace Spres.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class VictorFlamenco2 : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Benefits", "Position_Id", "dbo.Positions");
            DropIndex("dbo.Benefits", new[] { "Position_Id" });
            CreateTable(
                "dbo.PositionEquipments",
                c => new
                    {
                        Position_Id = c.Int(nullable: false),
                        Equipment_Id = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.Position_Id, t.Equipment_Id })
                .ForeignKey("dbo.Positions", t => t.Position_Id, cascadeDelete: true)
                .ForeignKey("dbo.Equipments", t => t.Equipment_Id, cascadeDelete: true)
                .Index(t => t.Position_Id)
                .Index(t => t.Equipment_Id);
            
            DropColumn("dbo.Benefits", "Position_Id");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Benefits", "Position_Id", c => c.Int());
            DropForeignKey("dbo.PositionEquipments", "Equipment_Id", "dbo.Equipments");
            DropForeignKey("dbo.PositionEquipments", "Position_Id", "dbo.Positions");
            DropIndex("dbo.PositionEquipments", new[] { "Equipment_Id" });
            DropIndex("dbo.PositionEquipments", new[] { "Position_Id" });
            DropTable("dbo.PositionEquipments");
            CreateIndex("dbo.Benefits", "Position_Id");
            AddForeignKey("dbo.Benefits", "Position_Id", "dbo.Positions", "Id");
        }
    }
}
