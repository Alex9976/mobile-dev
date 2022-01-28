using System.IO;
using System.Threading;
using System.Threading.Tasks;
using Firebase.Storage;
using LaptopCatalog.Services;

namespace XamarinApp.Droid.Services
{
    public class FirebaseStorageService : IFirebaseStorageService
    {
        private static readonly string StorageUrl = "laptop-catalog.appspot.com";
        private readonly FirebaseStorage _firebaseStorage = new FirebaseStorage(StorageUrl);

        public async Task<string> LoadImage(Stream fileStream, string fileName, string extension)
        {
            await _firebaseStorage.Child("images").Child($"{fileName}.{extension}")
                .PutAsync(fileStream, CancellationToken.None, "image/jpeg");

            return await _firebaseStorage.Child("images").Child($"{fileName}.{extension}").GetDownloadUrlAsync();
        }

        public async Task<string> LoadVideo(Stream fileStream, string fileName, string extension)
        {
            await _firebaseStorage.Child("videos").Child($"{fileName}.{extension}")
                .PutAsync(fileStream, CancellationToken.None, "video/mp4");

            return await _firebaseStorage.Child("videos").Child($"{fileName}.{extension}").GetDownloadUrlAsync();
        }

        public async Task RemoveImage(string fileName)
        {
            await _firebaseStorage
                .Child("images")
                .Child($"{fileName}.jpg")
                .DeleteAsync();
        }

        public async Task RemoveVideo(string fileName)
        {
            await _firebaseStorage
                .Child("videos")
                .Child($"{fileName}.mp4")
                .DeleteAsync();
        }
    }
}