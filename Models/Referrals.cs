namespace FoodAppApi.Models
{
    public class Referrals
    {
        public int Id { get; set; }
        public string ReferralCode { get; set; }
        public string? ReferrerId { get; set; }
        public string? RefereeId { get; set; }
        public string? ReferrerEmail { get; set; }
        public string? RefereeEmail { get; set; }
        public double? Points { get; set; }
        public string? OrderId { get; set; }
        public string? ReferenceId { get; set; }
        public DateTime? CreatedDate { get; set; }
    }
}
