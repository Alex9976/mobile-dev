using LaptopCatalog.Models;
using LaptopCatalog.ViewModels;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace LaptopCatalog.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class LaptopPage : ContentPage
    {
        public LaptopPage(Laptop laptop, bool isLandscape)
        {
            var viewModel = new LaptopViewModel(laptop);
            BindingContext = viewModel;
            InitializeComponent();

            stackLayout.Orientation = isLandscape ? StackOrientation.Horizontal : StackOrientation.Vertical;

            //player.Source = viewModel.VideoUrl;          
        }
    }
}