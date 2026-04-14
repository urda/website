---
title: "A Fresh Coat of Paint"
layout: post
date:   2026-04-14T09:30:00+0000

excerpt: |
    After over a decade on Jekyll and GitHub Pages, urda.com gets a long-overdue
    refresh: a new dark theme, modern CI pipelines, and a whole lot of
    cleanup under the hood.
---

It has been over ten years since I
[moved this site to Jekyll and GitHub Pages](/blog/2015/10/18/writings-reborn).
Back then the big win was escaping WordPress, PHP, MySQL, and the constant
maintenance treadmill that came with them. Jekyll let me open a text editor,
write some markdown, and publish. That simplicity has held up remarkably well
for a long time.

But "a long time" eventually catches up with you.

## How urda.com Finally Became Mine

In early 2018, the site found its permanent address. When I wrote that 2015
post, the domain was `urda.cc`. It worked, but `urda.com` was always the one I
really wanted. The `.com` had been registered by someone else
for as long as I could remember. It sat behind a parked page, held by someone
who had no real use for it but listed it through a domain reseller. Starting
around 2010, I emailed the sales rep at least once a year to ask about the price.

For a long time, the asking price was absurd. But I kept emailing, and over the
years the price kept dropping. After nearly a decade of persistence, the number
finally landed somewhere I could live with. Eight years of "not yet" turned into
"yes."

Once I had it, the migration was straightforward. GitHub Pages made the domain
swap painless, and `jekyll-redirect-from` handled the URL redirects just like it
did during the original move from `peter-urda.com`. Three domains later, I was
finally home.

## What Got Stale

The site still *worked*, but the tooling around it had not kept pace:

- **Deployment** was tied to the old GitHub Pages gem-based build. GitHub had
  long since shipped Actions-based deployments, but I was still on the legacy
  path.
- **Sass** was locked to an older version bundled with the GitHub Pages gem,
  missing out on the modern `@use` module system and other improvements in
  Dart Sass.
- **CI checks** were minimal. The site would build, but nothing was validating
  the HTML output or checking for dead links.
- **The theme itself** was showing its age. Light background, default fonts, and
  not much personality.

None of these were breaking anything, but all of them contributed to what felt
like an aged project asking for some TLC. So, I carved out some time and started
chipping away.

## The Refresh

### The New Stack

Not much has changed at the foundation level, and that is the point. Jekyll and
GitHub Pages are still doing exactly what they did in 2015: letting me write
markdown and publish static files. The difference is everything around them is
now modernized.

- **Content Platform**: [Jekyll](https://jekyllrb.com/)
- **Hosting**: [GitHub Pages](https://pages.github.com/) via Actions deployment, [Git LFS](https://git-lfs.com/) for image assets
- **CI/CD**: GitHub Actions (`build, test, lint, deploy`)
- **Validation & Linting**: W3C HTML (`vnu-jar`), HTML Proofer, Stylelint
- **Sass**: Modern Dart Sass with the `@use` module system
- **Analytics**: [Cloudflare Web Analytics](https://www.cloudflare.com/web-analytics/), replacing Google Analytics
- **Theme**: Custom dark theme with CSS custom properties and SCSS modules

### A Dark Theme with Some Glow

The most visible change is the new look. The whole site draws from the same
ENCOM color palette I use in my terminal. The goal was a TRON-like feel: electric
blue glows, cyan accents, and deep black surfaces. Glass-panel cards and deep
box shadows give the masthead and posts some depth, while glow effects on
headings and links round out the neon aesthetic. A deep navy background ties it
all together. Easy on the eyes during late-night reading sessions.

Under the hood, a dedicated SCSS color palette feeds into CSS custom properties,
making the whole theme easy to adjust down the road. Accessibility was not an
afterthought either: the theme respects `prefers-contrast: more` and
`prefers-reduced-motion: reduce` out of the box.

#### Code Blocks That Feel Like a Terminal

This is a blog that started with code posts, so the code blocks deserved
attention too. The same palette carries through here with full syntax
highlighting: color-coded keywords, strings, literals, and identifiers that are
easy to scan at a glance. Line numbers sit in a gutter along the left edge. The
blocks scroll horizontally instead of wrapping or clipping, and a copy button in
the top-right corner lets you grab the code with one click.

For example:

```python
from dataclasses import dataclass


@dataclass
class SiteRefresh:
    name: str
    year: int
    theme: str = "ENCOM"

    def summary(self) -> str:
        return f"{self.name} refreshed in {self.year} with {self.theme} theme"


refresh = SiteRefresh(name="urda.com", year=2026)
print(refresh.summary())
```

### A Modern CI/CD Pipeline

The build and deploy pipeline got a complete overhaul:

- **GitHub Actions** now handles the full build-test-deploy cycle through
  reusable workflows (`deploy.yaml`, `testing.yaml`, `linting.yaml`, `pr.yaml`)
- **W3C HTML validation** runs on every build via
  [vnu-jar](https://validator.github.io/validator/), catching spec violations
  before they hit production
- **HTML Proofer** checks for dead links, missing alt text, and other HTML
  quality issues
- **Stylelint** is wired up for SCSS linting with
  `stylelint-config-standard-scss`

The site is validated against real specs on every push. Passing builds ship
directly to the production website.

### Local Development in a Box

The local development environment runs entirely inside a Docker container.
Ruby, Node, Python, Java for the W3C validator, all of it lives in an Alpine
image and never touches the host machine. The `Makefile` wraps everything so the
workflow stays simple: `make run-server` to preview the site, `make test` to
run the full validation suite, `make build` to generate the output. Same
environment locally as in CI, no "works on my machine" surprises.

## What Is Next

Honestly, the same thing I said in 2015: just writing. The whole point of this
refresh was to clear out the cobwebs so I can focus on content. The
pipeline catches mistakes, the theme is far more pleasant, and the
tooling is current enough that I will not need to think about it for a while.

Nothing beats a fresh coat of paint.
