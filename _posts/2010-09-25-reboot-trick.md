---
title: Reboot Trick
author: Peter Urda
layout: post
redirect_from: /2010/09/reboot-trick/
categories:
  - How To
tags:
  - Windows
---
Have you ever had the issue where Windows insists that there are pending install or uninstall operations even after a system reboot? This can often be caused by programs not cleaning up a specific key in the registry. So here is a quick fix you can use to correct this problem.

As always be careful when editing the system registry, and be sure to make a backup before you do anything to its contents. I cannot be held liable if your computer breaks down, catches fire, or what-have-you.

To simply fix the issue where Windows is constantly stuck in a &#8220;Reboot Required&#8221; state, just remove any values that are contained in the **PendingFileRenameOperations** key. The full path for this key is listed below:

<pre class="brush: powershell; title: ; notranslate" title="">HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\PendingFileRenameOperations
</pre>

&#8230;and that should correct the issue and allow you to install more software!
