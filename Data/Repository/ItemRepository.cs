using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;

namespace FoodAppApi.Data.Repository
{
    public class ItemRepository : IItemRepository
    {
        private readonly DatabaseContext _context;
        public ItemRepository(DatabaseContext context)
        {
            _context = context;
        }

        public async Task<List<Item>> GetItems()
        {
            var items = await _context.Item.FromSqlInterpolated($"exec GetItems").ToListAsync();
            return items;
        }

        public async Task<int> InsertItems(Item item)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertItem @ItemId={item.ItemId}, @Name={item.Name}, @Description={item.Description}, @Price={item.Price}, @RegularPrice={item.RegularPrice}, @IsPopular={item.IsPopular}, @IsFeatured={item.IsFeatured}, @IsFavorite={item.IsFavorite}, @Image={item.Image}, @CategoryId={item.CategoryId}, @OnSale={item.OnSale}");
            return affectedRows;
        }

        public async Task<int> UpdateItems(Item item)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateItem @ItemId={item.ItemId}, @Name={item.Name}, @Description={item.Description}, @Price={item.Price}, @RegularPrice={item.RegularPrice}, @IsPopular={item.IsPopular}, @IsFeatured={item.IsFeatured}, @IsFavorite={item.IsFavorite}, @Image={item.Image}, @CategoryId={item.CategoryId}, @OnSale={item.OnSale}, @IsDeleted={item.IsDeleted}");
            return affectedRows;
        }
    }
}
