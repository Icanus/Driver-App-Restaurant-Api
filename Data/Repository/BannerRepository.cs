using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;

namespace FoodAppApi.Data.Repository
{
    public class BannerRepository : IBannerRepository
    {
        private readonly DatabaseContext _context;
        public BannerRepository(DatabaseContext context)
        {
            _context = context;
        }

        public async Task<List<Banner>> GetBanners()
        {
            var banners = await _context.Banner.FromSqlInterpolated($"exec GetBanners").ToListAsync();
            return banners;
        }

        public async Task<int> InsertBanner(Banner banner)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertBanner @Image={banner.Image}");
            return affectedRows;
        }

        public async Task<int> UpdateBanner(Banner banner)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateBanner @Id={banner.Id}, @Image={banner.Image}");
            return affectedRows;
        }
    }
}
