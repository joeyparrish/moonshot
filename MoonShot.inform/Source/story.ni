"MoonShot" by "Joey & Charity Parrish".


[Bibliographic Information]
The story genre is "Comedy".
The release number is 1.
The story description is "A NASA intern in the 1960s scrambles to make Apollo 11 a success."
The story creation year is 2020.


[Configuration]
Include the Standard Rules by Graham Nelson.
Include Basic Screen Effects by Emily Short.
Release along with an interpreter.


[Startup]
The display banner rule is not listed in the startup rulebook.

When play begins:
  center "'We choose to go to the moon in this decade...
    because that goal will serve to organize and measure the best of our
    energies and skills, because that challenge is one that we are willing to
    accept, one we are unwilling to postpone...'

    -- U.S. President John Fitzgerald Kennedy";
  leave space;
  center "[italic type]MoonShot[roman type]";
  center "Story by Joey & Charity Parrish";
  center "Copyright (C) 2020";
  leave space.


[General Tools]
To leave space:
  say paragraph break;
  say paragraph break.

["Asking" natively matches exact phrases, rather than things.  "Quizzing",
defined here, is a workaround for that which matches things, so that you can
use looser phrasing.  For example, if "worm" is a thing in the room, "quizzing"
would let the player write "ask Doctor about the worm" or "about worm", etc.
without the code listing all of those alternatives.  The same is true of
"informing", defined here as a workaround for the same effect on the built-in
"tell" action.]

Quizzing it about is an action applying to two things.  Understand "ask
[someone] about [something]" and "quiz [someone] about [something]" as quizzing
it about.

Check quizzing it about:
  say "[The noun] shrugs unhelpfully."

Informing it about is an action applying to two things.  Understand "tell
[someone] about [something]" and "inform [someone] about [something]" as
informing it about.

Check informing it about:
  say "'That's interesting,' [the noun] says, stifling a yawn."

[The "talk to" action will let us offer suggestions to the player about things
to "ask" about.]

Talking to is an action applying to one visible thing.  Understand "talk to
[someone]" or "converse with [someone]" as talking to.

[Here we define "concept" as a kind of thing you can refer to anywhere and ask
people about.  But you can't look at them in unless we write rules for
individual concepts to be examined.]

A concept is a kind of backdrop.  Instead of examining a concept, say "You
can't see any such thing."

The weather is a concept.  The weather is everywhere.  [We can talk about it or
ask about it in any room.]
Instead of examining the weather, say "Hrm... why are there no windows in this
building?"

[Here we define an unknown person.  They have a name, but we don't know it
right away.  Once we know it, that is how they will be referred to.  This lets
us give people alternate descriptions before and after they have been
introduced to us somehow.]

A stranger is a kind of person.  A stranger can be known or unknown.  A
stranger has some text called the real name.

Rule for printing the name of a stranger (called Bob) while Bob is known:
  say "[real name]".
Every turn, if a stranger (called Bob) is known, now Bob is proper-named.



Chapter 1

NASA headquarters is a room.

NASA engineering department is east of NASA headquarters.


In NASA engineering department is a stranger called the engineer.  The real
name of the engineer is "Rick".

Understand "ginger", "nerd", "man", and "Rick" as the engineer.

The description of the engineer is "He is tall and thin, with slicked-back
ginger hair and a short-sleeved shirt and tie.  He is wearing a pocket
protector and a name badge."

The engineer is wearing a name badge.  The description of the name badge is "It
says 'Rick' at the top.  The bottom says 'Apollo Systems Technician, Launch
Enablement Yroup.'  ... Huh.  Must be a typo."

After examining the name badge, now the engineer is known.

Rule for writing a paragraph about the engineer:
  if the engineer is unknown, say "An engineer is standing around by the coffee
    pot, doing nothing.";
  otherwise say "Rick is still here, still doing nothing.";

Instead of talking to the engineer:
  say "Perhaps you could ask [the noun] about the weather, the command module,
  or himself."

Instead of quizzing the engineer about the weather:
  say "[The noun] glances up at the ceiling for a moment before replying,
  'Maybe a bit cloudy, but we should still be clear for launch.  Besides, we're
  never gonna give this up.'"

Understand "himself" as the engineer.
Instead of quizzing the engineer about the engineer:
  say "[The noun] looks a bit embarrassed by the question, maybe even
  flattered.  He looks at his feet for a moment before replying, 'Well...  We're
  no strangers to love.'  Then he raises his eyes and gives you a look that
  makes you... distinctly uncomfortable."

The command module is a concept in the engineering department.

Instead of quizzing the engineer about the command module:
  say "[The noun] doesn't seem to know what that is."

