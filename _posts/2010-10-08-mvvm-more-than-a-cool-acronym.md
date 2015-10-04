---
title: MVVM, More Than a Cool Acronym
author: Peter Urda
layout: post
redirect_from: /2010/10/mvvm-more-than-a-cool-acronym/
categories:
  - Mercer Daily Reports
tags:
  - Co-Op
  - MVVM
  - Programming
---
If you have worked with WPF or Silverlight at all, you should be familiar with MVVM. If not this article is the perfect read for you! MVVM or Model View ViewModel is an architectural pattern that is used for designing advanced software projects. The MVVM pattern originated from Microsoft and follows closely to the Model View Controller (MVC) pattern employed by other software projects. This article will cover the basic concepts and characteristics that MVVM brings to the table.

From on overall point of view, the Model View ViewModel paradigm tries to blend the separation of functional development that MVC offers while implementing the power of XAML and WPF by controlling where data is manipulated. Basically, MVVM brings the code needed to alter the UI very close to the ViewModel and Model with data bindings, allowing for very little to no code having to be written in the actual XAML UI files.

Let&#8217;s go ahead and break down the individual portions of the MVVM architecture. I made a simple diagram (displayed bellow) that demonstrates the relationships between each portion:

<img class="aligncenter size-full wp-image-1030" title="MVVM Diagram, Created by Peter Urda" src="http://www.peter-urda.com/wp/wp-content/uploads/2010/10/MVVM-Diagram_By-Urda.png" alt="MVVM Diagram, Created by Peter Urda" width="552" height="347" />

**Model:** Models from MVVM tend to resemble models from MVC very closely. A model is just a simple way of representing an object or chunk of data. We really do not care if that data came from a database, user input, various variables, or anywhere else. It is just the layer that is used to query some form of data.

**View:** Once again MVVM pulls heavily from the MVC pattern for views. The view is in charge of controlling the presentation of the program to the user. Views will contain all the various buttons, text boxes, pop-ups, graphics, and other UI features to display on-screen to the end-user.

**ViewModel:** A view model can be defined as a "Model of the View" and yes I agree that phrase is really confusing and does not say much about the actual functionality of the ViewModel. Basically, the ViewModel binds the data from the Model to the View. It changes and manipulates data from the Model to send to the View for display Data or actions from the view are taken in, logic may or may not be ran against said actions, and any updates or changes to the data is relayed back to the Model. A ViewModel will contain all the commands, properties, and logic a program needs to function.

There are some current issues with MVVM at this time though:

  * MVVM is fairly new, so some concepts and practices are still being standardized and worked out
  * Lack of MVVM toolkits, walkthrough, and patterns compared to other architectures
  * Can be "overkill" for small applications
  * If data binding is not handle well and cleanly, things can get messy really quick!
  * Having to create a property then code needed to bind to said property, can lead to duplicate code and maintenance problems down the road

As with any project, plenty of planning and thought has to be put in to produce a successful program. MVVM will not fit every individual&#8217;s needs, but no architecture is perfect. So take a look at MVVM and see if it is the right path for your application.
