using LaptopCatalog.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LaptopCatalog.Views
{
    public class FlyoutMainPageFlyoutMenuItem
    {
        public int Id { get; set; }
        public string Title { get; set; }

        public Laptop Laptop { get; set; }

        public string TargetType { get; set; }
        public string Icon { get; set; }
    }
}