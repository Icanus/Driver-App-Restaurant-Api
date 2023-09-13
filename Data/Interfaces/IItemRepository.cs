using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface IItemRepository
    {
        Task<List<Item>> GetItems();
        Task<int> InsertItems(Item item);
        Task<int> UpdateItems(Item item);
    }
}
