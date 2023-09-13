using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Security.Cryptography;
using System.Text;

namespace FoodAppApi.Data.Repository
{
    public class CustomerRepository : ICustomerRepository
    {
        private readonly DatabaseContext _context;
        private readonly IReferralRewardsRepository _referralsRewardsRepository;
        private readonly IReferralsRepository _referralsRepository;
        public CustomerRepository(DatabaseContext context, IReferralRewardsRepository rewardsRepository, IReferralsRepository referralsRepository)
        {
            _context = context;
            _referralsRewardsRepository = rewardsRepository;
            _referralsRepository = referralsRepository;
        }

        public async Task<Customer> GetCustomerByEmail(string email)
        {
            var customer = await _context.Customer.FromSqlInterpolated($"exec GetCustomerByEmail @Email={email}").ToListAsync();
            return customer.FirstOrDefault();
        }

        public async Task<Customer> GetCustomerByEmailAndPassword(string email, string password)
        {
            var customer = await _context.Customer.FromSqlInterpolated($"exec GetCustomerByEmailAndPassword @Email={email}, @Password={password}").ToListAsync();
            return customer.FirstOrDefault();
        }

        public async Task<List<Customer>> GetCustomers()
        {
            var customers = await _context.Customer.FromSqlInterpolated($"exec GetCustomers").ToListAsync();
            return customers;
        }

        public async Task<int> InsertCustomer(Customer customer)
        {
            var exist = _context.Customer.Any(x => x.Email == customer.Email);
            if (exist)
            {
                return 2;
            }

            //var inviteExist = await _context.Referrals.Where(x => x.ReferralCode == customer.ReferralCode).ToListAsync();
            //if (inviteExist.Count() != 0)
            //{
            //    await _referralsRepository.UpdateReferral(customer.CustomerId, customer.Email);
            //}
            if (!string.IsNullOrEmpty(customer.ReferralCode))
            {
                var referralInfoList = await _context.Customer.Where(x => x.ReferralCode == customer.ReferralCode).ToListAsync();
                if (referralInfoList.Count() == 0)
                {
                    return 3;
                }
                var referralInfo = referralInfoList.FirstOrDefault();
                Referrals referrals = new Referrals
                {
                    Id = 0,
                    ReferralCode = referralInfo.ReferralCode,
                    ReferrerEmail = referralInfo.Email,
                    ReferrerId = referralInfo.CustomerId,
                    RefereeEmail = customer.Email,
                    RefereeId = customer.CustomerId,
                    Points = 0
                };
                var referralsEmailExist = await _referralsRepository.InsertReferral(referrals);
                if (referralsEmailExist == 0)
                {
                    return 0; //something went wrong
                }
            }

            //var referralCode = await GenerateReferralCode(9);
            var referralCode = await GenerateReferralCode();
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertCustomer @CustomerId={customer.CustomerId}, @FullName={customer.FullName}, @Username={customer.Username}, @Email={customer.Email}, @Password={customer.Password}, @Phone={customer.Phone}, @DateOfBirth={customer.DateOfBirth}, @Gender={customer.Gender}, @AccountPreferences={customer.AccountPreferences}, @TermsAndCondition={customer.TermsAndCondition}, @Image={customer.Image}, @ReferralCode={referralCode}, @CountryCode={customer.CountryCode}, @Country={customer.Country}");
            var res = await _referralsRewardsRepository.CreateRewards(customer.CustomerId);
            return affectedRows;
        }

        public async Task<int> UpdateCustomer(Customer customer)
        {
            var exist = _context.Customer.Any(x => x.Email == customer.Email && x.CustomerId != customer.CustomerId);
            if (exist)
            {
                return 2;
            }

            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateCustomer @CustomerId={customer.CustomerId}, @FullName={customer.FullName}, @Username={customer.Username}, @Email={customer.Email}, @Password={customer.Password}, @Phone={customer.Phone}, @DateOfBirth={customer.DateOfBirth}, @Gender={customer.Gender}, @AccountPreferences={customer.AccountPreferences}, @TermsAndCondition={customer.TermsAndCondition}, @Image={customer.Image}, @CountryCode={customer.CountryCode}, @Country={customer.Country}");
            return affectedRows;
        }

        //async Task<string> GenerateReferralCode(int length)
        public async Task<string> GenerateReferralCode()
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            //using (var rng = new RNGCryptoServiceProvider())
            //{
            //    while (true)
            //    {
            //        byte[] data = new byte[length];
            //        rng.GetBytes(data);
            //        StringBuilder result = new StringBuilder(length);
            //        foreach (byte b in data)
            //        {
            //            result.Append(chars[b % (chars.Length)]);
            //        }
            //        string generatedCode = "BNK" + result.ToString();
            //        bool codeExistsInDatabase = await _referralsRepository.CheckIFReferralCodeExists(generatedCode) > 0 ? true : false;;
            //        if (!codeExistsInDatabase)
            //        {
            //            return generatedCode;
            //        }
            //    }
            //}
            while (true)
            {
                for (int i = 0; i < 26 * 26 * 26 * 10 * 10 * 10; i++)
                {
                    int numPart = i % 1000;
                    int letterPart = i / 1000;

                    char letter1 = (char)('A' + (letterPart / (26 * 26)));
                    char letter2 = (char)('A' + ((letterPart / 26) % 26));
                    char letter3 = (char)('A' + (letterPart % 26));

                    int num1 = numPart / 100;
                    int num2 = (numPart / 10) % 10;
                    int num3 = numPart % 10;

                    string code = $"{letter1}{letter2}{letter3}{num1}{num2}{num3}";
                    bool codeExistsInDatabase = await _referralsRepository.CheckIFReferralCodeExists(code) > 0 ? true : false;
                    if (!codeExistsInDatabase)
                    {
                        return code;
                    }
                }
            }
        }

        public async Task<CustomerDetails> GetCustomerDetails(string customerId)
        {
            var customer = await _context.Customer.FromSqlInterpolated($"exec GetCustomerByCustomerId @CustomerId={customerId}").ToListAsync();
            CustomerDetails details = new CustomerDetails();
            if (customer != null)
            {
                var customerInfo = customer.FirstOrDefault();
                details = new CustomerDetails
                {
                    FullName = customerInfo.FullName,
                    Email = customerInfo.Email,
                    CountryCode = customerInfo.CountryCode,
                    Phone = customerInfo.Phone,
                    Image = customerInfo.Image,
                };
                return details;
            }
            return details;
        }
    }
}
