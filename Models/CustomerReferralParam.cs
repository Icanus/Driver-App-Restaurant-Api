using System.ComponentModel.DataAnnotations;

namespace FoodAppApi.Models
{
    public class CustomerReferralParam
    {
        public int Id { get; set; }
        [Required]
        public string CustomerId { get; set; }
        [Required]
        public string FullName { get; set; }
        public string Username { get; set; }
        [Required]
        public string Email { get; set; }
        [Required]
        public string Password { get; set; }
        [Required]
        public string Phone { get; set; }
        public DateTime DateOfBirth { get; set; }
        [Required]
        public string Gender { get; set; }
        public string AccountPreferences { get; set; }
        public bool TermsAndCondition { get; set; }
        public string Image { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? ReferrerId { get; set; }
        public string? RefereeId { get; set; }
        public string? ReferrerEmail { get; set; }
        public string? RefereeEmail { get; set; }
    }
}
