Version 1 of Drinks by Joey Parrish begins here.

Include Approximate Metric Units by Graham Nelson.

A drink is a kind of thing.
A drink has a volume called amount.

[Drinking, as an action, is already defined in the standard rules.  But it
doesn't do anything by default.]

Instead of drinking a thing:
	say "You can't drink that."

Instead of drinking a thing containing a drink (called the potion):
	try drinking the potion.

Instead of drinking a drink (called the potion):
	decrease the amount of the potion by 500 ml;
	if the amount of the potion <= 0 ml:
		say "You drink it all up!";
		now the potion is nowhere;
	otherwise:
		say "You have a drink.";

[If you try to "take" a drink, rather than its container...]
Instead of taking a drink (called the potion):
	say "Most of it slips through your fingers, but you manage to get some of it
	  to stain your pockets, too.";
	now the potion is nowhere.

Drinks ends here.

---- Documentation ----

This is a basic definition of a kind of thing called a "drink".  You can specify
the amount of a drink (as a volume), and each time you drink from it, it goes
down by 500 ml.  When it's gone, it disappears.  For example:

	In the kitchen is a container called coffee-pot.
	The printed name of coffee-pot is "the coffee pot".
	Understand "coffee pot" and "pot" as coffee-pot.                                                                      
                                                                                 
	The coffee is a drink.  The coffee is in the coffee-pot.  The amount of
	coffee is 1000 ml.

