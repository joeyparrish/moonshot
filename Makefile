# This makefile uses Docker so that you don't have to install Inform.
# Specifically, we use this image: https://hub.docker.com/r/jkmatila/inform7-docker

# Default build rule, which builds a release version
all: release

.PHONY: all clean i7-release i7-debug cns-html cns-library release debug serve

SOURCE_DIR := $(abspath $(shell dirname "$(MAKEFILE_LIST)"))
TAG := sha256:30ca124ab768d12edc90c8d6f0267607e95cf1b8e7b56eecf491125110d21eb9
UID := $(shell id -u $$USER)

INTERMEDIATE_FILES := \
	MoonShot.inform/Build \
	MoonShot.inform/Index \
	MoonShot.inform/Metadata.iFiction \
	MoonShot.inform/Release.blurb \
	MoonShot.inform/manifest.plist \
	MoonShot.inform/gameinfo.dbg

# This Docker image leaves files owned by root, as well as some garbage.
CLEANUP_AFTER_DOCKER := rm -f Inftemp*.tmp && chown -R $(UID) MoonShot.materials/Release $(INTERMEDIATE_FILES) 2>/dev/null

# Wipe out the output.
clean:
	rm -rf MoonShot.materials/Release/* $(INTERMEDIATE_FILES)

# Create a release build.
i7-release:
	docker run --rm \
		--mount type=bind,source="$(SOURCE_DIR)",target=/tmp \
		jkmatila/inform7-docker@$(TAG) \
		/bin/sh -c 'i7 -r /tmp/MoonShot.inform; rv=$$?; $(CLEANUP_AFTER_DOCKER); exit "$$rv"'

# Create a debug build, which supports "test" commands.
i7-debug:
	docker run --rm \
		--mount type=bind,source="$(SOURCE_DIR)",target=/tmp \
		jkmatila/inform7-docker@$(TAG) \
		/bin/sh -c 'i7 -c /tmp/MoonShot.inform; rv=$$?; $(CLEANUP_AFTER_DOCKER); exit "$$rv"'

cns-html:
	cp -a cns/html/* MoonShot.materials/Release/
	cp MoonShot.materials/*.* MoonShot.materials/Release/
	cp -a MoonShot.materials/astronauts MoonShot.materials/Release/
	cp -a MoonShot.materials/achievements MoonShot.materials/Release/
	rm MoonShot.materials/Release/achievements/*.xcf
	cat MoonShot.materials/Release/index.html.template | sed \
		-e 's/\[TITLE\]/MoonShot/g' \
		-e 's/\[TITLE_FILENAME\]/MoonShot/g' \
		-e 's/\[AUTHOR\]/Joey \&amp; Charity Parrish/g' \
		-e 's/\[DEDICATION\]/Dedicated to everyone who ever looked up at the moon and thought,<br>\&ldquo;no damn way.\&rdquo;/g' \
		-e 's/\[RELEASE\]/9.3.0/g' \
		-e 's/\[COPYRIGHT\]/\&copy; 2020-2025\nJoey \&amp; Charity Parrish/g' \
		-e 's/\[STEAM_APP_ID\]/3622090/g' \
		> MoonShot.materials/Release/index.html
	rm MoonShot.materials/Release/index.html.template

cns-library:
	cd cns/library/ && npm ci
	cd cns/library/ && npm run build
	cp cns/library/dist/bundle.js MoonShot.materials/Release/cns.js

release: clean i7-release cns-html cns-library
	sed -e 's/\[GA_KEY\]/G-K4EXJ8VT8V/g' -i MoonShot.materials/Release/index.html
	rm -f MoonShot.materials/Release/interpreter/vorple.min.js.map

debug: clean i7-debug cns-html cns-library
	sed -e 's/\[GA_KEY\]//g' -i MoonShot.materials/Release/index.html
	cp cns/library/dist/bundle.js.map MoonShot.materials/Release/

serve:
	docker run --rm -p 8000:80 -v $$(pwd)/MoonShot.materials/Release:/public joseluisq/static-web-server
