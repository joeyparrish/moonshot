Version 1 of Checklists by Joey Parrish begins here.

Include Vorple Screen Effects by Juhana Leinonen.

A checklist-item is a kind of object.
A checklist-item can be checked or unchecked.
A checklist-item has a list of things called sub-items.
[These can be references to anything: objects, people, etc.]

A checklist is a kind of thing.
A checklist has a list of checklist-items called items.
A checklist can be complete.
A checklist can be read.

checklist-block is a Vorple style.  [An outer span.]
checklist-contents is a Vorple style.  [An inner span.]

Definition: a checklist is complete:
	repeat with Y running through the items of it:
		if Y is not checked:
			decide no;
	decide yes.

[You can also "read" a checklist, which will just examine it.]
Carry out examining a checklist (called X):
	now X is read;
	say "[The description of X]";
	say "[If the description of X is not empty]  It[otherwise][The X][end if] reads:[line break][line break]";
	if Vorple is supported:
		say checklist-block style;
		say checklist-contents style;
	let NAME be "[X]";
	replace the text " checklist" in NAME with "";
	if Vorple is supported:
		say "[underlined font style][NAME][end style][line break]";
	otherwise:
		say "[bold type][NAME][roman type][line break]";
	repeat with Y running through the items of X:
		if Vorple is supported:
			say monospace font style;
		say "  [bracket][if Y is checked]X[otherwise] [end if][close bracket]";
		if Vorple is supported:
			say end style;  [monospace]
		say " [Y][line break]";
		repeat with Z running through sub-items of Y:
			if Vorple is supported:
				say monospace font style;
			say "      ";
			if Vorple is supported:
				say end style;  [monospace]
			say "[the Z][line break]";
	if Vorple is supported:
		say end style;  [checklist-contents]
		say end style;  [checklist-block]
	stop the action.  [Or else we see the description again at the bottom.]

Checklists ends here.

---- Documentation ----

This module allows the creation of a checklist, which the player of this game will carry around as they go about their tasks.  The checklist will be updated when they complete the tasks necessary to complete the chapter.  For example:

	Foo is a checklist-item.  The printed name of foo is "Get foo dog statue".

	Bar is a checklist-item.  The printed name of bar is "Get blueprints for the moon-pub". Bar is checked.

	There is a checklist in the waiting room. The items of the checklist are {foo, bar}.

	Instead of dropping the checklist:
		say "What just happened?";
		now bar is unchecked;
		now foo is checked.
