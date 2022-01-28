using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Firebase.Auth;
using Firebase.Database;
using Firebase.Database.Query;
using LaptopCatalog.Models;
using LaptopCatalog.Services;

namespace XamarinApp.Droid.Services
{
    public class FirebaseDatebaseService : IFirebaseDatebaseService
    {
        private static readonly string BaseUrl = "https://laptop-catalog-default-rtdb.europe-west1.firebasedatabase.app/";

        private readonly FirebaseClient _databaseClient = new FirebaseClient(BaseUrl);

        public async Task AddLaptop(Laptop laptopData)
        {
            await _databaseClient.Child("Laptops").PostAsync(laptopData);
        }

        public List<Laptop> GetAllLaptops()
        {
            var taskGetAllLaptops = _databaseClient.Child("Laptops").OnceAsync<Laptop>();

            taskGetAllLaptops.Wait();

            if (taskGetAllLaptops.Exception != null)
            {
                Console.WriteLine(taskGetAllLaptops.Exception.Message);
                return null;
            }

            IEnumerable<FirebaseObject<Laptop>> resultLaptops = taskGetAllLaptops.Result;
            return resultLaptops.Select(item => new Laptop
            {
                Id = item.Object.Id,
                Name = item.Object.Name,
                Description = item.Object.Description,
                Type = item.Object.Type,
                ProcessorModel = item.Object.ProcessorModel,
                RamSize = item.Object.RamSize,
                RomSize = item.Object.RomSize,
                Price = item.Object.Price,
                Image = new CloudFileData
                {
                    FileName = item.Object.Image?.FileName ?? "",
                    DownloadUrl = item.Object.Image?.DownloadUrl ?? "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg"
                },
                Video = new CloudFileData
                {
                    FileName = item.Object.Video?.FileName ?? "",
                    DownloadUrl = item.Object.Video?.DownloadUrl ?? ""
                }
            }).ToList();
        }

        public Laptop GetLaptopById(string id)
        {
            var taskGetAllLaptops = _databaseClient
                .Child("Laptops")
                .OnceAsync<Laptop>();

            taskGetAllLaptops.Wait();

            if (taskGetAllLaptops.Exception != null)
            {
                Console.WriteLine(taskGetAllLaptops.Exception.Message);
                return null;
            }

            IEnumerable<FirebaseObject<Laptop>> resultLaptops = taskGetAllLaptops.Result;

            return resultLaptops.Where(c => c.Object.Id == id).Select(item => new Laptop
            {
                Id = item.Object.Id,
                Name = item.Object.Name,
                Description = item.Object.Description,
                Type = item.Object.Type,
                ProcessorModel = item.Object.ProcessorModel,
                RamSize = item.Object.RamSize,
                RomSize = item.Object.RomSize,
                Price = item.Object.Price,
                Image = new CloudFileData
                {
                    FileName = item.Object.Image?.FileName ?? "",
                    DownloadUrl = item.Object.Image?.DownloadUrl ?? "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg"
                },
                Video = new CloudFileData
                {
                    FileName = item.Object.Video?.FileName ?? "",
                    DownloadUrl = item.Object.Video?.DownloadUrl ?? ""
                }
            }).FirstOrDefault();
        }

        public async Task UpdateLaptop(string id, Laptop laptopData)
        {
            var toUpdateLaptop = (await _databaseClient
                .Child("Laptops")
                .OnceAsync<Laptop>()).FirstOrDefault(c => c.Object.Id == id);

            await _databaseClient
                .Child("Laptops")
                .Child(toUpdateLaptop?.Key)
                .PutAsync(laptopData);
        }
    }
}