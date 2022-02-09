using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using LaptopCatalog.ViewModels;
using LaptopCatalog.Models;
using System.Collections.Generic;
using System;
using LaptopCatalog.Services;

namespace LaptopCatalog.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class LaptopsPage : ContentPage
    {
        LaptopsViewModel portaitLaptopsViewModel;

        public LaptopsPage(bool isListView)
        {
            portaitLaptopsViewModel = new LaptopsViewModel(this, isListView);
            BindingContext = portaitLaptopsViewModel;

            InitializeComponent();

            portaitLaptopsViewModel.UpdateGrid();
        }

        public async void OpenLaptop(Laptop laptop)
        {
            await Navigation.PushAsync(new LaptopPage(laptop, false));
        }

        public async void OpenAddLaptop(AddLaptopPage page)
        {
            await Navigation.PushAsync(page);
        }

        public async void OnItemClicked(object sender, ItemTappedEventArgs e)
        {
            MessagingCenter.Send(Application.Current.MainPage, "SetPage", (Laptop)e.Item as object);
            await Navigation.PushAsync(new LaptopPage((Laptop)e.Item, false));
            ListOfLaptops.SelectedItem = null;
        }

        private async void AddLaptopClicked(object sender, EventArgs e)
        {
            var page = new AddLaptopPage();
            MessagingCenter.Send(Application.Current.MainPage, "SetPage", page as object);
            await Navigation.PushAsync(page);
        }

        private async void FilterLaptopClicked(object sender, EventArgs e)
        {
            var page = new FilterPage(portaitLaptopsViewModel.filterOptions, portaitLaptopsViewModel);
            MessagingCenter.Send(Application.Current.MainPage, "SetPage", null as object);
            await Navigation.PushAsync(page);
        }

        public void AddLaptopsToGrid(List<Laptop> laptops)
        {
            var rows = (int)Math.Ceiling((decimal)laptops.Count / 3);
            grid.Children.Clear();
            
            for (int i = grid.RowDefinitions.Count; i < rows; i++)
            {
                grid.RowDefinitions.Add(new RowDefinition { Height = 110 });
            }

            for (int i = 0; i < rows; i++)
            {
                for (int j = 0; j < 3 && 3 * i + j < laptops.Count; j++)
                {
                    var image = new Image();
                    image.Source = laptops[3 * i + j].Image.DownloadUrl;
                    grid.Children.Add(image, j, i);

                    var button = new Button();
                    button.Text = laptops[3 * i + j].Id;
                    button.BackgroundColor = Color.Transparent;
                    button.TextColor = Color.Transparent;
                    button.Clicked += GridItemClicked;
                    grid.Children.Add(button, j, i);
                }
            }
        }

        private async void GridItemClicked(object sender, EventArgs e)
        {
            var firebaseDatebaseService = DependencyService.Get<IFirebaseDatebaseService>();
            var laptop = firebaseDatebaseService.GetLaptopById(((Button)sender).Text);

            MessagingCenter.Send(Application.Current.MainPage, "SetPage", laptop as object);
            await Navigation.PushAsync(new LaptopPage(laptop, false));
        }

        protected override void OnSizeAllocated(double width, double height)
        {
            base.OnSizeAllocated(width, height);
            if (width > height)
            {
                MessagingCenter.Send(Application.Current.MainPage, "ChangePageToFlyout");  
            }
        }

        private void ToolbarItem_Clicked(object sender, EventArgs e)
        {
            MessagingCenter.Send(Application.Current.MainPage, "SetPage", null as object);
        }
    }
}