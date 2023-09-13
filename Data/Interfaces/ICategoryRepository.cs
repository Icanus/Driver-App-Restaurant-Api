using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface IBannerRepository
    {
        public Task<List<Banner>> GetBanners();
        public Task<int> InsertBanner(Banner category);
        public Task<int> UpdateBanner(Banner category);
    }
}
