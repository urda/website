---
title: Disable You Have Created a Service
layout: post
redirect_from: /2010/11/disable-you-have-created-a-service/

urda_uuid: 20101118

categories:
  - Mercer Daily Reports
tags:
  - Co-Op
  - IIS
  - WCF
---

When you create a basic WCF service hosted through IIS, you are greeted with a
generic page informing you that "You Have Created a Service". This is useful
since it provides to the developer two critical pieces of information. First it
lets you know that the service is up and running, second it provides basic code
stubs to query the service with. While this may be fine for development, you
might not want to display this page in production. Disabling it is not
intuitive, but with some searching through the MSDN documentation I have found
the preferred way of changing this page.

When you first setup a service, you'll see this screen when you visit the
service URL:

[![HTTP Help Page](/content/{{ page.urda_uuid }}/calcservice.png)](/content/{{ page.urda_uuid }}/calcservice.png)

To disable the HTML "You Have Created a Service" page for your WCF services,
simply add this XML inside your **Web.config** file as a child of
**configuration**

```xml
<system.serviceModel>
    <behaviors>
        <serviceBehaviors>
            <behavior>
                <serviceDebug httpHelpPageEnabled="false"
                              httpsHelpPageenabled="false" />
            </behavior>
        </serviceBehaviors>
    </behaviors>
</system.serviceModel>
```

This block of XML will then cause the raw XML information to be displayed
instead of the generic "You Have Created a Service" page. You can fine tune the
behavior even more, so you may want to reference
[MSDN](https://msdn.microsoft.com/en-us/library/ms788993.aspx) for more
information.
