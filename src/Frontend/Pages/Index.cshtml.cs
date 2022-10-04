using Frontend.Models;
using Frontend.Options;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Options;
using System.Net.Http.Json;

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

        //public async Task<IActionResult> OnGetAsync()
        //{
        //    var httpClient = _httpClientFactory.CreateClient();
        //    var url = $"{_backendOptions.BaseUrl}/weatherforecast";
        //    var weatherForecast = await httpClient.GetFromJsonAsync<IEnumerable<WeatherForecast>>(url);
        //    ViewData["weatherForecast"] = weatherForecast;
        //    return Page();
        //}
    }
}