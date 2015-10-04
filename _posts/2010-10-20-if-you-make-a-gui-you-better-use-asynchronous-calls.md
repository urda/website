---
title: If You Make a GUI, You Better Use Asynchronous Calls
author: Peter Urda
layout: post
redirect_from: /2010/10/if-you-make-a-gui-you-better-use-asynchronous-calls/
categories:
  - Mercer Daily Reports
tags:
  - Co-Op
  - Programming
---
Sometime throughout one&#8217;s life they will encounter a not-so-well written piece of software. Maybe the user interface is confusing, maybe it does not do enough for the end-user, or perhaps it is not very good-looking. Generally we dislike certain pieces of software because they run slow or become unresponsive during tasks. A lot of times this is due to misconfigured computers or older computers. The other large chunk of time is because a developer setup work flow wrong. This will happen if the program is making synchronous calls in the middle of GUI operations.

Just a quick overview, a program on a computer runs on a thread which keep track of the execution of the program. It executes commands in order, when the processor on the computer gives it sometime for operations. So we when start up an application it will begin on a single thread, which usually is tasked with spinning up the application and launching the Graphical User Interface (GUI) for the end user. Now if we continue to make major executions straight from the GUI, then the program has to wait for those commands to finish. We&#8217;ve all seen this before, we start a major operation such as **&#8220;Save&#8221;** and the program appears to lock up. This is because we made a synchronous call, basically a command call that makes the GUI wait for a response back. There is a simple fix for this though!

Many modern languages will handle creating threads and allowing asynchronous calls to be performed. The asynchronous call will break away from the GUI (either in another thread or some language-dependent procedure) to do its busy work. The GUI is then released to continue what it was doing (such as accepting user input or display active information) before. So if we break away how do we bring back the asynchronous method? Again, this is already solved for us in most languages. The method has a &#8220;callback&#8221; method bound to it, and this callback is executed only when the asynchronous method completes. If we wanted to prompt the user with notification that a saved occurred, we would make the notification occur in the callback method for the save function.

So if your program ever hangs again, it could be because a synchronous call was made instead of an asynchronous call!
