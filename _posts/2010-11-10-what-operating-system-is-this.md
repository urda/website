---
title: What Operating System is This?
author: Peter Urda
layout: post
redirect_from: /2010/11/what-operating-system-is-this/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
---

You may, at one point, want to know the literal name of the operating system
your program is running out of. Well this can be determined indirectly using the
`Environment.OSVersion` information inside the .NET Framework. Normally if you
call that by itself, you'll can extract a string that reads like **Microsoft
Windows NT 6.1.7600** which isn't all that useful. Well I've put together a
simple little method to help you throw out a better string.

We first need to understand the Major and Minor versions of Windows. Major
version 4 included Windows NT, 98, and ME. Major version 5 brought 2000, XP, and
2003. Finally version 6 gave us Vista and Windows 7. So if we take the .NET
environment information from `Environment.OSversion.Version` we get a
`System.Version` object that contains the Major and Minor version numbers.

All you have to do is call this method below, and you'll get a string
representation of the operating system your application is running in:

```csharp
private string GetOSString()
{
    System.Version v = Environment.OSVersion.Version;

    if (v.Major == 4)
    {
        if (v.Minor == 0)
            return "Windows NT";
        if (v.Minor == 10)
            return "Windows 98";
        if (v.Minor == 90)
            return "Windows ME";
    }
    else if (v.Major == 5)
    {
        if (v.Minor == 0)
            return "Windows 2000";
        if (v.Minor == 1)
            return "Windows XP";
        if (v.Minor == 2)
            return "Windows 2003";
    }
    else if (v.Major == 6)
    {
        if (v.Minor == 0)
            return "Windows Vista";
        if (v.Minor == 1)
            return "Windows 7";
    }

    return "Unknown";
}
```

In the worst case it'll kick back *Unknown* if it can't figure it out. So now
instead of spitting out a long NT version, you can have the pretty brand name in
your application instead!
