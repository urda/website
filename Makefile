########################################################################################################################
# Variables
########################################################################################################################

CLEAN_TARGETS = ./_site ./.sass-cache

########################################################################################################################
# `make help` Needs to be first so it is ran when just `make` is called
########################################################################################################################


.PHONY: help
help: # Show this help screen
	@ack '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) |\
	sort -k1,1 |\
	awk 'BEGIN {FS = ":.*?# "}; {printf "\033[1m%-30s\033[0m %s\n", $$1, $$2}'


########################################################################################################################
# User-callable commands
########################################################################################################################


.PHONY: build
build: docker-builder-build # [DOCKER] Build the entire website, and output to ./_site .


.PHONY: clean
clean: docker-all-down # Clean up build, test, and other project artifacts. Downs all docker containers.
	rm -rf $(CLEAN_TARGETS)


.PHONY: run-server
run-server: docker-web-run # [DOCKER] Run the Jekyll server.


.PHONY: test
test: docker-test-run # [DOCKER] Run automated testing against website project.


########################################################################################################################
# Jekyll Commands
########################################################################################################################

.PHONY: jekyll-build
jekyll-build: require-container
	bundle exec jekyll build

.PHONY: jekyll-htmlproof
jekyll-htmlproof: require-container
	bundle exec htmlproofer ./_site --log-level debug --check-html --external_only --url-ignore http://linkedin.com/in/urdap

.PHONY: jekyll-serve
jekyll-serve: require-container jekyll-build
	bundle exec jekyll serve --host 0.0.0.0 --port 4000 --drafts

########################################################################################################################
# Docker Commands
########################################################################################################################

.PHONY: require-container
require-container:
ifeq ($(DOCKER_CONTAINER),true)
	$(info ---------- Detected docker container ----------)
else ifeq ($(TRAVIS),true)
	$(info ---------- Detected travis container ----------)
else
	$(error This command is ONLY ran inside docker or travis)
endif

.PHONY: docker-all-down
docker-all-down:
	docker-compose down

.PHONY: docker-builder-build
docker-builder-build:
	docker-compose build builder && docker-compose run builder

.PHONY: docker-test-run
docker-test-run:
	docker-compose build test && docker-compose run test

.PHONY: docker-web-run
docker-web-run:
	docker-compose build web && docker-compose run --service-ports web

#---------------------------------------------------------------------------------------------------
# Travis Container Commands
#---------------------------------------------------------------------------------------------------

.PHONY: travis-test
travis-test: require-container jekyll-build jekyll-htmlproof

