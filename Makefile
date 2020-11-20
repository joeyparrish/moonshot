# i7 is the Inform compiler.
# http://inform7.com/downloads/

# Default build rule, which builds a release version
all: release

# Wipe out the output.
clean:
	rm -f Release.zip
	rm -rf MoonShot.materials/Release/

# Create a release build.
release: clean
	i7 -r MoonShot.inform

# Create a debug build.
debug: clean
	i7 -c MoonShot.inform

# Create the zip file needed by itch.io.
dist: clean release
	cd MoonShot.materials/Release/; zip -r9 ../../Release.zip *
