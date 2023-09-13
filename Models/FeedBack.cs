namespace FoodAppApi.Models
{
    public class FeedBack
    {
        public int Id { get; set; }
        public string FeedbackId { get; set; }
        public string CustomerId { get; set; }
        public string OrderId { get; set; }
        public double? Rating { get; set; }
        public string? Comment { get; set; }
        public bool IsFeedBackAvailable { get; set; }
        public DateTime ActivityDate { get; set; }
    }
}
