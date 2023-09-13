using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly IOrderRepository _orderRepository;
        public OrderController(IOrderRepository itemRepository)
        {
            _orderRepository = itemRepository;
        }
        [HttpGet("{customerId}")]
        public async Task<IEnumerable<Orders>> GetOrderByCustomerId(string customerId)
        {
            var result = await _orderRepository.GetOrderByCustomerId(customerId);
            return result;
        }
        [HttpGet("CustomerId/{customerId}/OrderId/{orderId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetOrderByCustomerId(string customerId, string orderId)
        {
            var result = await _orderRepository.GetOrderDetails(customerId, orderId);
            return result == null ? NotFound() : Ok(result);
        }
        

        [HttpGet("OngoingOrder/{customerId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetOngoingOrderByCustomerId(string customerId)
        {
            var result = await _orderRepository.GetOngoingOrderByCustomerId(customerId);
            return result.Count == 0 ? NotFound() : Ok(result);
        }

        [HttpGet("MaxOrder")]
        public async Task<int> GetMaxOrderId()
        {
            var result = await _orderRepository.GetMaxOrderId();
            return result;
        }


        [HttpGet("CheckIfFirstPurchase")]
        public async Task<int> CheckIfFirstPurchase(string refereeId, string customerId)
        {
            var result = await _orderRepository.CheckIfFirstPurchase(refereeId, customerId);
            return result;
        }

        [HttpGet("CheckIfFirstPurchaseV2/{customerId}")]
        public async Task<int> CheckIfFirstPurchase(string customerId)
        {
            var result = await _orderRepository.CheckIfFirstPurchaseV2(customerId);
            return result;
        }

        [HttpPost("{isDeductRewards}")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> Create(Orders order,bool isDeductRewards)
        {
            var result = await _orderRepository.InsertOrder(order, isDeductRewards);
            return Ok(result);
        }

        [HttpPut("OrderId/{orderId}/Status/{orderStatus}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<IActionResult> Update(string orderId, string orderStatus)
        {
            var result = await _orderRepository.UpdateOrderStatus(orderId, orderStatus);
            return Ok(result);
        }

        [HttpPut("DriverId/{driverId}/OrderId/{orderId}/Lon/{Lon}/Lat/{Lat}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<IActionResult> Update(string driverId, string orderId, string Lon, string Lat)
        {
            var result = await _orderRepository.UpdateOrderSetDriverId(driverId, orderId, Lon, Lat);
            return Ok(result);
        }

        [HttpGet("OpenOrders/LastSyncId/{lastSyncId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        public async Task<IActionResult> GetOpenOrders(int lastSyncId)
        {
            var result = await _orderRepository.GetOpenOrders(lastSyncId);
            return result.Count == 0 ? NoContent() : Ok(result);
        }

        [HttpGet("ClosedOrders/LastSyncId/{lastSyncId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        public async Task<IActionResult> GetDeletedOpenOrders(int lastSyncId)
        {
            var result = await _orderRepository.GetDeletedOpenOrders(lastSyncId);
            return result.Count == 0 ? NoContent() : Ok(result);
        }

        [HttpGet("GetOrdersByDriverId/{driverId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetOrdersByDriverId(string driverId)
        {
            var result = await _orderRepository.GetOrdersByDriverId(driverId);
            return result.Count == 0 ? NotFound() : Ok(result);
        }

        [HttpPut("Location/DriverId/{driverId}/OrderId/{orderId}/Lon/{Lon}/Lat/{Lat}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<IActionResult> UpdateLocation(string driverId, string orderId, string Lon, string Lat)
        {
            var result = await _orderRepository.UpdateOrderLocationByDriverId(driverId, orderId, Lon, Lat);
            return Ok(result);
        }
        [HttpPut("OrderId/{orderId}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UpdateOrderAddressByOrderId(string orderId, ChangeAddressModel model)
        {
            if (orderId != model.OrderId) return BadRequest();
            var result = await _orderRepository.UpdateOrderAddressByOrderId(orderId, model);
            return Ok(result);
        }
        [HttpPut("Accept/OrderId/{orderId}/Driverid/{driverId}")]
        public async Task<IActionResult> AcceptAddressChange(string orderId, string driverId)
        {
            var result = await _orderRepository.AcceptAddressChange(orderId, driverId);
            return Ok(result);
        }
        [HttpGet("OngoingOrder/DriverId/{driverId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetOngoingOrdersByDriverId(string driverId)
        {
            var result = await _orderRepository.GetOngoingOrdersByDriverId(driverId);
            return result.Count == 0 ? NotFound() : Ok(result);
        }

        [HttpPut("ArchiveOrder/Type/{type}/OrderId/{orderid}")]
        public async Task<IActionResult> ArchiveOrder(string type, string orderid)
        {
            var result = await _orderRepository.ArchiveOrder(type, orderid);
            return Ok(result);
        }
    }
}
