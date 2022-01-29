using LaptopCatalog.Models;
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
        private Laptop _laptopId = null;
        private bool _listViewMode = true;

        public App()
        {
            InitializeComponent();
            MainPage = new NavigationPage(new LoginPage());

            MessagingCenter.Subscribe<Page>(this, "ChangePageToLaptops",
                (sender) =>
                {
                    var laptopPage = new PortaitLaptopsPage(_laptopId, _listViewMode);
                    var page = new NavigationPage(laptopPage);
                    if (_laptopId != null)
                    {
                        laptopPage.OpenLaptop(_laptopId);
                    }
                    Current.MainPage = page;
                });
            MessagingCenter.Subscribe<Page>(this, "ChangePageToFlyout",
               (sender) =>
               {
                   Current.MainPage = new FlyoutMainPage(_laptopId);
               });
            MessagingCenter.Subscribe<Page, Laptop>(this, "SetLaptop",
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
