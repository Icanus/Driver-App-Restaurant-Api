using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface IVehicleRepository
    {
        Task<Vehicle> GetVehicleByDriverId(string driverId);
        Task<int> InsertOrUpdateVehicle(Vehicle vehicle);
    }
}
