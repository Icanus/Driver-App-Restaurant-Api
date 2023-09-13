using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface IReferralRewardsHistoryRepository
    {
        Task<int> CreateHistory(ReferralRewardsHistory history);
        Task<List<ReferralRewardsHistory>> GetHistory(string loyaltyId);
    }
}
