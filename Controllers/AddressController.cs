using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AddressController : ControllerBase
    {
        private readonly IAddressRepository _addressRepository;
        public AddressController(IAddressRepository addressRepository)
        {
            _addressRepository = addressRepository;
        }

        [HttpGet("{customerId}")]
        [ProducesResponseType(typeof(Address), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetCategoryById(string customerId)
        {
            var result = await _addressRepository.GetAddressByCustomerId(customerId);
            return result == null ? NotFound() : Ok(result);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> Create(Address address)
        {
            var result = await _addressRepository.InsertAddress(address);
            return Ok(result);
        }

        [HttpPut("{addressId}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Update(string addressId, Address address)
        {
            if (addressId != address.AddressId) return BadRequest();

            //context.Entry(customer).State = EntityState.Modified;
            //await context.SaveChangesAsync();
            var result = await _addressRepository.UpdateAddress(addressId, address);
            return Ok(result);
        }
    }
}
