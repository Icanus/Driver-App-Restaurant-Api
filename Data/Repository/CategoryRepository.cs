using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;

namespace FoodAppApi.Data.Repository
{
    public class CategoryRepository : ICategoryRepository
    {
        private readonly DatabaseContext _context;
        public CategoryRepository(DatabaseContext context)
        {
            _context = context;
        }

        public async Task<List<Category>> GetCategories()
        {
            var categories = await _context.Category.FromSqlInterpolated($"exec GetCategories").ToListAsync();
            return categories;
        }

        public async Task<Category> GetCategoryById(int id)
        {
            var category = await _context.Category.FromSqlInterpolated($"exec GetCategoryById @Id={id}").ToListAsync();
            return category.FirstOrDefault();
        }

        public async Task<int> InsertCategory(Category category)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertCategory @Name={category.Name}, @Image={category.Image}");
            return affectedRows;
        }

        public async Task<int> UpdateCategory(Category category)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateCategory @Id={category.Id}, @Name={category.Name}, @Image={category.Image}");
            return affectedRows;
        }
    }
}
