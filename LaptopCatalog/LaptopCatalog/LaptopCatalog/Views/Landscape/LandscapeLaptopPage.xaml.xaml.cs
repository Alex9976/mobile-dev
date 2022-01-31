using LaptopCatalog.Models;
using LaptopCatalog.ViewModels;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace LaptopCatalog.Views.Landscape
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class LandscapeLaptopPage : ContentPage
    {
        public LandscapeLaptopPage(Laptop laptop)
        {
            var viewModel = new LaptopViewModel(laptop);
            BindingContext = viewModel;
            InitializeComponent();

            //player.Source = viewModel.VideoUrl;          
        }
    }
}