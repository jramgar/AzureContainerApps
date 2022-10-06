using Frontend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace Frontend.Pages
{
    public class HomeModel : PageModel
    {
        public async Task<IActionResult> OnGetAsync()
        {
            var myLog = new List<string>();

            try
            {
                myLog.Add($"Directory.GetCurrentDirectory: {Directory.GetCurrentDirectory()}");


                var rootDirectories = Directory.EnumerateDirectories(Directory.GetCurrentDirectory());
                ViewData["root"] = rootDirectories;



                var directory = Path.Combine(Directory.GetCurrentDirectory(), "ficheros");

                if (Directory.Exists(directory))
                {
                    myLog.Add($"directory exists: {directory}");

                    ViewData["files"] = Directory.EnumerateFiles(directory)
                                             .Select(x => new FileInfo(x))
                                             .Select(f => new FileItem { Name = f.Name, Size = f.Length })
                                             .ToList();
                }
                else
                {
                    Directory.CreateDirectory(directory);

                    myLog.Add($"directory not exists: {directory}, created!");
                }
            }
            catch (Exception ex)
            {
                myLog.Add($"Error: {ex}");
            }
            ViewData["mylog"] = myLog;


            return Page();
        }
    }
}
