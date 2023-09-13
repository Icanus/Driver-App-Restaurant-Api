using System.ComponentModel.DataAnnotations;

namespace FoodAppApi.Models
{
    public class Address
    {
        public int Id { get; set; }
        public string AddressId { get; set; }
        public string CustomerId { get; set; }
        public string Title { get; set; }
        public string PostCode { get; set; }
        public string Address1 { get; set; }
        public string State { get; set; }
        public string Street { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
        public string Comment { get; set; }
        public string Lon { get; set; }
        public string Lat { get; set; }
        public int IsDeleted { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
    }
}
