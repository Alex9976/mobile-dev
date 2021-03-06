using LaptopCatalog.Models;
using LaptopCatalog.Services;
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
    public partial class FlyoutMainPage : FlyoutPage
    {
        public FlyoutMainPage(object page)
        {
            InitializeComponent();
            FlyoutPage.ListView.ItemSelected += ListView_ItemSelected;

            if (page != null)
            {
                if (page is Laptop)
                {
                    var laptopPage = new LaptopPage(page as Laptop, true);
                    Detail = new NavigationPage(laptopPage);
                    IsPresented = false;
                    laptopPage.Title = (page as Laptop).Name;
                } else if (page is AddLaptopPage)
                {
                    var addPage = new AddLaptopPage();
                    addPage.Title = "Add laptop";
                    Detail = new NavigationPage(addPage);
                }
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
                page = new LaptopPage(item.Laptop, true);
                MessagingCenter.Send(Application.Current.MainPage, "SetPage", item.Laptop as object);
            }
            if (item.TargetType == "Add")
            {
                page = new AddLaptopPage();
                MessagingCenter.Send(Application.Current.MainPage, "SetPage", page as object);
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