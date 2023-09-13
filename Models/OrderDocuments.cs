namespace FoodAppApi.Models
{
    public class OrderDocuments
    {
        public int Id { get; set; }
        public string OrderId { get; set; }
        public string? OnTheWayImage { get; set; }
        public DateTime? OnTheWayImageTime { get; set; }
        public string? DeliveredImage { get; set; }
        public DateTime? DeliveredImageTime { get; set; }
        public string? CancelledImage { get; set; }
        public DateTime? CancelledImageTime { get; set; }
        public string? CancelledReason { get; set; }
    }
}
