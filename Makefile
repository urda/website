########################################################################################################################
# Variables
########################################################################################################################

CLEAN_TARGETS = ./_site ./.sass-cache
DOCKER_IMAGE = urda/website:latest
DOCKER_RUN_BASE_CMD = -it --mount type=bind,source=${MAKEFILE_PWD},target=/app/web
DOCKER_RUN_EXPOSE = -p 4000:4000/tcp
MAKEFILE_PWD = $(shell pwd)

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
build: docker-run-builder # [DOCKER] Build the entire website, and output to ./_site .


.PHONY: clean
clean: # Clean up build, test, and other project artifacts. Downs all docker containers.
	rm -rf $(CLEAN_TARGETS)


.PHONY: run-server
run-server: docker-run-server # [DOCKER] Run the Jekyll server.


.PHONY: test
test: docker-run-test # [DOCKER] Run automated testing against website project.


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
jekyll-serve: require-container
	bundle exec jekyll serve --host 0.0.0.0 --port 4000 --drafts --force_polling

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

.PHONY: docker-build
docker-build:
	docker build --rm -t ${DOCKER_IMAGE} .

.PHONY: docker-run-builder
docker-run-builder: docker-build
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_IMAGE} make jekyll-build

.PHONY: docker-run-server
docker-run-server: docker-build
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_RUN_EXPOSE} ${DOCKER_IMAGE} || :

.PHONY: docker-run-test
docker-run-test: docker-build
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_IMAGE} make travis-test

#---------------------------------------------------------------------------------------------------
# Travis Container Commands
#---------------------------------------------------------------------------------------------------

.PHONY: travis-test
travis-test: require-container jekyll-build jekyll-htmlproof

