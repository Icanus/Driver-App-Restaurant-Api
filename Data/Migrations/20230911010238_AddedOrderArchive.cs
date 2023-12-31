﻿using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FoodAppApi.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddedOrderArchive : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsArchive",
                table: "Order",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsArchive",
                table: "Order");
        }
    }
}
