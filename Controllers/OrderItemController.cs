using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderItemController : ControllerBase
    {
        private readonly IOrderItemRepository _orderItemRepository;
        public OrderItemController(IOrderItemRepository itemRepository)
        {
            _orderItemRepository = itemRepository;
        }
        [HttpGet("{orderId}")]
        public async Task<IEnumerable<OrderItem>> GetOrderItemByOrderId(string orderId)
        {
            var result = await _orderItemRepository.GetOrderItemByOrderId(orderId);
            return result;
        }
    }
}
