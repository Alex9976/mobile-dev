using LaptopCatalog.Services;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace LaptopCatalog.Views.Landscape
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class FlyoutMainPageFlyout : ContentPage
    {
        public ListView ListView;

        public FlyoutMainPageFlyout()
        {
            InitializeComponent();

            BindingContext = new FlyoutMainPageFlyoutViewModel();
            ListView = MenuItemsListView;
        }

        private class FlyoutMainPageFlyoutViewModel : INotifyPropertyChanged
        {
            public ObservableCollection<FlyoutMainPageFlyoutMenuItem> MenuItems { get; set; }

            public FlyoutMainPageFlyoutViewModel()
            {
                MenuItems = new ObservableCollection<FlyoutMainPageFlyoutMenuItem>();
                MenuItems.Add(new FlyoutMainPageFlyoutMenuItem { Id = 0, Title = "Add laptop", TargetType = "Add", Icon="icon_add.png" });


                var firebaseDbService = DependencyService.Get<IFirebaseDatebaseService>();
                var laptops = firebaseDbService.GetAllLaptops();

                if (laptops != null)
                {
                    foreach (var item in laptops)
                    {
                        MenuItems.Add(new FlyoutMainPageFlyoutMenuItem { Id = 0, Title = item.Name, LaptopId = item.Id, TargetType = "Laptop", Icon = "icon_laptops.png" });
                    }
                }
            }

            #region INotifyPropertyChanged Implementation
            public event PropertyChangedEventHandler PropertyChanged;
            void OnPropertyChanged([CallerMemberName] string propertyName = "")
            {
                if (PropertyChanged == null)
                    return;

                PropertyChanged.Invoke(this, new PropertyChangedEventArgs(propertyName));
            }
            #endregion
        }
    }
}