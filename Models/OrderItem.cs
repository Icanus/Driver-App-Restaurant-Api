namespace FoodAppApi.Models
{
    public class OrderItem
    {
        public int Id { get; set; }
        public string OrderId { get; set; }
        public string ProductId { get; set; }
        public string ProductName { get; set; }
        public string ProductImage { get; set; }
        public string ProductDescription { get; set; }
        public float UnitPrice { get; set; }
        public int Quantity { get; set; }
        public string IngredientString { get; set; }
        public string ChoiceString { get; set; }
        public double Total { get; set; }
    }
}
