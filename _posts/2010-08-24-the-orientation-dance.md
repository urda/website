---
title: The Orientation Dance
author: Peter Urda
layout: post
redirect_from: /2010/08/the-orientation-dance/
categories:
  - Mercer Daily Reports
tags:
  - Co-Op
  - Delegates
---
<img class="alignright size-full wp-image-292" style="margin-left: 10px; margin-right: 10px;" title="Mercer Logo" src="http://www.peter-urda.com/wp/wp-content/uploads/2010/08/Mercer_logo.jpg" alt="Mercer Logo" width="192" height="69" />On Monday I started my first day of my second co-op with a new employer. I will be working with Mercer, a subsidiary of Marsh & McLennan Companies, developing and supporting C# and .NET Mercer applications. The past two days have been filled with standard new hire training and orientation sessions and plenty of reading. However it is the brief product overview and C# introduction sessions I learned the most from.

I have learned a handful of C# specifics and design ideas from my supervisor Zane Thorn. Out of all the topics touched, C# \`delegates\` was the most new and interesting idea to me. A C# delegate is best defined as&#8230;

> &#8230;a method to call and optionally an object to call the method on. They are used, among other things, to implement callbacks and event listeners. It encapsulates a reference to a method inside a delegate object. The delegate object can then be passed to code which can call the referenced method, without having to know at compile time which method will be invoked.
> 
> Source: <a href="http://en.wikipedia.org/w/index.php?title=Delegate_%28.NET%29&oldid=380252993" class="external external_icon" target="_blank">http://en.wikipedia.org/wiki/Delegate_(.NET)</a>

So we can define a simple delegate name, and have our main program use it as a callback hook for asynchronous applications. All of this is done without the need for a program to know what in the world the method actually does. Our program is not bound to knowing which method exactly will be called when the delegate is used. This offers flexibility to defining the back-end method used by the delegate, without trigger compilation issues while working on a project.