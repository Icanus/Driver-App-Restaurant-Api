using FoodAppApi.Data;
using FoodAppApi.Data.Interfaces;
using FoodAppApi.Data.Repository;
using FoodAppApi.Models;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;

namespace FoodAppApi.Service
{
    public class OrderHub : Hub
    {
        private readonly IOrderRepository _orderRepository;
        public OrderHub(IOrderRepository repository)
        {
            _orderRepository = repository;
        }
        public async Task FetchAndSendRecordsByDriverId(string driverId) // Pass order ID as a parameter
        {
            List<Orders> orderList = new List<Orders>();
            orderList = await _orderRepository.GetOngoingOrdersByDriverId(driverId);
            await Clients.All.SendAsync("ReceiveOrderRecords", orderList);
        }
        public async Task FetchOpenOrders() // Pass order ID as a parameter
        {
            List<Orders> orderList = new List<Orders>();
            orderList = await _orderRepository.GetOpenOrders(0);
            await Clients.All.SendAsync("ReceivedOpenOrders", orderList);
        }
    }
}
