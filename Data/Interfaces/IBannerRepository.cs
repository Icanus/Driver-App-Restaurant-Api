using FoodAppApi.Models;

namespace FoodAppApi.Data.Interfaces
{
    public interface ICategoryRepository
    {
        public Task<Category> GetCategoryById(int id);
        public Task<List<Category>> GetCategories();
        public Task<int> InsertCategory(Category category);
        public Task<int> UpdateCategory(Category category);
    }
}
