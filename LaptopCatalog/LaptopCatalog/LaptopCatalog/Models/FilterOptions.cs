using System;
using System.Collections.Generic;
using System.Text;

namespace LaptopCatalog.Models
{
    public class FilterOptions
    {
        public string Type { get; set; }
        public string ProcessorModel { get; set; }
        public int MinRamSize { get; set; }
        public int MaxRamSize { get; set; }
        public int MinRomSize { get; set; }
        public int MaxRomSize { get; set; }
        public decimal MinPrice { get; set; }
        public decimal MaxPrice { get; set; }
    }
}
