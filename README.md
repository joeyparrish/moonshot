[![MoonShot cover art: an image of a camera reflected in an astronaut's helmet](MoonShot.materials/Cover.jpg)](https://joeyparrish.github.io/moonshot/)

# MoonShot

A work of interactive fiction created by Joey & Charity Parrish for the [GitHub
Game Off 2020](https://itch.io/jam/game-off-2020).

Created with [Inform 7](http://inform7.com/).


## Synopsis

You play as a NASA intern in the 1960s, working on the Apollo 11 project.

Everything goes very well, and you have no difficulties at all.  :grin:


## Playing in a browser

To play the latest official release version, visit
https://joeyparrish.github.io/moonshot/


## Compilation

You can either load the folder MoonShot.inform into the Inform IDE, or you can
build on the command-line.  You can install Inform from
http://inform7.com/downloads/ if you don't already have it.

For command-line builds on Linux using Docker (no Inform installation
required), just type `make`.  (For this, you must have Docker, of course.)

The HTML output goes to `MoonShot.materials/Release/`.


## Source

The project structure is more or less dictated by Inform 7, so if you are
unfamiliar with Inform, you may find it hard to locate the relevant source
files.

The main story source is in `MoonShot.inform/Source/story.ni`.  It relies on
several extensions, some of which are standard, some of which were installed
into the sources, and some of which were written expressly for this project.
Extensions are like source modules or libraries in Inform, and can be found in
`MoonShot.materials/Extensions/`.  The extensions written explicitly for this
project are all in `MoonShot.materials/Extensions/Joey Parrish/`, and were
mainly used to organize the source code and keep the non-story elements out of
the main source file.

Other assets, including CSS, cover art, and other associated, non-story
content, can all be found in the `MoonShot.materials/` folder.  A general HTML
wrapper for browser-based interactive fiction games by Chicken Noodle Soap can
be found in the `cns/` folder.

The final HTML output goes to `MoonShot.materials/Release/`.


## License

Full details can be found under [LICENSE.md](LICENSE.md).


## Cover Art

The cover art is based on the following images:
 - Astronaut helmet photo
   - [original link](https://pxhere.com/en/photo/116453)
   - "No Rights Reserved; Free for personal and commercial use"
   - [Creative Commons CC0 license](https://creativecommons.org/share-your-work/public-domain/cc0/)
 - Glass sphere photo
   - [original link](https://www.pickpik.com/photographer-hobby-profession-glass-ball-leisure-leisure-activity-142240)
   - "The images provided by PickPik are free to use for personal and
     commercial projects"
   - [PickPik Terms of Service](https://www.pickpik.com/terms-of-service)
