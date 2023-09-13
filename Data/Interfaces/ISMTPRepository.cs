using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface ISMTPRepository
    {
        public Task<int> SendSMS(SMTPConfigParams param);
        public Task<int> SendEmail(SMTPConfigParams param);
        public Task<SMTPConfig> GetASync(string type);
    }
}
