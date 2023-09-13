namespace FoodAppApi.Models
{
    public class Vehicle
    {
        public int Id { get; set; }
        public string DriverId { get; set; }
        public string? CarDescription { get; set; }
        public string? CarRegistration { get; set; }
        public string? DriversPhoto { get; set; }
        public string? CarPhoto { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime? UpdateAt { get; set; }
    }
}
