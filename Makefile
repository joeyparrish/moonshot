# This makefile uses Docker so that you don't have to install Inform.
# Specifically, we use this image: https://hub.docker.com/r/katre/docker-inform

# Default build rule, which builds a release version
all: release

SOURCE_DIR := $(abspath $(shell dirname "$(MAKEFILE_LIST)"))

# Wipe out the output.
clean:
	rm -f Release.zip
	rm -rf MoonShot.materials/Release/

# Create a release build.
release: clean
	docker run \
		--mount type=bind,source="$(SOURCE_DIR)",target=/home/informer \
		katre/docker-inform \
		/usr/lib/x86_64-linux-gnu/gnome-inform7/ni --release \
		--internal /usr/share/gnome-inform7 \
		--format=ulx \
		--project "MoonShot.inform"

# Create a debug build, which supports "test" commands.
debug: clean
	docker run \
		--mount type=bind,source="$(SOURCE_DIR)",target=/home/informer \
		katre/docker-inform \
		/usr/lib/x86_64-linux-gnu/gnome-inform7/ni \
		--internal /usr/share/gnome-inform7 \
		--format=ulx \
		--project "MoonShot.inform"

# Create the zip file needed by itch.io.
dist: clean release
	cd MoonShot.materials/Release/; zip -r9 ../../Release.zip *
