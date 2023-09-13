namespace FoodAppApi.Models
{
    public class ReferralRewardsHistory
    {
        public int Id { get; set; }
        public string ReferralCode { get; set; }
        public string ReferralId { get; set; }
        public string ReferrerId { get; set; }
        public string RefereeId { get; set; }
        public string? OrderId { get; set; }
        public string? ActionType { get; set; }
        public string? Description { get; set; }
        public double AddedBalance { get; set; }
        public DateTime AddedDate { get; set; }
    }
}
