.PHONY: serve-drafts
serve-drafts:
	bundle exec jekyll serve --host=0.0.0.0 --drafts

.PHONY: build
build:
	bundle exec jekyll build

.PHONY: htmlproof
htmlproof:
	bundle exec htmlproofer ./_site --log-level debug --check-html --external_only --url-ignore http://linkedin.com/in/urdap

.PHONY: install
install:
	bundle install

.PHONY: serve
serve:
	bundle exec jekyll serve --host=0.0.0.0

.PHONY: travis
travis: build htmlproof
