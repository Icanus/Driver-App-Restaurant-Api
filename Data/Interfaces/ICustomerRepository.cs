using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface ICustomerRepository
    {
        Task<List<Customer>> GetCustomers();
        Task<Customer> GetCustomerByEmailAndPassword(string email, string password);
        Task<Customer> GetCustomerByEmail(string email);
        Task<int> InsertCustomer(Customer customer);
        Task<int> UpdateCustomer(Customer customer);
        public Task<string> GenerateReferralCode();
        Task<CustomerDetails> GetCustomerDetails(string customerId);
    }
}
