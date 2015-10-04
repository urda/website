---
title: System.String or string?
author: Peter Urda
layout: post
redirect_from: /2010/11/system-string-or-string/
categories:
  - Mercer Daily Reports
tags:
  - 'C#'
  - Co-Op
---
At one point you may have wondered to yourself "What in the world is the difference between \`System.String\` and \`string\` in regards to C#?" Perhaps you are worried about performance or memory usage between the two. Well, the answer may surprise you!

\`System.String\` and \`string\` are not different as far as C# is concerned! They behave the same and generate identical intermediate language code. One does not have better performance or memory usage over the other. It just so happens that \`string\` is just a synonym inside C# for \`System.String\`. 

It is really up to you which keyword you would prefer to work with. You may want the more contextual \`System.String\` written in your program, or perhaps you would like to save a few keystrokes and shorten up method calls by just using \`string\`. Either way you cannot go wrong, just be sure to keep the same standard across your project!
