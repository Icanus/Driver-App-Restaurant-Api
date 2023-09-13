using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomerLoyaltyPointsController : ControllerBase
    {
        private readonly ICustomerLoyaltyPointsRepository _customerLoyaltyPointsRepository;
        public CustomerLoyaltyPointsController(ICustomerLoyaltyPointsRepository customerLoyaltyPointsRepository)
        {
            _customerLoyaltyPointsRepository = customerLoyaltyPointsRepository;
        }
        [HttpGet("CustomerId/{customerId}")]
        public async Task<CustomerLoyaltyPoints> GetAsync(string customerId)
        {
            var result = await _customerLoyaltyPointsRepository.GetActiveLoyaltyPoints(customerId);
            return result;
        }

        [HttpGet("CustomerId/{customerId}/LoyaltyId/{loyaltyId}")]
        public async Task<CustomerLoyaltyPointsParam> GetAsync(string customerId, string loyaltyId)
        {
            var result = await _customerLoyaltyPointsRepository.GetLoyaltyPoints(customerId, loyaltyId);
            return result;
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> Create(CustomerLoyaltyPoints loyaltyPoints)
        {
            var result = await _customerLoyaltyPointsRepository.CreateLoyaltyPoints(loyaltyPoints);
            return Ok(result);
        }

        [HttpPost("Transfer/{customerId}/Sender/{senderName}/Email/{email}")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<int> Transfer(string customerId, string senderName, string email, LoyaltyPointsHistory history)
        {
            var result = await _customerLoyaltyPointsRepository.TransferLoyaltyPoints(customerId, senderName, email, history);
            return result;
        }

        [HttpPut("{loyaltyId}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Update(string loyaltyId, CustomerLoyaltyPoints loyaltyPoints)
        {
            if (loyaltyId != loyaltyPoints.LoyaltyId) return BadRequest();

            var result = await _customerLoyaltyPointsRepository.UpdateLoyaltyBalance(loyaltyPoints);
            return Ok(result);
        }
    }
}
