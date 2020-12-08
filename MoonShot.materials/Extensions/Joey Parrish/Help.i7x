Version 1 of Help by Joey Parrish begins here.

Include Vorple Screen Effects by Juhana Leinonen.
Include Vorple Hyperlinks by Juhana Leinonen.

help-card is a Vorple style.

Helping is an action out of world applying to nothing.  Understand "help" as helping.

Carry out helping:
	say help-card style;
	say "Welcome to interactive fiction!  In this story, [bold type]you[roman type] are the main character.  You interact with the story by typing what you want to do.  For example, you can 'look' if you forget what is in the room, you can 'examine' a thing to look more closely at it (such as 'examine clock'), you can 'take' an object, and you can move 'east', 'west', etc. to move from room to room.";
	say line break;
	say "Here are some common verbs/commands/patterns you will want to try out.  Some commands have single-letter aliases you can use (shown here in parentheses):";
	say "[line break][italic type]";
	say "  look (l)[line break]";
	say "  look at thing/person[line break]";
	say "  examine (x) thing/person[line break]";
	say "  take thing / take all[line break]";
	say "  inventory (i)[line break]";
	say "  talk to so-and-so[line break]";
	say "  talk[line break]";
	say "  ask so-and-so about thing[line break]";
	say "  ask about thing[line break]";
	say "  east (e)[line break]";
	say "  west (w)[line break]";
	say "  north (n)[line break]";
	say "  south (s)[line break]";
	say "  down (d)[line break]";
	say "  up (u)[line break]";
	say "  map[line break]";
	say "  wait (z)[line break]";
	say "  save[line break]";
	say "  restore[line break]";
	say "  options[line break]";
	say "  quit (q)[line break]";
	say "[roman type][line break]";
	say "There are many other things you can do, so just try things out and see.  You can also visit ";
	place a link to web site "http://www.microheaven.com/ifguide/step3.html";
	say " for general information on playing interactive fiction.";
	say line break;
	say "Finally, we provide a quick reference for verbs.  Just type 'verbs' to see it.";
	say line break;
	say "Enjoy!";
	say end style.

Showing verb reference is an action out of world applying to nothing.  Understand "verb" and "verbs" as showing verb reference.

Carry out showing verb reference:
	say help-card style;
	say "Here is a short, alphabetical list of useful verbs in this game.  Others may also work, so feel free to try things out.  But you can use this list if you get stuck.";
	say line break;
	say "[italic type]     apologize, ask about... / ask so-and-so about..., drink, drop, eat, enter, examine (x), give, inventory (i), look (l) / look at..., open, take / take all, talk / talk to..., wait (z), wake so-and-so[roman type][line break]";
	say line break;
	say "You can also use the following 'out-of-world' commands to manipulate the game outside of controlling your character.";
	say line break;
	say "[italic type]     brief, easy mode, hard mode, help, map, medium mode, options, restore, save, verbose, verbs[roman type][line break]";
	say end style.

Showing map is an action out of world applying to nothing.  Understand "map" as showing map.
Carry out showing map:
	if Vorple is supported:
		place a link to web site "Map.svg" reading "Click here to read the map.";
		say line break;
	otherwise:
		say "Check out 'Map.svg' in the release."

Help ends here.

---- Documentation ----

Some people won't know how to play an interactive fiction game.  Really, if you never touched a computer in the 1980s, the original era of IF may have passed you by.  This adds a "help" command that people can type to get some direction.  Make sure you mention this in your game's startup.
