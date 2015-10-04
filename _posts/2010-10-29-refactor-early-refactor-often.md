---
title: Refactor Early, Refactor Often
author: Peter Urda
layout: post
redirect_from: /2010/10/refactor-early-refactor-often/
categories:
  - Mercer Daily Reports
tags:
  - Co-Op
  - Programming
---
...it may very well save your life! Well maybe not your life, but keep your mentality sanity intact and your stress levels low. A great piece of software will go through many iterations. What you once thought was a proper and understandable method or variable name may now represent something completely different! If you keep your code clean, organized, and efficient the task of upgrading it or repairing it will be so much easier.

All programmers are guilty of bad habits at one time or another. Sometimes extra code stubs that are commented out stay in the class files for many revisions. Other times cryptic methods and variables such as **var01, var02, var03** may have worked OK for a quick prototype, but have no purpose in living in production code. You may even have constructors, methods, and variables scattered across a source file, all intermingled together with no logic or order.

If another programmer cannot take a quick look at your program and understand your work-flow, something has gone terribly wrong. Another programmer should be able to look at your methods and understand what the basic functionality is. Variable names should not only describe something, but make sense with the flow of code all around them. Each source file should have a common infrastructure and order. If something does not make sense to the reader, all they should have to do is look for a nearby comment which should explain complex functionality.

A great project will follow these guidelines:

  * Clean, correctly indented code
  * Useful Variable Names
  * Understandable Method Names
  * Proper constructor design
  * A common layout across **all** source files in the same project
  * **DOCUMENTATION FOR EACH FUNCTION** </ul>
    When you follow these standards, you will be able to quickly find critical sections in your code when you need to. It will also allow you to pass your source code along to another user without having to explain every line of the source.

    All of these points take into consideration that you will make the effort to apply them. It is you that must take action. You must stay on top of your project by refactoring early and often. If you take the time to do this (no matter how boring it may be to do it) you will be keep your project running smoothly and have source code that is easy to work with.
