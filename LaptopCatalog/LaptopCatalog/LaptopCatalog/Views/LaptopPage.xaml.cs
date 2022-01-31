using LaptopCatalog.Models;
using LaptopCatalog.ViewModels;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace LaptopCatalog.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class LaptopPage : ContentPage
    {
        private readonly LaptopViewModel _viewModel;
        private readonly bool _isLandscape;
        public LaptopPage(Laptop laptop, bool isLandscape)
        {
            _viewModel = new LaptopViewModel(laptop);
            BindingContext = _viewModel;
            InitializeComponent();

            stackLayout.Orientation = isLandscape ? StackOrientation.Horizontal : StackOrientation.Vertical;
            _isLandscape = isLandscape;
            //player.Source = viewModel.VideoUrl;          
        }

        private void Button_Clicked(object sender, System.EventArgs e)
        {
            player.AutoPlay = false;
            player.Source = _viewModel.VideoUrl;
            //player.Source = "https://firebasestorage.googleapis.com/v0/b/laptop-catalog.appspot.com/o/videos%2Fvideo_small.mp4?alt=media&token=fbe9cd92-30ed-4c7e-9012-aebed74b5f8f";
        }
    }
}