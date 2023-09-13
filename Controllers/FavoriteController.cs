using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FoodAppApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FavoriteController : ControllerBase
    {
        private readonly IFavoriteRepository _favoriteRepository;
        public FavoriteController(IFavoriteRepository favoriteRepository)
        {
            _favoriteRepository = favoriteRepository;
        }
        [HttpGet("{customerId}")]
        public async Task<IEnumerable<Favorite>> GetAsync(string customerId)
        {
            var result = await _favoriteRepository.GetFavorites(customerId);
            return result;
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<IActionResult> Create(Favorite favorite)
        {
            var result = await _favoriteRepository.InsertFavorite(favorite);
            return Ok(result);
        }

        [HttpDelete("{favoriteId}")]
        public async Task<IActionResult> Update(string favoriteId)
        {
            var result = await _favoriteRepository.DeleteFavorite(favoriteId);
            return Ok(result);
        }
    }
}
