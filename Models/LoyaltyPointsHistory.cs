namespace FoodAppApi.Models
{
    public class LoyaltyPointsHistory
    {
        public int Id { get; set; }
        public string LoyaltyId { get; set; }
        public string? OrderId { get; set; }
        public double TotalAmount { get; set; }
        public double AddedBalance { get; set; }
        public string? TransferId { get; set; }
        public string? ActionType { get; set; }
        public string? Description { get; set; }
        public int? ReferenceId { get; set; }
        public DateTime AddedDate { get; set; }
    }
}
