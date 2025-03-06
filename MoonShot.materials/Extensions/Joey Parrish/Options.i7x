Version 1 of Options by Joey Parrish begins here.

Include Vorple Screen Effects by Juhana Leinonen.

interesting-highlight is a Vorple style.
hint is a Vorple style.

To show hint (T - text):
	if Vorple is supported:
		say hint style;
	say "(Hint: [T])[line break]";
	if Vorple is supported:
		say end style;

To say interesting:
	if Vorple is supported:
		say interesting-highlight style;

To say /interesting:
	if Vorple is supported:
		say end style;

A thing can be uninteresting.  Things are usually not uninteresting.
Before printing the name of a thing (called the thingy):
	if the thingy is not uninteresting:
		say interesting.
After printing the name of a thing (called the thingy):
	if the thingy is not uninteresting:
		say /interesting.

Showing options is an action out of world applying to nothing.  Understand "options" and "settings" as showing options.

Carry out showing options:
	if Vorple is supported:
		execute JavaScript code "showSettings()";
	otherwise:
		say "Sorry, in-game options require the web interpreter.".

Options ends here.

---- Documentation ----

This creates a "show hint" action.  You can hide hints in CSS through Vorple using the "hint" class.

This creates a highlight class for "interesting" objects and phrases.  You can choose to highlight these in CSS through the "interesting" class.  To mark up text in a room description or conversation for highlighting, use the "[interesting]" opening tag and the "[/interesting]" closing tag.
