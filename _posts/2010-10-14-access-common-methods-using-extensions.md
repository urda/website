---
title: Access Common Methods Using Extensions
author: Peter Urda
layout: post
redirect_from: /2010/10/access-common-methods-using-extensions/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - Programming
---
There will be times when you are using a third-party library or some other "black box" software in your project. During those times you may need to add functionality to objects or classes, but that addition does not necessarily call for employing inheritance or some other subclass. In fact, you might not have access to the library's source code if it is proprietary. There is a wonderful feature of C# though that allows you to add-on commonly used methods to any type of object, and that feature is called **Extension Methods**

Extension methods are a simple way of adding common functionality to a given object in C#. It is usually faster than trying to build a new subclass from the original class and it makes your code a lot more readable. MSDN has a wonderful explanation of extension methods:

> Extension methods enable you to "add" methods to existing types without creating a new derived type, recompiling, or otherwise modifying the original type. Extension methods are a special kind of static method, but they are called as if they were instance methods on the extended type. For client code written in C# and Visual Basic, there is no apparent difference between calling an extension method and the methods that are actually defined in a type.
>
> Source: <a href="http://msdn.microsoft.com/en-us/library/bb383977.aspx" class="external external_icon" target="_blank">http://msdn.microsoft.com/en-us/library/bb383977.aspx</a>

To create an extension method, you must use this syntax:

```csharp
public static return-type MethodName(this ObjectType TheObject, ParamType1 param1, ..., ParamTypeN paramN)
{
    /* Your actual method code here */
}
```

Notice the all important **this ObjectType TheObject** inside the parameter list? Well this needs to match what object is actually calling it. So if you are making an extension method for a string, your first parameter will read **this string YourDesiredStringName**. In short: ObjectType is the name of the type that you are creating the extension method and will be stored inside TheObject property for use in the method. Any extra parameters such as param1 and so on are optional and can be used inside your method also.

So take a look at the simple sample I have created. Notice I am calling in the namespace that contains the extensions in my main namespace, and thanks to that my int object can call all the methods naturally:

```csharp
using System;

namespace MainProgram
{
    // Call in UrdaExtensions namespace so we can access the extension methods
    using UrdaExtensions;

    class MainProgram
    {
        public static void Main()
        {
            int MyNum = 21;
            Console.WriteLine("MyNum = {0}\n", MyNum);
            Console.WriteLine("MyNum.Cube()     : " + MyNum.Cube());
            Console.WriteLine("MyNum.FlipInt()  : " + MyNum.FlipInt());
            Console.WriteLine("MyNum.ShiftTwo() : " + MyNum.ShiftTwo());
        }
    }
}

namespace UrdaExtensions
{
    public static class UrdaExtensionClass
    {
        #region Extension Methods

        public static int Cube(this int value)
        {
            return value * value * value;
        }

        public static int FlipInt(this int value)
        {
            char[] CharArray = value.ToString().ToCharArray();
            Array.Reverse(CharArray);
            return int.Parse(new string(CharArray));
        }

        public static int ShiftTwo(this int value)
        {
            return value + 2;
        }

        #endregion
    }
}

/*
Program prints this to screen at runtime:

MyNum = 21

MyNum.Cube()     : 9261
MyNum.FlipInt()  : 12
MyNum.ShiftTwo() : 23
Press any key to continue . . .
*/
```

Thanks to extension methods, I do not have to make a call that looks something like **MyUtilityObject.Cube(MyNum)**. Instead I can make a better method call straight from the int object. This makes life easier for all involved since the code will be much simpler to read and it allows for better code re-usability.
