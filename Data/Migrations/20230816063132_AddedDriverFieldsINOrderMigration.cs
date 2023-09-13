using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FoodAppApi.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddedDriverFieldsINOrderMigration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "DriverId",
                table: "Order",
                type: "nvarchar(255)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "DriverLat",
                table: "Order",
                type: "nvarchar(255)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "DriverLon",
                table: "Order",
                type: "nvarchar(255)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DriverId",
                table: "Order");

            migrationBuilder.DropColumn(
                name: "DriverLat",
                table: "Order");

            migrationBuilder.DropColumn(
                name: "DriverLon",
                table: "Order");
        }
    }
}
