using LaptopCatalog.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace LaptopCatalog.Services
{
    public interface IFirebaseDatebaseService
    {
        List<Laptop> GetAllLaptops();

        Laptop GetLaptopById(string id);

        Task AddLaptop(Laptop laptopData);

        Task UpdateLaptop(string id, Laptop laptopData);
    }
}