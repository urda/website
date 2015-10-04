---
title: 'Handling &#8220;bool?&#8221; Safely'
author: Peter Urda
layout: post
redirect_from: /2010/10/handling-bool-safely/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - Programming
---
Say you have some if/else statements that check the condition of a boolean variable. That bool could be from a database, user input, XAML data binding, or anywhere. The point is, you have logic based on the value (true or false) of that boolean variable. You may not have considered, how C# behaves when it encounters the boolean as null.

If you have done any work with C# you should be well aware of what nullable types are. MSDN states:

> Nullable types can represent all the values of an underlying type, and an additional null value. Nullable types are declared in one of two ways:
> 
> System.Nullable variable
> 
> -or-
> 
> T? variable
> 
> Source: <a href="http://msdn.microsoft.com/en-us/library/2cf62fcy.aspx" class="external external_icon" target="_blank">http://msdn.microsoft.com/en-us/library/2cf62fcy.aspx</a>

What this means is I can declare a nullable boolean value, without having to specify if it is true or false when I create it.  
Normally, if you declare a normal bool the compiler will throw a fit if you set it to null. Below is an example showing the syntax difference, and the error Visual Studio will spit out if you attempt to make a normal boolean null.

<pre class="brush: csharp; title: ; notranslate" title="">class MyClass
{
    // ERROR:
    // Cannot convert null to 'bool' because it is a non-nullable value type
    bool MyBadBoolean = null;

    // This Works!
    bool? MyBoolean = null;
}
</pre>

So going to back to the theme of if/else statements, what would happen if you sent a null boolean into a logic block without proper handling it properly beforehand? Let&#8217;s start with a basic program:

<pre class="brush: csharp; title: ; notranslate" title="">using System;

class Sandbox
{
    static void Main()
    {
        bool? MyBoolean = null;

        if (MyBoolean)
            Console.WriteLine("True \n");
        else
            Console.WriteLine("False \n");
    }
}
</pre>

If we key this into Visual Studio, we are prompted with the error:

> **Cannot implicity convert type &#8216;bool?&#8217; to &#8216;bool&#8217;. An explicit conversion exists (are you missing a cast?)**

This is nice because Visual Studio is informing us of a simple work around (casting) that could be applied. However, if we had a more complex program that had variables declared in objects elsewhere, values pulled out of databases, or dynamic types there would be no way for the compiler to catch them before runtime. Obviously, a null boolean being encountered in logic will produce a nasty stacktrace and crash the program if it is not caught.

We can deal with this issue though! We simply have to double-check the condition of the boolean before we enter any critical logic blocks of code. For most instances we will want to just set the variable to false, and continue to our logic blocks. The check can be performed by any method of your design, but I&#8217;ll simply use the **HasValue** method to handle it for this short example. After handling the null type, we simply just cast it to a regular boolean. Now check out the example:

<pre class="brush: csharp; title: ; notranslate" title="">using System;

class Sandbox
{
    static void Main()
    {
        bool? MyBoolean = null;

        if (!MyBoolean.HasValue)
            MyBoolean = false;

        if ((bool)MyBoolean)
            Console.WriteLine("True \n");
        else
            Console.WriteLine("False \n");
    }
}

/*
Console Output:
False

Press any key to continue . . .
*/
</pre>

Pretty straight forward! This could be a serious issue you will need to handle if you are using anything such as dynamic types with logic statements. The compiler will be unable to catch instances of the sort, and you&#8217;ll need to account for null booleans if so.
