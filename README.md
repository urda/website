## Git Repo Setup

```bash
# Clone the staging repo, store as 'website'
$ git clone git@github.com:urda/website-staging.git website
$ cd website/

# Add the "production" remote
$ git remote add production git@github.com:urda/website.git
$ git fetch production

# Checkout production's `gh-pages`. NOTE: DETACHED HEAD STATE
$ git checkout production/gh-pages

# Create a local branch for "live" on the `production/gh-pages` reference
$ git checkout -b live-gh-pages

# Add an alias to "push to live" from your local live branch
$ git config alias.live-push "push production live-gh-pages:gh-pages"
```

## Sublime Project Settings

### OS X

```json
{
	"folders":
	[
		{
			"path": "/path/to/github/website",
            "default_line_ending": "unix",
            "file_exclude_patterns":
            [
                "Gemfile",
                "Gemfile.lock",
                "android-chrome*.png",
                "apple-touch-icon*.png",
                "browserconfig.xml",
                "favicon*.ico",
                "favicon*.png",
                "manifest.json",
                "mstile*.png"
            ],
            "folder_exclude_patterns":
            [
                ".sass-cache",
                "_site"
            ]
		}
	]
}
```
