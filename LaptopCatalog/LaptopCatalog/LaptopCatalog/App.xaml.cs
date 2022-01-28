using LaptopCatalog.Views;
using LaptopCatalog.Views.Landscape;
using LaptopCatalog.Views.Portait;
using System;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace LaptopCatalog
{
    public partial class App : Application
    {
        private string _laptopId = "";
        private bool _listViewMode = true;

        public App()
        {
            InitializeComponent();
            MainPage = new NavigationPage(new LoginPage());

            MessagingCenter.Subscribe<Page>(this, "ChangePageToLaptops",
                (sender) =>
                {
                    Current.MainPage = new NavigationPage(new PortaitLaptopsPage(_laptopId, _listViewMode));
                });
            MessagingCenter.Subscribe<Page>(this, "ChangePageToFlyout",
               (sender) =>
               {
                   Current.MainPage = new FlyoutMainPage(_laptopId);// _flyoutPage;
                });
            MessagingCenter.Subscribe<Page, string>(this, "SetId",
               (sender, args) =>
               {
                   _laptopId = args;
               });

            MessagingCenter.Subscribe<Page, bool>(this, "SetListView",
               (sender, args) =>
               {
                   _listViewMode = args;
               });
        }

        protected override void OnStart()
        {
        }

        protected override void OnSleep()
        {
        }

        protected override void OnResume()
        {
        }
    }
}
