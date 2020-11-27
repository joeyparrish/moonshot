Version 1 of Drinks by Joey Parrish begins here.

Include Approximate Metric Units by Graham Nelson.

A drink is a kind of thing.
A drink has a volume called amount.  The amount of a drink is usually 500 ml.
A drink can be staining.  A drink is usually staining.

[Drinking, as an action, is already defined in the standard rules.  But it doesn't do anything by default.]

Instead of drinking a thing:
	say "You can't drink that."

Instead of drinking a liquid-safe container (called the flask):
	if the flask contains a drink (called the potion):
		try drinking the potion;
	otherwise if the flask contains nothing:
		say "[The flask] is empty.";
	otherwise:
		say "There's nothing to drink in [the flask]."

Instead of drinking a drink (called the potion):
	decrease the amount of the potion by 500 ml;
	if the amount of the potion <= 0 ml:
		say "You drink it all up!";
		now the potion is nowhere;
	otherwise:
		say "You have a drink.";

[If you try to "take" a drink, rather than its container...]
Instead of taking a drink (called the potion):
	try taking the holder of the potion instead.

Instead of dropping a thing (called the flask) containing a drink (called the potion):
	try dropping the potion;
	now the flask is in the location.

Instead of dropping a drink (called the potion):
	say "[The potion] spills everywhere[if the potion is staining], staining the floors terribly[end if].";
	now the potion is nowhere.

[You can carefully put a container onto the floor, as opposed to dropping it.]
The floor is a backdrop.  The floor is everywhere.

Instead of putting a drink (called the potion) on the floor:
	try dropping the potion.

Instead of putting a thing on the floor:
	say "You carefully place [the noun] on the floor.";
	now the noun is in the location.

A container can be liquid-safe.
Instead of inserting a drink (called the potion) into a thing (called the flask):
	if the flask is a person:
		say "You know, you really should let [the flask] decide if they want to drink [the potion].";
	otherwise if the flask is not liquid-safe:
		say "You pour [the potion] into [the flask], but it doesn't look like it was made to hold liquid.  [The potion] leaks out all over the place.";
		now the potion is nowhere;
	otherwise if the flask contains the potion:
		say "[The potion] is already in [the flask].";
	otherwise if the flask contains a drink (called the potion2):
		say "Maybe you shouldn't mix [the potion] into [the potion2].";
	otherwise:
		say "You pour [the potion] into [the flask].";
		now the potion is in the flask.

Instead of inserting a drink (called the potion) into a drink (called the potion2):
	let the flask be the holder of the potion2;
	try inserting the potion into the flask.

Instead of putting a drink (called the potion) on a thing (called the surface):
	if the surface is a supporter:
		say "You pour [the potion] onto [the surface][if the potion is staining], staining it in the process[end if].";
		now the potion is nowhere;
	otherwise if the surface is a person:
		say "You had better not.";
	otherwise:
		say "That doesn't make sense."

Pouring is an action applying to one thing.  Understand "pour [thing]" as pouring.
Pouring it into is an action applying to two things.  Understand "pour [thing] into [thing]" and "pour [thing] in [thing]" as pouring it into.
Pouring it onto is an action applying to two things.  Understand "pour [thing] onto [thing]" and "pour [thing] on [thing]" as pouring it onto.
Pouring out is an action applying to one thing.  Understand "pour out [thing]" and "pour [thing] out" as pouring out.
Mixing is an action applying to one things.  Understand "mix [thing]" as mixing.
Mixing it into is an action applying to two things.  Understand "mix [thing] into [thing]" and "mix [thing] in [thing]" as mixing it into.

Check pouring a drink (called the potion):
	say "What do you want to pour [the potion] into?"

Check pouring a container (called the flask):
	say "What do you want to pour [the flask] into?"

Check pouring a thing:
	say "That isn't something you can pour."

Check pouring a drink (called the potion) into something (called the destination):
	try inserting the potion into the destination.

Check pouring a container (called the flask) into something (called the destination):
	if the flask contains nothing:
		say "[The flask] appears to be empty.";
	repeat with X running through the list of things contained by the flask:
		try inserting X into the destination.

Check pouring a thing into a thing:
	say "That isn't something you can pour."

Check pouring a drink (called the potion) onto a thing (called the surface):
	try putting the potion on the surface.

Check pouring a container (called the flask) onto something (called the surface):
	if the flask contains nothing:
		say "[The flask] appears to be empty.";
	repeat with X running through the list of things contained by the flask:
		try putting X on the surface.

Check pouring a thing onto a thing:
	say "That isn't something you can pour."

Check pouring out a drink (called the potion):
	try dropping the potion.

Check pouring out a container (called the flask):
	if the flask contains nothing:
		say "[The flask] appears to be empty.";
	repeat with X running through the list of things contained by the flask:
		try dropping X.

Check pouring out a thing:
	say "That isn't something you can pour."

Check mixing a drink (called the potion):
	say "You swirl [the potion] around in [the holder of the potion], but nothing happens."

Check mixing a thing:
	say "That isn't something you can mix."

Check mixing a drink (called the potion) into something (called the destination):
	try inserting the potion into the destination.

Check mixing a container (called the flask) into something (called the destination):
	if the flask contains nothing:
		say "[The flask] appears to be empty.";
	repeat with X running through the list of things contained by the flask:
		try mixing X into the destination.

Check mixing a thing into a thing:
	say "That isn't something you can mix."

Drinks ends here.

---- Documentation ----

This is a basic definition of a kind of thing called a "drink".  You can specify the amount of a drink (as a volume), and each time you drink from it, it goes down by 500 ml.  When it's gone, it disappears.  For example:

	In the kitchen is a container called coffee-pot.
	The printed name of coffee-pot is "the coffee pot".
	Understand "coffee pot" and "pot" as coffee-pot.                                                                      
                                                                                 
	The coffee is a drink.  The coffee is in the coffee-pot.  The amount of coffee is 1000 ml.

