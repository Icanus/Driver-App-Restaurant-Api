using FoodAppApi.Data.Interfaces;
using FoodAppApi.Data.Repository;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RatePointsController : ControllerBase
    {
        private readonly IRatePointsRepository _ratePointsRepository;
        public RatePointsController(IRatePointsRepository ratePointsRepository)
        {
            _ratePointsRepository = ratePointsRepository;
        }
        [HttpGet]
        public async Task<RatePoints> GetAsync()
        {
            var result = await _ratePointsRepository.GetRatePoints();
            return result;
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> Create(RatePoints ratePoints)
        {
            var result = await _ratePointsRepository.InsertUpdateRatePoints(ratePoints);
            return Ok(result);
        }
    }
}
