Version 1 of Options by Joey Parrish begins here.

Include Vorple Screen Effects by Juhana Leinonen.

interesting-highlight is a Vorple style.
help-card is a Vorple style.

Difficulty is a kind of value.  The difficulties are easy, medium, and hard.
A difficulty has a number called numeric value.
The numeric value of easy is 1.
The numeric value of medium is 2.
The numeric value of hard is 3.
Difficulty mode is a difficulty that varies.  Difficulty mode is initially medium.

Setting difficulty mode to is an action out of world applying to one difficulty.
Understand "[difficulty] mode" and "set [difficulty] mode" as setting difficulty mode to.
Check setting difficulty mode to a difficulty (called X):
	say "The game is now set to [X] mode.";
	now difficulty mode is X;
	say " - Interesting objects will [if the numeric value of X > 1]not [end if]be [interesting]highlighted[/interesting].";
	say " - Hints will [if the numeric value of X > 2]not [end if]be provided.";

To show hint (T - text):
	if the numeric value of difficulty mode <= 2:
		say italic type;
		say hint style;
		say "(Hint: [T])[line break]";
		say end style;
		say roman type;

To say interesting:
	if the numeric value of difficulty mode <= 1:
		if Vorple is supported:
			say interesting-highlight style;
		otherwise:
			say bold type;

To say /interesting:
	if the numeric value of difficulty mode <= 1:
		if Vorple is supported:
			say end style;
		otherwise:
			say roman type;

Before printing the name of a thing (called the thingy):
	if the thingy is not a person and the thingy is not TBD:
		say interesting.
After printing the name of a thing (called the thingy):
	if the thingy is not a person and the thingy is not TBD:
		say /interesting.


Showing options is an action out of world applying to nothing.  Understand "options" as showing options.

Carry out showing options:
	say help-card style;
	say "This game supports a few options, some of which may be familiar from other interactive fiction.";
	say line break;
	say "To control the appearance of room descriptions, you can use the common 'brief' and 'verbose' commands.";
	say line break;
	say "  - The [italic type]brief[roman type] command will turn on 'brief mode', so that room descriptions are only printed automatically the first time you visit a room.  In this mode, you can still see room descriptions by typing 'look' or 'l'.";
	say line break;
	say "  - The [italic type]verbose[roman type] command will turn on 'verbose mode' (the default), so that room descriptions are always printed automatically when you enter a room, whether or not the room is new to you.";
	say line break;
	say "This game also has three difficulty modes.";
	say line break;
	say "  - The [italic type]easy mode[roman type] command causes the game to show you hints and to [interesting-highlight style]highlight[end style] potentially interesting objects in room descriptions and conversations.";
	say line break;
	say "  - The [italic type]medium mode[roman type] command (the default) causes the game to show you hints, but not to highlight potentially interesting objects for you.";
	say line break;
	say "  - The [italic type]hard mode[roman type] command causes the game to neither show hints nor highlight potentially interesting objects for you.";
	say end style.

Options ends here.

---- Documentation ----

This adds three difficulty modes (easy, medium, and hard), commands to control the difficulty, and an "options" dialog that explains these commands.

It also creates a "show hint" action.  Hints will not be shown in hard mode.

Finally, this creates styles for highlighting interesting objects.  These highlights only show up in easy mode.  To mark up text in a room description or conversation for highlighting in easy mode, use the "[interesting]" opening tag and the "[/interesting]" closing tag.
