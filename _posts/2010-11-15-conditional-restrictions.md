---
title: Conditional Restrictions
author: Peter Urda
layout: post
redirect_from: /2010/11/conditional-restrictions/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
---
The other day I showed you how to use conditional statements to build more elegant debugging code blocks. What I did not discuss in that same article was the restrictions that came with using conditionals. Today I'll cover that.

My <a href="http://www.peter-urda.com/2010/11/debugging-with-conditionals" target="_blank">"Debugging with Conditionals"</a> article offered a different way to handle debug code blocks. The traditional, and longer way is to use ** #if, #endif** statements. Instead of **#if** blocks we used conditional statements to control if debug code was used or not. There are restrictions on Conditionals though...

>   * The conditional method must be a method in a class or struct declaration. A compile-time error occurs if the Conditional attribute is specified on a method in an interface declaration.
>   * The conditional method must have a return type of *void*.
>   * The conditional method must not be marked with the *override* modifier. A conditional method may be marked with the *virtual* modifier, however. Overrides of such a method are implicitly conditional, and must not be explicitly marked with a *Conditional* attribute.
>
> Source: <a href="http://msdn.microsoft.com/en-us/library/aa664622%28v=VS.71%29.aspx" class="external external_icon" target="_blank">http://msdn.microsoft.com/en-us/library/aa664622%28v=VS.71%29.aspx</a>

These points must be taken into consideration if you plan to use the **Conditional** type exclusively or heavily in your project. With proper planning and design you will be able to leverage the conditional attribute to your advantage for better code readability and usability.
