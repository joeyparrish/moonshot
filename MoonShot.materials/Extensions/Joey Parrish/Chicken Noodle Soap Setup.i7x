Version 1 of Chicken Noodle Soap Setup by Joey Parrish begins here.

[Setup common to all Chicken Noodle Soap adventure games.]

Include Exit Lister by Gavin Lambert.
Include Vorple Screen Effects by Juhana Leinonen.
Include Vorple Hyperlinks by Juhana Leinonen.
Include Events by Joey Parrish.


[Always output HTML.]
Release along with the "Vorple" interpreter.


[Dialect preferences.]
Use American dialect.
Use serial comma.


[Room headings and exits.]
room-heading is a Vorple style.
room-name is a Vorple style.
direction-name is a Vorple style.
continue is a Vorple style.

This is the fancy room description heading rule:
	say "[room-heading style][bold type][Location][roman type][end style]".
The fancy room description heading rule substitutes for the room description heading rule.

Rule for printing the name of a room (called the place):
	say "[room-name style][printed name of place][end style]";

Rule for printing the name of a direction (called whither):
	say "[direction-name style][printed name of whither][end style]".

[By default, we don't seem to get a description of what rooms are adjacent to the current room, and in what direction.  This is something I'm used to seeing in IF, and I'd like to avoid writing it explicitly in every room.  Including the "Exit Lister" extension solves that.  But it needs a little configuration.  We want to always tell the user what the names of nearby rooms are, even if we have not yet been to them.  For this, we use:]
A room memory rule:
	rule succeeds.


[Customize how we print inventory, using nested unordered lists.]
Carry out taking inventory (this is the print inventory using HTML lists rule):
	if Vorple is supported:
		say "[We] [are] carrying:[line break]" (A);
		open HTML tag "ul" called "inventory";
		repeat with item running through things carried by the player:
			place "li" element reading "[item]";
			if the item contains something and the item is not opaque:
				open HTML tag "ul";
				repeat with content running through things contained by the item:
					place "li" element reading "[content]";
				close HTML tag;
		close HTML tag;
	otherwise:
		follow the print standard inventory rule.
The print inventory using HTML lists rule is listed instead of the print standard inventory rule in the carry out taking inventory rules.


[Fix titles with punctuation.  This is so that things like "examine Mr. Furtwangler" are understood.  Otherwise, the period ends the player's command command.  "Punctuation Removal" by Emily Short exists, but doesn't seem to function in Vorple.]
After reading a command:
	let T be "[the player's command]";
	replace the regular expression "(?i)mrs\." in T with "mrs";
	replace the regular expression "(?i)mr\." in T with "mr";
	replace the regular expression "(?i)ms\." in T with "ms";
	replace the regular expression "(?i)dr\." in T with "dr";
	change the text of the player's command to T.


[I don't like how Emily Short's "pause the game" rule clears the screen after continuing. Here's my own definition built on some of hers.]
To pause:
	if Vorple is supported:
		center "[continue style](click or tap to continue)[end style]";
		execute JavaScript code "pauseGame()";
		[unpauseGame() will send a keystroke here to allow us to continue sending outputs to Vorple.]
		wait for any key;
	otherwise:
		say "[paragraph break]Please press SPACE to continue[line break]";
		wait for the SPACE key;


[One play tester kept using "exa" instead of "x" or "examine" because that alias works in some common MUD games.  Support it here.]
Understand "exa [thing]" as examining.

[People also tried this during testing phases.]
Understand "examine room" as looking.

[Directional aliases that came up during testing.]
Understand "upstairs" and "up stairs" as up.
Understand "downstairs" and "down stairs" as down.


[Disable the initial banner.  We show our own splash screen and intro banners.]
The display banner rule is not listed in the startup rulebook.


[Start Vorple a little early.  This is important for our banner and other early setup to work correctly.]
The detect interpreter's Vorple support rule is listed before the start in the correct scenes rule in the startup rulebook.


[Disable clarification printouts.  For example, if the player says "ask secretary about director", we don't need to see "(the secretary about the director)".  This disables those messages.]
[ For the older inform releases we're still using, before the v10 open source version: ]
Include (-
Replace PrintInferredCommand;

[ PrintInferredCommand; ];
-) before "Parser.i6t".
[ v10 equivalent, if we ever update:
Include (-
[ PrintInferredCommand; ];
-) replacing "PrintInferredCommand".
]


[This is how the game ends; not with a bang, but a whimper.]
The print obituary headline rule is not listed in any rulebook.
To show ending (N - number) of (MAX - number) aka the (T - text) ending:
	if Vorple is supported:
		execute JavaScript code "logEvent('ending[N]')";
	say paragraph break;
	[NOTE: ending-card is centered in CSS.  See CSS for an explanation.]
	say ending-card style;
	say "You have discovered ending #[N] of [MAX] (the [T] ending) after [turn count] turns!";
	say end style;
	end the story.


[Sometimes, we have a piece of scenery that is technically portable, but that we don't want the player to take.  The default for taking scenery is "that's hardly portable", but sometimes, that isn't true.  So this type prints a different message.]
Portable-scenery is a kind of thing.
Portable-scenery is scenery.
Instead of taking portable-scenery:
	say "It's probably best if you leave that alone."


[Analytics hook.]
To log event (NAME - text):
	if Vorple is supported:
		execute JavaScript code "logEvent('[NAME]')";


[Page effects, defined in CSS.]
Remove-page-effect is an event.
To add page effect (X - text) for (N - a number) turns with message (Z - text):
	execute JavaScript code "document.body.dataset.effect = '[X]'";
	activate remove-page-effect in N turns with message Z.
Carry out triggering remove-page-effect:
	execute JavaScript code "document.body.dataset.effect = ''".


[Autocomplete hooks.]
To decide what list of things is the available objects:
	let L be a list of things;
	repeat with item running through things:
		if item is yourself:
			do nothing;
		otherwise if item is a visible physical concept:
			add item to L;
		otherwise if item is visible and item is not a concept:
			if the item is interesting or the description of item is not "":
				add item to L;
	decide on L.

Before reading a command:
	if Vorple is supported:
		execute JavaScript code "resetObjects()";
		repeat with item running through the available objects:
			execute JavaScript code "addObject('[item]')";
		execute JavaScript code "resetInventory()";
		repeat with item running through things carried by the player:
			execute JavaScript code "addInventory('[item]')";
		execute JavaScript code "resetPeople()";
		repeat with person running through people in the location:
			if person is not yourself:
				execute JavaScript code "addPerson('[person]')";


Chicken Noodle Soap Setup ends here.
