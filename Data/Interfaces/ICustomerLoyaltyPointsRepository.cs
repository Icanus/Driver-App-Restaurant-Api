using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface ICustomerLoyaltyPointsRepository
    {
        public Task<int> CreateLoyaltyPoints(CustomerLoyaltyPoints customerLoyaltyPoints);
        public Task<int> TransferLoyaltyPoints(string CustomerId, string SenderName, string Email, LoyaltyPointsHistory history);
        public Task<CustomerLoyaltyPointsParam> GetLoyaltyPoints(string CustomerId, string LoyaltyId);
        public Task<CustomerLoyaltyPoints> GetActiveLoyaltyPoints(string CustomerId);
        public Task<int> UpdateLoyaltyBalance(CustomerLoyaltyPoints customerLoyaltyPoints);
        public Task<int> SubtractLoyaltyBalance(CustomerLoyaltyPoints customerLoyaltyPoints);
    }
}
