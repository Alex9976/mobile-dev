using LaptopCatalog.Models;
using LaptopCatalog.Services;
using LaptopCatalog.Views;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace LaptopCatalog.ViewModels
{
    public class LaptopsViewModel : BaseViewModel
    {
        private bool _isListView;
        private bool _isRefreshing;
        private LaptopsPage _page;
        private FilterOptions _filterOptions;

        public List<Laptop> Laptops { get; set; }
        public List<Laptop> Items
        {
            get => getFilterLaptops();
        }
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

        public LaptopsViewModel(LaptopsPage page, bool isListView)
        {
            _page = page;
            _isListView = isListView;
            _filterOptions = new FilterOptions();

            var firebaseDbService = DependencyService.Get<IFirebaseDatebaseService>();

            RefreshCommand = new Command(Refresh);
            ChangeView = new Command(OnChangeView);

            var laptops = firebaseDbService.GetAllLaptops();

            Laptops = laptops != null ? laptops : new List<Laptop>();
        }

        public void UpdateGrid()
        {
            _page.AddLaptopsToGrid(Items);
        }

        private async void Refresh(object obj)
        {
            IsRefreshing = true;

            var firebaseDbService = DependencyService.Get<IFirebaseDatebaseService>();
            var laptops = firebaseDbService.GetAllLaptops();

            if (laptops != null)
                Laptops = laptops;

            if (!_isListView)
                _page.AddLaptopsToGrid(Items);


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
                _page.AddLaptopsToGrid(Items);

            MessagingCenter.Send(Application.Current.MainPage, "SetListView", _isListView);
        }

        private List<Laptop> getFilterLaptops()
        {
            var CurrentList = new List<Laptop>(Laptops);
            if (_filterOptions.ProcessorModel != null && _filterOptions.ProcessorModel.Length > 0)
                CurrentList = Laptops.FindAll(x => x.ProcessorModel.ToLower().Contains(_filterOptions.ProcessorModel.ToLower()));
            if (_filterOptions.MaxRamSize != 0)
                CurrentList = Laptops.FindAll(x => x.RamSize <= _filterOptions.MaxRamSize);
            CurrentList = Laptops.FindAll(x => x.RamSize >= _filterOptions.MinRamSize);
            if (_filterOptions.MaxRomSize != 0)
                CurrentList = Laptops.FindAll(x => x.RomSize <= _filterOptions.MaxRomSize);
            CurrentList = Laptops.FindAll(x => x.RomSize >= _filterOptions.MinRomSize);
            if (_filterOptions.MaxPrice != 0)
                CurrentList = Laptops.FindAll(x => x.Price <= _filterOptions.MaxPrice);
            CurrentList = Laptops.FindAll(x => x.Price >= _filterOptions.MinPrice);
            if (_filterOptions.Type != null && _filterOptions.Type.Length > 0)
                CurrentList = Laptops.FindAll(x => x.Type.ToLower().Contains(_filterOptions.Type.ToLower()));

            return CurrentList;
        } 
    }
}
