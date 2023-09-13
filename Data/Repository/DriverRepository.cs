using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;

namespace FoodAppApi.Data.Repository
{
    public class DriverRepository : IDriverRepository
    {
        private readonly DatabaseContext _context;
        public DriverRepository(DatabaseContext context)
        {
            _context = context;

        }
        public async Task<List<Driver>> GetDriver()
        {
            var drivers = await _context.Driver.FromSqlInterpolated($"exec GetDriver").ToListAsync();
            return drivers;
        }

        public async Task<Driver> GetDriverByEmail(string email)
        {
            var customer = await _context.Driver.FromSqlInterpolated($"exec GetDriverByEmail @Email={email}").ToListAsync();
            return customer.FirstOrDefault();
        }

        public async Task<Driver> GetDriverByEmailAndPassword(string email, string password)
        {
            var drivers = await _context.Driver.FromSqlInterpolated($"exec GetDriverByEmailAndPassword @Email={email}, @Password={password}").ToListAsync();
            return drivers.FirstOrDefault();
        }

        public async Task<DriverDetails> GetDriverDetails(string driverId)
        {
            var drivers = await _context.Driver.FromSqlInterpolated($"exec GetDriverDetails @DriverId={driverId}").ToListAsync();
            var driver = drivers.FirstOrDefault();
            DriverDetails driverDetails = new DriverDetails();
            if (driver != null)
            {
                var vehicles = await _context.Vehicle.FromSqlInterpolated($"exec GetVehicleByDriverId @DriverId={driverId}").ToListAsync();
                var vehicle = vehicles.FirstOrDefault();
                driverDetails = new DriverDetails
                {
                    Id = driver.Id,
                    DriverId = driver.DriverId,
                    FullName = driver.FullName,
                    DriversPhoto = vehicle?.DriversPhoto,
                    CarDescription = vehicle?.CarDescription,
                    CarPhoto = vehicle?.CarPhoto,
                    CarRegistration = vehicle?.CarRegistration,
                    ContactNo = !string.IsNullOrEmpty(driver?.Phone) ? "+" + driver?.CountryCode + driver?.Phone : "",
                };
            }
            return driverDetails;
        }

        public async Task<int> Insert(Driver driver)
        {
            var exist = _context.Driver.Any(x => x.Email == driver.Email);
            if (exist)
            {
                return 2;
            }
            string referralCode = string.Empty;
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertDriver @DriverId={driver.DriverId}, @FullName={driver.FullName}, @Username={driver.Username}, @Email={driver.Email}, @Password={driver.Password}, @Phone={driver.Phone}, @DateOfBirth={driver.DateOfBirth}, @Gender={driver.Gender}, @AccountPreferences={driver.AccountPreferences}, @TermsAndCondition={driver.TermsAndCondition}, @Image={driver.Image}, @ReferralCode={referralCode}, @CountryCode={driver.CountryCode}, @Country={driver.Country}");
            return affectedRows;
        }

        public async Task<int> Update(Driver driver)
        {
            var exist = _context.Driver.Any(x => x.Email == driver.Email && x.DriverId != driver.DriverId);
            if (exist)
            {
                return 2;
            }

            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateDriver @DriverId={driver.DriverId}, @FullName={driver.FullName}, @Username={driver.Username}, @Email={driver.Email}, @Password={driver.Password}, @Phone={driver.Phone}, @DateOfBirth={driver.DateOfBirth}, @Gender={driver.Gender}, @AccountPreferences={driver.AccountPreferences}, @TermsAndCondition={driver.TermsAndCondition}, @Image={driver.Image}, @CountryCode={driver.CountryCode}, @Country={driver.Country}");
            return affectedRows;
        }
    }
}
