using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface IFavoriteRepository
    {
        public Task<List<Favorite>> GetFavorites(string CustomerId);
        public Task<int> InsertFavorite(Favorite favorite);
        public Task<int> DeleteFavorite(string FavoriteId);
    }
}
