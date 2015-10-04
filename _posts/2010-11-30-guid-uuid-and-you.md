---
title: GUID, UUID, and You!
author: Peter Urda
layout: post
redirect_from: /2010/11/guid-uuid-and-you/
categories:
  - Mercer Daily Reports
tags:
  - GUID
  - Programming
  - UUID
---
So let's say you have a bunch of objects. Yeah, a bunch of random objects completely unrelated to each other. You need a simple system that will take the information about these objects and shove them into a database. Do you just create a simple *int* identification value? If you do that then how do you control the indexing across multiple database servers? A surefire way to do this is instead use some method to generate a unique ID no matter the instance. This is where a GUID/UUID will come in handy!

First things first, what exactly is a GUID or a UUID? First off they are essentially the same thing. A GUID is a "Globally unique identifier" and a UUID is a "Universally unique identifier". They sound similar because they are pretty much the same, the exception being a GUID is Microsoft's implementation of the UUID standard.

Now that is out of the way, let's take a look at the makeup of a regular UUID value. A UUID is a 128-bit, 16 byte value that follows this pattern:

```
01234567-0123-0123-0123456789ab
```

With this design, you can have 3 x 10<sup>38</sup> unique values. The chance of a collision is so small that you can use UUID's as your ID data in a database. The downside to using a UUID is going to be the larger size and readability compared to an integer. However, the benefits of using a UUID allow you to merge databases quickly and without collisions, be sure that each row is truly a unique row, and other operations that need to be spread across machines or physical locations.

So just remember: a UUID can be used to create a true unique identification value for anything and everything, a GUID is just Microsoft's implementation of the UUID standard.
