using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface IOrderDocumentsRepository
    {
        Task<int> CreateOrderDocuments(string orderId);
        Task<OrderDocuments> GetOrderDocuments(string orderId);
        Task<int> UpdateOrderDocuments(int type, OrderDocuments docs);
    }
}
