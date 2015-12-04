.PHONY: live-push serve serve-drafts

live-push:
	git push production live-gh-pages:gh-pages

serve:
	bundle exec jekyll serve

serve-drafts:
	bundle exec jekyll serve --drafts
