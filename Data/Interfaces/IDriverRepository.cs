using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface IDriverRepository
    {
        Task<List<Driver>> GetDriver();
        Task<DriverDetails> GetDriverDetails(string driverId);
        Task<Driver> GetDriverByEmail(string email);
        Task<Driver> GetDriverByEmailAndPassword(string email, string password);
        Task<int> Insert(Driver customer);
        Task<int> Update(Driver customer);
    }
}
