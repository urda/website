---
title: Build Objects With Interfaces
layout: post

summary: |
    Interfaces can help you design better objects, let's review in C#.

redirect_from: /2010/11/build-objects-with-interfaces/

urda_uuid: 20101123

categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - Programming
---

Being able to drop certain chunks of code from one piece of software to another
piece of unrelated software is a powerful thing. Not only does this save time,
but it will also allow you to build a small library of tools you find useful in
all your applications. Interfaces in C# is just one of many ways to build more
modular objects that have similar behavior.

We are going to create an interface **IHuman** to build people objects from.
Everyone can agree that all people have a First Name, Last Name, Age, and have
some ability to speak. So we will wrap that up into a neat interface.

```csharp
public interface IHuman
{
    string fname { get; set; }
    string lname { get; set; }
    int age { get; set; }

    void Speak(string input);
}
```

An interface is a very basic chunk of code in C#. It is like a checklist of
objects and actions that all derived classes should have. The way each class
handles each dimension of the **IHuman** will be unique to each class. So now we
will create just a basic person object from the interface. I will then use
Visual Studio to implement the interface, and this will be the result:

```csharp
public class Person : IHuman
{
    public string fname
    {
        get
        {
            throw new NotImplementedException();
        }
        set
        {
            throw new NotImplementedException();
        }
    }

    public string lname
    {
        get
        {
            throw new NotImplementedException();
        }
        set
        {
            throw new NotImplementedException();
        }
    }

    public int age
    {
        get
        {
            throw new NotImplementedException();
        }
        set
        {
            throw new NotImplementedException();
        }
    }

    public void Speak(string input)
    {
        throw new NotImplementedException();
    }
}
```

As you can tell, you'll need to go through each method and implement it for use.
I simply took a moment to do some clean up, and added logic to my **Speak**
method:

```csharp
public class Person : IHuman
{
    public string fname
    {
        get;
        set;
    }

    public string lname
    {
        get;
        set;
    }

    public int age
    {
        get;
        set;
    }

    public void Speak(string input)
    {
        Console.WriteLine(input);
    }
}
```

Now I can build a simple program and declare a Person Object. Then I can set
variables within the object and/or use any of the methods associated with it.
Yet, I need another object to describe a programmer. Again, I'll use the
**IHuman** interface and make the needed changes to my methods. I'm also adding
a custom method in this class as another way to speak.

```csharp
public class Programmer : IHuman
{
    public string fname
    {
        get;
        set;
    }

    public string lname
    {
        get;
        set;
    }

    public int age
    {
        get;
        set;
    }

    public void Speak(string input)
    {
        string result = "";

        foreach (string s in input.Select(c => Convert.ToString(c, 2)))
        {
            result += s;
        }

        Console.WriteLine(result);
    }

    public void DudeInPlainEnglish(string input)
    {
        Console.WriteLine("Sorry my bad... " + input);
    }
}
```

If you pull the interface and two objects together, you can build a simple
console application to prove this proof of concept:

```csharp
static void Main(string[] args)
{
    Person MyPerson = new Person();
    MyPerson.fname = "John";
    MyPerson.lname = "Smith";
    MyPerson.age = 25;

    MyPerson.Speak(string.Format("Hello I am {0} {1}!",
                                 MyPerson.fname,
                                 MyPerson.lname));

    Console.WriteLine();

    Programmer Me = new Programmer();
    Me.fname = "Peter";
    Me.lname = "Urda";
    Me.age = 21;
    string UrdaText
        = string.Format("Hey, I'm {0} {1}", Me.fname, Me.lname);

    Me.Speak(UrdaText);
    Console.WriteLine();

    Me.DudeInPlainEnglish(UrdaText);
    Console.WriteLine();
}
```

Running the program will produce this output:

[![Humans of C#](/content/{{ page.urda_uuid }}/humans.png)](/content/{{ page.urda_uuid }}/humans.png)

As you can tell the Programmer spits out binary when asked to speak, and it is
only when you call the *DudeInPlainEnglish* method against it is when you get a
readable format. The method also appends "Sorry my bad..." to the start of the
print out.

If we only had access to the interface, we would know what properties and
methods that each class must have when using said interface. Think of this
interface as a type of contract, where each class that uses it must (in some
fashion) use the properties and methods laid out. You can also think of an
interface as a very basic framework for all involved classes.

So the next time you are working on a bunch of objects that are closely related
to each other, consider using an interface.
