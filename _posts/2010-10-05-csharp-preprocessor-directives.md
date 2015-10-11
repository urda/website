---
title: 'C# Preprocessor Directives'
author: Peter Urda
layout: post
redirect_from: /2010/10/csharp-preprocessor-directives/

urda_uuid: 20101005

categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - Visual Studio 2010
---

If you have ever worked with an application that bounces from your workstation, to QA, then to production the odds are high you have dealt with C# preprocessor directives. While C# does not have a preprocessing engine, these directives are treated as such. They have been named as such to be consistent with C and C++ for familiarity. Directives can be used to build classes based on the environment they will be deployed in, to grouping chunks of your source code together for collapsing inside the Visual Studio code editor. This article will go over each C# preprocessor directive.

C# has the following directives, all of which will be covered in this article:

  * **#if**
  * **#else**
  * **#elif**
  * **#endif**
  * **#define**
  * **#undef**
  * **#warning**
  * **#error**
  * **#line**
  * **#region**
  * **#endregion**

Let's start with **#define** and **#undef**. These directives are used to define and undefine symbols that evaluate to true (if using #define) when used in other logical directives. As you could imagine, #undef will undefine a given symbol (such that it yields false).

```csharp
// Set Debug Mode
#define DEBUG_MODE
// Kill SQL Logger
#undef SQL_LOG
```

With those two directives down, we can move on to **#if, #else, #elif,** and **#endif** directives. These directives let you step into or over chunks of code depending on the condition that is checked. As you can imagine, they behave like if, else if, and else statements in C#. The #endif directive must be used to finish off any statement or statements starting with the #if directive. You may use the **==, !=, &&, ||** operators to check various conditions. You can also group symbols and operators by using parentheses.

```csharp
#define DEBUG_MODE
#undef SQL_LOG
using System;

public class SomeClass
{
    public static void Main()
    {
        #if (DEBUG_MODE && !SQL_LOG)
            Console.WriteLine("DEBUG_MODE is defined!");
        #elif (!DEBUG && SQL_LOG)
            Console.WriteLine("SQL_LOG is defined!");
        #elif (DEBUG && SQL_LOG)
            Console.WriteLine("DEBUG_MODE and SQL_LOG are defined!");
        #else
            Console.WriteLine("No symbols defined");
        #endif
    }
}

/*
Prints to screen:
DEBUG_MODE is defined!
*/
```

In just these two examples I have already covered 6 of the 11 possible C# preprocessor directives. The next few will help you add messages to your compiler output.

Now let's cover the **#warning** and **#error** directives. Both of these directives will throw Warnings or Errors respectively when you compile your application in Visual Studio. For example, you may want to throw a warning that you left debug mode on so you don't accidentally deploy your application to production while it is running in a debug state:

```csharp
#define DEBUG_MODE
using System;

public class SomeClass
{
    public static void Main()
    {
        #if DEBUG_MODE
        #warning DEBUG_MODE is defined
        #endif
    }
}
```

...and of course #error will cause an error to be displayed in the compiler output:

```csharp
#define DEBUG_MODE
using System;

public class SomeClass
{
    public static void Main()
    {
        #if DEBUG_MODE
        #error DEBUG_MODE is defined
        #endif
    }
}
```

The **#line** directive is more strange than the other preprocessor directives. Specifically, #line allows you to modify the compiler's line number and optionally change the file name that is used for warning and error outputs.The syntax is as follows:

```
#line [ number ["file_name"] | hidden | default ]
```

Hidden will remove successive lines from the debugger *until* another #line directive is hit. Usually the #line directive is used in automated build process or code creators. But for an example if I use this chunk of code:

```csharp
using system

class SomeClass
{
    static void Main()
    {
        #line 208
        int i;
        #line default
        char c;
    }
}
```

Will produce this error output inside Visual Studio:

```
C:\Path\To\File.cs(208,13): warning CS0168: The variable 'i' is declared but never used
C:\Path\To\File.cs(10,13): warning CS0168: The variable 'c' is declared but never used
```

Finally, we have the **#region** and **#endregion**. Every #region block must end with a #endregion block. When you define a block it allows you to expand and collapse code inside Visual Studio for easier reading and reference. There are some important points to note though: A #region block **cannot** overlap an #if block and vice versa . You can nest an #if block inside a #region block or a #region block inside an #if block though. So for example:

```csharp
using System;

class MainBox
{
    static void Main(string[] args)
    {
        #region Secrets
        /*
         * ...here be dragons!
         */
        #endregion
    }
}
```

I can expand and collapse the section inside Visual Studio as pictured:

<img class="aligncenter size-full wp-image-984" title="#region in Visual Studio" src="http://www.peter-urda.com/wp/wp-content/uploads/2010/10/Collapse.png" alt="#region, #endregion in Visual Studio" width="602" height="215" />

...and that is all the possible C# preprocessor directives you can use! I love the #region one, since it allows you to lump your code together for easier reading.
