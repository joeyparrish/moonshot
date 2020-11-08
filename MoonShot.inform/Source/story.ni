"MoonShot" by "Joey & Charity Parrish".


[Bibliographic Information]
The story genre is "Comedy".
The release number is 1.
The story description is "A NASA intern in the 1960s scrambles to make Apollo 11 a success."
The story creation year is 2020.


[Configuration]
Include the Standard Rules by Graham Nelson.
Include Basic Screen Effects by Emily Short.
Include Concepts by Joey Parrish.
Include Strangers by Joey Parrish.
Include Better Asking by Joey Parrish.
Include Help by Joey Parrish.
Release along with an interpreter.


[Startup]
The display banner rule is not listed in the startup rulebook.

When play begins:
  center "'We choose to go to the moon in this decade...
    because that goal will serve to organize and measure the best of our
    energies and skills, because that challenge is one that we are willing to
    accept, one we are unwilling to postpone...'

    -- U.S. President John Fitzgerald Kennedy";
  say paragraph break;
  say paragraph break;
  center "[italic type]MoonShot[roman type]";
  center "Story by Joey & Charity Parrish";
  center "Copyright (C) 2020";
  say paragraph break;
  say paragraph break;
  say "If you have never played interactive fiction before, you can type 'help'
    to get some basic instruction."



Chapter 1

The weather is a concept.  The weather is everywhere.  [We can talk about it or
ask about it in any room.]
Instead of examining the weather, say "Hrm... why are there no windows in this
building?"


NASA headquarters is a room.


NASA engineering department is east of NASA headquarters.

In NASA engineering department is a stranger called the engineer.  The real
name of the engineer is "Rick".

The description of the engineer is "He is tall and thin, with slicked-back
ginger hair and a short-sleeved shirt and tie.  He is wearing a pocket
protector and a name badge.  What a nerd!"

Understand "ginger", "nerd", "man", and "Rick" as the engineer.

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
