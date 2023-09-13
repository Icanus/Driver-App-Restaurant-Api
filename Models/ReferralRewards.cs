namespace FoodAppApi.Models
{
    public class ReferralRewards
    {
        public int Id { get; set; }
        public string ReferralId { get; set; }
        public double Balance { get; set; }
        public bool IsTerminated { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
    }

    public class ReferralRewardsParam
    {
        public int Id { get; set; }
        public string ReferralId { get; set; }
        public string ReferralCode { get; set; }
        public double Balance { get; set; }
        public bool IsTerminated { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public List<ReferralRewardsHistory> ReferralRewardsHistory { get; set; }
    }
}
