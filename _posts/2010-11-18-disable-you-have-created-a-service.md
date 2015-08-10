---
title: 'Disable &#8220;You Have Created a Service&#8221;'
author: Peter Urda
layout: post
redirect_from: /2010/11/disable-you-have-created-a-service/
categories:
  - Mercer Daily Reports
tags:
  - Co-Op
  - IIS
  - WCF
---
When you create a basic WCF service hosted through IIS, you are greeted with a generic page informing you that &#8220;You Have Created a Service&#8221;. This is useful since it provides to the developer two critical pieces of information. First it lets you know that the service is up and running, second it provides basic code stubs to query the service with. While this may be fine for development, you might not want to display this page in production. Disabling it is not intuitive, but with some searching through the MSDN documentation I have found the preferred way of changing this page.

When you first setup a service, you&#8217;ll see this screen when you visit the service URL:

<img src="http://www.peter-urda.com/wp/wp-content/uploads/2010/11/CalculatorService-Service.png" alt="CalculatorService Service HTML" title="CalculatorService Service HTML" width="396" height="256" class="aligncenter size-full wp-image-1217" />

To disable the HTML &#8220;You Have Created a Service&#8221; page for your WCF services, simply add this XML inside your *Web.config* file as a child of **configuration**

<pre class="brush: xml; title: ; notranslate" title="">&lt;system.serviceModel&gt;
    &lt;behaviors&gt;
        &lt;serviceBehaviors&gt;
            &lt;behavior&gt;
                &lt;serviceDebug httpHelpPageEnabled="false"
                              httpsHelpPageenabled="false" /&gt;
            &lt;/behavior&gt;
        &lt;/serviceBehaviors&gt;
    &lt;/behaviors&gt;
&lt;/system.serviceModel&gt;
</pre>

This block of XML will then cause the raw XML information to be displayed instead of the generic &#8220;You Have Created a Service&#8221; page. You can fine tune the behavior even more, so you may want to reference the <a href="http://msdn.microsoft.com/en-us/library/ms788993.aspx" class="external external_icon" target="_blank">MSDN documentation</a> for more information.