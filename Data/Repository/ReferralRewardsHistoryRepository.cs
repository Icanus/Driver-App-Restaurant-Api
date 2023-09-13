using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;

namespace FoodAppApi.Data.Repository
{
    public class ReferralRewardsHistoryRepository : IReferralRewardsHistoryRepository
    {
        private readonly DatabaseContext _context;
        public ReferralRewardsHistoryRepository(DatabaseContext context)
        {
            _context = context;
        }
        public async Task<int> CreateHistory(ReferralRewardsHistory history)
        {
        var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertRewardHistory @ReferralId={history.ReferralId}, @ReferrerId={history.ReferrerId}, @RefereeId={history.RefereeId}, @OrderId={history.OrderId}, @ActionType={history.ActionType}, @Description={history.Description}, @AddedBalance={history.AddedBalance}, @AddedDate={history.AddedDate}");
            return affectedRows;
        }

        public async Task<List<ReferralRewardsHistory>> GetHistory(string referralId)
        {
            var history = await _context.ReferralRewardsHistory.FromSqlInterpolated($"exec GetRewardsHistory @ReferralId={referralId}").ToListAsync();
            return history;
        }

    }
}
