using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReferralRewardsHistoryController : ControllerBase
    {
        private readonly IReferralRewardsHistoryRepository _repository;
        public ReferralRewardsHistoryController(IReferralRewardsHistoryRepository repository)
        {
            _repository = repository;
        }
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> Create(ReferralRewardsHistory history)
        {
            var result = await _repository.CreateHistory(history);
            return Ok(result);
        }
    }
}
