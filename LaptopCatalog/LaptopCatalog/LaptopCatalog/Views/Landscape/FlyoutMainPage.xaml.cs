using LaptopCatalog.Models;
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
        public FlyoutMainPage(Laptop laptop)
        {
            InitializeComponent();
            FlyoutPage.ListView.ItemSelected += ListView_ItemSelected;

            if (laptop != null)
            {
                var page = new LandscapeLaptopPage(laptop);
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
                page = new LandscapeLaptopPage(item.Laptop);
                MessagingCenter.Send(Application.Current.MainPage, "SetLaptop", item.Laptop);
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