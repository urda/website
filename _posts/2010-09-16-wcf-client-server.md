---
title: 'Windows Communication Foundation - A Simple Client and Server'
layout: post
redirect_from: /2010/09/wcf-client-server/

urda_uuid: 20100916

categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - WCF
---

Windows Communication Foundation (or WCF for short) is an interface located
inside the .NET Framework for creating connected, service-oriented applications.
We can use C# and Visual Studio 2010 to build a simple WCF Client and WCF
Server. We will start by developing the server and the service it will provide,
and from that we can build a WCF Client based on that very server.

First we need to setup our project...

1. Start Visual Studio 2010 as an Administrator

2. Create a new **Console Application**, you can name it **WCF.Tutorial.Server**

3. Change the default **Service** namespace to
   **Microsoft.ServiceModel.Samples**

  1. Open the **Properties** of the of the solution

  2. Select the **Application** Tab

  3. Change the box **Default Namespace** to **Microsoft.ServiceModel.Samples**

4. You will need to add a reference to **System.ServiceModel.dll** in your new
   project.

5. Rename **Program.cs** to **Server.cs**

6. Update the namespace line inside **Server.cs** to
   **Microsoft.ServiceModel.Samples**

7. Add **using System.ServiceModel;** to your **Server.cs** file.

...and NOW we are ready to build our interface for the service. In this case we
are going to build a calculator.

```csharp
using System;
using System.ServiceModel;
using System.ServiceModel.Description;

namespace Microsoft.ServiceModel.Samples
{
    [ServiceContract(Namespace = "http://Microsoft.ServiceModel.Samles")]
    public interface ICalculator
    {
        [OperationContract]
        double Add(double n1, double n2);
        [OperationContract]
        double Subtract(double n1, double n2);
        [OperationContract]
        double Multiply(double n1, double n2);
        [OperationContract]
        double Divide(double n1, double n2);
    }

    public class CalculatorService : ICalculator
    {
        public double Add(double n1, double n2)
        {
            double result = n1 + n2;
            Console.WriteLine("Received Add({0},{1})", n1, n2);
            // Code added to write output to the console.
            Console.WriteLine("Return: {0}", result);
            return result;
        }

        public double Subtract(double n1, double n2)
        {
            double result = n1 - n2;
            Console.WriteLine("Received Subtract({0},{1})", n1, n2);
            Console.WriteLine("Return: {0}", result);
            return result;
        }

        public double Multiply(double n1, double n2)
        {
            double result = n1 * n2;
            Console.WriteLine("Received Multiply({0},{1})", n1, n2);
            Console.WriteLine("Return: {0}", result);
            return result;
        }

        public double Divide(double n1, double n2)
        {
            double result = n1 / n2;
            Console.WriteLine("Recieved Divide({0},{1})", n1, n2);
            Console.WriteLine("Return: {0}", result);
            return result;
        }
    }

    class Server
    {
        static void Main(string[] args)
        {
            Uri BaseAddress = new Uri("http://localhost:8000/ServiceModelSamples/Service");

            ServiceHost SelfHost = new ServiceHost(typeof(CalculatorService), BaseAddress);
            try
            {
                SelfHost.AddServiceEndpoint(
                        typeof(ICalculator),
                        new WSHttpBinding(),
                        "CalculatorService");

                ServiceMetadataBehavior smb = new ServiceMetadataBehavior();
                smb.HttpGetEnabled = true;
                SelfHost.Description.Behaviors.Add(smb);

                SelfHost.Open();
                Console.WriteLine("The service is ready.");
                Console.WriteLine("Press <ENTER> to terminate service.");
                Console.WriteLine();
                Console.ReadLine();

                // Close the ServiceHostBase to shutdown the service.
                SelfHost.Close();
            }
            catch (CommunicationException ce)
            {
                Console.WriteLine("An exception occured: {0}", ce.Message);
                SelfHost.Abort();
            }
        }
    }
}
```

The first block of code defines our calculator interface, or **ICalculator**. We
have directives before each method, named **OperationContractAttribute**, that
define what portions of this interface are being exposed for the WCF contract.
Pretty straight forward.

Then our second block of code actually defines our **CalculatorService**. We
have added some *Console.WriteLine* statements that will appear when we start
the service up. Again, the operations this calculator is doing are very simple
and could easily be added to a standalone program. However, we will be using
this to demonstrate how to setup a WCF client-server environment.

Our final block of code defines the *Server* class. This will be in charge of
spinning up the application and listening on a specified host and port number.
In this case it will listen from localhost on port 8000. We declare a new
service host, and attempt to bind the server to it. If it fails we catch the
error and dump it to screen. If not, it will fire up the service and be ready
for use! So go ahead and run your project (without debugging) and after it
starts verify that the server is running by opening your web browser and
navigating to **http://localhost:8000/ServiceModelSamples/Service**. You'll see
a screen like this:

[![WCF Server, Web Browser Page](/content/{{ page.urda_uuid }}/WCFServerHTTP.png)](/content/{{ page.urda_uuid }}/WCFServerHTTP.png)

Now we can just leave that running, and go ahead and build our Client project.
Just do the following...

1. Add a new project to the root of your Solution. Choose
   **Console Application** and name it **WCF.Tutorial.Client**
2. Add a reference to **System.ServiceModel.dll** to the new project
3. Rename **Program.cs** to **Client.cs**
4. Add **using System.ServiceModel;** to the source code.

Now here is where we can use Visual Studio to build some code for us. Go ahead
and open up the **Visual Studio 2010 Command Prompt** from your Program Files.
Inside the command prompt navigate to the location of your client code project.

Now when you are inside the directory you want the generated code to be placed,
run this command:

```powershell
svcutil.exe /language:cs /out:generatedProxy.cs /config:app.config http://localhost:8000/ServiceModelSamples/service
```

Now all you have to do is add the **generatedProxy** file to your project. That
should be as simple as clicking **Show All Files** and then
**Include in Project**.

Now let's define the client:

```csharp
using System;
using System.ServiceModel;
using System.Text;

namespace Client
{
    class Client
    {
        static void Main(string[] args)
        {
            // Step 1: Create an endpoint address and an instance of the WCF client
            CalculatorClient client = new CalculatorClient();

            // Step 2: Call the service operations.
            // Call Add
            double value1 = 100.00D;
            double value2 = 15.99D;
            double result = client.Add(value1, value2);
            Console.WriteLine("Add({0},{1}) = {2}", value1, value2, result);

            // Call Subtract
            value1 = 145.00D;
            value2 = 76.54D;
            result = client.Subtract(value1, value2);
            Console.WriteLine("Subtract({0},{1}) = {2}", value1, value2, result);

            // Call Multiply
            value1 = 9.00D;
            value2 = 81.25D;
            result = client.Multiply(value1, value2);
            Console.WriteLine("Multiply({0},{1}) = {2}", value1, value2, result);

            // Call Divide
            value1 = 22.00D;
            value2 = 7.00D;
            result = client.Divide(value1, value2);
            Console.WriteLine("Divide({0},{1}) = {2}", value1, value2, result);

            // Step 3: Close the client gracefully.
            // This closes the connection and cleans up resources.
            client.Close();

            Console.WriteLine();
            Console.WriteLine("Press <ENTER> to terminate client.");
            Console.ReadLine();
        }
    }
}
```

The first step is to create a **CalculatorClient** object. Then it is as simple
as calling any of the following:

```csharp
client.Add(...);
client.Subtract(...);
client.Multiply(...);
client.Divide(...);
```

All the above commands will cause our Client app to hit the Server app with
requests. The Server app will then run the methods and send back results to the
Client. Here is a screenshot of the applications running side-by-side:

[![WCF Client, Server Outputs](/content/{{ page.urda_uuid }}/side-by-side.png)](/content/{{ page.urda_uuid }}/side-by-side.png)

With WCF you can setup dedicated application servers for your client apps to hit
with requests. These requests can then be processed either synchronously or
asynchronously. In this example we ran the commands synchronously, so we had to
wait for the server to kick back results to us. But you could instead build a
giant processing server, and have clients request asynchronous tasks and just
catch a callback.

WCF can be applied for use in...

* Distributed Processing
* Threaded Web Applications
* Dedicated Servers hosting specific services, all based on their capability
* Routing tasks [ Client <\----> Proxy(WCF Server & Client) <\----> Server ]
* ...any other possible Client-Server task you would need! The possibilities are
  up to you.

All of this is easily setup and built by just using C#, .NET, and Visual Studio
2010. If you can write your methods and algorithms in C#, you can extend them
for use in WCF.
