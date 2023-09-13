using Microsoft.AspNetCore.SignalR.Client;

namespace FoodAppApi.Service
{
    public class SignalRService
    {
        private HubConnection _hubConnection;

        public SignalRService()
        {
            _hubConnection = new HubConnectionBuilder()
                .WithUrl("https://your-signalr-hub-url")
                .Build();
        }

        public async Task StartConnection()
        {
            await _hubConnection.StartAsync();
        }

        public void SubscribeToUpdates(Action<string> onUpdateReceived)
        {
            _hubConnection.On<string>("ReceiveUpdate", onUpdateReceived);
        }
    }
}