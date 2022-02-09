using LaptopCatalog.Models;
using LaptopCatalog.ViewModels;
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
    public partial class FilterPage : ContentPage
    {
        private FilterOptions _filterOptions;
        LaptopsViewModel _portaitLaptopsViewModel;

        public FilterPage(FilterOptions filterOptions, LaptopsViewModel portaitLaptopsViewModel)
        {
            _filterOptions = filterOptions;
            _portaitLaptopsViewModel = portaitLaptopsViewModel;

            InitializeComponent();

            ProcessorModel.Text = _filterOptions.ProcessorModel;
            Type.Text = _filterOptions.Type;
            MinRamSize.Text = _filterOptions.MinRamSize == 0 ? "" : _filterOptions.MinRamSize.ToString();
            MaxRamSize.Text = _filterOptions.MaxRamSize == 0 ? "" : _filterOptions.MaxRamSize.ToString();

            MinRomSize.Text = _filterOptions.MinRomSize == 0 ? "" : _filterOptions.MinRomSize.ToString();
            MaxRomSize.Text = _filterOptions.MaxRomSize == 0 ? "" : _filterOptions.MaxRomSize.ToString();

            MinPrice.Text = _filterOptions.MinPrice == 0 ? "" : _filterOptions.MinPrice.ToString();
            MaxPrice.Text = _filterOptions.MaxRomSize == 0 ? "" : _filterOptions.MaxPrice.ToString();
        }

        private void Button_Clicked(object sender, EventArgs e)
        {
            _filterOptions.clear();

            ProcessorModel.Text = "";
            Type.Text = "";
            MinRamSize.Text = "";
            MaxRamSize.Text = "";

            MinRomSize.Text = "";
            MaxRomSize.Text = "";

            MinPrice.Text = "";
            MaxPrice.Text = "";
            _portaitLaptopsViewModel.UpdateFilter();
        }

        private async void Button_Clicked_1(object sender, EventArgs e)
        {
            if (IsCorrectFields())
            {
                var minrams = int.Parse(MinRamSize.Text == "" ? "0" : MinRamSize.Text);
                var maxrams = int.Parse(MaxRamSize.Text == "" ? "0" : MaxRamSize.Text);
                var minroms = int.Parse(MinRomSize.Text == "" ? "0" : MinRomSize.Text);
                var maxroms = int.Parse(MaxRomSize.Text == "" ? "0" : MaxRomSize.Text);
                var minp = decimal.Parse(MinPrice.Text == "" ? "0" : MinPrice.Text);
                var maxp = decimal.Parse(MaxPrice.Text == "" ? "0" : MaxPrice.Text);

                _filterOptions.MinPrice = minp;
                _filterOptions.MaxPrice = maxp;
                _filterOptions.MinRamSize = minrams;
                _filterOptions.MaxRamSize = maxrams;
                _filterOptions.MinRomSize = minroms;
                _filterOptions.MaxRomSize = maxroms;
                _filterOptions.Type = Type.Text;
                _filterOptions.ProcessorModel = ProcessorModel.Text;
                _portaitLaptopsViewModel.UpdateFilter();
                await Navigation.PopAsync();
            }
            else
            {
                await Application.Current.MainPage.DisplayAlert("Fields filled in incorrectly",
                    "Please fill in the fields with correct data", "OK");
            }
        }

        private bool IsCorrectFields()
        {
            try
            {
                _ = int.Parse(MinRamSize.Text == "" ? "0" : MinRamSize.Text);
                _ = int.Parse(MaxRamSize.Text == "" ? "0" : MaxRamSize.Text);
                _ = int.Parse(MinRomSize.Text == "" ? "0" : MinRomSize.Text);
                _ = int.Parse(MaxRomSize.Text == "" ? "0" : MaxRomSize.Text);
                _ = decimal.Parse(MinPrice.Text == "" ? "0" : MinPrice.Text);
                _ = decimal.Parse(MaxPrice.Text == "" ? "0" : MaxPrice.Text);

                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}