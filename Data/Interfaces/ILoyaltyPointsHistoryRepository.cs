using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface ILoyaltyPointsHistoryRepository
    {
        Task<int> CreateHistory(LoyaltyPointsHistory history);
        Task<List<LoyaltyPointsHistory>> GetHistory(string loyaltyId);
        Task<LoyaltyPointsHistory> GetHistoryByOrderId(string orderId);
    }
}
