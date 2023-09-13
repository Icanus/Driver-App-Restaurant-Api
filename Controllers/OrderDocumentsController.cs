using FoodAppApi.Data.Interfaces;
using FoodAppApi.Data.Repository;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderDocumentsController : ControllerBase
    {
        private readonly IOrderDocumentsRepository _repository;
        public OrderDocumentsController(IOrderDocumentsRepository repository)
        {
            _repository = repository;
        }
        [HttpGet("OrderId/{orderId}")]
        public async Task<IActionResult> GetAsync(string orderId)
        {
            var result = await _repository.GetOrderDocuments(orderId);
            return result?.OrderId == null ? NotFound() : Ok(result);
        }
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> Create(string orderId)
        {
            var result = await _repository.CreateOrderDocuments(orderId);
            return Ok(result);
        }
        [HttpPut("OrderId/{orderId}/Type/{type}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Update(string orderId, int type, OrderDocuments docs)
        {
            if (orderId != docs.OrderId) return BadRequest();

            //context.Entry(customer).State = EntityState.Modified;
            //await context.SaveChangesAsync();
            var result = await _repository.UpdateOrderDocuments(type, docs);
            return Ok(result);
        }
    }
}
