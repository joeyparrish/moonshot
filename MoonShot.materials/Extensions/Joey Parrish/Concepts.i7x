Version 1 of Concepts by Joey Parrish begins here.

Include Strangers by Joey Parrish.

A concept is a kind of backdrop.  Instead of examining a concept, say "You can't see any such thing."

A concept can be physical.  A concept is usually not physical.

A concept has a scene called allowed-scene.  The allowed-scene of a concept is usually the entire game.

Instead of taking a concept (called the considered):
	if the considered is physical:
		say "You can't see any such thing.";
		[Treat it as an object that isn't present in the room.]
	otherwise:
		say "What would that even [italic type]mean?[roman type][line break]";
		[Treat it as a purely conceptual thing.]

[This is initially empty.  It is used to store concepts we know in a way that can be saved and restored.]
Table of Known Concepts
Concept
""
with 99 blank rows

To make (string - text) known:
	if Vorple is supported:
		execute JavaScript code "addTopic('[string]')";
	choose a blank row in the Table of Known Concepts;
	now Concept entry is "[string]".

To make (thingy - concept) known:
	if Vorple is supported:
		execute JavaScript code "addTopic('[thingy]')";
	choose a blank row in the Table of Known Concepts;
	now Concept entry is "[thingy]".

To make (Bob - stranger) known:
	if Bob is not known:
		if Vorple is supported:
			execute JavaScript code "addTopic('[Bob]')";
			execute JavaScript code "addTopic('[real name of Bob]')";
		choose a blank row in the Table of Known Concepts;
		now Concept entry is "[Bob]";
		choose a blank row in the Table of Known Concepts;
		now Concept entry is "[real name of Bob]";
		now Bob is known.

[To allow known topics to be saved and restored, we need to hook into the restore logic.  To do that, we only have a hook for the message that gets printed.  So we define a fake message which actually calls our logic to reset the UI's topic list.]
Restore the game rule response (B) is "[post-restore routine]".
To say post-restore routine:
	if Vorple is supported:
		execute JavaScript code "resetTopics()";
		repeat through the Table of Known Concepts:
			execute JavaScript code "addTopic('[Concept entry]')";
	say "Ok.";
	try looking.

Concepts ends here.

---- Documentation ----

Here we define a "concept" as a kind of thing that you can refer to and ask people about without having to create an object in the room.  To do this, we build on top of the native "backdrops" type.

By default, concepts cannot be examined.  For example, with the following source:

	The weather is a concept.  The weather is everywhere.

We can now refer to the weather from any room.  But examining it would result in:

	You can't see any such thing.

But we can override this for specific concepts:

	Instead of examining the weather, say "Hrm... why are there no windows in this building?"

Finally, characters can discuss concepts in conversation.

	Include Better Asking by Joey Parrish.
	
	Instead of quizzing Bob about the weather:
		say "[The noun] says 'Beautiful day, isn't it?'"
