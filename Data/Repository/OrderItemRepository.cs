using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;

namespace FoodAppApi.Data.Repository
{
    public class OrderItemRepository : IOrderItemRepository
    {
        private readonly DatabaseContext _context;
        public OrderItemRepository(DatabaseContext context)
        {
            _context = context;
        }
        public async Task<List<OrderItem>> GetOrderItemByOrderId(string OrderId)
        {
            var orders = await _context.OrderItem.FromSqlInterpolated($"exec GetOrderItemByOrderId {OrderId}").ToListAsync();
            return orders;
        }

        public async Task<int> InsertOrderItem(List<OrderItem> orderItems)
        {
            foreach(var item in orderItems)
            {
                await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertOrderItem @OrderId={item.OrderId}, @ProductId={item.ProductId}, @ProductName={item.ProductName}, @ProductImage={item.ProductImage}, @ProductDescription={item.ProductDescription}, @UnitPrice={item.UnitPrice}, @Quantity={item.Quantity}, @IngredientString={item.IngredientString}, @ChoiceString={item.ChoiceString}, @Total={item.Total}");
            }
            return 1;
        }
    }
}
