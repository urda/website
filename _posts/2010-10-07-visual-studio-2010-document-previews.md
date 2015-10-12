---
title: Visual Studio 2010 Document Previews
author: Peter Urda
layout: post
redirect_from: /2010/10/visual-studio-2010-document-previews/

urda_uuid: 20101007

categories:
  - Mercer Daily Reports
tags:
  - Co-Op
  - Visual Studio 2010
---

If you have used Visual Studio 2008 or the Visual Studio 2010 Betas you should
remember a distinct feature. When you moved through documents inside the IDE
with **CTRL + TAB** you would get a nice little preview of the documents you
were flipping through. If you have used the latest version of Visual Studio
2010, you may have noticed that this feature has been pulled. Well you can
restore it with a simple registry change!

If you use **CTRL + TAB** in Visual Studio 2010 today, you'll get a dialog that
looks something like the following:

[![VS2010 - No Preview](/content/{{ page.urda_uuid }}/vs2010-nopreview.png)](/content/{{ page.urda_uuid }}/vs2010-nopreview.png)

So in order to restore the thumbnail previews we will run this simple command
from ***an elevated command prompt*** in Windows:

```
reg ADD HKCU\Software\Microsoft\VisualStudio\10.0\General /v ShowThumbnailsOnNavigation /t REG_DWORD /d 1
```

Now all you have to do is start up or restart Visual Studio 2010, get your
documents open again, and then try to cycle through them. You should get a much
more useful display like so:

[![VS2010 - Preview](/content/{{ page.urda_uuid }}/vs2010-preview.png)](/content/{{ page.urda_uuid }}/vs2010-preview.png)

Isn't that fantastic?
