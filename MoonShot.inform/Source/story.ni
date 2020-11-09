"MoonShot" by "Joey & Charity Parrish".


[Bibliographic Information]
The story genre is "Comedy".
The release number is 1.
The story description is "A NASA intern in the 1960s scrambles to make Apollo 11
  a success."
The story creation year is 2020.


[Configuration]
Include the Standard Rules by Graham Nelson.
Include Basic Screen Effects by Emily Short.
Include Concepts by Joey Parrish.
Include Drinks by Joey Parrish.
Include Strangers by Joey Parrish.
Include Better Asking by Joey Parrish.
Include Help by Joey Parrish.
Release along with an interpreter.


[Startup]
The display banner rule is not listed in the startup rulebook.

[I don't like how Emily Short's "pause the game" rule clears the screen after
continuing.  Here's my own definition built on some of hers.]
To pause:
	say "[paragraph break]Please press SPACE to continue[line break]";
	wait for the SPACE key;
	say line break;

When play begins:
	center "'We choose to go to the moon in this decade...
	  because that goal will serve to organize and measure the best of our
	  energies and skills, because that challenge is one that we are willing
	  to accept, one we are unwilling to postpone...'

	  -- U.S. President John Fitzgerald Kennedy";
	say paragraph break;
	say paragraph break;
	center "[italic type]MoonShot[roman type]";
	center "Story by Joey & Charity Parrish";
	center "Copyright (C) 2020";
	pause;
	say paragraph break;
	say paragraph break;
	say "NASA, 1969.";
	say line break;
	say "You did it!  You finally landed an internship at NASA, the National
	  Aeronautics and Space ... Association?  Agency?  Authority?  You're
	  not really sure what the last A stands for, but it's only your first
	  day.  You're pretty certain you'll figure it out soon enough.";
	pause;
	say "After a whirlwind tour of NASA headquarters, which you are sure
	  you've already [italic type]completely[roman type] forgotten, you are
	  ushered into the office of your new boss: the director of NASA's
	  Apollo program.  You heard recently that we're ready to send
	  [italic type]man to the moon[roman type].  You can scarely believe it!
	  It's like something out of science fiction.  Nervously, you wait to be
	  called into the inner office.";
	pause;
	say "[italic type](If you have never played interactive fiction before,
	  you can type 'help' to get some basic instruction.)[roman type]";
	say line break;



The weather is a concept.  The weather is everywhere.  [We can talk about it or
ask about it in any room.  But if you try to look at it...]
Instead of examining the weather, say "Hrm... why are there no windows in this
building?"

Name is a concept.  Name is everywhere.



Chapter 1


NASA director's waiting room is a room.  "The tiny waiting room barely has
enough room for you, the secretary, and her desk."

In the waiting room is a stranger called the secretary.  The real name of the
secretary is "Donna".  The secretary can be happy or mad.  When play begins, now
the secretary is happy.  Understand "Donna" as the secretary.

The desk is scenery in the waiting room.  "A simple teak desk with a light
stain, and unusually spartan."

A phone is on the desk.  The description of the phone is "A black rotary
telephone.  It looks brand new."

Instead of taking the phone:
	say "[The secretary] stands up quickly and snatches it back from you.
	  'What is the matter with you?' she yells.  It takes her a minute or so
	  to get the phone plugged back in.";
	now the secretary is mad.

Instead of saying sorry while the player is in the waiting room:
	if the secretary is mad:
		say "She doesn't look ready to forgive you.";
	otherwise:
		say "What is there to apologize for?"

The description of the secretary is "[if the secretary is mad]She glares at you
and says 'Keep your eyes to yourself, you nut job.'[otherwise][The noun] is a
youngish woman, possibly in her 30s, with a beehive haircut and horn-rimmed
glasses.  She notices you looking and smiles."

Instead of talking to the secretary:
	say "Perhaps you could ask [the noun] about the weather, or her name."

Name is a concept in the waiting room.
Instead of quizzing the secretary about name:
	if the secretary is mad:
		say "She harrumphs at you and continues to scowl.";
	otherwise:
		say "'It's donna.  Nice to meet you!'";
		now the secretary is known.

Instead of quizzing the secretary about the weather:
	say "'Oh, it's lovely this time of year, don't you think?'"



NASA engineering department is east of the waiting room.  "Another room?!"

In NASA engineering department is a stranger called the engineer.  The real
name of the engineer is "Rick".

In NASA engineering department is a container called coffee-pot.  The printed
name of coffee-pot is "the coffee pot".  Understand "coffee pot" and "pot" as
coffee-pot.

The coffee is a drink.  The coffee is in the coffee-pot.  The amount of coffee
is 1000 ml.

The description of the engineer is "He is tall and thin, with slicked-back
ginger hair and a short-sleeved shirt and tie.  He is wearing a pocket
protector and a name badge.  What a nerd!"

Understand "ginger", "nerd", "man", and "Rick" as the engineer.

The engineer is wearing a name badge.  The description of the name badge is "It
says 'Rick' at the top.  The bottom says 'Apollo Systems Technician, Launch
Enablement Yroup.'  ... Huh.  Must be a typo."

After examining the name badge, now the engineer is known.

Rule for writing a paragraph about the engineer:
	if the engineer is unknown, say "An engineer is standing around by the
	  coffee pot, doing nothing.";
	otherwise say "Rick is still here, still doing nothing.";

Instead of talking to the engineer:
	say "Perhaps you could ask [the noun] about the weather, the command
	  module, or himself."

Instead of quizzing the engineer about the weather:
	say "[The noun] glances up at the ceiling for a moment before replying,
	  'Maybe a bit cloudy, but we should still be clear for launch.
	  Besides, we're never gonna give this up.'"

Understand "himself" as the engineer.
Instead of quizzing the engineer about the engineer:
	say "[The noun] looks a bit embarrassed by the question, maybe even
	  flattered.  He looks at his feet for a moment before replying,
	  'Well...  We're no strangers to love.'  Then he raises his eyes and
	  gives you a look that makes you... distinctly uncomfortable."

The command module is a concept in the engineering department.

Instead of quizzing the engineer about the command module:
	say "[The noun] doesn't seem to know what that is."
