Version 1 of Better Asking by Joey Parrish begins here.


[NOTE: "anything" matches distant objects, whereas "something" only matches objects in scope (in the room).]

Quizzing it about is an action applying to two things.  Understand "ask [someone] about [anything]" and "quiz [someone] about [anything]" as quizzing it about.

Check quizzing it about:
	say "[The noun] shrugs unhelpfully."

[This adds the ability to say "ask about thingy" without specifying a specific person to ask.  It will ask the first person found in the room with you.]
To decide which person is arbitrary-person:
	let occupants be the list of people in the location;
	remove yourself from occupants;
	if occupants is empty:
		decide on nothing;
	otherwise:
		decide on entry 1 of occupants.

Quizzing generally is an action applying to one thing.  Understand "ask about [anything]" as quizzing generally.

Check quizzing generally:
	if arbitrary-person is nobody:
		say "There's nobody here to ask.";
	otherwise:
		try quizzing arbitrary-person about the noun.

[This adds the ability to say "ask for thingy" without specifying a specific person to ask.  It will ask the first person found in the room with you.]
Begging generally is an action applying to one thing.  Understand "ask for [anything]" as begging generally.

Check begging generally:
	if arbitrary-person is nobody:
		say "There's nobody here to ask.";
	otherwise:
		try asking arbitrary-person for the noun.



Informing it about is an action applying to two things.  Understand "tell [someone] about [anything]" and "inform [someone] about [anything]" as informing it about.

Check informing it about:
	say "'That's interesting,' [the noun] says, stifling a yawn."

[This adds the ability to say "tell about thingy" without specifying a specific person to tell.  It will tell the first person found in the room with you.]
Informing generally is an action applying to one thing.  Understand "tell about [anything]" as informing generally.

Check informing generally:
	if arbitrary-person is nobody:
		say "There's nobody here to tell.";
	otherwise:
		try informing arbitrary-person about the noun.


Talking to is an action applying to one visible thing.  Understand "talk to [someone]" or "converse with [someone]" as talking to.
Carry out talking to:
	say "[The noun] doesn't look interested in talking."


Talking to it about is an action applying to two things.  Understand "talk to [someone] about [anything]" as talking to it about.
Check talking to it about:
	try quizzing the noun about the second noun.
[Now "talk to Bob about thingy" is the same as "ask Bob about thingy".]

Talking about generally is an action applying to one thing.  Understand "talk about [anything]" as talking about generally.
Check talking about generally:
	if arbitrary-person is nobody:
		say "There's nobody here to ask.";
	otherwise:
		try quizzing arbitrary-person about the noun.
[Now "talk about thingy" is the same "ask about thingy".]

Talking generally is an action applying to nothing.  Understand "talk" as talking generally.
Check talking generally:
	if arbitrary-person is nobody:
		say "There's nobody here to talk to.";
	otherwise:
		try talking to arbitrary-person.
[Now "talk" in a room with Bob is the same as "talk to Bob".]


[These activities are now explicitly allowed to reference things in other rooms.]
Rule for reaching inside a room while quizzing or quizzing generally or informing or informing generally:
	allow access;


Better Asking ends here.

---- Documentation ----

This extension is based on examples found in documentation at:
 - http://inform7.com/book/RB_7_10.html
 - https://www.musicwords.net/if/I7Handbook8x11.pdf

"Asking" natively matches exact phrases, rather than things.  "Quizzing", defined here, is a workaround for that which matches things, so that you can use looser phrasing.  For example, if "worm" is a thing, "quizzing" would let the player write "ask Doctor about the worm" or "ask Doctor about worm", etc.  without the code listing all of those alternatives.  With native "asking", you would have to define the exact textual phrase the player could ask about.  This also allows you to "ask about the worm" without specifying that you're asking "the Doctor".  If you aren't specific, the first character in the room with you is the one you're asking.

For example:

	Include Concepts by Joey Parrish.
	Include Better Asking by Joey Parrish.
	
	The weather is a concept.  The weather is everywhere.
	
	The kitchen is a room.  In the kitchen is a man called Bob.
	
	Instead of quizzing Bob about the weather:
		say "[The noun] says 'Beautiful day, isn't it?'"

The same is true of "informing", defined here as a workaround for the same effect on the built-in "tell" action.

The "talk to" action will let us offer suggestions to the player about things to "ask" about.  For example:

	Instead of talking to Bob:
		say "Perhaps you could ask [the noun] about the weather."
