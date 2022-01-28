using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using LaptopCatalog.ViewModels.Portait;
using LaptopCatalog.Models;
using System.Collections.Generic;
using System;

namespace LaptopCatalog.Views.Portait
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class PortaitLaptopsPage : ContentPage
    {
        public PortaitLaptopsPage(string selectedId, bool isListView)
        {
            var portaitLaptopsViewModel = new PortaitLaptopsViewModel(this, isListView);
            BindingContext = portaitLaptopsViewModel;

            InitializeComponent();

            portaitLaptopsViewModel.UpdateGrid();

            if (selectedId != "")
            {
                OpenLaptop(selectedId);
            }
        }

        private async void OpenLaptop(string id)
        {
            await Navigation.PushAsync(new PortaitLaptopPage(id));
        }

        public async void OnItemClicked(object sender, ItemTappedEventArgs e)
        {
            MessagingCenter.Send(Application.Current.MainPage, "SetId", ((Laptop)e.Item).Id);
            await Navigation.PushAsync(new PortaitLaptopPage(((Laptop)e.Item).Id));
            ListOfLaptops.SelectedItem = null;
        }

        private async void AddLaptopClicked(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new AddLaptopPage());
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
            MessagingCenter.Send(Application.Current.MainPage, "SetId", ((Button)sender).Text);
            await Navigation.PushAsync(new PortaitLaptopPage(((Button)sender).Text));
        }

        protected override void OnSizeAllocated(double width, double height)
        {
            base.OnSizeAllocated(width, height);
            if (width > height)
            {
                MessagingCenter.Send(Application.Current.MainPage, "ChangePageToFlyout");  
            }
        }
    }
}