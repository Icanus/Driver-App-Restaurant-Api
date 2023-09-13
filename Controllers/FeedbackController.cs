using FoodAppApi.Data.Interfaces;
using FoodAppApi.Data.Migrations;
using FoodAppApi.Data.Repository;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FeedbackController : ControllerBase
    {
        private readonly IFeedbackRepository _feedbackRepository;
        public FeedbackController(IFeedbackRepository repository)
        {
            _feedbackRepository = repository;
        }
        [HttpGet("{orderId}")]
        public async Task<FeedBack> GetAsync(string orderId)
        {
            var result = await _feedbackRepository.GetFeedbackByOrderId(orderId);
            return result;
        }

        [HttpPut("{feedbackId}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UpdateFeedback(string feedbackId, FeedBack feedback)
        {

            if (feedbackId != feedback.FeedbackId) return BadRequest();

            var result = await _feedbackRepository.UpdateFeedback(feedback);
            return Ok(result);
        }
    }
}
