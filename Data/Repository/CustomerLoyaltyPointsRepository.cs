using FoodAppApi.Data.Interfaces;
using FoodAppApi.Data.Migrations;
using FoodAppApi.Models;

namespace FoodAppApi.Data.Repository
{
    public class CustomerLoyaltyPointsRepository : ICustomerLoyaltyPointsRepository
    {
        private readonly DatabaseContext _context;
        private readonly ILoyaltyPointsHistoryRepository loyaltyPointsHistory;
        private readonly ICustomerRepository customerRepository;
        public CustomerLoyaltyPointsRepository(DatabaseContext context, ILoyaltyPointsHistoryRepository history, ICustomerRepository _customerRepository)
        {
            _context = context;
            loyaltyPointsHistory = history;
            customerRepository = _customerRepository;
        }
        public async Task<int> CreateLoyaltyPoints(CustomerLoyaltyPoints customerLoyaltyPoints)
        {
            var exist = _context.CustomerLoyaltyPoints.Any(x => x.CustomerId == customerLoyaltyPoints.CustomerId && x.ExpirationDate <= DateTime.Now);
            if (exist)
            {
                return 2;
            }
            //DateTime expirationDate = DateTime.Now.AddYears(1);
            DateTime currentDateTime = DateTime.Now;

            // Calculate the end date and time of the current year
            DateTime endOfYearDateTime = new DateTime(currentDateTime.Year, 12, 31, 23, 59, 59, 999);
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertCustomerLoyaltyPoints @LoyaltyId={customerLoyaltyPoints.LoyaltyId}, @CustomerId={customerLoyaltyPoints.CustomerId}, @Balance={customerLoyaltyPoints.Balance}, @TermsAndAgreement={customerLoyaltyPoints.TermsAndAgreement}, @IsTerminated={customerLoyaltyPoints.IsTerminated}, @ExpirationDate={endOfYearDateTime}");
            return affectedRows;
        }

        public async Task<CustomerLoyaltyPoints> GetActiveLoyaltyPoints(string CustomerId)
        {
            var customerLoyaltyPoints = await _context.CustomerLoyaltyPoints.FromSqlInterpolated($"exec GetActiveCustomerLoyaltyPointsByCustomerId @CustomerId={CustomerId}").ToListAsync();
            return customerLoyaltyPoints.FirstOrDefault();
        }

        public async Task<CustomerLoyaltyPointsParam> GetLoyaltyPoints(string CustomerId, string LoyaltyId)
        {
            var customerLoyaltyPoints = await _context.CustomerLoyaltyPoints.FromSqlInterpolated($"exec GetLoyaltyPointsByCustomerId @LoyaltyId={LoyaltyId}, @CustomerId={CustomerId}").ToListAsync();
            var history = await loyaltyPointsHistory.GetHistory(LoyaltyId);
            var customerLoyalty = customerLoyaltyPoints.FirstOrDefault();
            if(customerLoyalty?.LoyaltyId != null)
            {
                var ords = new CustomerLoyaltyPointsParam
                {
                    Id = customerLoyalty.Id,
                    LoyaltyId = customerLoyalty.LoyaltyId,
                    CustomerId = customerLoyalty.CustomerId,
                    Balance = customerLoyalty.Balance,
                    ExpirationDate = customerLoyalty.ExpirationDate,
                    TermsAndAgreement = customerLoyalty.TermsAndAgreement,
                    IsTerminated = customerLoyalty.IsTerminated,
                    CreatedAt = customerLoyalty.CreatedAt,
                    UpdatedAt = customerLoyalty.UpdatedAt,
                    LoyaltyPointsHistory = history
                };
                return ords;
            }
            
            return new CustomerLoyaltyPointsParam();
        }

        public async Task<int> SubtractLoyaltyBalance(CustomerLoyaltyPoints customerLoyaltyPoints)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec SubtractCustomerLoyaltyPoints @LoyaltyId={customerLoyaltyPoints.LoyaltyId}, @CustomerId={customerLoyaltyPoints.CustomerId}, @Balance={customerLoyaltyPoints.Balance}");
            return affectedRows;
        }

        public async Task<int> TransferLoyaltyPoints(string CustomerId, string CustomerName, string Email, LoyaltyPointsHistory history)
        {
            var res =await customerRepository.GetCustomerByEmail(Email);
            if(res?.CustomerId != null)
            {
                if(res.CustomerId == CustomerId)
                {
                    return 6;
                }
                var loyaltyPoint = await GetActiveLoyaltyPoints(res.CustomerId);
                if(loyaltyPoint?.LoyaltyId == null)
                {
                    return 4;
                }
                history.Description = $"{res.FullName}";// -${Math.Abs(history.AddedBalance)}";
                history.ActionType = "Transfer";
                await loyaltyPointsHistory.CreateHistory(history);
                await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateCustomerLoyaltyPoints @LoyaltyId={history.LoyaltyId}, @CustomerId={CustomerId}, @Balance={history.AddedBalance}");

                var model = new LoyaltyPointsHistory
                {
                    Id = 0,
                    LoyaltyId = loyaltyPoint.LoyaltyId,
                    Description = $"{CustomerName}", //+${Math.Abs(history.AddedBalance)}",
                    ActionType = "Transfer",
                    TransferId = history.TransferId,
                    AddedBalance = Math.Abs(history.AddedBalance),
                    AddedDate = history.AddedDate,
                    TotalAmount = Math.Abs(history.AddedBalance),
                    OrderId = null
                };
                await loyaltyPointsHistory.CreateHistory(model);
                await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateCustomerLoyaltyPoints @LoyaltyId={loyaltyPoint.LoyaltyId}, @CustomerId={res.CustomerId}, @Balance={Math.Abs(history.AddedBalance)}");
            return 1;
            }
            return 3;
        }

        public async Task<int> UpdateLoyaltyBalance(CustomerLoyaltyPoints customerLoyaltyPoints)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateCustomerLoyaltyPoints @LoyaltyId={customerLoyaltyPoints.LoyaltyId}, @CustomerId={customerLoyaltyPoints.CustomerId}, @Balance={customerLoyaltyPoints.Balance}");
            return affectedRows;
        }
    }
}
