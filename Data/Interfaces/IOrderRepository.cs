using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface IOrderRepository
    {
        Task<Orders> GetOrderDetails(string CustomerId, string OrderId);
        Task<List<Orders>> GetOrderByCustomerId(string CustomerId);
        Task<List<Orders>> GetOngoingOrderByCustomerId(string CustomerId);
        Task<int> InsertOrder(Orders customer, bool isDeductRewards);
        Task<int> UpdateOrderStatus(string OrderId, string OrderStatus);
        Task<int> GetMaxOrderId();
        Task<int> CheckIfFirstPurchase(string ReferrerId, string customerId);
        Task<int> CheckIfFirstPurchaseV2(string customerId);
        Task<int> UpdateOrderSetDriverId(string driverId, string orderId, string Lon, string Lat);
        Task<int> UpdateOrderLocationByDriverId(string driverId, string orderId, string Lon, string Lat);
        Task<List<Orders>> GetOpenOrders(int lastSyncId);
        Task<List<Orders>> GetDeletedOpenOrders(int lastSyncId);
        Task<List<Orders>> GetOrdersByDriverId(string driverId);
        Task<List<Orders>> GetOngoingOrdersByDriverId(string driverId);
        Task<int> UpdateOrderAddressByOrderId(string orderId, ChangeAddressModel model);
        Task<int> AcceptAddressChange(string orderId, string driverId);
        Task<int> ArchiveOrder(string type, string OrderIds);
    }
}
