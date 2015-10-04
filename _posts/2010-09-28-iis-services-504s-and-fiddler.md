---
title: IIS Services, 504's, and Fiddler
author: Peter Urda
layout: post
redirect_from: /2010/09/iis-services-504s-and-fiddler/
categories:
  - Mercer Daily Reports
tags:
  - 504
  - ClickOnce
  - Debug
  - Fiddler
  - IIS
---
I have been tracking a random issue in one of our projects here at Mercer. It is a simple ClickOnce application, with a handful of hosted services through an IIS website. When I worked on the tool in my local development environment everything worked fine. When I deployed the tool to QA for testing it completely broke at a single point in the application for our QA team in India. The tool worked fine here in Louisville, with the exception of this morning where I was able to reproduce the problem.

### ***<span style="color: #ff0000;"><span style="text-decoration: underline;">ATTENTION!</span> The actual problem was found later on and is detailed here in depth:</span> <a href="http://www.peter-urda.com/2010/09/follow-up-iis-services-504s-and-fiddler" target="_blank">http://www.peter-urda.com/2010/09/follow-up-iis-services-504s-and-fiddler</a>***

With the problem triggering locally, I started up Fiddler on my program. In case you have never heard of Fiddler it is a wonderful tool to track HTTP requests entering and exiting your computer. From the official Fiddler website:

> Fiddler is a Web Debugging Proxy which logs all HTTP(S) traffic between your computer and the Internet. Fiddler allows you to inspect all HTTP(S) traffic, set breakpoints, and "fiddle" with incoming or outgoing data. Fiddler includes a powerful event-based scripting subsystem, and can be extended using any .NET language.
> 
> Fiddler is freeware and can debug traffic from virtually any application, including Internet Explorer, Mozilla Firefox, Opera, and thousands more.
> 
> Source: <a href="http://www.fiddler2.com/fiddler2/" class="external external_icon" target="_blank">http://www.fiddler2.com/fiddler2/</a>

When I performed the action that caused the application to lock up (in this case hit a service on IIS to pull down a list from a database), Fiddler treated me with this error message:

<pre class="brush: plain; title: ; notranslate" title="">HTTP/1.1 504 Fiddler - Receive Failure
Content-Type: text/html
Connection: close
Timestamp: XX:XX:XX.XXX

ReadResponse() failed: The server did not return a response for this request.
</pre>

This had me lost, I was not sure why the server would be kicking back a 504 timeout error. I was able to get access to the service at its endpoint URL and I was able to use **svcutil.exe** to build generated stubs for C# off it. The logs in IIS also did not give me any further information. What I did know is that when a request for information came from the ClickOnce application, it would be unable to pull in any results right after Fiddler logged a 504 from the service.

So I had to do some investigation into the matter server-side. Afterall, it was during the client request that the timeout occurs, so it was the best place to start. I tried re-deploying the application to the QA cluster multiple times, digging through IIS configuration settings, and double checking my code changes until I figured out the magic bit I was missing.

The request was being cutoff by IIS because it was too large for whatever reason. So I simply added this line to my **Web.config** for the IIS project in Visual Studio:

<pre class="brush: xml; title: ; notranslate" title="">&lt;system.web&gt;
    &lt;!-- ... --&gt;

    &lt;httpRuntime maxRequestLength="16384"/&gt;

    &lt;!-- ... --&gt;
&lt;/system.web&gt;
</pre>

The **maxRequestLength **attribute of **httpRuntime **controls how much information IIS will accept before throwing an error. In this case it was trying to build up our desired database query, but was exceeding the limit. For testing purposes, I have increased the limit to 16384KB or 16MB. This allowed the ClickOnce application to receiving all the information it wanted, and our QA team in India was able to run the application as expected.

There are some things to keep in mind with **maxRequestLength**. It is an attribute in ASP websites to prevent DOS attacks on the machine. It prevents a malicious user from making a huge HTTP request in an attempt to cause the server to lock up or crash from a request of that size. In this case it was cutting my application off too soon before it could load up any results from the request.
