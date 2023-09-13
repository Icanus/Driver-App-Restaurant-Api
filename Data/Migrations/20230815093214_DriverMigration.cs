using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FoodAppApi.Data.Migrations
{
    /// <inheritdoc />
    public partial class DriverMigration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Driver",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DriverId = table.Column<string>(type: "nvarchar(255)", nullable: false),
                    FullName = table.Column<string>(type: "nvarchar(255)", nullable: false),
                    ReferralCode = table.Column<string>(type: "nvarchar(255)", nullable: false),
                    Username = table.Column<string>(type: "nvarchar(255)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(255)", nullable: false),
                    CountryCode = table.Column<string>(type: "nvarchar(255)", nullable: true),
                    Country = table.Column<string>(type: "nvarchar(255)", nullable: true),
                    Phone = table.Column<string>(type: "nvarchar(255)", nullable: true),
                    Password = table.Column<string>(type: "nvarchar(255)", nullable: true),
                    DateOfBirth = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Gender = table.Column<string>(type: "nvarchar(255)", nullable: true),
                    AccountPreferences = table.Column<string>(type: "nvarchar(255)", nullable: true),
                    TermsAndCondition = table.Column<bool>(type: "bit", nullable: false),
                    Image = table.Column<string>(type: "nvarchar(255)", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    UpdatedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Driver", x => x.Id);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Driver");
        }
    }
}
