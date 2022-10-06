using Frontend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace Frontend.Pages
{
    public class HomeModel : PageModel
    {
        public async Task<IActionResult> OnGetAsync()
        {
            var directory = Path.Combine(Directory.GetCurrentDirectory(), "ficheros");

            if (Directory.Exists(directory))
            {
                ViewData["files"] = Directory.EnumerateFiles(directory)
                                         .Select(x => new FileInfo(x))
                                         .Select(f => new FileItem { Name = f.Name, Size = f.Length / 1000 })
                                         .ToList();
            }


            return Page();
        }
    }
}
