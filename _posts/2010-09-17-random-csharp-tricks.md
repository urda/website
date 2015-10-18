---
title: 'Random C# Tricks'
layout: post
redirect_from: /2010/09/random-csharp-tricks/

urda_uuid: 20100917

categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
---

I wanted to share a few C# tricks I reviewed today. Some programmers will use
them all the time, others barely know about their existence.

In this short source code example I will be demoing the **?? operator**,
**chaining ??**, and **String.IsNullOrWhiteSpace()** which is a newer .NET
method.

So here is the source I'll talk about:

```csharp
using System;

namespace C.Sharp.Tricks
{
    class Tricks
    {
        static void Main(string[] args)
        {
            /*** ?? Operator ***/
            // Allow x to be null by using 'int?'
            int? x = null;

            // Set y = x if not null, otherwise use 30 for a value
            int y = x ?? 30;

            // Print the results to screen
            Console.WriteLine("*** ?? Operator ***");
            Console.WriteLine("y = x ?? 30\ny = {0}\n", y);

            /*** Chaining ?? Operators **/
            // Set z = x if not null, else if w not null, else y + 1
            int? w = null;
            int z = x ?? w ?? (y + 1);

            // Print the results to screen
            Console.WriteLine("*** Chaining ?? Operators ***");
            Console.WriteLine("z = x ?? w ?? (y + 1)\nz = {0}\n", z);

            /*** String, Null or Empty (Whitespace)? ***/
            // Make a null string, empty string (spaces), and one with 'Hello!'
            string string1 = null;
            string string2 = "      ";
            string string3 = "Hello!";

            // Print the results to screen
            Console.WriteLine("*** String, Null or Empty? ***");
            Console.WriteLine("string1 ... ({0}) -- Null or Empty? " +
                              String.IsNullOrWhiteSpace(string1), string1);
            Console.WriteLine("string2 ... ({0}) -- Null or Empty? " +
                              String.IsNullOrWhiteSpace(string2), string2);
            Console.WriteLine("string3 ... ({0}) -- Null or Empty? " +
                              String.IsNullOrWhiteSpace(string3), string3);
        }
    }
}
```

The **?? operator** is a simple way to set a variable to something, and if that
first condition is null it will fallback to a second value. So since x is null,
y will end up being set to 30. The program outputs the expected result to prove
that.

Next we will **chain the ?? operators** together. In my example both x and w are
null, so z will have to be set to (y + 1), or 31. The program again prints the
expected result to screen.

The benefit that ?? brings to the table is that it turns what could have been a
complicated if/else statement, into a logic one-liner. It is also a nice
convenience since you can write code that may or may not have to deal with an
uninstantiated variable at runtime very easily.

Finally, I have a block of code that shows how the new
**String.IsNullOrWhiteSpace()** method from .NET version 4 works. Basically, the
method returns true if a given string is null, or just a bunch of whitespace;
otherwise it will return false. So I send in a null, a string with just spaces,
and a string with a phrase and I print the expected results to screen. This
method could be helpful to determine if the user entered in a space or spaces
when in reality it should have been sent in as null or just empty.

Here is a screenshot of the running program:

[![Program Output](/content/{{ page.urda_uuid }}/runningProgram01.png)](/content/{{ page.urda_uuid }}/runningProgram01.png)

I found these either new or exciting to use today, and I hope you can find
interesting ways to incorporate them in your software design!
