using LaptopCatalog.Models;
using LaptopCatalog.Views;
using System;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace LaptopCatalog
{
    public partial class App : Application
    {
        private object _page = null;
        private bool _listViewMode = true;

        public App()
        {
            InitializeComponent();
            MainPage = new NavigationPage(new LoginPage());

            MessagingCenter.Subscribe<Page>(this, "ChangePageToLaptops",
                (sender) =>
                {
                    var laptopPage = new LaptopsPage(_listViewMode);
                    var page = new NavigationPage(laptopPage);
                    if (_page != null)
                    {
                        if (_page is Laptop)
                        {
                            laptopPage.OpenLaptop(_page as Laptop);
                        }
                        else if (_page is AddLaptopPage) {
                            laptopPage.OpenAddLaptop(new AddLaptopPage());
                        }
                    }
                    Current.MainPage = page;
                });
            MessagingCenter.Subscribe<Page>(this, "ChangePageToFlyout",
               (sender) =>
               {
                   Current.MainPage = new FlyoutMainPage(_page);
               });
            MessagingCenter.Subscribe<Page, object>(this, "SetPage",
               (sender, args) =>
               {
                   _page = args;
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
