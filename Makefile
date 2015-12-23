.PHONY: serve-drafts
serve-drafts:
	bundle exec jekyll serve --drafts

.PHONY: build
build:
	bundle exec jekyll build

.PHONY: htmlproof
htmlproof:
	bundle exec htmlproof ./_site --url-ignore http://linkedin.com/in/urdap

.PHONY: live-push
live-push:
	git push production live-gh-pages:gh-pages

.PHONY: serve
serve:
	bundle exec jekyll serve

.PHONY: travis
travis: build htmlproof
