namespace FoodAppApi.Models
{
    public class Favorite
    {
        public int Id { get; set; }
        public string FavoriteId { get; set; }
        public string CustomerId { get; set; }
        public string ItemId { get; set; }
    }
}
