using System.ComponentModel.DataAnnotations;

namespace FoodAppApi.Models
{
    public class CustomerDetails
    {
        public string? FullName { get; set; }
        public string Email { get; set; }
        public string? CountryCode { get; set; }
        public string? Phone { get; set; }
        public string? Image { get; set; }
    }
}
