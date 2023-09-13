using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FoodAppApi.Data.Migrations
{
    /// <inheritdoc />
    public partial class ChangeAddressMigation : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<double>(
                name: "AdditionalFee",
                table: "Order",
                type: "float",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ChangeAddress",
                table: "Order",
                type: "nvarchar(255)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ChangeAddressLat",
                table: "Order",
                type: "nvarchar(255)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ChangeAddressLon",
                table: "Order",
                type: "nvarchar(255)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ChangeAddressTitle",
                table: "Order",
                type: "nvarchar(255)",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsChangeAddress",
                table: "Order",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AdditionalFee",
                table: "Order");

            migrationBuilder.DropColumn(
                name: "ChangeAddress",
                table: "Order");

            migrationBuilder.DropColumn(
                name: "ChangeAddressLat",
                table: "Order");

            migrationBuilder.DropColumn(
                name: "ChangeAddressLon",
                table: "Order");

            migrationBuilder.DropColumn(
                name: "ChangeAddressTitle",
                table: "Order");

            migrationBuilder.DropColumn(
                name: "IsChangeAddress",
                table: "Order");
        }
    }
}
