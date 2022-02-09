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

        public void clear()
        {
            this.Type = "";
            this.ProcessorModel = "";
            this.MaxRamSize = 0;
            this.MinRamSize = 0;
            this.MaxRomSize = 0;
            this.MinRomSize = 0;
            this.MaxPrice = 0;
            this.MinPrice = 0;
        }

        public FilterOptions(FilterOptions options)
        {
            this.Type = options.Type;
            this.ProcessorModel = options.ProcessorModel;
            this.MaxRomSize = options.MaxRomSize;
            this.MinRomSize = options.MinRomSize;
            this.MaxRamSize = options.MaxRamSize;
            this.MinRamSize = options.MinRamSize;
            this.MaxPrice = options.MaxPrice;
            this.MinPrice = options.MinPrice;
        }
        public FilterOptions()
        {
            this.Type = "";
            this.ProcessorModel = "";
            this.MaxRomSize = 0;
            this.MinRomSize = 0;
            this.MaxRamSize = 0;
            this.MinRamSize = 0;
            this.MaxPrice = 0;
            this.MinPrice = 0;
        }
    }
}
