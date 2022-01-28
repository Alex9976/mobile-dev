using LaptopCatalog.Models;
using LaptopCatalog.Services;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using System.Windows.Input;
using Xamarin.Forms;

namespace LaptopCatalog.ViewModels.Portait
{
    public class PortaitLaptopViewModel : BaseViewModel
    {
        public Laptop Laptop { get; set; }

        private readonly IFirebaseDatebaseService _firebaseDatebaseService;
        private readonly IFirebaseStorageService _firebaseStorageService;

        public string Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Type { get; set; }
        public string ProcessorModel { get; set; }
        public string RamSize { get; set; }
        public string RomSize { get; set; }
        public string Price { get; set; }

        public string ImageUrl { get; set; }
        public string ImageName { get; set; }
        public string VideoUrl { get; set; }
        public string VideoName { get; set; }

        public ICommand ViewImage { get; }
        public ICommand ViewVideo { get; }
        public ICommand Save { get; }

        public PortaitLaptopViewModel(string id)
        {
            _firebaseDatebaseService = DependencyService.Get<IFirebaseDatebaseService>();
            _firebaseStorageService = DependencyService.Get<IFirebaseStorageService>();

            Laptop = _firebaseDatebaseService.GetLaptopById(id);

            Id = id;
            Name = Laptop.Name;
            Description = Laptop.Description;
            Type = Laptop.Type;
            ProcessorModel = Laptop.ProcessorModel;
            RamSize = Laptop.RamSize.ToString();
            RomSize = Laptop.RomSize.ToString();
            Price = Laptop.Price.ToString(CultureInfo.InvariantCulture);
            ImageUrl = Laptop.Image.DownloadUrl;
            ImageName = Laptop.Image.FileName;
            VideoUrl = Laptop.Video.DownloadUrl ?? "";
            VideoName = Laptop.Video.FileName;

            ViewImage = new Command(OnViewImageButtonClicked);
            ViewVideo = new Command(OnViewVideoButtonClicked);
        }

        private async void OnViewImageButtonClicked()
        {
            //await Application.Current.MainPage.Navigation.PushAsync(new ViewImagePage(ImageUrl));
        }

        private async void OnViewVideoButtonClicked()
        {
            if (!string.IsNullOrEmpty(VideoUrl))
            {
                //await Application.Current.MainPage.Navigation.PushAsync(new ViewVideoPage(VideoUrl));
            }
            else
            {
                //await Application.Current.MainPage.DisplayAlert(AppContentText.NotFoundTitle,
                //    AppContentText.VideoNotFoundMessage, AppContentText.OkButton);
            }
        }
    }
}
