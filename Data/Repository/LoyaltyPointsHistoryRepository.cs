using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
namespace FoodAppApi.Data.Repository
{
    public class LoyaltyPointsHistoryRepository : ILoyaltyPointsHistoryRepository
    {
        private readonly DatabaseContext _context;
        public LoyaltyPointsHistoryRepository(DatabaseContext context)
        {
            _context = context;
        }
        public async Task<int> CreateHistory(LoyaltyPointsHistory history)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertLoyaltyPointsHistory @OrderId={history.OrderId}, @LoyaltyId={history.LoyaltyId}, @TotalAmount={history.TotalAmount}, @AddedBalance={history.AddedBalance}, @AddedDate={history.AddedDate}, @TransferId={history.TransferId}, @ActionType={history.ActionType}, @Description={history.Description}, @ReferenceId={history.ReferenceId}");
            return affectedRows;
        }

        public async Task<List<LoyaltyPointsHistory>> GetHistory(string loyaltyId)
        {
            var history = await _context.LoyaltyPointsHistory.FromSqlInterpolated($"exec GetLoyaltyPointsHistory {loyaltyId}").ToListAsync();
            return history;
        }

        public async Task<LoyaltyPointsHistory> GetHistoryByOrderId(string orderId)
        {
            var history = await _context.LoyaltyPointsHistory.FromSqlInterpolated($"exec GetLoyaltyPointsHistoryByOrderId @OrderId={orderId}").ToListAsync();
            return history.FirstOrDefault();
        }
    }
}
