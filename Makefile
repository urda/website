########################################################################################################################
# Variables
########################################################################################################################

CLEAN_TARGETS = ./_site ./.sass-cache ./.jekyll-cache
DOCKER_IMAGE = urda/website:latest
DOCKER_TTY_FLAG = $(shell [ -t 0 ] && echo "-t")
DOCKER_RUN_BASE_CMD = -i ${DOCKER_TTY_FLAG} --mount type=bind,source=${MAKEFILE_PWD},target=/app/web
DOCKER_RUN_EXPOSE = -p 4000:4000/tcp
HTMLPROOF_IGNORES = "/static.cloudflareinsights.com/,/www.fiddler2.com/,/www.linkedin.com/"
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

.PHONY: lint
lint: docker-run-lint # [DOCKER CONTAINER] Run automated linting against website project.

.PHONY: run-server
run-server: docker-run-server # [DOCKER CONTAINER] Run the Jekyll server.

.PHONY: test
test: lint docker-run-test # [DOCKER CONTAINER] Run automated testing against website project.

.PHONY: update
update: docker-run-updater # [DOCKER CONTAINER] Update Jekyll

.PHONY: update-bundler
update-bundler: docker-run-updater-bundler # [DOCKER CONTAINER] Update Jekyll's Bundler

########################################################################################################################
# Docker Entry Points Commands
########################################################################################################################

.PHONY: docker-build
docker-build:
	docker build --rm -t ${DOCKER_IMAGE} .

.PHONY: docker-run-jekyll-builder
docker-run-jekyll-builder: docker-build
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_IMAGE} make jekyll-build

.PHONY: docker-run-lint
docker-run-lint: docker-build
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_IMAGE} make jekyll-lint

.PHONY: docker-run-server
docker-run-server: docker-build
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_RUN_EXPOSE} ${DOCKER_IMAGE} || :

.PHONY: docker-run-test
docker-run-test: docker-build
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_IMAGE} make jekyll-test

.PHONY: docker-run-updater
docker-run-updater: docker-build
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_IMAGE} make jekyll-update

.PHONY: docker-run-updater-bundler
docker-run-updater-bundler: docker-build
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_IMAGE} make jekyll-update-bundler

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
	bundle exec htmlproofer ./_site --log-level debug --ignore-urls ${HTMLPROOF_IGNORES}

.PHONY: jekyll-lint
jekyll-lint: require-container
	pnpm exec stylelint "**/*.{css,scss}" --ignore-path .stylelintignore

.PHONY: jekyll-serve
jekyll-serve: require-container
	bundle exec jekyll serve --drafts --future --force_polling --host 0.0.0.0 --port 4000

.PHONY: jekyll-test
jekyll-test: require-container jekyll-build jekyll-htmlproof jekyll-w3c-check

.PHONY: jekyll-update
jekyll-update: require-container
	bundle update --all

.PHONY: jekyll-update-bundler
jekyll-update-bundler: require-container
	bundle update --bundler

.PHONY: jekyll-version-check
jekyll-version-check: require-container
	./scripts/version_manager.py check

.PHONY: jekyll-w3c-check
jekyll-w3c-check: require-container
	java -jar $$(pnpm exec node -e "process.stdout.write(require('vnu-jar').toString())") --errors-only --skip-non-html ./_site

########################################################################################################################
# Version Checker
########################################################################################################################

.PHONY: version-check
version-check: docker-build # [DOCKER CONTAINER] Verify the project version string is correct across the project
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_IMAGE} make jekyll-version-check

.PHONY: version-only
version-only: docker-build # [DOCKER CONTAINER] Get the version string for the project
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_IMAGE} ./scripts/version_manager.py get-version-only

.PHONY: version-update
version-update: docker-build # [DOCKER CONTAINER] Update the project version string is correct across the project
	docker run ${DOCKER_RUN_BASE_CMD} ${DOCKER_IMAGE} ./scripts/version_manager.py update
