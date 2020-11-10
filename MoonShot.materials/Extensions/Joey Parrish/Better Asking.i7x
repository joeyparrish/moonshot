Version 1 of Better Asking by Joey Parrish begins here.


Quizzing it about is an action applying to two things.  Understand "ask
[someone] about [something]" and "quiz [someone] about [something]" as quizzing
it about.

Check quizzing it about:
	say "[The noun] shrugs unhelpfully."

[This adds the ability to say "ask about [something]" without specifying a
specific person to ask.  It will ask the first person found in the room with
you.]
Quizzing generally is an action applying to one thing.  Understand "ask about
[something]" as quizzing generally.

Check quizzing generally:
	let occupants be the list of people in the location;
	remove yourself from occupants;
	if occupants is empty:
		say "There's nobody here to ask.";
	otherwise:
		let arbitrary-person be entry 1 of occupants;
		try quizzing arbitrary-person about the noun.


Informing it about is an action applying to two things.  Understand "tell
[someone] about [something]" and "inform [someone] about [something]" as
informing it about.

Check informing it about:
	say "'That's interesting,' [the noun] says, stifling a yawn."

[This adds the ability to say "tell about [something]" without specifying a
specific person to tell.  It will tell the first person found in the room with
you.]
Informing generally is an action applying to one thing.  Understand "tell about
[something]" as informing generally.

Check informing generally:
	let occupants be the list of people in the location;
	remove yourself from occupants;
	if occupants is empty:
		say "There's nobody here to tell.";
	otherwise:
		let arbitrary-person be entry 1 of occupants;
		try informing arbitrary-person about the noun.



Talking to is an action applying to one visible thing.  Understand "talk to
[someone]" or "converse with [someone]" as talking to.


Better Asking ends here.

---- Documentation ----

This extension is based on examples found in documentation at:
 - http://inform7.com/book/RB_7_10.html
 - https://www.musicwords.net/if/I7Handbook8x11.pdf

"Asking" natively matches exact phrases, rather than things.  "Quizzing",
defined here, is a workaround for that which matches things, so that you can
use looser phrasing.  For example, if "worm" is a thing, "quizzing" would let
the player write "ask Doctor about the worm" or "ask Doctor about worm", etc.
without the code listing all of those alternatives.  With native "asking", you
would have to define the exact textual phrase the player could ask about.  This
also allows you to "ask about the worm" without specifying that you're asking
"the Doctor".  If you aren't specific, the first character in the room with you
is the one you're asking.

For example:

	Include Concepts by Joey Parrish.
	Include Better Asking by Joey Parrish.
	
	The weather is a concept.  The weather is everywhere.
	
	The kitchen is a room.  In the kitchen is a man called Bob.
	
	Instead of quizzing Bob about the weather:
		say "[The noun] says 'Beautiful day, isn't it?'"

The same is true of "informing", defined here as a workaround for the same
effect on the built-in "tell" action.

The "talk to" action will let us offer suggestions to the player about things
to "ask" about.  For example:

	Instead of talking to Bob:
		say "Perhaps you could ask [the noun] about the weather."
