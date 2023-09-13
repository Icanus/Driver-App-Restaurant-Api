using FoodAppApi.Data.Interfaces;
using FoodAppApi.Models;
using Microsoft.EntityFrameworkCore;
using System.Net;

namespace FoodAppApi.Data.Repository
{
    public class AddressRepository : IAddressRepository
    {
        private readonly DatabaseContext _context;
        public AddressRepository(DatabaseContext context)
        {
            _context = context;
        }

        public async Task<List<Address>> GetAddressByCustomerId(string customerId)
        {
            var customers = await _context.Address.FromSqlInterpolated($"exec GetAddressByCustomerId {customerId}").ToListAsync();
            return customers;
        }

        public async Task<int> InsertAddress(Address address)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec InsertAddress @AddressId={address.AddressId}, @CustomerId={address.CustomerId}, @Title={address.Title}, @PostCode={address.PostCode}, @Address1={address.Address1}, @State={address.State}, @Street={address.Street}, @City={address.City}, @Country={address.Country}, @Comment={address.Comment}, @Lon={address.Lon}, @Lat={address.@Lat}, @IsDeleted={address.IsDeleted}");
            return affectedRows;
        }

        public async Task<int> UpdateAddress(string id, Address address)
        {
            var affectedRows = await _context.Database.ExecuteSqlInterpolatedAsync($"exec UpdateAddress @AddressId={id}, @Title={address.Title}, @PostCode={address.PostCode}, @Address1={address.Address1}, @State={address.State}, @Street={address.Street}, @City={address.City}, @Country={address.Country}, @Comment={address.Comment}, @Lon={address.Lon}, @Lat={address.@Lat}, @IsDeleted={address.IsDeleted}");
            return affectedRows;
        }
    }
}
