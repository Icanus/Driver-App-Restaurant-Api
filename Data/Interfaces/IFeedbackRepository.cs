using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface IFeedbackRepository
    {
        Task<FeedBack> GetFeedbackByOrderId(string OrderId);
        Task<int> InsertFeedback(FeedBack customer);
        Task<int> UpdateFeedback(FeedBack customer);
    }
}
