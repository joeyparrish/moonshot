Version 1 of Chicken Noodle Soap Setup by Joey Parrish begins here.

[Setup common to all Chicken Noodle Soap adventure games.]

Include Exit Lister by Gavin Lambert.
Include Vorple Screen Effects by Juhana Leinonen.
Include Vorple Hyperlinks by Juhana Leinonen.
Include Concepts by Joey Parrish.
Include Drinks by Joey Parrish.
Include Events by Joey Parrish.
Include Strangers by Joey Parrish.


[Always output HTML.]
Release along with the "Vorple" interpreter.


[Dialect preferences.]
Use American dialect.
Use serial comma.


[Disable built-in transcripts from the interpreter.  Vorple only wants to save them into an obnoxious virtual filesystem that is a pain to access.  We have our own way to handle transcripts.]
Check switching the story transcript on:
	say "Traditional transcripts are not supported.  Use the 'save transcript' button.";
	stop the action;
Check switching the story transcript off:
	say "Traditional transcripts are not supported.  Use the 'save transcript' button.";
	stop the action;


[Room headings and exits.]
room-heading is a Vorple style.
room-name is a Vorple style.
direction-name is a Vorple style.
continue is a Vorple style.
ending-card is a Vorple style.

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
	say "[We] [are] carrying:[line break]" (A);
	open HTML tag "ul" called "inventory";
	repeat with item running through things carried by the player:
		place "li" element reading "[item]";
		if the item contains something and the item is not opaque:
			open HTML tag "ul";
			repeat with content running through things contained by the item:
				place "li" element reading "[content]";
			close HTML tag;
	close HTML tag.
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
	center "[continue style](click or tap to continue)[end style]";
	execute JavaScript code "cns.pauseGame()";
	[unpauseGame() will send a keystroke here to allow us to continue sending outputs to Vorple.]
	wait for the SPACE key.


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
	[Remove any active page effects on death]
	deactivate remove-page-effect;
	execute JavaScript code "document.body.dataset.effect = ''";
	[Show the ending card]
	say paragraph break;
	say ending-card style;
	say "You have discovered ending #[N] of [MAX] (the [T] ending) after [turn count] turns!";
	say end style;
	[Pause]
	pause;
	[Log the ending]
	execute JavaScript code "cns.logEvent('ending[N]')";
	add bit N to stats bitmask "endings_bitmask";
	count bits from bitmask "endings_bitmask" into "endings_discovered";
	unlock achievement "ending_[N]";
	[Show the credits]
	execute JavaScript code "cns.showCredits()";
	end the story.


[Sometimes, we have a piece of scenery that is technically portable, but that we don't want the player to take.  The default for taking scenery is "that's hardly portable", but sometimes, that isn't true.  So this type prints a different message.]
Portable-scenery is a kind of thing.
Portable-scenery is scenery.
Instead of taking portable-scenery:
	say "It's probably best if you leave that alone."


[Analytics hook.]
To log event (NAME - text):
	execute JavaScript code "cns.logEvent('[NAME]')".


[Page effects, defined in CSS.]
Remove-page-effect is an event.
To add page effect (X - text) for (N - a number) turns with message (Z - text):
	execute JavaScript code "document.body.dataset.effect = '[X]'";
	activate remove-page-effect in N turns with message Z.
Carry out triggering remove-page-effect:
	execute JavaScript code "document.body.dataset.effect = ''".


[Autocomplete hooks.]
A thing can be noticed or unnoticed.  Things are usually noticed.
To decide what list of things is the available objects:
	let L be a list of things;
	repeat with item running through things:
		if item is yourself:
			do nothing;
		otherwise if item is a visible physical concept:
			add item to L;
		otherwise if item is a visible person:
			[A visible person is an available object whether or not they are noticed.]
			add item to L;
		otherwise if item is visible and item is not a concept and item is noticed:
			if the item is interesting or the description of item is not "":
				add item to L;
	decide on L.

[Apps can declare "When play begins: now can-sit-on-people is true." to enable that.]
Can-sit-on-people is a truth state that varies.  Can-sit-on-people is false.
Extra autocomplete verbs rules is a rulebook.
Extra-verbs is a list of text that varies.
Autocomplete update rules is a rulebook.
Autocomplete update rule:
	if the story has ended:
		execute JavaScript code "cns.autocomplete.resetVerbs(false)"; [Remove basic verbs.]
		execute JavaScript code "cns.autocomplete.addVerb('restart\n')";
		execute JavaScript code "cns.autocomplete.addVerb('quit\n')";
		execute JavaScript code "cns.autocomplete.addVerb('undo\n')";
		[Do not check story rules for verbs.]
	otherwise:
		execute JavaScript code "cns.autocomplete.resetVerbs(true)"; [Include basic verbs.]
		execute JavaScript code "cns.autocomplete.resetCustomAutoComplete()";
		[Call story rules for verbs.]
		follow the extra autocomplete verbs rules;
		repeat with verb-name running through extra-verbs:
			execute JavaScript code "cns.autocomplete.addVerb('[verb-name]')";
		repeat with dir running through directions:
			if the room dir from the location is a room:
				execute JavaScript code "cns.autocomplete.addVerb('[dir]\n')";
		execute JavaScript code "cns.autocomplete.resetPeople()";
		repeat with person running through people enclosed by the location:
			if person is not yourself and person is noticed:
				[A person is an available conversation partner only if noticed.]
				execute JavaScript code "cns.autocomplete.addPerson('[person]')";
		execute JavaScript code "cns.autocomplete.resetObjects()";
		let can-ask be false;
		let can-take be false;
		let can-drop be false;
		let can-eat be false;
		let can-drink be false;
		let can-open be false;
		let can-sit be false;
		repeat with item running through the available objects:
			let is-takeable be true;
			let is-inventory be false;
			let is-edible be false;
			let is-potable be false;
			let is-openable be false;
			let is-sittable be false;
			if item is carried by the player:
				now is-takeable is false;
				now is-inventory is true;
				now can-drop is true;
			if item is a person:
				now is-takeable is false;
				now can-ask is true;
				if can-sit-on-people is true:
					now is-sittable is true;
			if item is scenery:
				now is-takeable is false;
			if item is portable-scenery:
				now is-takeable is false;
			if item is fixed in place:
				now is-takeable is false;
			if item is a concept:
				now is-takeable is false;
			if item is edible:
				now is-edible is true;
				now can-eat is true;
			if item is a drink:
				now is-potable is true;
				now can-drink is true;
			if item is openable:
				now is-openable is true;
				now can-open is true;
			if item is an enterable supporter:
				now is-sittable is true;
				now can-sit is true;
			execute JavaScript code "cns.autocomplete.addObject({
				name: '[item]',
				inventory: [is-inventory],
				takeable: [is-takeable],
				edible: [is-edible],
				potable: [is-potable],
				openable: [is-openable],
				sittable: [is-sittable],
			})";
			if is-takeable is true:
				now can-take is true;
		if can-ask is true:
			execute JavaScript code "cns.autocomplete.addVerb('ask ')";
		if can-take is true:
			execute JavaScript code "cns.autocomplete.addVerb('take ')";
		if can-drop is true:
			[if you have something, you can drop it.]
			execute JavaScript code "cns.autocomplete.addVerb('drop ')";
			["give" also requires a person, so...]
			if can-ask is true:
				execute JavaScript code "cns.autocomplete.addVerb('give ')";
		if can-eat is true:
			execute JavaScript code "cns.autocomplete.addVerb('eat ')";
		if can-drink is true:
			execute JavaScript code "cns.autocomplete.addVerb('drink ')";
		if can-open is true:
			execute JavaScript code "cns.autocomplete.addVerb('open ')";
		if can-sit is true:
			execute JavaScript code "cns.autocomplete.addVerb('sit on ')";

[This is initially empty.  It is used to store concepts we know in a way that can be saved and restored.]
Table of Known Concepts
Concept
""
with 999 blank rows

To make (string - text) known:
	execute JavaScript code "cns.autocomplete.addTopic('[string]')";
	choose a blank row in the Table of Known Concepts;
	now Concept entry is "[string]".

To make (thingy - concept) known:
	execute JavaScript code "cns.autocomplete.addTopic('[thingy]')";
	choose a blank row in the Table of Known Concepts;
	now Concept entry is "[thingy]".

Meeting rules is a rulebook.
The acquaintance is a stranger that varies.
To make (Bob - stranger) known:
	if Bob is not known:
		execute JavaScript code "cns.autocomplete.addTopic('[Bob]')";
		execute JavaScript code "cns.autocomplete.addTopic('[real name of Bob]')";
		choose a blank row in the Table of Known Concepts;
		now Concept entry is "[Bob]";
		choose a blank row in the Table of Known Concepts;
		now Concept entry is "[real name of Bob]";
		now Bob is proper-named;
		now Bob is known;
		now the acquaintance is Bob;
		follow meeting rules;

[This occurs before each normal game prompt, whereas "before reading a command" fails to fire after an "undo".]
Vorple interface update rule:
	follow autocomplete update rules.

[The "final question" prompt after the game ends is distinct from "reading a command" or "vorple interface update".]
Before handling the final question:
	follow autocomplete update rules.

[This is also distinct from the above triggers.  Here we just want to put yes/no into autocomplete.  This is only used when the player types "restart" during a game, not at the end of a game.]
Check restarting the game:
	execute JavaScript code "cns.autocomplete.resetVerbs(false)"; [Remove basic verbs.]
	execute JavaScript code "cns.autocomplete.addVerb('yes\n')";
	execute JavaScript code "cns.autocomplete.addVerb('no\n')".

[Reset any extra verbs after each command.]
After reading a command:
	now extra-verbs is {}.


[Add commands to invoke UI dialogs.  These commands used to be in MoonShot before we had the corresponding UI elements, so we should maybe keep them for backward compatibility.]
Helping is an action out of world applying to nothing.  Understand "help", "verb", and "verbs" as helping.
Carry out helping:
	execute JavaScript code "cns.showHelp()".

Showing map is an action out of world applying to nothing.  Understand "map" as showing map.
Carry out showing map:
	execute JavaScript code "cns.showMap()".

Showing options is an action out of world applying to nothing.  Understand "options" and "settings" as showing options.
Carry out showing options:
	execute JavaScript code "cns.showSettings()".


[Add hooks for hints and highlights for interesting objects.]
hint is a Vorple style.
To show hint (T - text):
	say hint style;
	say "(Hint: [T])[line break]";
	say end style.

interesting-highlight is a Vorple style.
To say interesting:
	say interesting-highlight style.
To say /interesting:
	say end style.

A thing can be interesting or uninteresting.  Things are usually uninteresting.
Before printing the name of a thing (called the thingy):
	if the thingy is interesting:
		say interesting.
After printing the name of a thing (called the thingy):
	if the thingy is interesting:
		say /interesting.


Background music is a kind of object.
Background music has a text called url.
Background music has a real number called loop point.  The loop point of background music is usually 0.
Background music has a text called author credit.
Background music has a text called link.

To play music (M - background music):
	execute JavaScript code "cns.setBackgroundMusic(
		'[url of M]',
		[loop point of M],
		'[author credit of M]',
		'[link of M]')";
To stop music:
	execute JavaScript code "cns.stopBackgroundMusic()";



To set stat (name - text) to (value - number):
	execute JavaScript code "cns.achievements.setStat('[name]', [value])";

To increment stat (name - text):
	execute JavaScript code "cns.achievements.incrementStat('[name]')";

To add bit (value - number) to stats bitmask (name - text):
	execute JavaScript code "cns.achievements.addBit('[name]', [value])";

To count bits from bitmask (maskname - text) into (statname - text):
	execute JavaScript code "cns.achievements.countBits('[maskname]', '[statname]')";

To unlock achievement (name - text):
	execute JavaScript code "cns.achievements.unlock('[name]')";

Every turn, increment stat "turns_taken".



To decide if we are playing in a desktop bundle:
	execute JavaScript code "return cns.isDesktopBundle()";
	decide on whether or not the JavaScript code returned true.

To decide if we are playing in a browser:
	execute JavaScript code "return cns.isDesktopBundle()";
	decide on whether or not the JavaScript code returned false.



CNS init is a scene.
CNS init begins when play begins.
CNS ready is a truth state that varies.  CNS ready is initially false.
CNS init ends when CNS ready is true.

When CNS init begins:
	[Autoload saved games.]
	if the file of save data exists:
		read file of save data into memory;
		[If successful, the next command does not happen because we load the old state.  If it fails, we fall through.]
		execute JavaScript code "console.log('Failed to load saved game during CNS init.')";
		execute JavaScript code "cns.wipeSavedGames()";
		execute JavaScript code "cns.toast.error('Auto-Restore Failed!', 'Your saved game was from an older version of the game, and could not be read.')";
	[Setup autocomplete.]
	execute JavaScript code "cns.autocomplete.initialize()";
	execute JavaScript code "cns.autocomplete.resetTopics()";
	[Handling for end-game scenarios.]
	[Remove the "RESTORE" row from the end-game options, which conflicts with autosave and which we do not support.]
	choose a row with final response rule of immediately restore saved game rule in the Table of Final Question Options;
	blank out the final question wording entry;
	[Modify the action of "RESTART" from the end-game options, to hook in with our own logic to wipe the saved game.]
	choose a row with final response rule of immediately restart the VM rule in the Table of Final Question Options;
	now the final response rule entry is the restart on end rule;
	[Modify the action of "QUIT" from the end-game options, to hook in with our own logic to wipe the saved game.]
	choose a row with final response rule of immediately quit rule in the Table of Final Question Options;
	now the final response rule entry is the quit on end rule;
	[Now we allow the game to start.]
	now CNS ready is true;
	follow the scene changing rules.


[These rules let us hook into the end game options to wipe the saved game.]
This is the restart on end rule:
	execute JavaScript code "console.log('Restart at end of game.')";
	execute JavaScript code "cns.wipeSavedGames()";
	follow the immediately restart the VM rule.
This is the quit on end rule:
	execute JavaScript code "console.log('Quit at end of game.')";
	execute JavaScript code "cns.wipeSavedGames()";
	follow the immediately quit rule.


[To allow known topics to be saved and restored, we need to hook into the restore logic.]
Restoring from a saved game is an activity.
For restoring from a saved game (this is the default restore rule):
	execute JavaScript code "cns.autocomplete.initialize()";
	execute JavaScript code "cns.autocomplete.resetTopics()";
	repeat through the Table of Known Concepts:
		execute JavaScript code "cns.autocomplete.addTopic('[Concept entry]')";
	execute JavaScript code "return cns.postRestore()";
	if the JavaScript code returned false:
		[In case of catastrophic failure, delete the save and restart the game.  This should not happen to users, but happened to me once during debugging.  If the save file exists (in user home directory), but the cloud sync file for Steam does not exist, we can end up here.]
		execute JavaScript code "console.log('Post-restore returned false.')";
		execute JavaScript code "cns.wipeSavedGames()";
		execute JavaScript code "location.reload()";
	[Desktop bundles can also restore the HTML transcript, but browsers can't.  So for a browser session, you need to give some missing context.]
	if we are playing in a browser:
		say "[bracket]RESTORED AUTO-SAVE FROM YOUR LAST SESSION; TYPE 'RESTART' TO START OVER[close bracket][paragraph break]";
		try looking;
		try taking inventory;


[Auto-save and auto-restore logic are based on Kerkerkruip Permadeath by Victor Gijsbers, but heavily customized for our games and for Vorple.  Vorple itself also had to be modified to add support for file deletion.]
An external file can be a save file.
The binary file of save data is called "CNSAutoSave".
The file of save data is a save file.
No save failures is a truth state that varies. No save failures is true.  [Used to stop messages from piling up beyond the first autosave failure.]

Before reading a command (this is the automatically save after input rule):
	[Save before each command except the first one.]
	if the turn count is not 1:
		write game data to the file of save data;
	continue the action.

Check saving the game (this is the block saving rule):
	say "The game is saved and loaded automatically. There is no need to save it manually." instead.

Check restoring the game (this is the block restore rule):
	say "The game is saved and loaded automatically. There is no need to restore your game manually." instead.

First carry out restarting the game (this is the delete save on restart rule):
	[Delete the auto-save on an explicit restart command mid-game.]
	execute JavaScript code "console.log('Explicit game restart.')";
	execute JavaScript code "cns.wipeSavedGames()";
	continue the action.


[We take advantage of the existence of the I7 "external file" type to make declaring files easier, but we should only use saved game files with these three phrases; the built-in external file handling is not equipped to deal with them. If we didn't use the I7 type, we would need to declare the name the saved game file(s) in I6 using string arrays.]
To read (filename - save file external file) into memory:
	(- FileIO_LoadSavedGame({filename}); -).

To write game data to (filename - save file external file):
	(- FileIO_WriteSavedGame({filename}); -).

To delete (filename - save file external file):
	(- FileIO_DeleteSavedGame({filename}); -).

To decide if (filename - external file) exists:
	if filename is a save file:
		set filename as a save file;
	decide on whether or not filename exists part b.

To set (filename - external file) as a save file:
	(- FileIO_SetSaveFile( {filename} ); -).

To decide if (filename - external file) exists part b:
	(- (FileIO_Exists({filename}, false)) -).

Include (-

[ FileIO_LoadSavedGame extf struc fref res;
	if ((extf < 1) || (extf > NO_EXTERNAL_FILES))
		return FileIO_Error(extf, "tried to access a non-file");
	struc = TableOfExternalFiles-->extf;
	fref = glk_fileref_create_by_name(fileusage_SavedGame + fileusage_BinaryMode, Glulx_ChangeAnyToCString(struc-->AUXF_FILENAME), 0);
	if (fref == 0) jump RFailed;
	gg_savestr = glk_stream_open_file(fref, $02, GG_SAVESTR_ROCK);
	glk_fileref_destroy(fref);
	if (gg_savestr == 0) jump RFailed;
	@restore gg_savestr res;
	glk_stream_close(gg_savestr, 0);
	gg_savestr = 0;
	rtrue;
	.RFailed;
	print "[Failed to restore existing game.]^^";
	rfalse;
];

[ FileIO_WriteSavedGame extf struc fref res;
	if (actor ~= player) rfalse;
	if ((extf < 1) || (extf > NO_EXTERNAL_FILES))
		return FileIO_Error(extf, "tried to access a non-file");
	struc = TableOfExternalFiles-->extf;
	fref = glk_fileref_create_by_name(fileusage_SavedGame + fileusage_BinaryMode, Glulx_ChangeAnyToCString(struc-->AUXF_FILENAME), 0);
	if (fref == 0) jump SFailed;
	gg_savestr = glk_stream_open_file(fref, $01, GG_SAVESTR_ROCK);
	glk_fileref_destroy(fref);
	if (gg_savestr == 0) jump SFailed;
	@save gg_savestr res;
	if (res == -1) {
		! The player actually just typed "restore". We have to recover all the Glk objects;
		! the values in our global variables are all wrong.
		GGRecoverObjects();
		glk_stream_close(gg_savestr, 0); ! stream_close
		gg_savestr = 0;
		CarryOutActivity( (+ restoring from a saved game +) );
		rtrue;
	}
	glk_stream_close(gg_savestr, 0); ! stream_close
	gg_savestr = 0;
	if (res == 0) rtrue;
	.SFailed;
	if ( (+ No save failures +) )
	{
		print "[Could not save the game.]^^";
		(+ No save failures +) = 0;
	}
];

[ FileIO_DeleteSavedGame extf struc fref res;
	if ((extf < 1) || (extf > NO_EXTERNAL_FILES))
		return FileIO_Error(extf, "tried to access a non-file");
	struc = TableOfExternalFiles-->extf;
	fref = glk_fileref_create_by_name(fileusage_SavedGame + fileusage_BinaryMode, Glulx_ChangeAnyToCString(struc-->AUXF_FILENAME), 0);
	if (fref == 0) rfalse;
	if (glk_fileref_does_file_exist(fref)) {
		res = glk_fileref_delete_file(fref);
		if (res ~= 0) {
			print "[Failed to delete the saved game. Please remove by hand.]^^";
		}
	}
	glk_fileref_destroy(fref);
];

[ FileIO_SetSaveFile extf struc;
	if ((extf < 1) || (extf > NO_EXTERNAL_FILES))
		return FileIO_Error(extf, "tried to access a non-file");
	struc = TableOfExternalFiles-->extf;
	struc-->AUXF_BINARY = struc-->AUXF_BINARY | 2;
];

-).

[ We will alter the built in if (external file) exists phrase so that we don't confuse matters with two similar phrases. ]
Include (-

[ FileIO_Exists extf fref struc rv usage;
	if ((extf < 1) || (extf > NO_EXTERNAL_FILES)) rfalse;
	struc = TableOfExternalFiles-->extf;
	if ((struc == 0) || (struc-->AUXF_MAGIC ~= AUXF_MAGIC_VALUE)) rfalse;
	if ( struc-->AUXF_BINARY )
	{
		usage = fileusage_BinaryMode;
	} else {
		usage = fileusage_TextMode;
	}
	if ( struc-->AUXF_BINARY & 2 == 2 )
	{
		usage = usage + fileusage_SavedGame;
	} else {
		usage = usage + fileusage_Data;
	}
	fref = glk_fileref_create_by_name( usage, Glulx_ChangeAnyToCString(struc-->AUXF_FILENAME), 0 );
	rv = glk_fileref_does_file_exist(fref);
	glk_fileref_destroy(fref);
	return rv;
];

-) instead of "Existence" in "FileIO.i6t".



Chicken Noodle Soap Setup ends here.
