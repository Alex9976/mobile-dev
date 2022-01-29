using LaptopCatalog.Models;
using LaptopCatalog.ViewModels.Landscape;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace LaptopCatalog.Views.Landscape
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class LandscapeLaptopPage : ContentPage
    {
        public LandscapeLaptopPage(Laptop laptop)
        {
            var viewModel = new LandscapeLaptopViewModel(laptop);
            BindingContext = viewModel;
            InitializeComponent();

            player.Source = viewModel.VideoUrl;          
        }
    }
}