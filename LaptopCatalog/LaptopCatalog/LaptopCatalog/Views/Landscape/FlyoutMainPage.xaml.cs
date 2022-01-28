using LaptopCatalog.Services;
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
    public partial class FlyoutMainPage : FlyoutPage
    {
        public FlyoutMainPage(string laptopId)
        {
            InitializeComponent();
            FlyoutPage.ListView.ItemSelected += ListView_ItemSelected;

            if (laptopId != "")
            {
                var firebaseDatebaseService = DependencyService.Get<IFirebaseDatebaseService>();

                var laptop = firebaseDatebaseService.GetLaptopById(laptopId);
                var page = new LandscapeLaptopPage(laptopId);
                Detail = new NavigationPage(page);
                IsPresented = false;
                page.Title = laptop.Name;
            }
        }

        private void ListView_ItemSelected(object sender, SelectedItemChangedEventArgs e)
        {
            var item = e.SelectedItem as FlyoutMainPageFlyoutMenuItem;
            if (item == null)
                return;

            var page = new Page();
            if (item.TargetType == "Laptop")
            {
                page = new LandscapeLaptopPage(item.LaptopId);
                MessagingCenter.Send(Application.Current.MainPage, "SetId", item.LaptopId);
            }
            if (item.TargetType == "Add")
            {
                page = new AddLaptopPage();
            }
            //var page = (Page)Activator.CreateInstance(item.TargetType);
            page.Title = item.Title;

            Detail = new NavigationPage(page);
            IsPresented = false;

            FlyoutPage.ListView.SelectedItem = null;
        }

        protected override void OnSizeAllocated(double width, double height)
        {
            base.OnSizeAllocated(width, height);
            if (width < height)
            {
                MessagingCenter.Send(Application.Current.MainPage, "ChangePageToLaptops");
            }
        }
    }
}