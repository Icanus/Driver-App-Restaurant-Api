using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface IAddressRepository
    {
        public Task<List<Address>> GetAddressByCustomerId(string customerId);
        public Task<int> InsertAddress(Address category);
        public Task<int> UpdateAddress(string id, Address category);
    }
}
