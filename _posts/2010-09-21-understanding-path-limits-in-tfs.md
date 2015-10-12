---
title: Understanding Path Limits in TFS
author: Peter Urda
layout: post
redirect_from: /2010/09/understanding-path-limits-in-tfs/
categories:
  - Mercer Daily Reports
tags:
  - Co-Op
  - Team Foundation Server
  - Visual Studio 2010
---

Team Foundation Server (TFS) is bound to a some limitations that can potentially
break your Visual Studio project. One of these limitations is the character
count limit in a file path. If you overshoot this limit you will run into issue
when adding new files to TFS or attempting to compile your project in Visual
Studio. Here is a quick overview explaining why TFS behaves like this and what
you can do about it.

When attempting to add a file to TFS or Visual Studio for compilation, you will
be prompted with this error:

> The specified path, file name, or both are too long. The fully qualified file
> name must be less than 260 characters, and the directory name must be less
> than 248 characters.

So why is this an issue? Surely modern operating systems should not be bound to
these kinds of restrictions. After all, once you get past
**C:\Users\[Username]\Documents\Projects\...** you have already eaten up 40 or
so characters! This is an issue since TFS is apparently making non-unicode calls
to create paths. When a program makes a non-unicode call, it will be limited to
260 characters for the path. This is not an issue with other programs that make
a unicode call through the Windows API to create paths, as their limit is
actually 32,767 characters.

So what can you do about this? The best thing to do is to shorten your base
path. You can easily do this by moving your project from, say 'My Documents',
to something along the lines of **C:\Projects** or **C:\TFS**

If you are really interested in the full technical details of this issue, you
can visit [MSDN](http://msdn.microsoft.com/en-us/library/aa365247.aspx) for more
information.
