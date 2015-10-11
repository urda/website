---
title: 'Using #region Effectively'
author: Peter Urda
layout: post
redirect_from: /2010/10/using-region-effectively/

urda_uuid: 20101010

categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
  - Visual Studio 2010
---

The **#region** preprocessor directive can make your C# code very organized. It
is a shame that so many coders do not learn to use #region early and often. Sure
**#region** allows Visual Studio 2010 to collapse your code block down into
one-line, but better yet it can be used to sort code by common sections. This
provides a framework for other source files throughout your project to mimic.
Today I wanted to cover how I like to sort my code in my projects.

Many of your C# classes, interfaces, and other source files will have common
logical groupings. For example many classes will contain one or more of the
following:

* Public Variables
* Private Variables
* Constructors
* Public Methods
* Private Methods

So using that as our **#region** framework we can develop a skeleton C# class
file that follows that concept:

```csharp
using System;

namespace SomeConsoleApp
{
    class ConsoleClass
    {
        #region Public Variables

        /* ...Here Be Dragons... */

        #endregion

        #region Private Variables

        /* ...Here Be Secret Dragons... */

        #endregion

        #region Constructors

        /* ...Here Be Dragon Eggs... */

        #endregion

        #region Public Methods

        public void BreatheFire()
        {
            /* ...Magic Goes Here... */
        }

        // ...other public methods...

        #endregion

        #region Private Methods

        private void RebuildFireBreath()
        {
            /* ...Some Secret Magic Goes Here... */
        }

        // ...other private methods...

        #endregion
    }
}
```

So if you were to plug-in the C# example from above, you could collapse your
sections down so your editor looks like this:

<img class="aligncenter size-full wp-image-1039" title="Collapsed Code Sections" src="http://www.peter-urda.com/wp/wp-content/uploads/2010/10/Collapsed-Dragons.png" alt="Collapsed Code Sections" width="229" height="297" />

If you are good about keeping your code clean a system like this can be
invaluable to you. A system like my example will let you quickly move from file
to file knowing where all the important chunks of code are, and allow you to
"ignore" other sections since they will be collapsed already.

This is just one way to structure your project. You can of course re-order your
blocks into however you see fit, and if you do you should leave a comment and
tell me how you prefer to organize your source files.

So go ahead and give it a try in your next project!
