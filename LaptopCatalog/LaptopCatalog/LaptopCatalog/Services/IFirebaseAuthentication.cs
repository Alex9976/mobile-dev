using System.Threading.Tasks;

namespace LaptopCatalog.Services
{
    public interface IFirebaseAuthentication
    {
        Task<bool> RegisterAsync(string email, string password);
        Task<bool> LoginAsync(string email, string password);
        bool SignOut();
        bool IsSignIn();
    }
}