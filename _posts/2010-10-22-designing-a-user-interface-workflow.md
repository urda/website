---
title: Designing a User Interface Workflow
author: Peter Urda
layout: post
redirect_from: /2010/10/designing-a-user-interface-workflow/
categories:
  - Mercer Daily Reports
tags:
  - Co-Op
  - Programming
---
If an interface to a piece of software is simple, clean, and easy to follow you are likely to enjoy working with that program. When an interface is complex, difficult to navigate, or just doesn&#8217;t make sense it will frustrate you as an end user. You may be able to write the best back-end code of all time, but if you cannot write a wonderful User Interface to go with it you might as well give up. Today, I would like to discuss with you how to start creating a wonderful interface that is not only easy to follow, but controls the direction in which the user will follow.

First you need a basic pattern that the user will need to step through in a given menu or window. Once you have a start point and an end point you&#8217;ll need to account for all possible directions a user can take at a given time. I like to start with a simple diagram of the window I am working with in the corner of my sketch. I highlight or mark special sections that need to be accounted for. It might mean that a button or entry box is disabled at the start, but overall this sketch describes the initial state of the window.

I start from my starting point and step through each part of the workflow I want my user to go through. I&#8217;ll need to manipulate the UI to not only lead the user to that point, but restrict any unwanted actions that they may attempt to do. I usually start with the shortest direction that a user can take to an end point, and then I expand each possible route they could legally take from there. You may want to grab yourself a large piece of paper, or a large whiteboard during this process as things can get a little complicated.

Here is the markup I made for my workflow for my latest project:

[<img class="aligncenter size-large wp-image-1144" title="Markup Workflow of a UI" src="http://www.peter-urda.com/wp/wp-content/uploads/2010/10/IMG_11461-700x522.jpg" alt="Markup Workflow of a UI" width="700" height="522" />][1]

It is a workflow to control how a user can pick a &#8220;project code&#8221; and then account for further actions such as searching, defining a new code, validating the new code, exiting, and so forth. I used various methods within my project to disable and enable each of these sections, literally preventing the user from clicking or typing into disabled fields and controls.

Creation can be a little messy, but in the end I have defined a wonderful UI flow that is easy to follow when the program is actually used by an end user. Believe me, your users will thank you if you take the time to make a wonderful UI.

 [1]: http://www.peter-urda.com/wp/wp-content/uploads/2010/10/IMG_11461.jpg
