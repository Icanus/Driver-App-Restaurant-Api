using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReferralRewardController : ControllerBase
    { 
            private readonly IReferralRewardsRepository _referralRewardsRepository;
            public ReferralRewardController(IReferralRewardsRepository referralRewardsRepository)
            {
            _referralRewardsRepository = referralRewardsRepository;
            }
            [HttpGet("Get/{customerId}")]
            public async Task<ReferralRewardsParam> GetAsync(string customerId)
            {
                var result = await _referralRewardsRepository.GetRewards(customerId);
                return result;
            }

            [HttpPost("Create/{customerId}")]
            [ProducesResponseType(StatusCodes.Status201Created)]
            public async Task<IActionResult> Create(string customerId)
            {
                var result = await _referralRewardsRepository.CreateRewards(customerId);
                return Ok(result);
            }

            [HttpPut("CustomerId/{customerId}/Balance/{balance}")]
            [ProducesResponseType(StatusCodes.Status204NoContent)]
            [ProducesResponseType(StatusCodes.Status400BadRequest)]
            public async Task<IActionResult> Update(string customerId, double balance)
            {
                var result = await _referralRewardsRepository.UpdateBalance(customerId, balance);
                return Ok(result);
            }
        }
    }
