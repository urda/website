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
build: docker-run-jekyll-builder # [DOCKER CONTAINER] Build the entire website, and output to ./_site .


.PHONY: clean
clean: # Clean the project directory.
	rm -rf $(CLEAN_TARGETS)


.PHONY: run-server
run-server: docker-run-server # [DOCKER CONTAINER] Run the Jekyll server.


.PHONY: test
test: docker-run-test # [DOCKER CONTAINER] Run automated testing against website project.


.PHONY: update
update: docker-run-updater # [DOCKER CONTAINER] Update Jekyll

########################################################################################################################
# Docker Commands
########################################################################################################################

.PHONY: docker-build
docker-build:
	docker build --rm -t ${DOCKER_IMAGE} .

.PHONY: docker-run-jekyll-builder
docker-run-jekyll-builder: docker-build
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_IMAGE} make jekyll-build

.PHONY: docker-run-server
docker-run-server: docker-build
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_RUN_EXPOSE} ${DOCKER_IMAGE} || :

.PHONY: docker-run-test
docker-run-test: docker-build
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_IMAGE} make jekyll-test

.PHONY: docker-run-updater
docker-run-updater: docker-build
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_IMAGE} make jekyll-update

########################################################################################################################
# Jekyll Commands
########################################################################################################################

.PHONY: require-container
require-container:
ifeq ($(DOCKER_CONTAINER),true)
	$(info ---------- Detected docker container ----------)
else ifeq ($(GITHUB_ACTIONS),true)
	$(info ---------- Detected GitHub Actions ----------)
else
	$(error This command is ONLY ran inside containers)
endif

.PHONY: jekyll-build
jekyll-build: require-container
	bundle exec jekyll build

.PHONY: jekyll-htmlproof
jekyll-htmlproof: require-container
	bundle exec htmlproofer ./_site --log-level debug --ignore_urls https://linkedin.com/in/urda

.PHONY: jekyll-serve
jekyll-serve: require-container
	bundle exec jekyll serve --drafts --future --force_polling --host 0.0.0.0 --port 4000

.PHONY: jekyll-test
jekyll-test: require-container jekyll-build jekyll-htmlproof

.PHONY: jekyll-update
jekyll-update: require-container
	bundle update --all
