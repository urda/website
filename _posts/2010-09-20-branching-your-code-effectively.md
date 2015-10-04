---
title: Branching Your Code Effectively
author: Peter Urda
layout: post
redirect_from: /2010/09/branching-your-code-effectively/
categories:
  - Mercer Daily Reports
tags:
  - Co-Op
---
To develop and maintain a healthy software project you are going to need a good revision tracking system and branching strategy. There are many different techniques and patterns you can take advantage of when branching from your development trunk or merging code back into it. Branching should be a part of all major and minor software development processes, and the activity of branching and merging should be a natural event throughout the lifetime of a product. So here are some common branching strategies you may want to integrate into your next project.

<p style="text-align: center;">
  <strong>Branching Per Release</strong>
</p>

<img class="aligncenter size-full wp-image-776" title="BranchPerRelease" src="http://www.peter-urda.com/wp/wp-content/uploads/2010/09/BranchPerRelease.gif" alt="" width="449" height="118" />  
One of the most common methods is branching per release. This makes the most sense to many developers, since you would want to build a new branch for each major release. All code comes from a central line and changes are pushed out to either create a new X.0 main branch, or add a point release to a given version branch. All releases will generate their own new branch, which will be long lived.

<p style="text-align: center;">
  <strong>Branching Per Component</strong>
</p>

<img src="http://www.peter-urda.com/wp/wp-content/uploads/2010/09/BranchPerComponent.gif" alt="" title="BranchPerComponent" width="436" height="149" class="aligncenter size-full wp-image-775" />  
For every major component that is developed into the program, a new independent branch is built. This allows the main software line to continue either maintenance or releases. Once a component is mature enough to be safely pulled into the main program suite, a merge can then be conducted to bring the new code into the program. All of these branches will be short lived, and not long term like per release branches.

<p style="text-align: center;">
  <strong>Branching Per Technology</strong>
</p>

<img src="http://www.peter-urda.com/wp/wp-content/uploads/2010/09/BranchPerTechnology.gif" alt="" title="BranchPerTechnology" width="420" height="150" class="aligncenter size-full wp-image-778" />  
Finally, since there is more to the world than just Windows it may make a lot of sense to develop branches for major operating systems. Since features and functionality may be fundamentally different in a Linux environment than a Windows environment, different calls and code chunks may need to exist. Also a bug fix may apply to one branch and be irrelevant in the other. These branches are going to be long lived branches.

[All images from <a href="http://msdn.microsoft.com/" class="external external_icon" target="_blank">MSDN</a>]
