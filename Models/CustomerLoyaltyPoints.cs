namespace FoodAppApi.Models
{
    public class CustomerLoyaltyPoints
    {
        public int Id { get;set; }
        public string LoyaltyId { get; set; }
        public string CustomerId { get; set; }
        public double Balance { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public bool TermsAndAgreement { get; set; }
        public bool IsTerminated { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
    }

    public class CustomerLoyaltyPointsParam
    {
        public int Id { get; set; }
        public string LoyaltyId { get; set; }
        public string CustomerId { get; set; }
        public double Balance { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public bool TermsAndAgreement { get; set; }
        public bool IsTerminated { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public List<LoyaltyPointsHistory> LoyaltyPointsHistory { get; set; }
    }
}
