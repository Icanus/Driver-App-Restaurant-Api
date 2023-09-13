using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System.Threading;

namespace FoodAppApi.Data.Repository
{
    public class VehicleRepository : IVehicleRepository
    {
        private readonly DatabaseContext _context;
        public VehicleRepository(DatabaseContext context)
        {
            _context = context;
        }
        public async Task<Vehicle> GetVehicleByDriverId(string driverId)
        {
            var vehicle = await _context.Vehicle.FromSqlInterpolated($"exec GetVehicleByDriverId @DriverId={driverId}").ToListAsync();
            return vehicle.FirstOrDefault();
        }

        public async Task<int> InsertOrUpdateVehicle(Vehicle vehicle)
        {
            var resultParameter = new SqlParameter("@Result", System.Data.SqlDbType.Int)
            {
                Direction = System.Data.ParameterDirection.Output
            };
            await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpsertVehicle @DriverId={vehicle.DriverId}, @CarDescription={vehicle.CarDescription}, @CarRegistration={vehicle.CarRegistration}, @DriversPhoto={vehicle.DriversPhoto}, @CarPhoto={vehicle.CarPhoto}, @Result = {resultParameter} OUTPUT");
            return (int)resultParameter.Value; ;
        }
    }
}
