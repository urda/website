---
title: Add Some Descriptions to Enumerations!
author: Peter Urda
layout: post
redirect_from: /2010/10/add-some-descriptions-to-enumerations/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - Programming
---
Enumerations in C# allow you to group common constants together inside a piece of code. They are often used for determining a system state, flag state, or other constant conditions throughout the program. Usually enums are not formatted for "pretty" displaying to the end user. However you can use a little C# magic to make them behave better with descriptions!

In order to add descriptions to the desired enum, you'll need to declare **using System.ComponentModel;** at the top of your source file. This will help with simplifying the definitions later on. So first let's lay out an enum:

```csharp
enum MyColors
{
    White,
    Gray,
    Black
}
```

Now we just add the description parameter before each portion of the enum:

```csharp
enum MyColors
{
    [Description("Eggshell White")]
    White,

    [Description("Granite Gray")]
    Gray,

    [Description("Midnight Black")]
    Black
}
```

Now we will need to construct an extension method for accessing these new descriptions.

```csharp
public static class EnumExtensions
{
    public static string GetDescription(this Enum value)
    {
        var type = value.GetType();
        var field = type.GetField(value.ToString());
        var attributes = field.GetCustomAttributes(typeof(DescriptionAttribute), false);
        return attributes.Length == 0 ? value.ToString() : ((DescriptionAttribute)attributes[0]).Description;
    }
}
```

Basically, this method has the following workflow:

  * Grab the enum type
  * Get the actual field value
  * Grab our custom attribute "Description"
  * Finally, check to make sure we got a value.
  * If we didn't, just return the string of the enum value
  * If we did, return the Description attribute.

All you have to do now is loop through the enum to prove the code:

```csharp
for (MyColors i = MyColors.White; i &lt;= MyColors.Black; i++)
    Console.WriteLine(i.GetDescription());

/*
Eggshell White
Granite Gray
Midnight Black
*/
```

This could be very useful if you want to pull something for a XAML binding, and not try to format an enum at runtime! You also will only have to keep the description in one place, and that is with the actual enum value itself.
