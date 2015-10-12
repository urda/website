---
title: 'C# Classes Versus Structures'
author: Peter Urda
layout: post
redirect_from: /2010/11/csharp-classes-versus-structures/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - Programming
---

There are a few situations where a C# structure will provided better performance
than a C# class and other times a class will be faster than a structure. The
reason for this is how C# is handling both of these in memory during program
execution.

Let's talk about classes first. A class in C# is a **reference type**. This
means that C# creates references, or pointers, to values in memory for each part
of the object. When you copy a C# class you are making a copy of the references
to values in memory. Structures have a different behavior than this.

Structures behave like a **value type** much like an **int** or a **bool**.
These types are based on values in memory directly, there are no pointers or
references in between. These types are said to run *on the metal* since they do
not use references.

Knowing these two bits of crucial information, you can modify some class objects
into structures and gain a good performance boost. However, you must make these
decisions carefully since a bad implementation of structure will actually cause
slower performance. Thankfully we have MSDN to show us a few guidelines on
structure uses:

> **✓ CONSIDER** defining a struct instead of a class if instances of the type are
> small and commonly short-lived or are commonly embedded in other objects.
>
> **X AVOID** defining a struct unless the type has all of the following
> characteristics:
>
> * It logically represents a single value, similar to primitive types
>   (int, double, etc.).
> * It has an instance size under 16 bytes.
> * It is immutable.
> * It will not have to be boxed frequently.
>
> In all other cases, you should define your types as classes.
>
> Source: [MSDN](https://msdn.microsoft.com/en-us/library/ms229017.aspx)

All of those points make sense. If something is going to be a structure it
should represent a single value (like the other primitive types), it has a small
memory footprint, it is immutable (again like the other primitive types), and
will not be boxed/unboxed a lot inside other portions of your program. If you
cannot meet these key requirements, you should be using a class instead of a
structure.

The next time you think you can represent a chunk of information as a structure,
you should take a moment and check the requirements. If you do not check for
these key points, then your performance will suffer down the road as your
application scales out.
