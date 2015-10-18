---
title: 'Simple C# Threading & Thread Safety'
layout: post
redirect_from: /2010/10/simple-c-threading-thread-safety/

urda_uuid: 20101006

categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - Parallel Programming
  - Threading
---

A few days ago I compared and contrasted Asynchronous and Parallel Programming.
Today I would like to walk you through a very simple threading example in C#,
and why the concept of "thread safety" is important to know before you start
writing parallel applications.

[Since we already know what exactly parallel programming is, and how it is different from asynchronous calls]({% post_url 2010-10-04-asynchronous-versus-parallel-programming %})
we can go ahead and drill down to some more aspects of parallel programming.
So here is an application that will start a new thread from the main, and both
threads will call the same method:

```csharp
using System;
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
```

Now at first glance you might say that we will only see "Method Fired" shown on
screen, however when we run the program we will see this output:

[![Program Output](/content/{{ page.urda_uuid }}/unsafethreading.png)](/content/{{ page.urda_uuid }}/unsafethreading.png)

Well we have obviously called the method on both threads, but we got an
undesired output! This example shows the clear issues you will encounter when
working with threads in C#. This method is defined as **thread unsafe** and does
not work correctly (in its current state) when used in threading applications.

So what can we do about this? Well we need some method of preventing a thread
from entering a method when another thread is entering a critical part of the
method. So we just have to update our code to account for some type of locking
functionality and then re-work our application:

```csharp
using System;
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
```

Running the code above now produces a better threading result:

[![Program Output](/content/{{ page.urda_uuid }}/safethreading.png)](/content/{{ page.urda_uuid }}/safethreading.png)

Now that looks better! We made sure that only a single thread could enter a
critical section of the code, and prevent other threads from stepping in. We
first use **Monitor.TryEnter(locker)** to check for a lock, and if there is no
lock we step in and run our code. If there is already a lock, we have added the
logic to print that result to screen.

Pretty simple huh? So this little app spawns an extra thread, and both threads
fire the same method. However, the variable is only changed once, and the
message from the method is only printed once. The first snippet is a perfect
example of a method that is not thread safe, and the second one is a great way
to protect that same method.
