---
title: Solution Folders in Visual Studio 2010 Explained
author: Peter Urda
layout: post
redirect_from: /2010/09/solution-folders-in-visual-studio-2010-explained/
categories:
  - How To
  - Mercer Daily Reports
tags:
  - Co-Op
  - Visual Studio 2010
---
If you are new to Visual Studio, you may not be familiar with how "Solution Folders" work. Visual Studio allows you to group together any number of sub-projects that your root solution may contain. However, what is strange about Solution Folders in Visual Studio is that they do *not* create the same logical structure on your disk. Solution Folders will not create a mirror on your hard drive. They just create a logical grouping inside your Visual Studio Project. They will not move files around, or create directories for your projects when you create Solution Folders and place your projects inside them. It is a good practice to have your logical project structure to have a one-to-one relationship with your physical directory structure, and the behavior of the Solution Folders do not follow this. But there is a way for Visual Studio to create the physical structure on the disk when adding projects to the solution.

Let's say you have a project located at **C:\VS.Projects\** and you have a number of other projects contained within it. Well your personal projects have become too cumbersome and are in great need of folders for grouping. You want to use Solution Folders to group them together. So you group them together, and your Visual Studio Solution structure looks nice and wonderful. You build your project, and the build succeeds as before. You are so excited you decide to go ahead and make a backup of your project for the day. After all it was a lot of work moving those projects around in the Solution Explorer!

However when you check the actual folder on your hard drive, you discover that there are no sub-folders inside **C:\VS.Projects\**! All the sub-projects are still lying around without any organization whatsoever. You are now frustrated that Visual Studio must have tricked you. So you go ahead and move the files around to match your structure in Visual Studio. After that is all done, you fire up Visual Studio and grab yourself a cup of coffee while it starts up.

When you return you are shocked to see your project no longer works at all. All the sub-projects are complaining that they are "Unavailable" or are unable to be read from the disk. You can't open any of your source files, nothing is there anymore! Oh the horror!

This terrible occurrence could have easily been avoidable. So what can you do about it?

First off it is easiest to use Solution Folders right away the correct way. This article will cover that approach and let Visual Studio 2010 do all the work. So let's create a new Console Application that we want stored in **C:\VS.Projects\Test\MyApp** since you are planning on writing a new application for testing.

We are going to create the solution folder first, by Right-Clicking on the root of the project, then clicking 'Add', and then clicking 'New Solution Folder'. We go ahead and type in 'Test' and so our project looks like this:

<p style="text-align: center;">
  <img class="size-full wp-image-570  aligncenter" title="Solution Folders in Visual Studio 2010" src="http://www.peter-urda.com/wp/wp-content/uploads/2010/09/SolutionFolders01.png" alt="Solution Folders in Visual Studio 2010" width="344" height="122" />
</p>

Now we will go ahead and create our Console Application inside the 'Test' Solution Folder. We will do that by Right-Clicking on 'Test', then clicking 'Add', and then clicking 'New Project'. We select "Console Application" from the Visual C# &#8211; Windows templates, and we fill in 'MyApp' in the Name field.** But do not click OK yet!**

*<span style="color: #ff0000;">Pay attention to this critical step:</span> * We need to change the location of this project to correctly reflect our desired one-to-one relationship when it comes to comparing Solution Folders to actual physical folders on the hard drive. So we are going to tack on '\Test\' to the end of the Location Path. This will cause Visual Studio to automatically create a sub-folder inside the VS.Projects folder named 'Test', and then place our new project titled 'MyApp' inside the new folder on the hard drive. Your project screen will look like this before you submit it:

<p style="text-align: center;">
  <a href="http://www.peter-urda.com/wp/wp-content/uploads/2010/09/SolutionFolders02-Corrected1.png"><img class="aligncenter size-full wp-image-593" title="Solution Folders - Creating a New Project" src="http://www.peter-urda.com/wp/wp-content/uploads/2010/09/SolutionFolders02-Corrected1.png" alt="Solution Folders - Creating a New Project" width="688" height="475" /></a>
</p>

When we click 'OK' our new project will be setup as normal in Visual Studio. It will be placed underneath the new Solution Folder, and Visual Studio has already created the structure on the disk to mirror your project now. Here is the Solution Explorer and Windows Explorer compared for reference:

<img class="aligncenter size-full wp-image-596" title="Solution Folders and Windows Explorer" src="http://www.peter-urda.com/wp/wp-content/uploads/2010/09/SolutionFolders03.png" alt="Solution Folders and Windows Explorer" width="497" height="751" />

There you go!

Now if you had already had a bunch of projects you wanted to organize, you're best bet is to remove each project from your solution, reorganize them on your hard drive, and then re-import them inside new solutions folders. This method is not in the scope of this article, but for the experienced Visual Studio users it should be straight forward to remove and re-add your projects correctly. 

So hopefully this guide helps clear up some confusion for newer users to Visual Studio when it comes to Solution Folders, and how they work.
