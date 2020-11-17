Version 1 of Strangers by Joey Parrish begins here.

A stranger is a kind of person.  A stranger can be known or unknown.  A stranger has some text called the real name.

Rule for printing the name of a stranger (called Bob) while Bob is known:
	say "[real name]".

[It would be better if this were triggered at exactly the time someone becomes known.  But until I learn how to build that trigger, we check on every turn.  I'm sure there's an edge case that's not handled this way, but I'm not sure where.]
Every turn:
	repeat with Bob running through strangers:
		if Bob is known:
			now the printed name of Bob is "[real name of Bob]";
			now Bob is proper-named.
[This last rule eliminates articles before the person's name.]

Strangers ends here.

---- Documentation ----

Here we define a "stranger", which is a type of person who is unknown to the player at the start of the game.  Game activities can cause a stranger to become "known", at which point the stranger's "real name" property is used to refer to them for the rest of the game.  For example:

	The kitchen is a room.  In the kitchen is a stranger called the tall man.  The real name of the tall man is "Robert".
	
	The description of the tall man is "He is shockingly tall.  His head nearly scrapes the ceiling!  He is wearing a name tag."
	
	The tall man is wearing a name tag.  The description of the name tag is "The name tag reads 'Robert Wadlow'."  After examining the name tag, now the tall man is known.

You can also write other conditions based on a stranger's known/unknown status:

	Rule for writing a paragraph about the tall man:
		if the tall man is unknown:
			say "An extremely tall man is standing here, trying his best not to hit his head on anything.";
		otherwise:
			say "Robert is still lurking about, looking uncomfortable."

