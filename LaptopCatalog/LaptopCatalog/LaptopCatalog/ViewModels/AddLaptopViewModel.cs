using LaptopCatalog.Models;
using LaptopCatalog.Services;
using LaptopCatalog.Views;
using System;
using System.Threading.Tasks;
using System.Windows.Input;
using Xamarin.Essentials;
using Xamarin.Forms;

namespace LaptopCatalog.ViewModels
{
    public class PortaitAddLaptopViewModel : BaseViewModel
    {
        private AddLaptopPage _page;
        private readonly IFirebaseDatebaseService _firebaseDatebaseService;
        private readonly IFirebaseStorageService _firebaseStorageService;

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

        public ICommand AddImage { get; }
        public ICommand AddVideo { get; }
        public ICommand Save { get; }

        private FileResult _image;
        private FileResult _video;

        public PortaitAddLaptopViewModel(AddLaptopPage page)
        {
            _page = page;
            _firebaseDatebaseService = DependencyService.Get<IFirebaseDatebaseService>();
            _firebaseStorageService = DependencyService.Get<IFirebaseStorageService>();

            Save = new Command(OnSaveButtonClicked);
            AddImage = new Command(OnAddImageButtonClicked);
            AddVideo = new Command(OnAddVideoButtonClicked);
        }

        private async void OnAddImageButtonClicked()
        {
            _image = await MediaPicker.PickPhotoAsync(new MediaPickerOptions { Title = "Select image" });
        }

        private async Task<string> LoadImage()
        {
            if (_image == null)
            {
                return null;
            }

            string extension = _image.FileName.Split('.')[1];
            var stream = await _image.OpenReadAsync();
            ImageName = Guid.NewGuid().ToString();
            return await _firebaseStorageService.LoadImage(stream, ImageName, extension);
        }

        private async void OnAddVideoButtonClicked()
        {
            _video = await MediaPicker.PickVideoAsync(new MediaPickerOptions { Title = "Select video" });
        }

        private async Task<string> LoadVideo()
        {
            if (_video == null)
            {
                return null;
            }

            string extension = _video.FileName.Split('.')[1];
            var stream = await _video.OpenReadAsync();
            VideoName = Guid.NewGuid().ToString();
            return await _firebaseStorageService.LoadVideo(stream, VideoName, extension);
        }

        private async void OnSaveButtonClicked()
        {
            if (IsCorrectFields())
            {
                ImageUrl = await LoadImage();
                VideoUrl = await LoadVideo();

                var computer = new Laptop
                {
                    Id = Guid.NewGuid().ToString(),
                    Name = Name,
                    Description = Description,
                    Type = Type,
                    ProcessorModel = ProcessorModel,
                    RamSize = int.Parse(RamSize),
                    RomSize = int.Parse(RomSize),
                    Price = decimal.Parse(Price),
                    Image = new CloudFileData
                    {
                        FileName = ImageName,
                        DownloadUrl = ImageUrl
                    },
                    Video = new CloudFileData
                    {
                        FileName = VideoName,
                        DownloadUrl = VideoUrl
                    }
                };

                await _firebaseDatebaseService.AddLaptop(computer);
                _page.Close();
            }
            else
            {
                await Application.Current.MainPage.DisplayAlert("Fields filled in incorrectly",
                    "Please fill in the fields with correct data", "OK");
            }
        }

        private bool IsCorrectFields()
        {
            if (!string.IsNullOrWhiteSpace(Name) || !string.IsNullOrWhiteSpace(Description) ||
                !string.IsNullOrWhiteSpace(Type) || !string.IsNullOrWhiteSpace(ProcessorModel))
            {
                try
                {
                    _ = int.Parse(RamSize);
                    _ = int.Parse(RomSize);
                    _ = decimal.Parse(Price);

                    return true;
                }
                catch
                {
                    return false;
                }
            }

            return false;
        }
    }
}