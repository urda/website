---
title: Debugging With Conditionals
author: Peter Urda
layout: post
redirect_from: /2010/11/debugging-with-conditionals/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
---
So you have your program written out, and you have met all your goals. You are so confident that the program is ready, you rip out the debug statements and other debugging related functionality from it. You fire up the program and feed it the initial values and **BAM** nothing works! If only you kept the debug calls! Well you can avoid this in the future by using conditions in your code.

If you have ever worked on a complex C# application, you may have seen code such as the following:

<pre class="brush: csharp; title: ; notranslate" title="">#if DEBUG
debug.PrintStackTrace();
#endif
</pre>

You would have these block in your program everywhere you made a call to the debug class. This adds extra lines to our source code, and can cause issues when you have to make changes to debug handling. 

But there is a more elegant way of enabling or disabling debugging. We can add conditionals to our methods based on the build environment. So let&#8217;s say we have a \`debug\` class with the method named \`PrintStackTrace\`. This simply prints out some stack trace where ever it has been requested. Instead of surrounding each method call with #if and #endif we will add a line before our method in the debug class (look at the highlighted line):

<pre class="brush: csharp; highlight: [3]; title: ; notranslate" title="">// debug class...

[Conditional("DEBUG")]
public void PrintStackTrace()
{
    /* Method code would be here */
}

// Main, or other class...

/* And simply call it normally */
debug.PrintStackTrace();
</pre>

So now all you have to do is make the call to the method when you like by simply building in DEBUG mode. When we switch to release, the code is stripped out and ignored as if it never existed. If you use the first method, you are adding at least two extra lines to every debug call in your program. This can rapidly increase the length of your source code. Instead the second method only costs an extra line before each method you are using for debugging. Plus, it looks a lot cleaner without all the #if/#endif statements!