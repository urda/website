---
title: Delegate Chain of Command
author: Peter Urda
layout: post
redirect_from: /2010/08/delegate-chain-of-command/

urda_uuid: 20100826

categories:
  - How To
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - Delegates
---

Another cool thing about delegates is the ability to chain them together. Say
for example you have an object modification process, and you need a given object
to be manipulated in a very specific order. Well you could use a delegate chain
to accomplish that. For a simple example I have written up a C# delegate chain
program that evaluates a mathematical expression following the order of
operations by using a delegate chain.

```csharp
using System;

namespace DelegateChain
{
    // Declare the delegate type
    delegate void UrdaDelegate(ref int x);

    // A general class to store methods for use by delegates
    public class DelegateMath
    {
        public static void AddOne(ref int a)
        {
            a = a + 1;
        }
        public static void TimesTwo(ref int b)
        {
            b = b * 2;
        }
        public static void PlusThree(ref int c)
        {
            c = c + 3;
        }
    }

    public class DelegateChainExample
    {
        public static void Main(string[] args)
        {
            // Create delegate objects based on our created methods.
            UrdaDelegate delegate01 = new UrdaDelegate(DelegateMath.AddOne);
            UrdaDelegate delegate02 = new UrdaDelegate(DelegateMath.TimesTwo);
            UrdaDelegate delegate03 = new UrdaDelegate(DelegateMath.PlusThree);

            // Chain the delegates together. The variable manipulation will
            // start with delegate01, then delegate02, and end with delegate03.
            UrdaDelegate DelegateChain = delegate01 + delegate02 + delegate03;

            // Define our value, and build the expected result from it
            int value = 5;
            int expected = ((value + 1) * 2) + 3;

            // Build a string for explaining the output
            string ExplanationString = "\n";
            ExplanationString += "DelegateChain(5) should produce " + expected;
            ExplanationString += " since ((" + value + " + 1) * 2) + 3 = ";
            ExplanationString += expected;

            // Pass the value into the delegate chain
            DelegateChain(ref value);

            // ...and write the explanation and result to console!
            Console.WriteLine(ExplanationString);
            Console.WriteLine("RESULT: " + value + "\n");
        }
    }
}
```

...and when we run the program we get this output:

[![Program Output](/content/{{ page.urda_uuid }}/delegatesoftwarerunning.png)](/content/{{ page.urda_uuid }}/delegatesoftwarerunning.png)

Sure you could have just performed the mathematical expression by itself without
writing all of that code. But the point is you are able to link delegates
together, and perform manipulation on a given variable at each function in a
specific order. This can be dragged out to more complex methods, where ordered
execution is mission critical.
