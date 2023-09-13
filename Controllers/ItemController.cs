using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ItemController : ControllerBase
    {
        private readonly IItemRepository _itemRepository;
        public ItemController(IItemRepository itemRepository)
        {
            _itemRepository = itemRepository;
        }
        [HttpGet]
        public async Task<IEnumerable<Item>> GetAsync()
        {
            var result = await _itemRepository.GetItems();
            return result;
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> Create(Item customer)
        {
            var result = await _itemRepository.InsertItems(customer);
            return Ok(result);
        }

        [HttpPut("{itemId}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Update(string itemId, Item item)
        {
            if (itemId != item.ItemId) return BadRequest();

            //context.Entry(customer).State = EntityState.Modified;
            //await context.SaveChangesAsync();
            var result = await _itemRepository.UpdateItems(item);
            return Ok(result);
        }
    }
}
