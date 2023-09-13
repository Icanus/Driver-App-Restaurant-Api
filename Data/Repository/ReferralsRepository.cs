using FoodAppApi.Data.Interfaces;
using FoodAppApi.Data.Migrations;
using FoodAppApi.Models;
using Microsoft.EntityFrameworkCore;

namespace FoodAppApi.Data.Repository
{
    public class ReferralsRepository : IReferralsRepository
    {
        private readonly DatabaseContext _context;
        private readonly IReferralRewardsRepository _referralRewardsRepository;
        private readonly IReferralRewardsHistoryRepository _referralRewardsHistoryRepository;
        public ReferralsRepository(DatabaseContext context, IReferralRewardsRepository referralsRepository, IReferralRewardsHistoryRepository referralRewardsHistoryRepository)
        {
            _context = context;
            _referralRewardsRepository = referralsRepository;
            _referralRewardsHistoryRepository = referralRewardsHistoryRepository;
        }
        public async Task<Referrals> CheckForReferrals(string customerId)
        {
            var referral = await _context.Referrals.FromSqlInterpolated($"exec CheckForReferrals @CustomerId={customerId}").ToListAsync();
            return referral.FirstOrDefault();
        }

        public async Task<int> CheckIFReferralCodeExists(string ReferralCode)
        {
            var referral = await _context.Database.SqlQuery<int>($"exec CheckIfReferralCodeExist @ReferralCode={ReferralCode}").ToListAsync();
            return referral.FirstOrDefault();
        }

        public async Task<ReferralRewardsParam> GetReferralReward(string customerId)
        {
            return await _referralRewardsRepository.GetRewards(customerId);
        }

        public async Task<List<Referrals>> GetReferrals(string customerId)
        {
            var referralHistory = await _context.Referrals.FromSqlInterpolated($"exec GetReferralsByCustomerId @CustomerId={customerId}").ToListAsync();
            return referralHistory;
        }

        public async Task<Referrals> GetReferralsByOrderId(string orderId)
        {
            var referral = await _context.Referrals.FromSqlInterpolated($"exec GetReferralsByOrderId @OrderId={orderId}").ToListAsync();
            return referral.FirstOrDefault();
        }

        public async Task<int> InsertReferral(Referrals referrals)
        {
            //var exist = await _context.Customer.Where(x => x.Email == referrals.RefereeEmail).ToListAsync();
            //if (exist.Count() != 0)
            //{
            //    return 2;
            //}
            //var inviteExist = await _context.Referrals.Where(x => x.RefereeEmail == referrals.RefereeEmail).ToListAsync();
            //if (inviteExist.Count() != 0)
            //{
            //    return 5;
            //}
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertReferral @ReferrerId={referrals.ReferrerId}, @RefereeId={referrals.RefereeId}, @ReferrerEmail={referrals.ReferrerEmail}, @RefereeEmail={referrals.RefereeEmail}, @ReferralCode={referrals.ReferralCode}, @Points={referrals.Points}, @OrderId={referrals.OrderId}, @ReferenceId={referrals.ReferenceId}");
            //if(affectedRows > 0)
            //{
            //    var res = await _referralRewardsRepository.UpdateBalance(referralData.CustomerId, 1);
            //    if(res > 0)
            //    {
            //        ReferralRewardsHistory history = new ReferralRewardsHistory
            //        {
            //            Id = 0,
            //            ReferralId = referralData.CustomerId,
            //            ReferrerId = referralData.CustomerId,
            //            RefereeId = referrals.RefereeId,
            //            ActionType = "Referral",
            //            AddedBalance = 1,
            //            Description = "Points for successful signup",
            //            AddedDate = DateTime.Now,
            //            OrderId = null
            //        };
            //        await _referralRewardsHistoryRepository.CreateHistory(history);
            //    }
            //    else
            //    {
            //        return 0;
            //    }
            //}
            //else
            //{
            //    return 0;
            //}
            return affectedRows;
        }

        public async Task<int> UpdateReferral(string RefereeId, string refereeEmail)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateReferral @RefereeEmail={refereeEmail}, @RefereeId={RefereeId}");
            return affectedRows;
        }

        public async Task<int> updateReferralBalance(string RefereeId, string ReferrerId)
        {
            var res = await _referralRewardsRepository.UpdateBalance(ReferrerId, 1);
            if (res > 0)
            {
                var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateReferralBalance @RefereeId={RefereeId}, @ReferrerId={ReferrerId}");
                return affectedRows;
            }
            return 0;
        }

        public async Task<int> UpdateReferralRewards(string customerId, double balance)
        {
            return await _referralRewardsRepository.UpdateBalance(customerId, balance);
        }
    }
}
