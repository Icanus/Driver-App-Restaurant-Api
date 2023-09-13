using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using Microsoft.EntityFrameworkCore;
using Vonage.Accounts;

namespace FoodAppApi.Data.Repository
{
    public class OrderDocumentsRepository : IOrderDocumentsRepository
    {
        private readonly DatabaseContext _context;
        public OrderDocumentsRepository(DatabaseContext context)
        {
            _context = context;
        }
        public async Task<int> CreateOrderDocuments(string orderId)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertOrderDocs @OrderId={orderId}");
            return affectedRows;
        }

        public async Task<OrderDocuments> GetOrderDocuments(string orderId)
        {
            var customer = await _context.OrderDocuments.FromSqlInterpolated($"exec GetOrderDocs @OrderId={orderId}").ToListAsync();
            return customer.FirstOrDefault();
        }

        public async Task<int> UpdateOrderDocuments(int type, OrderDocuments docs)
        {
            string image = string.Empty;
            string reason = string.Empty;
            //for on the way == 0
            if(type == 0)
            {
                image = docs.OnTheWayImage;
            }
            //for cancelled
            if(type == 1)
            {
                image = docs.CancelledImage;
                reason = docs.CancelledReason;
            }
            //for delivered
            if (type == 2)
            {
                image = docs.DeliveredImage;
            }
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateOrderDocs @OrderId={docs.OrderId}, @Type={type}, @Image={image}, @Reason={reason}");
            return affectedRows;
        }
    }
}
