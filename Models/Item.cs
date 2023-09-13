namespace FoodAppApi.Models
{
    public class Item
    {
        public int Id { get; set; }
        public string ItemId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public float Price { get; set; }
        public float RegularPrice { get; set; }
        public bool IsPopular { get; set; }
        public bool IsFeatured { get; set; }
        public bool IsFavorite { get; set; }
        public string Image { get; set; }
        public int CategoryId { get; set; }
        public bool OnSale { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public bool IsDeleted { get; set; }
    }
}
