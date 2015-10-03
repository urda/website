---
title: 'Simple C# Threading &#038; Thread Safety'
author: Peter Urda
layout: post
redirect_from: /2010/10/simple-c-threading-thread-safety/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - Parallel Programming
  - Threading
---
A few days ago I compared and contrasted Asynchronous and Parallel Programming. Today I would like to walk you through a very simple threading example in C#, and why the concept of &#8220;thread safety&#8221; is important to know before you start writing parallel applications.

[Since we already know what exactly parallel programming is, and how it is different from asynchronous calls][1] we can go ahead and drill down to some more aspects of parallel programming. So here is an application that will start a new thread from the main, and both threads will call the same method:

<pre class="brush: csharp; title: ; notranslate" title="">using System;
using System.Threading;

class Threading101
{
    static bool fire;

    static void Main()
    {
        new Thread(FireMethod).Start();  // Call FireMethod() on new thread
        FireMethod();                    // Call FireMethod() on main thread
    }

    static void FireMethod()
    {
        if (!fire)
        {
            Console.WriteLine("Method Fired");
            fire = true;
        }
    }
}
</pre>

Now at first glance you might say that we will only see &#8220;Method Fired&#8221; shown on screen, however when we run the program we will see this output:

<img class="aligncenter size-full wp-image-1002" title="UnsafeThreading" src="http://www.peter-urda.com/wp/wp-content/uploads/2010/10/UnsafeThreading.png" alt="UnsafeThreading" width="677" height="342" />

Well we have obviously called the method on both threads, but we got an undesired output! This example shows the clear issues you will encounter when working with threads in C#. This method is defined as **thread unsafe** and does not work correctly (in its current state) when used in threading applications.

So what can we do about this? Well we need some method of preventing a thread from entering a method when another thread is entering a critical part of the method. So we just have to update our code to account for some type of locking functionality and then re-work our application:

<pre class="brush: csharp; title: ; notranslate" title="">using System;
using System.Threading;

class Threading101
{
    static bool fire;

    static readonly object locker = new object();

    static void Main()
    {
        new Thread(FireMethod).Start();  // Call FireMethod() on new thread
        FireMethod();                    // Call FireMethod() on main thread
    }

    static void FireMethod()
    {
        // Use Monitor.TryEnter to attempt an exclusive lock.
        // Returns true if lock is gained
        if (Monitor.TryEnter(locker))
        {
            lock (locker)
            {
                if (!fire)
                {
                    Console.WriteLine("Method Fired");
                    fire = true;
                }
            }
        }
        else
        {
            Console.WriteLine("Method is in use by another thread!");
        }
    }
}
</pre>

Running the code above now produces a better threading result:

<img class="aligncenter size-full wp-image-1005" title="SafeThreading" src="http://www.peter-urda.com/wp/wp-content/uploads/2010/10/SafeThreading.png" alt="SafeThreading" width="677" height="342" />

Now that looks better! We made sure that only a single thread could enter a critical section of the code, and prevent other threads from stepping in. We first use **Monitor.TryEnter(locker)** to check for a lock, and if there is no lock we step in and run our code. If there is already a lock, we have added the logic to print that result to screen.

Pretty simple huh? So this little app spawns an extra thread, and both threads fire the same method. However, the variable is only changed once, and the message from the method is only printed once. The first snippet is a perfect example of a method that is not thread safe, and the second one is a great way to protect that same method.

 [1]: http://www.peter-urda.com/2010/10/asynchronous-versus-parallel-programming