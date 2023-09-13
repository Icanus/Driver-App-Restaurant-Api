using System.ComponentModel.DataAnnotations;

namespace FoodAppApi.Models
{
    public class Banner
    {
        public int Id { get; set; }
        public string Image { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
    }
}
