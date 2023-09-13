using FoodAppApi.Data.Interfaces;
using FoodAppApi.Data.Repository;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoyaltyPointsHistoryController : ControllerBase
    {
        private readonly ILoyaltyPointsHistoryRepository _loyaltyPointsHistoryRepository;
        public LoyaltyPointsHistoryController(ILoyaltyPointsHistoryRepository loyaltyPointsHistoryRepository)
        {
            _loyaltyPointsHistoryRepository = loyaltyPointsHistoryRepository;
        }
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> Create(LoyaltyPointsHistory history)
        {
            var result = await _loyaltyPointsHistoryRepository.CreateHistory(history);
            return Ok(result);
        }
    }
}
