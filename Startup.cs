using FoodAppApi.Data;
using FoodAppApi.Data.Interfaces;
using FoodAppApi.Data.Repository;
using FoodAppApi.Service;
using Handy.DotNETCoreCompatibility.ColourTranslations;
using Microsoft.AspNetCore.ResponseCompression;
using Microsoft.OpenApi.Models;

namespace FoodAppApi
{
    public class Startup
    {
        private readonly IConfiguration _configuration;

        public Startup(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public void ConfigureServices(IServiceCollection services)
        {
            // Configure application services here
            services.AddEndpointsApiExplorer();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo
                {
                    Title = "FoodAppAPI",
                    Version = "v1",
                    Description = "Food app/DineDash api",
                });
            });
            services.AddDbContext<DatabaseContext>(options =>
            {
                options.UseSqlServer(_configuration.GetConnectionString("SqlServer"));
            });
            services.AddControllers();
            services.AddResponseCompression(opts =>
            {
                opts.MimeTypes = ResponseCompressionDefaults.MimeTypes.Concat(
                   new[] { "application/octet-stream" });
            });
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            services.AddScoped<ICustomerRepository, CustomerRepository>();
            services.AddScoped<ICategoryRepository, CategoryRepository>();
            services.AddScoped<IAddressRepository, AddressRepository>();
            services.AddScoped<IBannerRepository, BannerRepository>();
            services.AddScoped<IFavoriteRepository, FavoriteRepository>();
            services.AddScoped<IItemRepository, ItemRepository>();
            services.AddScoped<IOrderRepository, OrderRepository>();
            services.AddScoped<IOrderItemRepository, OrderItemRepository>();
            services.AddScoped<IFeedbackRepository, FeedbackRepository>();
            services.AddScoped<ICustomerLoyaltyPointsRepository, CustomerLoyaltyPointsRepository>();
            services.AddScoped<ILoyaltyPointsHistoryRepository, LoyaltyPointsHistoryRepository>();
            services.AddScoped<IRatePointsRepository, RatePointsRepository>();
            services.AddScoped<IReferralsRepository, ReferralsRepository>(); //for customer referrals reference
            services.AddScoped<IReferralRewardsRepository, ReferralRewardsRepository>(); //for gaining rewards as a referrer
            services.AddScoped<IReferralRewardsHistoryRepository, ReferralRewardsHistoryRepository>(); // for rewards history
            services.AddScoped<ISMTPRepository, SMTPRepository>();
            services.AddScoped<IDriverRepository, DriverRepository>();
            services.AddScoped<IOrderDocumentsRepository, OrderDocumentsRepository>();
            services.AddScoped<IVehicleRepository, VehicleRepository>();
            services.AddSignalR();
            // Add other services as needed
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            app.UseResponseCompression();
            // Configure the HTTP request pipeline.
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "FoodAppApiV1"));
            }
            app.UseHttpsRedirection();
            app.UseRouting();
            app.UseAuthorization();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
                endpoints.MapHub<OrderHub>("ChatHub");
            });
        }
    }

}
