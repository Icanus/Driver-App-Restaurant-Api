using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using System.Net.Mail;
using System.Net;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.Identity.Client.Platforms.Features.DesktopOs.Kerberos;
using Vonage;
using Vonage.Request;
using Vonage.Messaging;

namespace FoodAppApi.Data.Repository
{
    public class SMTPRepository : ISMTPRepository
    {
        private readonly DatabaseContext _context;
        private const string Title = "Ben's Kitchen";
        private const string Link = "www.google.com";
        public SMTPRepository(DatabaseContext context)
        {
            _context = context;
        }
        public async Task<int> SendEmail(SMTPConfigParams config)
        {
            var type = "email_sms";
            var smtpList = await _context.SMTPConfig.FromSqlInterpolated($"exec GetSMTP @Type={type}").ToListAsync();
            var smtp = smtpList.FirstOrDefault();
            if (!string.IsNullOrEmpty(smtp?.Email))
            {
                // Sender's email address and password
                string senderEmail = smtp.Email;
                string FullName = config.RecipientName;
                string senderPassword = smtp.Password;

                // Recipient's email address
                string recipientEmail = config.Email;

                // Create a new SMTP client
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com");
                smtpClient.Port = 587;
                smtpClient.EnableSsl = true;
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new NetworkCredential(senderEmail, senderPassword);

                // Create a new MailMessage
                MailMessage mailMessage = new MailMessage(config.SenderEmail, config.Email)
                {
                    Subject = "Your Exclusive Referral Code Awaits You!",
                    Body = $"Hey {config.RecipientName}, I'm thrilled to share an exclusive opportunity with you as you register for {Title}.\n\n" +
                    $" As a token of appreciation for joining our community, you're eligible for an incredible offer." +
                    $" During the registration process, in referral code. Simply use my personal code: {config.ReferralCode}." +
                    $" By doing so, you'll unlock an exclusive 10% discount on your initial purchase." +
                    $"\n\n"+
                    $" Here's how to claim your offer:" +
                    $"\n\n"+
                    $" 1. Download {Title}'s App in Playstore/AppStore, here is the link: {Link}" +
                    $"\n 2. Complete the registration process, providing the required information." +
                    $"\n 3. Fill up the referral code field" +
                    $"\n 4. You'll immediately enjoy your 10% discount as a warm welcome gesture" +
                    $"\n\n" +
                    $" Not only will you enjoy these fantastic savings, but I'll also receive a point as a gesture of gratitude for introducing you to {Title} App." +
                    $" Should you encounter any questions or need assistance during registration, feel free to reach out. I'm here to ensure your journey begins seamlessly." +
                    $" I can't wait for you to discover the remarkable features and benefits that {Title} has to offer. Thank you for considering my referral, and I'm excited to hear about your positive experiences.\n\n"+
                    $" Best regards,\n"+
                    $" {FullName}"
                };

                try
                {
                    // Send the email
                    smtpClient.Send(mailMessage);
                    Console.WriteLine("Email sent successfully!");
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"An error occurred: {ex.Message}");
                    return 0;
                }
            }
            return 1;

        }

        public async Task<int> SendSMS(SMTPConfigParams config)
        {
            var type = "email_sms";
            var smtpList = await _context.SMTPConfig.FromSqlInterpolated($"exec GetSMTP @Type={type}").ToListAsync();
            var smtp = smtpList.FirstOrDefault();
            string FullName = config.RecipientName;
            var credentials = Credentials.FromApiKeyAndSecret(smtp.ApiKey, smtp.ApiSecret);
            var vonageClient = new VonageClient(credentials);

            var response = vonageClient.SmsClient.SendAnSms(request: new SendSmsRequest
            {
                To = $"{config.Phone}",
                From = $"{config.SenderName}",
                Text = $"Hey {config.RecipientName}," +
                $"\n\n" +
                $" Great news! As you register for {Title} App, you're in for an exclusive treat." +
                $" Simply enter my referral code: {config.ReferralCode} during registration," +
                $" and you'll instantly unlock %10 off on your first purchase. " +
                $"\n\n" +
                $" Here's how:" +
                $"\n\n" +
                $" 1. Download {Title}'s App in Playstore/AppStore, here is the link. {Link}" +
                $"\n 2. Complete your registration and remember to enter my referral code: {config.ReferralCode}" +
                $"\n 3. Enjoy your 10% discount right from the start" +
                $"\n\n" +
                $"And the best part? I'll receive an reward for introducing you to {Title}." +
                $"\n\n" +
                $"Need help? I'm just a message away. Let's make your registration seamless and rewarding!" +
                $"\n\n" +
                $"Cheers," +
                $"\n" +
                $"{config.SenderName}"
            });

            if (response.Messages[0].StatusCode == SmsStatusCode.Success)
            {
                Console.WriteLine("SMS sent successfully!");
            }
            else
            {
                Console.WriteLine($"Error sending SMS: {response.Messages[0].ErrorText}");
                return 0;
            }
            return 1;
        }

        public async Task<SMTPConfig> GetASync(string type)
        {
            var smtpList = await _context.SMTPConfig.FromSqlInterpolated($"exec GetSMTP @Type={type}").ToListAsync();
            return smtpList.FirstOrDefault();
        }
    }
}
