using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;

namespace FoodAppApi.Data.Repository
{
    public class FavoriteRepository : IFavoriteRepository
    {
        private readonly DatabaseContext _context;
        public FavoriteRepository(DatabaseContext context)
        {
            _context = context;
        }

        public async Task<List<Favorite>> GetFavorites(string CustomerId)
        {
            var favorites = await _context.Favorite.FromSqlInterpolated($"exec GetFavoriteByCustomerId {CustomerId}").ToListAsync();
            return favorites;
        }

        public async Task<int> InsertFavorite(Favorite favorite)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertFavorite @FavoriteId={favorite.FavoriteId}, @CustomerId={favorite.CustomerId}, @ItemId={favorite.ItemId}");
            return affectedRows;
        }

        public async Task<int> DeleteFavorite(string FavoriteId)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec DeleteFavorite @FavoriteId={FavoriteId}");
            return affectedRows;
        }
    }
}
