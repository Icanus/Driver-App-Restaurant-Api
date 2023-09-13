using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VehicleController : ControllerBase
    {
        private readonly IVehicleRepository _vehicleRepository;
        public VehicleController(IVehicleRepository vehicleRepository)
        {
            _vehicleRepository = vehicleRepository;
        }

        [HttpGet("DriverId/{driverId}")]
        [ProducesResponseType(typeof(Customer), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetByEmailAndPassword(string driverId)
        {
            var result = await _vehicleRepository.GetVehicleByDriverId(driverId);
            return result?.Id == null ? NotFound() : Ok(result);
        }


        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> InsertOrUpdate(Vehicle driver)
        {
            var result = await _vehicleRepository.InsertOrUpdateVehicle(driver);
            return Ok(result);
        }
    }
}
