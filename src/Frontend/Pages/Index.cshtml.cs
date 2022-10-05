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
        public IActionResult OnGet()
        {
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