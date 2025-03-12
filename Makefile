# This makefile uses Docker so that you don't have to install Inform.
# Specifically, we use this image: https://hub.docker.com/r/jkmatila/inform7-docker

# Default build rule, which builds a release version
all: release

SOURCE_DIR := $(abspath $(shell dirname "$(MAKEFILE_LIST)"))
TAG := sha256:30ca124ab768d12edc90c8d6f0267607e95cf1b8e7b56eecf491125110d21eb9
UID := $(shell id -u $$USER)

# This Docker image leaves files owned by root, as well as some garbage.
CLEANUP_AFTER_DOCKER := rm -f Inftemp*.tmp; chown -R $(UID) \
    /tmp/MoonShot.materials/Release \
    /tmp/MoonShot.inform/Build \
    /tmp/MoonShot.inform/Index \
    /tmp/MoonShot.inform/Metadata.iFiction \
    /tmp/MoonShot.inform/Release.blurb \
    /tmp/MoonShot.inform/manifest.plist \
    /tmp/MoonShot.inform/gameinfo.dbg

# Wipe out the output.
clean:
	rm -f Release.zip
	rm -rf MoonShot.materials/Release/*

# Create a release build.
release: clean
	docker run --rm \
		--mount type=bind,source="$(SOURCE_DIR)",target=/tmp \
		jkmatila/inform7-docker@$(TAG) \
		/bin/sh -c 'i7 -r /tmp/MoonShot.inform; $(CLEANUP_AFTER_DOCKER)'
	cp -a web-interface/* MoonShot.materials/Release/
	rm -f MoonShot.materials/Release/interpreter/vorple.min.js.map
	cat MoonShot.materials/Release/index.html.template | sed \
		-e 's/\[TITLE\]/MoonShot/g' \
		-e 's/\[AUTHOR\]/Joey \&amp; Charity Parrish/g' \
		-e 's/\[RELEASE\]/9/g' \
		-e 's/\[GA_KEY\]/G-K4EXJ8VT8V/g' \
		-e 's/\[GA_APP\]/MoonShot/g' \
		-e 's/\[COPYRIGHT\]/\&copy; 2020-2025 Joey \&amp; Charity Parrish/g' \
		> MoonShot.materials/Release/index.html
	rm MoonShot.materials/Release/index.html.template

# Create a debug build, which supports "test" commands.
debug: clean
	docker run \
		--mount type=bind,source="$(SOURCE_DIR)",target=/tmp \
		jkmatila/inform7-docker@$(TAG) \
		/bin/sh -c 'i7 -c /tmp/MoonShot.inform; $(CLEANUP_AFTER_DOCKER)'
	cp -a web-interface/* MoonShot.materials/Release/
	mv MoonShot.materials/Release/index.html{.template,}
