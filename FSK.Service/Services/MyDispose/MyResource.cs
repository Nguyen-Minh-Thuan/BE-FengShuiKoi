using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FSK.Service.Services.MyDispose
{
    public class MyResource : IAsyncDisposable
    {
        public MyResource()
        {
            // Constructor logic (e.g., open a connection, allocate resources)
            Console.WriteLine("Resource allocated.");
        }

        // Simulating some async operation
        public async Task PerformAsyncOperation()
        {
            await Task.Delay(1000);  // Simulate an async operation
            Console.WriteLine("Async operation performed.");
        }

        // Implementing the DisposeAsync method
        public async ValueTask DisposeAsync()
        {
            // Logic to clean up the resource asynchronously
            await Task.Delay(500);  // Simulate cleanup operation
            Console.WriteLine("Resource cleaned up asynchronously.");
        }
    }
}
