using FoodAppApi.Data;
using FoodAppApi.Data.Interfaces;
using FoodAppApi.Data.Repository;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomerController : ControllerBase
    {
        private readonly ICustomerRepository _customerRepository;
        public CustomerController(ICustomerRepository customerRepository)
        {
            _customerRepository = customerRepository;
        }
        [HttpGet]
        public async Task<IEnumerable<Customer>> GetAsync()
        {
            var result = await _customerRepository.GetCustomers();
            return result;
        }

        [HttpGet("Email/{email}/Password/{password}")]
        [ProducesResponseType(typeof(Customer), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetByEmailAndPassword(string email, string password)
        {
            var result = await _customerRepository.GetCustomerByEmailAndPassword(email, password);
            return result?.Id == null ? NotFound() : Ok(result);
        }

        [HttpGet("Email/{email}")]
        [ProducesResponseType(typeof(Customer), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetByEmail(string email)
        {
            var result = await _customerRepository.GetCustomerByEmail(email);
            return result?.Id == null ? NotFound() : Ok(result);
        }

        [HttpGet("Details/CustomerId/{customerId}")]
        [ProducesResponseType(typeof(Customer), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> GetCustomerDetails(string customerId)
        {
            var result = await _customerRepository.GetCustomerDetails(customerId);
            return result?.FullName == null ? NotFound() : Ok(result);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> Create(Customer customer)
        {
            var result = await _customerRepository.InsertCustomer(customer);
            return Ok(result);
        }
        [HttpGet("GenerateCode")]
        public async Task<string> CheckIfFirstPurchase()
        {
            var result = await _customerRepository.GenerateReferralCode();
            return result;
        }

        [HttpPut("{customerId}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Update(string customerId,Customer customer)
        {
            if(customerId != customer.CustomerId) return BadRequest();

            //context.Entry(customer).State = EntityState.Modified;
            //await context.SaveChangesAsync();
            var result = await _customerRepository.UpdateCustomer(customer);
            return Ok(result);
        }
    }
}
