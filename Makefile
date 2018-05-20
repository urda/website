########################################################################################################################
# Main
########################################################################################################################


.PHONY: build
build: require-container
	bundle exec jekyll build


.PHONY: serve
serve: require-container build
	bundle exec jekyll serve --host 0.0.0.0 --port 4000 --drafts


#---------------------------------------------------------------------------------------------------
# Main Subcommands
#---------------------------------------------------------------------------------------------------


.PHONY: require-container
require-container:
ifeq ($(DOCKER_CONTAINER),true)
	$(info ---------- Detected docker container ----------)
else ifeq ($(TRAVIS),true)
	$(info ---------- Detected travis container ----------)
else
	$(error This command is ONLY ran inside docker or travis)
endif


########################################################################################################################
# Testing
########################################################################################################################


.PHONY: test
test:
	docker-compose run test


#---------------------------------------------------------------------------------------------------
# Test Subcommands
#---------------------------------------------------------------------------------------------------

# Travis entrypoint
.PHONY: travis
travis: build htmlproof

# HTML Proofer
.PHONY: htmlproof
htmlproof: require-container
	bundle exec htmlproofer ./_site --log-level debug --check-html --external_only --url-ignore http://linkedin.com/in/urdap
