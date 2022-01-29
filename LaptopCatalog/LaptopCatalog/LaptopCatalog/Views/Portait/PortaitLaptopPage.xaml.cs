using LaptopCatalog.Models;
using LaptopCatalog.ViewModels;
using LaptopCatalog.ViewModels.Portait;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace LaptopCatalog.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class PortaitLaptopPage : ContentPage
    {
        public PortaitLaptopPage(Laptop laptop)
        {
            var viewModel = new PortaitLaptopViewModel(laptop);
            BindingContext = viewModel;
            InitializeComponent();

            player.Source = viewModel.VideoUrl;
        }
    }
}