using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;

namespace FoodAppApi.Data.Repository
{
    public class ReferralRewardsRepository : IReferralRewardsRepository
    {
        private readonly DatabaseContext _context;
        private readonly IReferralRewardsHistoryRepository _historyRepository;
        public ReferralRewardsRepository(DatabaseContext context, IReferralRewardsHistoryRepository referralRewardsHistory)
        {
            _context = context;
            _historyRepository = referralRewardsHistory;
        }
        public async Task<int> CreateRewards(string customerId)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertReferralRewards @ReferralId={customerId}");
            return affectedRows;
        }

        public async Task<ReferralRewardsParam> GetRewards(string CustomerId)
        {
            var referralRewards = await _context.ReferralRewards.FromSqlInterpolated($"exec GetRewardsByCustomerId @ReferralId={CustomerId}").ToListAsync();
            var reward = referralRewards.FirstOrDefault();
            if (reward?.ReferralId != null)
            {
                string referralCode = null;
                try
                {
                    var resu = await _context.Customer.Where(x => x.CustomerId == reward.ReferralId).ToListAsync();
                    referralCode = resu.FirstOrDefault().ReferralCode;
                }
                catch(Exception e)
                {

                }
                var ords = new ReferralRewardsParam
                {
                    Id = reward.Id,
                    ReferralId = reward.ReferralId,
                    Balance = reward.Balance,
                    IsTerminated = reward.IsTerminated,
                    CreatedAt = reward.CreatedAt,
                    UpdatedAt = reward.UpdatedAt,
                    ReferralRewardsHistory = await _historyRepository.GetHistory(reward.ReferralId),
                    ReferralCode = referralCode
                };
                return ords;
            }
            return new ReferralRewardsParam();
        }

        public async Task<int> UpdateBalance(string customerId, double balance)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateRewards @ReferralId={customerId}, @Balance={balance}");
            return affectedRows;
        }
    }
}
