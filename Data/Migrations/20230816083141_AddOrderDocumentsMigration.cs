using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FoodAppApi.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddOrderDocumentsMigration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "OrderDocuments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    OrderId = table.Column<string>(type: "nvarchar(255)", nullable: false),
                    OnTheWayImage = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    OnTheWayImageTime = table.Column<DateTime>(type: "datetime2", nullable: true),
                    DeliveredImage = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DeliveredImageTime = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CancelledImage = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CancelledImageTime = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CancelledReason = table.Column<string>(type: "nvarchar(255)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OrderDocuments", x => x.Id);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "OrderDocuments");
        }
    }
}
