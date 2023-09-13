namespace FoodAppApi.Models
{
    public class SMTPConfig
    {
        public int Id { get; set; }
        public string Type { get; set; }
        public string? Email { get; set; }
        public string? Password { get; set; }
        public string? ApiKey { get; set; }
        public string? ApiSecret { get; set; }
    }

    public class SMTPConfigParams
    {
        public string? SenderName { get; set; }
        public string? SenderEmail { get; set; }
        public string? RecipientName { get; set; }
        public string? Email { get; set; }
        public string? SenderPhone { get; set; }
        public string? Phone { get; set; }
        public string ReferralCode { get; set; }
    }
}
