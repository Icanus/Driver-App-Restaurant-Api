using FoodAppApi.Data.Interfaces;
using FoodAppApi.Data.Repository;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SMTPController : ControllerBase
    {
        private readonly ISMTPRepository _repository;
        public SMTPController(ISMTPRepository repository)
        {
            _repository = repository;
        }

        [HttpPost("SMS")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> SendSms(SMTPConfigParams param)
        {
            var result = await _repository.SendSMS(param);
            return Ok(result);
        }

        [HttpPost("Email")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> SendEmail(SMTPConfigParams param)
        {
            var result = await _repository.SendEmail(param);
            return Ok(result);
        }

        [HttpGet("{type}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetAsync(string type)
        {
            var result = await _repository.GetASync(type);
            return Ok(result);
        }
    }
}
