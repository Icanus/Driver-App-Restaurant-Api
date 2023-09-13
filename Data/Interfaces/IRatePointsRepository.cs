using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface IRatePointsRepository
    {
        Task<int> InsertUpdateRatePoints(RatePoints ratePoints);
        Task<RatePoints> GetRatePoints();
    }
}
