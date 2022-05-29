#!/usr/bin/env make -f

## ----------------------------------------------------------------------
## This Makefile is used to manage common tasks used to run several commands on this project.
## It's a useful way to encapsulate all needed commands as targets, and also to make those targets as a standard to run project commands regardless of used technology.
## ----------------------------------------------------------------------

.PHONY: deploy install-dependencies install-gems install-pods update-dependencies update-gems update-pods build clean deply deploy-% upload-to-testflight docs setup

include .env

# Targets

help: ## Display this help.
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'

print-environment: ## Print environment variables from .env file.
	@echo $(wildcard ./.env)
	@echo APP_IDENTIFIER = "${APP_IDENTIFIER}"
	@echo APP_NAME = "${APP_NAME}"
	@echo FL_APPLE_ID = "${FL_APPLE_ID}"
	@echo GIT_BRANCH = "${GIT_BRANCH}"
	@echo ITC_TEAM_ID = "${ITC_TEAM_ID}"
	@echo LANGUAGE = "${LANGUAGE}"
	@echo TEAM_ID = "${TEAM_ID}"
	@echo TEAM_NAME = "${TEAM_NAME}"
	@echo XCODE_PROJECT = "${XCODE_PROJECT}"
	@echo XCODE_SCHEME = "${XCODE_SCHEME}"
	@echo XCODE_TARGET = "${XCODE_TARGET}"
	@echo XCODE_UITESTS_SCHEME = "${XCODE_UITESTS_SCHEME}"
	@echo XCODE_WORKSPACE = "${XCODE_WORKSPACE}"

clean: command-exists-bundle ## Clean and remove old version of dependencies.
	# bundle clean
	bundle exec pod cache clean --all ${VERBOSE}
	bundle exec fastlane run clean_build_artifacts ${VERBOSE}
	bundle exec fastlane run clear_derived_data ${VERBOSE}

install-dependencies: install-gems install-pods
	@echo Finished installing dependencies ...

install-gems: command-exists-bundle ## Install Ruby Gems.
	@echo Updating bundler ...
	gem update bundler ${VERBOSE}
	@echo Installing gems ...
	# Set local gem installation to main gems only
ifdef CI # GitHub Actions uses this environment variable
	@echo Configure Bundler for CI ...
	bundle config unset --local clean
	bundle config set --local without development
	bundle config set --local deployment true
else
	@echo Configure Bundler for development ...
	# bundle config set --local clean true
	bundle config unset --local without
	bundle config unset --local deployment
endif
	# Install bundles with multiple jobs for performance
	bundle install --jobs 8 --retry 3 ${VERBOSE}

install-pods: command-exists-bundle ## Install CocoaPods Pods.
	@echo Installing pods ...
	bundle exec pod install --repo-update ${VERBOSE}

force-update-dependencies: force-update-gems force-update-pods ## Force update dependencies.
	@echo Force update dependencies ...

force-update-gems: remove-gemfile-lock update-gems ## Force update Ruby Gems.
	@echo Force update gems ...

remove-gemfile-lock: ## Remove Gemfile.lock
	@echo Remove Gemfile.lock
	rm -fv Gemfile.lock

force-update-pods: remove-podfile-lock update-pods ## Force update pods.
	@echo Force update pods ...

remove-podfile-lock: ## Remove Podfile.lock
	@echo Remove Podfile.lock
	rm -fv Podfile.lock

update-dependencies: update-gems update-pods ## Update dependencies.
	@echo Finished updating dependencies ...

update-gems: command-exists-bundle ## Update gems
	@echo Updating gems ...
	bundle update

update-pods: command-exists-bundle ## Update pods.
	@echo Updating pods ...
	bundle exec pod update ${VERBOSE}

build: build-beta ## Build app.
	@echo building app ...

build-%: command-exists-bundle ## Generate .ipa file.
	@echo building ".ipa" file for $(*) ...
	bundle exec fastlane generate_ipa_file --env $(*)

generate-app-file: command-exists-bundle ## Generate .app file (still broken).
	@echo building ".app" file ...
	bundle exec fastlane generate_app_file

deploy: deploy-beta deploy-app_store ## Deploy Beta version and Production version.

deploy-beta: deploy-build-beta ## Deploy-beta

deploy-next_generation: deploy-build-next_generation ## Deploy next_generation version (used only for builds that diverge from Beta and App Store builds).

deploy-app_store: deploy-build-app_store ## Deploy App Store version.

deploy-build-%: pull install-gems ## Deploy by incrementing build for selected environment.
	@echo deploying app \(incrementing build for $(*)\) ...
	bundle exec fastlane $(*) build_type:build --env $(*) ${VERBOSE}

deploy-patch-%: pull install-gems ## Deploy by incrementing patch for selected environment.
	@echo deploying app \(incrementing patch\) ...
	bundle exec fastlane $(*) build_type:patch --env $(*) ${VERBOSE}

deploy-minor-%: pull install-gems ## Deploy by incrementing minor for selected environment.
	@echo deploying app \(incrementing minor\) ...
	bundle exec fastlane $(*) build_type:minor --env $(*) ${VERBOSE}

deploy-major-%: pull install-gems ## Deploy by incrementing major for selected environment.
	@echo deploying app \(incrementing major\) ...
	bundle exec fastlane $(*) build_type:major --env $(*) ${VERBOSE}

increment_build_number: ## Increment build number, and push to remote. Useful when Fastlane failes on `post_release` lane for some reason.
	@echo Incrementing build number app ...
	bundle exec fastlane increment_version_with build_type:build commit_version_bump:true

upload-to-testflight: ## Upload to TestFlight.
	@echo Uploading build to TestFlight ...
	bundle exec fastlane deploy_to_testflight ${VERBOSE}

swiftgen: ## Run SwiftGen.
	Pods/SwiftGen/bin/swiftgen

lint: ## Lint current Xcode project files.
	Pods/SwiftLint/swiftlint

lint-fix: ## Lint and auto-fix fixable warnings of current Xcode project files.
	Pods/SwiftLint/swiftlint --fix --format

pull: ## Git pull to update current branch if not in CI
ifndef CI # If not in CI environment
	@echo Pull latest changes from Git repository for \"$$(git branch --show-current)\" branch ...
	git pull && git fetch --tags
endif

renew-push-certificate: renew-push-certificate-app_store ## Renew APNs certificate depending for App Store (Production) environment.

renew-push-certificate-%: ## Renew APNs certificate depending on specified environment.
	bundle exec fastlane renew_push_certificate --env $(*)

docs: ## Generate documentation.
	@echo Generating documentation ...
	bundle exec fastlane generate_docs

setup: ## Setup development environment.
	./setup.sh

# Convenience targets ############################################

command-exists-%: ## Check if a command exists. This target is currently used as internal function only.
	@hash $(*) > /dev/null 2>&1 || \
		(echo "ERROR: '$(*)' must be installed before running this target.\nPlease run 'make setup' and try again."; exit 1)
