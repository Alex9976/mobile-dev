using System;
using System.Collections.Generic;
using System.Text;

namespace LaptopCatalog.Models
{
    public class Laptop
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }

        public string Type { get; set; }
        public string ProcessorModel { get; set; }
        public int RamSize { get; set; }
        public int RomSize { get; set; }
        public decimal Price { get; set; }

        public CloudFileData Image { get; set; }
        public CloudFileData Video { get; set; }
    }
}
