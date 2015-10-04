---
title: Visual Studio 2010 Document Previews
author: Peter Urda
layout: post
redirect_from: /2010/10/visual-studio-2010-document-previews/
categories:
  - Mercer Daily Reports
tags:
  - Co-Op
  - Visual Studio 2010
---
If you have used Visual Studio 2008 or the Visual Studio 2010 Betas you should remember a distinct feature. When you moved through documents inside the IDE with **CTRL + TAB** you would get a nice little preview of the documents you were flipping through. If you have used the latest version of Visual Studio 2010, you may have noticed that this feature has been pulled. Well you can restore it with a simple registry change!

If you use **CTRL + TAB** in Visual Studio 2010 today, you'll get a dialog that looks something like the following:

<img class="aligncenter size-full wp-image-1012" title="Visual Studio 2010 - No Document Previews" src="http://www.peter-urda.com/wp/wp-content/uploads/2010/10/VS2010-NoPreview.png" alt="Visual Studio 2010 - No Document Previews" width="390" height="323" />

So in order to restore the thumbnail previews we will run this simple command from ***an elevated command prompt*** in Windows:

```
reg ADD HKCU\Software\Microsoft\VisualStudio\10.0\General /v ShowThumbnailsOnNavigation /t REG_DWORD /d 1
```

Now all you have to do is start up or restart Visual Studio 2010, get your documents open again, and then try to cycle through them. You should get a much more useful display like so:

<img class="aligncenter size-full wp-image-1020" title="Visual Studio 2010 - Document Previews" src="http://www.peter-urda.com/wp/wp-content/uploads/2010/10/VS2010-Preview.png" alt="Visual Studio 2010 - Document Previews" width="600" height="323" />

Isn't that fantastic?
