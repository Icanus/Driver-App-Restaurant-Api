using System.ComponentModel.DataAnnotations;

namespace FoodAppApi.Models
{
    public class Driver
    {
        public int Id { get; set; }
        [Required]
        public string DriverId { get; set; }
        [Required]
        public string? FullName { get; set; }
        public string ReferralCode { get; set; }
        public string Username { get; set; }
        [Required]
        public string Email { get; set; }
        public string? CountryCode { get; set; }
        public string? Country { get; set; }
        public string? Phone { get; set; }
        public string? Password { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string? Gender { get; set; }
        public string? AccountPreferences { get; set; }
        public bool TermsAndCondition { get; set; }
        public string? Image { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
    }
}
