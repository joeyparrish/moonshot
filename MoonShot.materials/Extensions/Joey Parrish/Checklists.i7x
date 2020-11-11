Version 1 of Checklists by Joey Parrish begins here.

A checklist-item is a kind of object.
A checklist-item can be checked or unchecked.

A checklist is a kind of thing.
A checklist has a list of checklist-items called items.

[You can also "read" a checklist, which will just examine it.]
Instead of examining a checklist (called X):
	say "[The description of X]";
	say "[If the description of X is not empty]  It[otherwise][The X][end
	  if] reads:[line break]";
	repeat with Y running through the items of X:
		say "  [bracket][if Y is checked]X[otherwise] [end if][close
		  bracket] [printed name of Y][line break]";

Checklists ends here.

---- Documentation ----

This module allows the creation of a checklist, which the player of this game
will carry around as they go about their tasks.  The checklist will be updated
when they complete the tasks necessary to complete the chapter.  For example:

	Foo is a checklist-item.  The printed name of foo is "Get foo dog
	statue".

	Bar is a checklist-item.  The printed name of bar is "Get blueprints for
	the moon-pub". Bar is checked.

	There is a checklist in the waiting room. The items of the checklist are
	{foo, bar}.

	Instead of dropping the checklist:
		say "What just happened?";
		now bar is unchecked;
		now foo is checked.
