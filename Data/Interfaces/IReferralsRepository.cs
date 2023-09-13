using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface IReferralsRepository
    {
        Task<Referrals> CheckForReferrals(string customerId);
        Task<List<Referrals>> GetReferrals(string customerId);
        Task<Referrals> GetReferralsByOrderId(string orderId);
        Task<int> InsertReferral(Referrals referrals);
        Task<int> UpdateReferral(string RefereeId, string refereeEmail);
        Task<int> updateReferralBalance(string RefereeId, string ReferrerId);
        Task<int> CheckIFReferralCodeExists(string ReferralCode);
        Task<ReferralRewardsParam> GetReferralReward(string customerId);
        Task<int> UpdateReferralRewards(string customerId, double balance);

    }
}
