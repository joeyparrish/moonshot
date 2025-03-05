Version 1 of Help by Joey Parrish begins here.

Include Vorple Screen Effects by Juhana Leinonen.
Include Vorple Hyperlinks by Juhana Leinonen.

help-card is a Vorple style.

Helping is an action out of world applying to nothing.  Understand "help" as helping.

Carry out helping:
	if Vorple is supported:
		execute JavaScript code "showHelp()";
	otherwise:
		say "Sorry, in-game help requires the web interpreter.".

Showing verb reference is an action out of world applying to nothing.  Understand "verb" and "verbs" as showing verb reference.

Carry out showing verb reference:
	try helping.

Showing map is an action out of world applying to nothing.  Understand "map" as showing map.
Carry out showing map:
	if Vorple is supported:
		execute JavaScript code "showMap()";
	otherwise:
		say "Sorry, in-game maps require the web interpreter.".

Help ends here.

---- Documentation ----

Some people won't know how to play an interactive fiction game.  Really, if you never touched a computer in the 1980s, the original era of IF may have passed you by.  This adds a "help" command that people can type to get some direction.  Make sure you mention this in your game's startup, and/or add a button to the web page.
