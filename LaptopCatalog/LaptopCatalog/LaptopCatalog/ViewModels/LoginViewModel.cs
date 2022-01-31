using LaptopCatalog.Services;
using LaptopCatalog.Views;
using System.Windows.Input;
using Xamarin.Forms;

namespace LaptopCatalog.ViewModels
{
    public class LoginViewModel : BaseViewModel
    {
        private readonly IFirebaseAuthentication _firebaseAuthentication;
        private readonly IFirebaseDatebaseService _firebaseDbService;

        public string Email { get; set; }
        public string Password { get; set; }
        public bool IsLandscape { get; set; }

        public Command LoginCommand { get; }

        public LoginViewModel()
        {
            LoginCommand = new Command(OnLoginClicked);

            _firebaseAuthentication = DependencyService.Get<IFirebaseAuthentication>();
            _firebaseDbService = DependencyService.Get<IFirebaseDatebaseService>();
        }

        private async void OnLoginClicked(object obj)
        {
            bool isAuthSuccessful = await _firebaseAuthentication.LoginAsync(Email, Password);

            if (isAuthSuccessful)
            {
                if (IsLandscape)
                {
                    MessagingCenter.Send(Application.Current.MainPage, "ChangePageToFlyout");
                }
                else
                {
                    MessagingCenter.Send(Application.Current.MainPage, "ChangePageToLaptops");
                }

                
            }
            else
            {
                await Application.Current.MainPage.DisplayAlert("Login error",
                    "Logout Failed", "OK");
            }
        }
    }
}