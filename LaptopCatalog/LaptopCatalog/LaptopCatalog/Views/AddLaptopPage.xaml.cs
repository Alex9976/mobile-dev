using LaptopCatalog.ViewModels;
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
    public partial class AddLaptopPage : ContentPage
    {
        public AddLaptopPage()
        {
            var portaitAddLaptopViewModel = new PortaitAddLaptopViewModel(this);
            BindingContext = portaitAddLaptopViewModel;

            InitializeComponent();
        }

        public async void Close()
        {
            await Navigation.PopAsync();
        }
    }
}