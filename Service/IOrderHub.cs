namespace FoodAppApi.Service
{
    public interface IOrderHub
    {
        Task FetchAndSendRecordsByDriverId(string id);
    }
}
