using FoodAppApi.Data.Interfaces;
using FoodAppApi.Data.Repository;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DriverController : ControllerBase
    {
        private readonly IDriverRepository _driverRepository;
        public DriverController(IDriverRepository driverRepository)
        {
            _driverRepository = driverRepository;
        }
        [HttpGet]
        public async Task<IEnumerable<Driver>> GetAsync()
        {
            var result = await _driverRepository.GetDriver();
            return result;
        }

        [HttpGet("Email/{email}/Password/{password}")]
        [ProducesResponseType(typeof(Customer), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetByEmailAndPassword(string email, string password)
        {
            var result = await _driverRepository.GetDriverByEmailAndPassword(email, password);
            return result?.Id == null ? NotFound() : Ok(result);
        }

        [HttpGet("DriverId/{driverId}")]
        [ProducesResponseType(typeof(Customer), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetDriverDetails(string driverId)
        {
            var result = await _driverRepository.GetDriverDetails(driverId);
            return result?.Id == null ? NotFound() : Ok(result);
        }

        [HttpGet("Email/{email}")]
        [ProducesResponseType(typeof(Customer), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetByEmail(string email)
        {
            var result = await _driverRepository.GetDriverByEmail(email);
            return result?.Id == null ? NotFound() : Ok(result);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> Create(Driver driver)
        {
            var result = await _driverRepository.Insert(driver);
            return Ok(result);
        }

        [HttpPut("{driverId}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Update(string driverId, Driver driver)
        {
            if (driverId != driver.DriverId) return BadRequest();

            //context.Entry(customer).State = EntityState.Modified;
            //await context.SaveChangesAsync();
            var result = await _driverRepository.Update(driver);
            return Ok(result);
        }
    }
}
