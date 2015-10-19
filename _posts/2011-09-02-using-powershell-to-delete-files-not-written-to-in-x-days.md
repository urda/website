---
title: Using PowerShell to Delete Files Not Written to in 'X' Days
layout: post

excerpt: |
    Use PowerShell to clean up those old files that have not been written to
    or altered in a while.

redirect_from: /2011/09/using-powershell-to-delete-files-not-written-to-in-x-days/

categories:
  - How To
tags:
  - PowerShell
  - Scripting
  - Windows
---

If you have ever had any type of program or application that keeps logs or fouls
up the **temp** directory in your system you know the frustration that comes
from wasted disk space with old, unused files. Luckily, you can create a very
basic PowerShell script to check a given folder and delete files that are older
than a set number of days.

Let's start with a basic script for this. We will have two variables:
**FilePath** and **FileDays**. The file path is used for specifying what folder
we want PowerShell to search against. If a file's last write timestamp is less
than the file days variable the script will delete said file from the directory.
For the sake of simplicity, this script does not check dates on subdirectories
nor does it attempt to delete subdirectories. The PowerShell script is just
interested in files directly in the **FilePath**.

So enough talk, here is the script:

```powershell
# Path to purge old files from
$FilePath = "C:\temp\"

# Define the minimum number of days since last write time
# for a file to be purged. Set this to a negative number, since
# it is in the past.
$FileDays = "-30"

foreach($File in Get-ChildItem $FilePath | Where {!($_.PsIsContainer)})
{
    if($File.LastWriteTime -lt (Get-Date).AddDays($FileDays))
    {
        del $File.FullName
    }
}
```

Like I said, really simple. You could schedule this to run as a task, or you
could even re-write this script to act as a function within another PowerShell
script. This script is well suited for purging files from a log folder, say
**C:\dev\logs** if the log files are created containing the current date in the
file name (something-Year-Month-Day.log). This way, you will only have a month
of log files at any given time. Once this script is set up, it is pretty much a
"set it and forget it".
