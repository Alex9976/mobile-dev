using System;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using LaptopCatalog.ViewModels;

namespace LaptopCatalog.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class LoginPage : ContentPage
    {
        private readonly LoginViewModel _loginViewModel = new LoginViewModel();

        public LoginPage()
        {
            BindingContext = _loginViewModel;
            InitializeComponent();
        }

        public async void TapGestureRecognizerTapped(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new RegisterPage());
        }

        protected override void OnSizeAllocated(double width, double height)
        {
            base.OnSizeAllocated(width, height);
            _loginViewModel.IsLandscape = width > height;
        }
    }
}