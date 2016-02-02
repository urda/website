.PHONY: serve-drafts
serve-drafts:
	bundle exec jekyll serve --drafts

.PHONY: build
build:
	bundle exec jekyll build

.PHONY: htmlproof
htmlproof:
	bundle exec htmlproof ./_site --verbose --check-html --external_only --url-ignore http://linkedin.com/in/urdap

.PHONY: install
install:
	bundle install

.PHONY: serve
serve:
	bundle exec jekyll serve

.PHONY: travis
travis: build htmlproof
