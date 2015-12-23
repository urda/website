.PHONY: serve-drafts
serve-drafts:
	bundle exec jekyll serve --drafts


.PHONY: live-push
live-push:
	git push production live-gh-pages:gh-pages

.PHONY: serve
serve:
	bundle exec jekyll serve
