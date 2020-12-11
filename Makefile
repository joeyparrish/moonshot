# This makefile uses Docker so that you don't have to install Inform.
# Specifically, we use this image: https://hub.docker.com/r/jkmatila/inform7-docker

# Default build rule, which builds a release version
all: release

SOURCE_DIR := $(abspath $(shell dirname "$(MAKEFILE_LIST)"))
TAG := sha256:30ca124ab768d12edc90c8d6f0267607e95cf1b8e7b56eecf491125110d21eb9
UID := $(shell id -u $$USER)

# This Docker image leaves files owned by root, as well as some garbage.
CLEANUP_AFTER_DOCKER := chown -R $(UID) /tmp/MoonShot.materials/Release; rm -f Inftemp*.tmp

# Wipe out the output.
clean:
	rm -f Release.zip
	rm -rf MoonShot.materials/Release/

# Create a release build.
release: clean
	docker run \
		--mount type=bind,source="$(SOURCE_DIR)",target=/tmp \
		jkmatila/inform7-docker@$(TAG) \
		/bin/sh -c 'i7 -r /tmp/MoonShot.inform; $(CLEANUP_AFTER_DOCKER)'

# Create a debug build, which supports "test" commands.
debug: clean
	docker run \
		--mount type=bind,source="$(SOURCE_DIR)",target=/tmp \
		jkmatila/inform7-docker@$(TAG) \
		/bin/sh -c 'i7 -c /tmp/MoonShot.inform; $(CLEANUP_AFTER_DOCKER)'

# Create the zip file needed by itch.io for the contest.
dist: clean release
	cd MoonShot.materials/Release/; zip -r9 ../../Release.zip *
