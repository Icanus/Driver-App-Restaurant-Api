using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface IReferralRewardsRepository
    {
        public Task<int> CreateRewards(string customerId);
        public Task<ReferralRewardsParam> GetRewards(string CustomerId);
        public Task<int> UpdateBalance(string customerId, double balance);
    }
}
