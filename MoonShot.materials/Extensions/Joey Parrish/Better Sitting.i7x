Version 1 of Better Sitting by Joey Parrish begins here.

Understand the command "sit" as something new.

[NOTE: "anything" matches distant objects, whereas "something" only matches objects in scope (in the room).]
Sitting on is an action applying to one thing.  Understand "sit on [something]" as sitting on.

[An enterable supporter is a general thing that can hold your body.]
A chair is a kind of enterable supporter.
[This is a more specific kind of thing.  We prefer to sit on chairs over, say, desks.]

Check sitting on:
	if the noun is a chair:
		say "You sit in [the noun].";  [This sounds better to me than "on".]
		try silently entering the noun;
	otherwise if the noun is an enterable supporter:
		say "You sit on [the noun].";  [For a general supporter, "on" is always correct.]
		try silently entering the noun;
	otherwise:
		say "That's not something you can sit down on."

Sitting generally is an action applying to nothing.  Understand "sit" as sitting generally.

Check sitting generally:
	let good-seats be the list of chairs in the location;
	if good-seats is not empty:
		try sitting on entry 1 of good-seats;
	otherwise:
		let good-enough-seats be the list of enterable supporters in the location;
		if good-enough-seats is not empty:
			try sitting on entry 1 of good-enough-seats;
		otherwise:
			say "You don't see anything good to sit on, so you sit on the floor.";

[The default behavior of "stand" is weird, and I don't like it.  I don't like the response phrasing, and it prints the room description again, which seems inappropriate for leaving chairs and tables.  And if you aren't sitting, the default is "you aren't *in* anything", which seems really weird, too.]
Understand the command "stand" as something new.
Standing generally is an action applying to nothing.
Understand "stand" and "stand up" as standing generally.
Check standing generally:
	if the player is on a supporter (called the seat):
		say "You stand up from [the seat].  It's good to move around.  (It keeps the blood moving!)";
		let the former exterior be the not-counting-parts holder of the seat;
		surreptitiously move the player to the former exterior;
	otherwise:
		say "You are already standing.";

Better Sitting ends here.

---- Documentation ----

Has _this_ ever happened to you?

	>sit
	(on dog)
	That's not something you can sit down on.

Then _you_ need Better Sitting!

With Better Sitting, you will no longer have players accidentally sitting on the first object in their inventory, the first person in the room, etc.  Saying "sit" (without specifying on what) will intelligently choose a specific sittable thing, or else have the player just sit on the floor instead.

You can also mark specific things as "chairs", meaning that the player will naturally prefer to sit on those instead of other enterable supporters.

	The desk is an enterable supporter in the living room.  [You could sit on it, but you wouldn't normally.]
	The wooden armchair is a chair in the living room.  [This is where you would sit if you don't specify.]
