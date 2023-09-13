using FoodAppApi.Data.Interfaces;
using FoodAppApi.Data.Migrations;
using FoodAppApi.Models;
using Microsoft.EntityFrameworkCore;

namespace FoodAppApi.Data.Repository
{
    public class FeedbackRepository : IFeedbackRepository
    {
        private readonly DatabaseContext _context;
        public FeedbackRepository(DatabaseContext context)
        {
            _context = context;
        }

        public async Task<FeedBack> GetFeedbackByOrderId(string OrderId)
        {
            var feedback = await _context.FeedBack.FromSqlInterpolated($"exec GetFeedbackByOrderId {OrderId}").ToListAsync();
            return feedback.FirstOrDefault();
        }

        public async Task<int> InsertFeedback(FeedBack feedback)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertFeedback @FeedbackId={feedback.FeedbackId}, @CustomerId={feedback.CustomerId}, @OrderId={feedback.OrderId}, @Rating={feedback.Rating}, @Comment={feedback.Comment}, @IsFeedBackAvailable={feedback.IsFeedBackAvailable}");
            return affectedRows;
        }

        public async Task<int> UpdateFeedback(FeedBack feedback)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateFeedback @FeedbackId={feedback.FeedbackId}, @CustomerId={feedback.CustomerId}, @OrderId={feedback.OrderId}, @Rating={feedback.Rating}, @Comment={feedback.Comment}, @IsFeedBackAvailable={feedback.IsFeedBackAvailable}");
            return affectedRows;
        }
    }
}
