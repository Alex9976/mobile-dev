using LaptopCatalog.Models;
using LaptopCatalog.Services;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using System.Windows.Input;
using Xamarin.Forms;

namespace LaptopCatalog.ViewModels.Portait
{
    public class PortaitLaptopViewModel : BaseViewModel
    {
        private readonly string _defaultViedoName = "https://firebasestorage.googleapis.com/v0/b/laptop-catalog.appspot.com/o/videos%2Fb5c3155e-c95d-4bda-a255-e10aa1382f33.mp4?alt=media&token=c8f38dde-8f3f-49da-a10f-3eaf00f05ab7";

        public Laptop Laptop { get; set; }

        public string Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Type { get; set; }
        public string ProcessorModel { get; set; }
        public string RamSize { get; set; }
        public string RomSize { get; set; }
        public string Price { get; set; }

        public string ImageUrl { get; set; }
        public string ImageName { get; set; }
        public string VideoUrl { get; set; }
        public string VideoName { get; set; }

        public PortaitLaptopViewModel(Laptop laptop)
        {
            Laptop = laptop;

            Id = Laptop.Id;
            Name = Laptop.Name;
            Description = Laptop.Description;
            Type = Laptop.Type;
            ProcessorModel = Laptop.ProcessorModel;
            RamSize = Laptop.RamSize.ToString();
            RomSize = Laptop.RomSize.ToString();
            Price = Laptop.Price.ToString(CultureInfo.InvariantCulture);
            ImageUrl = Laptop.Image.DownloadUrl;
            ImageName = Laptop.Image.FileName;
            if (Laptop.Video.DownloadUrl == "")
                Laptop.Video.DownloadUrl = _defaultViedoName;
            VideoUrl = Laptop.Video.DownloadUrl;
            VideoName = Laptop.Video.FileName;
        }
    }
}
