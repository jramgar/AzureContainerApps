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
        private readonly ILogger<IndexModel> _logger;
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly BackendOptions _backendOptions;
        public IndexModel(ILogger<IndexModel> logger, IHttpClientFactory httpClientFactory, IOptions<BackendOptions> backendOptions)
        {
            _logger = logger;
            _httpClientFactory = httpClientFactory;
            _backendOptions = backendOptions.Value;
        }

        public async Task<IActionResult> OnGetAsync()
        {
            ViewData["weatherForecast"] = await GetWeatherForecasts();
            ViewData["Claims"] = GetClaims();            

            return Page();
        }

        private Task<IEnumerable<WeatherForecast>> GetWeatherForecasts()
        {
            var httpClient = _httpClientFactory.CreateClient();
            var url = $"{_backendOptions.BaseUrl}/weatherforecast";
            return httpClient.GetFromJsonAsync<IEnumerable<WeatherForecast>>(url);
        }
        private IEnumerable<Claim> GetClaims()
        {
            var user = HttpContext.User;
            return user.Claims;
        }

    
    }
}