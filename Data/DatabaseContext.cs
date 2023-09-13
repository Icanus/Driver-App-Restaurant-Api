using FoodAppApi.Models;
using Microsoft.EntityFrameworkCore;

namespace FoodAppApi.Data
{
    public class DatabaseContext : DbContext
    {
        public DatabaseContext(DbContextOptions<DatabaseContext> options)
            : base(options)
        {

        }
        public DbSet<Customer> Customer {get;set; }
        public DbSet<Category> Category { get; set; }
        public DbSet<Address> Address { get; set; }
        public DbSet<Banner> Banner { get; set; }
        public DbSet<Favorite> Favorite { get; set; }
        public DbSet<Item> Item { get; set; }
        public DbSet<Order> Order { get; set; }
        public DbSet<OrderItem> OrderItem { get; set; }
        public DbSet<FeedBack> FeedBack { get; set; }
        public DbSet<CustomerLoyaltyPoints> CustomerLoyaltyPoints { get; set; }
        public DbSet<LoyaltyPointsHistory> LoyaltyPointsHistory { get; set; }
        public DbSet<RatePoints> RatePoints { get; set; }
        public DbSet<Referrals> Referrals { get; set; }
        public DbSet<ReferralRewards> ReferralRewards { get; set; }
        public DbSet<ReferralRewardsHistory> ReferralRewardsHistory { get; set; }
        public DbSet<SMTPConfig> SMTPConfig { get; set; }
        public DbSet<Driver> Driver { get; set; }
        public DbSet<OrderDocuments> OrderDocuments { get; set; }
        public DbSet<Vehicle> Vehicle { get; set; }
    }
}
