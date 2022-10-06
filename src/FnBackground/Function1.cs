using Microsoft.Azure.WebJobs;
using Microsoft.Extensions.Logging;
using System.Threading;

namespace FnBackground
{
    public class Function1
    {
        [FunctionName("Function1")]
        public void Run([QueueTrigger("riojadotnet-queue", Connection = "QUEUE_CONNECTIONSTRING")] string myQueueItem, ILogger log)
        {
            Thread.Sleep(5000); // Do something...

            log.LogInformation($"C# Queue trigger function processed: {myQueueItem}");
        }
    }
}
