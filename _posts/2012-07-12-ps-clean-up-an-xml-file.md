---
title: Using PowerShell to Clean Up an Xml File
author: Peter Urda
layout: post
redirect_from: /2012/07/ps-clean-up-an-xml-file/
categories:
  - Programming
tags:
  - PowerShell
---

Sometimes you are given an Xml file, either handmade or machine generated, to
work with. Many times, this Xml file can be a mess, with indentation all wrong
or every single node on a single line or two. Within PowerShell, I have created
a simple function which accepts just a single input of the file path, and
attempts to locate the Xml file and "prettify" for easier reading. This function
is only 19 lines long (for a total of 31 when including the documentation) and
is a great tool to add to your PowerShell profile!

There is error handling at each step, to verify that there was input, the file
exists, can be accessed, and the save operation completed. Just simply provide
the function the path to the target Xml file, and fire away!

Here is the function you can load into your session, or add to your profile for
future use:

```powershell
function Format-Xml
{
    <#
    .SYNOPSIS
        Loads, formats (prettifies), and resaves an Xml file for easier reading and editing.
    .DESCRIPTION
        This function attempts to load and re-save an xml file. When the Xml file is resaved,
        the document is saved in a "prettified" or formatted view. This is useful for when
        you have an Xml file, but all the formatting is messed up, or the whitespace is not uniform.
    .NOTES
        Author : Peter Urda (@Urda)
    .LINK
        This script posted to: http://www.peter-urda.com/2012/07/ps-clean-up-an-xml-file
    #>
    param ([string]$FilePath = $null)
    if ($FilePath) {
        if (Test-Path $FilePath) {
            $FileObject = Get-ChildItem $FilePath
            if (!($FileObject.IsReadOnly)) {
                try {
                    $xml = New-Object Xml
                    $xml.Load($FileObject.ToString())
                    $xml.Save($FileObject.ToString())
                } catch {
                    Write-Host "/!\ An error occured /!\" -Foreground Black -Background Red
                    Write-Host $_.Exception.Message -Foreground Black -Background Red
                }
            } else { Write-Host "/!\ File is read only /!\" -Foreground Black -Background Red }
        } else { Write-Host "/!\ File not found /!\" -Foreground Black -Background Red }
    } else { Write-Host "Usage: Format-Xml \Path\To\Xml\File" }
}
```
