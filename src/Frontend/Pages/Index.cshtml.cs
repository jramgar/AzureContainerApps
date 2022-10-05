using Frontend.Models;
using Frontend.Options;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Options;
using System.Security.Claims;

namespace Frontend.Pages
{
    public class IndexModel : PageModel
    {
        //private readonly ILogger<IndexModel> _logger;
        //private readonly IHttpClientFactory _httpClientFactory;
        //private readonly BackendOptions _backendOptions;
        //public IndexModel(ILogger<IndexModel> logger) //, IHttpClientFactory httpClientFactory, IOptions<BackendOptions> backendOptions)
        //{
        //    //_logger = logger;
        //    //_httpClientFactory = httpClientFactory;
        //    //_backendOptions = backendOptions.Value;
        //}

        public IActionResult OnGet()
        {
            //var httpClient = _httpClientFactory.CreateClient();
            //var url = $"{_backendOptions.BaseUrl}/weatherforecast";
            //var weatherForecast = await httpClient.GetFromJsonAsync<IEnumerable<WeatherForecast>>(url);
            //ViewData["weatherForecast"] = weatherForecast;
            //return Page();
            ViewData["Claims"] = GetClaims();
            return Page();
        }

        private IEnumerable<Claim> GetClaims()
        {
            var user = HttpContext.User;
            return user.Claims;
        }
    }
}