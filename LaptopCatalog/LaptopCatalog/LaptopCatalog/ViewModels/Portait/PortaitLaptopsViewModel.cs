using LaptopCatalog.Models;
using LaptopCatalog.Services;
using LaptopCatalog.Views.Portait;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace LaptopCatalog.ViewModels.Portait
{
    public class PortaitLaptopsViewModel : BaseViewModel
    {
        private bool _isListView;
        private bool _isRefreshing;
        private PortaitLaptopsPage _page;

        public List<Laptop> Laptops { get; set; }
        public Command RefreshCommand { get; }
        public Command ChangeView { get; }

        public string ViewIcon { get => _isListView ? "icon_list.png" : "icon_grid.png"; }
        public bool IsListView { get => _isListView; }
        public bool IsGridView { get => !_isListView; }

        public bool IsRefreshing
        {
            get { return _isRefreshing; }
            set
            {
                _isRefreshing = value;
                OnPropertyChanged();
            }
        }

        public PortaitLaptopsViewModel(PortaitLaptopsPage page, bool isListView)
        {
            _page = page;
            _isListView = isListView;

            var firebaseDbService = DependencyService.Get<IFirebaseDatebaseService>();

            RefreshCommand = new Command(Refresh);
            ChangeView = new Command(OnChangeView);

            var laptops = firebaseDbService.GetAllLaptops();

            Laptops = laptops != null ? laptops : new List<Laptop>();
        }

        public void UpdateGrid()
        {
            _page.AddLaptopsToGrid(Laptops);
        }

        private async void Refresh(object obj)
        {
            IsRefreshing = true;

            var firebaseDbService = DependencyService.Get<IFirebaseDatebaseService>();
            var laptops = firebaseDbService.GetAllLaptops();

            if (laptops != null)
                Laptops = laptops;

            if (!_isListView)
                _page.AddLaptopsToGrid(Laptops);


            await Task.Delay(200);
            OnPropertyChanged("Laptops");
            IsRefreshing = false;
        }

        private void OnChangeView(object obj)
        {
            _isListView = !_isListView;

            OnPropertyChanged("IsListView");
            OnPropertyChanged("IsGridView");
            OnPropertyChanged("ViewIcon");

            if (!_isListView)
                _page.AddLaptopsToGrid(Laptops);

            MessagingCenter.Send(Application.Current.MainPage, "SetListView", _isListView);
        }
    }
}
