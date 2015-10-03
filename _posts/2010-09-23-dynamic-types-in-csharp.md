---
title: 'Dynamic Types in C#'
author: Peter Urda
layout: post
redirect_from: /2010/09/dynamic-types-in-csharp/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - Visual Studio 2010
---
When C# 4.0 was released, it added a new type for variables called dynamic. The dynamic type is a static type, but it is an object that bypasses static type checking. Now if your head has just exploded from reading that last sentence I apologize. When you compile an application that contains any dynamic types, those dynamic objects are assumed to support any operation that may be ran against them. This allows a developer to not worry about where a method is coming from be it XML, DOM, or other dynamic languages like IronPython. However, if at runtime a method or command does not exist errors will be thrown at run-time instead.

All of these basic concepts come together to form the concept of a C# dynamic type. The dynamic type in C# is a strange, new concept that has some interesting use cases. Those use cases usually apply to interacting with other languages or documents.

Let&#8217;s say I build a simple class that describes a person object. I will also go ahead and create a main class, build a person object with the dynamic type, and print one line to screen.

<pre class="brush: csharp; title: ; notranslate" title="">using System;

namespace IntroDynamicTypes
{
    class Person
    {
        public Person(string n)
        {
            this.Name = n;
        }

        public string Name { get; set; }
    }
    
    class DynamicTypesProgram
    {
        static void Main(string[] args)
        {
            dynamic DynamicPerson = new Person("Urda");
            Console.WriteLine("Person Created, Name: " +
                              DynamicPerson.Name);
            // Prints "Person Created, Name: Urda"
        }
    }  
}
</pre>

Now you may notice as you key this into Visual Studio 2010 you will not have your normal IntelliSense to guide you. You will be prompted with this notice:  
<img src="http://www.peter-urda.com/wp/wp-content/uploads/2010/09/No-IntelliSense1.png" alt="No IntelliSense" title="No IntelliSense" width="351" height="134" class="aligncenter size-full wp-image-835" />

Since we have defined this person object as dynamic, we can use any method we want with it! The compiler will not check for anything or stop you from building an application with objects using undefined methods. This is because a dynamic class can call these methods at run time, with the expectation that the method definitions and code will exist when the program is ran. In fact we can even add some more code into our main like so&#8230;

<pre class="brush: csharp; title: ; notranslate" title="">static void Main(String[] args)
{
    dynamic DynamicPerson = new Person("Urda");
    Console.WriteLine("Person Created, Name: " +
                      DynamicPerson.Name);
    // Prints "Person Created, Name: Urda"

    // This will throw an error only at runtime,
    // *not* at compile time!
    DynamicPerson.SomeMagicFunction();
}
</pre>

At this point you&#8217;ll notice we have added a method called **SomeMagicFunction** that does not exist in the class, but Visual Studio 2010 still lets us compile the application. It is only at run time that this application will throw an error when it attempts to make a call to **SomeMagicFunction**. But if the function was made available through some form of interop, you would be able to execute that function against the object.

So dynamic types allows C# to play nice with other languages such as IronPython, HTML DOMs, COM API, or somewhere else in a program. Think of the dynamic type as a way to bridge the gap between strongly typed components such as C# and weakly type components such as IronPython, COM, or other DOM objects.