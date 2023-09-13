using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReferralController : ControllerBase
    {
        private readonly IReferralsRepository repository;
        public ReferralController(IReferralsRepository _repository)
        {
            repository = _repository;
        }
        [HttpGet("Get/{customerId}")]
        public async Task<List<Referrals>> GetAsync(string customerId)
        {
            var result = await repository.GetReferrals(customerId);
            return result;
        }

        [HttpPost("Create")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> Create(Referrals referrals)
        {
            var result = await repository.InsertReferral(referrals);
            return Ok(result);
        }
    }
}
