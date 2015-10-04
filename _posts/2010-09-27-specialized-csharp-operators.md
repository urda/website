---
title: 'Specialized C# Operators'
author: Peter Urda
layout: post
redirect_from: /2010/09/specialized-csharp-operators/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
---
In a <a href="http://www.peter-urda.com/2010/09/random-csharp-tricks" target="_blank">previous post</a> I went over some random C# operators. This article is a follow-up to that one, covering some more advanced C# operators and techniques. Specifically, the **?:** operator, the **~** operator, **|=** operator, and the **^=** operator.

We will start off with the conditional operator **?:**. This operator is used to simplify an expression to test for a boolean value, and execute specific code that matches the value. Let's start off with a code snippet that does not use the **?:** operator.

```csharp
int TestValue = 6;
int result = -1;

if(TestValue &lt;= 5)
    result = 0;
else
    result = 1;
```

Instead we can use **?:** to simplify that. We can refactor that into a new code snippet:

```csharp
int TestValue = 6;

int result = TestValue &lt;= 5 ? 0 : 1;
```

In plain English the **?:** operator reads as so:

```csharp
condition ? CodeIfTrue : CodeIfFalse;
```

* * *Now we will move onto the

**~** operator. This operator is used for a NOT bitwise operation, or better stated from MSDN:</p>

> The ~ operator performs a bitwise complement operation on its operand. Bitwise complement operators are predefined for int, uint, long, and ulong.
>
> Source: <a href="http://msdn.microsoft.com/en-us/library/d2bd4x66%28v=VS.71%29.aspx" class="external external_icon" target="_blank">http://msdn.microsoft.com/en-us/library/d2bd4x66%28v=VS.71%29.aspx</a>

A NOT bitwise operation is also known as a one's compliment operation. It takes the binary of a variable or object, and flips each bit to a 0 if it was a 1, and to a 1 if it was a 0. The code below demonstrates the operator:

```csharp
byte OriginalValue = 208;
byte complement = (byte) ~OriginalValue;

string OriginalString = Convert.ToString(OriginalValue, 2);
string ComplementString = Convert.ToString(complement, 2);

Console.WriteLine(OriginalString.PadLeft(8, '0'));
Console.WriteLine(ComplementString.PadLeft(8, '0'));

/*
Prints to screen the following:
11010000
00101111
*/
```

As you can see, all of the bits are flipped to their opposite partner. This is could be useful if you are using C# to interact with a piece of hardware, and need to manipulate the bits of data that is exchanged with said hardware.

* * *Next we have the

**|=** operator. This operator performs a bitwise OR operation against a variable. So when compare two values, if one or both are true, then the result must be true. The following C# code shows an example of the OR operation:</p>

```csharp
byte Value1 = 245;
byte Value2 = 113;

string Value1String = Convert.ToString(Value1, 2);
string Value2String = Convert.ToString(Value2, 2);

Console.WriteLine(Value1String.PadLeft(8, '0'));
Console.WriteLine(Value2String.PadLeft(8, '0'));

Value1 |= Value2;
string ResultString = Convert.ToString(Value1, 2);
Console.WriteLine("OR:");
Console.WriteLine(ResultString.PadLeft(8, '0'));

/*
Prints to screen the following:
11110101
01110001
OR:
11110101
*/
```

Once again, this is useful for specific hardware signaling or situations where specific binary operations are needed.

* * *Finally we have the

**^=** operator. This operator is another bitwise operator, specifically the exclusive OR (XOR). An XOR operation returns a true result if exactly one operand has a true value. If both compared values are true or both are false, XOR will yield a false result. This code snippet demonstrates how it works in C#:</p>

```csharp
byte Value1 = 245;
byte Value2 = 113;

string Value1String = Convert.ToString(Value1, 2);
string Value2String = Convert.ToString(Value2, 2);

Console.WriteLine(Value1String.PadLeft(8, '0'));
Console.WriteLine(Value2String.PadLeft(8, '0'));

Value1 ^= Value2;
string ResultString = Convert.ToString(Value1, 2);
Console.WriteLine("XOR:");
Console.WriteLine(ResultString.PadLeft(8, '0'));

/*
Prints to screen the following:
11110101
01110001
XOR:
10000100
*/
```

Again, this is useful for things like hardware communication or data stream manipulation.

* * *There are a ton more bitwise operations that C# can perform, all of which are detailed here on

<a href="http://msdn.microsoft.com/en-us/library/6a71f45d%28VS.71%29.aspx" class="external external_icon" target="_blank">MSDN</a>.</p>
