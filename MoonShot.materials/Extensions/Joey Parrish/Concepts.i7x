Version 1 of Concepts by Joey Parrish begins here.

A concept is a kind of backdrop.  Instead of examining a concept, say "You
can't see any such thing."

Concepts ends here.

---- Documentation ----

Here we define a "concept" as a kind of thing that you can refer to and ask
people about without having to create an object in the room.  To do this, we
build on top of the native "backdrops" type.

By default, concepts cannot be examined.  For example, with the following
source:

	The weather is a concept.  The weather is everywhere.

We can now refer to the weather from any room.  But examining it would result
in:

	You can't see any such thing.

But we can override this for specific concepts:

	Instead of examining the weather, say "Hrm... why are there no windows
	in this building?"

Finally, characters can discuss concepts in conversation.

	Include Better Asking by Joey Parrish.
	
	Instead of quizzing Bob about the weather:
	  say "[The noun] says 'Beautiful day, isn't it?'"
