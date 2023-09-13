using FoodAppApi.Data.Interfaces;
using FoodAppApi.Data.Migrations;
using FoodAppApi.Models;

namespace FoodAppApi.Data.Repository
{
    public class RatePointsRepository : IRatePointsRepository
    {
        private readonly DatabaseContext _context;
        public RatePointsRepository(DatabaseContext context)
        {
            _context = context;
        }
        public async Task<RatePoints> GetRatePoints()
        {
            var res = await _context.RatePoints.FromSqlInterpolated($"exec GetRatePoints").ToListAsync();
            return res.FirstOrDefault();
        }

        public async Task<int> InsertUpdateRatePoints(RatePoints ratePoints)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertOrUpdateRatePoints @RatePoints={ratePoints.Rate}");
            return affectedRows;
        }
    }
}
