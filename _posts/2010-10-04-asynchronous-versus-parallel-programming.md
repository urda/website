---
title: Asynchronous Versus Parallel Programming
author: Peter Urda
layout: post
redirect_from: /2010/10/asynchronous-versus-parallel-programming/
categories:
  - Mercer Daily Reports
tags:
  - Asynchronous Programming
  - Co-Op
  - Conceptual
  - Parallel Programming
  - Threading
---
The last decade has brought about the age of multi-core processors to many homes and businesses around the globe. In fact, you would be more hard-pressed to find a computer with no multi-core (either physical, or virtual) support for sale on the market today. Software Engineers and Architects have already started designing and developing applications that use multiple cores. This leads to extended use of Asynchronous and Parallel programming patterns and techniques.

Before we begin it would help to review a key difference in Asynchronous and Parallel programming. The two perform similar tasks and functions in most modern languages, but they have conceptual differences.

Asynchronous calls are used to prevent &#8220;blocking&#8221; within an application. For instance, if you need to run a query against a database or pull a file from a local disk you will want to use an asynchronous call. This call will spin-off in an already existing thread (such as an I/O thread) and do its task when it can. Asynchronous calls can occur on the same machine or be used on another machine somewhere else (such as a computer in the LAN or a webserver exposing an API on the internet). This is used to keep the user interface from appearing to &#8220;freeze&#8221; or act unresponsively.

In parallel programming you still break up work or tasks, but the key differences is that you spin up new threads for each chunk of work and each thread can reach a common variable pool. In most cases parallel programming only takes place on the local machine, and is never sent out to other computers. Again, this is because each call to a parallel task spins up a brand new thread for execution. Parallel programming can also be used to keep an interface snappy and not feel &#8220;frozen&#8221; when running a challenging task on the CPU.

So you might ask yourself &#8220;Well these sound like the same deal!&#8221; In reality they are not by any means. With an asynchronous call you have no control over threads or a thread pool (which is a collection of threads) and are dependent on the system to handle the requests. With parallel programming you have much more control over the tasks chunks, and can even create a number of threads to be handled by a given number of cores in a processor. However each call to spin up or tear down a thread is very system intensive so extra care must be taken into account when creating your programming.

Imagine this use case: I have an array of 1,000,000 int values. I have requested that you, the programmer, make an addition to each of these people objects to contain an internal id equal to the object&#8217;s array index. I also tell you about how the latest buzzword on the street is &#8220;multi-core processing&#8221; so I want to see patterns on that used for this assignment. Assuming you have already defined the original &#8220;person&#8221; class and wrote a &#8220;NewPerson&#8221; class with the added dimension, which pattern (asynchronous or parallel) would be preferred to break the work up and why?

...

The correct answer of course would be the parallel pattern. Since each object is **not** dependent on another object from somewhere else (from something like a remote API) we can split the million objects into smaller chunks and perform the object copy and addition of the new parameter. We can then break send those chunks to different processors to conduct the execution of our code. Our code can even be designed to account for n processors in any computer, and evenly spread the work across CPU cores.

Now here at Mercer I am working on a .NET web product. Our tech leads and developers have created a &#8220;Commons&#8221; library that contains factories and objects that are useful to all the sub-projects that exist in this very large .NET product. Exposed services or factories are hosted via IIS and are accessible by other projects in the product by simply referring to the &#8220;Commons&#8221; namespace. Basically the &#8220;Commons&#8221; library prevents all developers from re-inventing the wheel if they need things such as a log writer, methods to extract objects from a MSSQL database, or even methods for interoperability between projects.

When it comes to the &#8220;Commons&#8221; library we are using Asynchronous calls between the server and client. We do this since a user could potentially hit one server in the cluster, then make another request that is picked up by a separate server in the cluster. It would not be helpful if we spun up a processing thread on Server A, only for the client to hit Server B (which then would have to spin up its own thread) if the cluster load balancer redirects them to Server B. Since our services are built to be asynchronous calls, all the client end has to do is pass in some session information to the server and the server can pull up the requested objects or data. If we were to use parallel processing in regards to the .NET pattern, we would be creating a ton of overhead with the constant setup and tear-down of threads within the webserver. There is also a chance the client might be redirected to another server completely by the forward facing load balancer. For our &#8220;Commons&#8221; it makes much, much more sense to just let the operating system handle sending off and receiving asynchronous calls.

So this should have served as a basic compare and contrast of asynchronous and parallel programming. If you remember anything, remember this: While both patterns are used to prevent blocking within, say a User Interface, keep in mind that an **asynchronous calls** will use **threads already in use by the system** and **parallel programming** requires **the developer to break the work up, spinup, and teardown threads needed**.
