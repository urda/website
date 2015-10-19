---
layout: post
title: Writings Reborn

excerpt: |
    After a long hiatus, Writings of Urda is reborn!
---

This blog originally started out as a simple place for posting my daily reports
when I worked at Mercer. Little did I know that a number of my articles would
appear across the internet in other blogs and even used in a few Stack Overflow
answers. So when it came time to migrate my website to a more modern platform
and to a different domain name I had a number of problems to handle.

My website ran on a technology stack that I found difficult to maintain over
time.

- Domain: peter-urda.com
- Content Platform: [WordPress](https://wordpress.org/)
- Analytics Engine: [Piwik](http://piwik.org/)
  - Both required PHP
  - Both required MySQL Database
- Hosting Group: [DreamHost](https://www.dreamhost.com/)

Getting started out these tools fit the bill. WordPress at the time was as
lightweight blog system, Piwik let me have my own private analytics, and
DreamHost allowed for a quick solution to get hosting online quickly. For the
duration of my time at Mercer, and a period following that the entire stack
allowed me to publish content online without having to worry about the details.

As life went on I found it more and more difficult to keep up with this
technology stack. WordPress grew heavier, Piwik had it's required updates, and
all of which required keeping up with what version of PHP was needed. I spent
more time worrying about keeping the website online and secure instead of
generating content. Finally, I just honestly was not happy with my domain name.

This changed in January of 2015 when two events happened. One, I started a new
job and saw a lot of fantastic websites and related web services from my new
co-workers. Two, I was able to register my new domain name **urda.cc** which was
an ideal domain name for myself. I started planning my migrations shortly after.

I had a few "must haves" on building my new website:

- No more databases
- No more self-hosted solutions
- Management needs to be kept simple
- Content is king, and should be easy to write
- Easy to deal with my old links on WordPress

I narrowed down my potential solutions to Squarespace and GitHub Pages. Both
allowed me to leave databases, provide the hosting for my website, and had great
author tools for generating content. Both of course had drawbacks though. GitHub
pages however did not provide analytics for my website. Squarespace did not have
a great solution to providing URL redirects for my new site and URL structure.
GitHub pages required some setup on a local machine, but Squarespace required
that I do all my content making on their platform.

After back and forth, and testing both Squarespace in a sandbox and setting up
a GitHub pages site, I settled with GitHub pages. I was really drawn by the fact
that I could just start making a post in familiar markdown and everything would
end up as static files to be served up on the internet. Using this I created a
new technology stack, and a migration plan.

- Domain: urda.cc (leaving peter-urda.com)
- Content Platform: [Jekyll](https://jekyllrb.com/)
- Analytics Engine: [Google Analytics](http://www.google.com/analytics/)
- Hosting Group: [GitHub Pages](https://pages.github.com/)
- Simple NGINX instance to raise `301 Moved Permanently` from peter-urda.com
  - While I have to manage the NGINX, it is only for a short period during
    the migration window

One of the major features of this stack was being able to redirect my old pages
to my new website. While yes I do have a NGINX instance handling the actual
peter-urda.com requests to urda.cc, I also wanted to use `/blog/` in front of
all my URLs for post. I was lucky to be able to use
[jekyll-redirect-from](https://github.com/jekyll/jekyll-redirect-from). This
allowed me to simply add a `redirect_from` in my posts to handle my old URLs.

```yaml
redirect_from: /YYYY/MM/post-title/ # Old WordPress URL to redirect from
```

Any sites that used an old peter-urda.com link will first hit my
NGINX instance, which will then send them to urda.cc, which will then send them
to the new URL. Eventually I will just have my old domain pointed to the new one
but this allows search engines to update their links first.

It's been a long road, but I am very happy that I can just open up a text
editor and start writing again. No complications, no noise, just content. Since
my Mercer days I have spent far more time using Python, Git, and OS X and I am
excited to start putting out posts regarding all the new technologies I have
started working with.
