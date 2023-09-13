using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface IOrderItemRepository
    {
        Task<List<OrderItem>> GetOrderItemByOrderId(string OrderId);
        Task<int> InsertOrderItem(List<OrderItem> customer);
    }
}
