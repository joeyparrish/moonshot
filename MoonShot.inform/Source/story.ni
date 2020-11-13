"MoonShot" by "Joey & Charity Parrish".


[Bibliographic Information]
The story genre is "Comedy".
The release number is 1.
The story description is "A NASA intern in the 1960s scrambles to make Apollo 11
  a success."
The story creation year is 2020.


[Configuration]
Include the Standard Rules by Graham Nelson.
Include Punctuation Removal by Emily Short.
Include Exit Lister by Gavin Lambert.
Include Vorple Screen Effects by Juhana Leinonen.
Include Concepts by Joey Parrish.
Include Drinks by Joey Parrish.
Include Strangers by Joey Parrish.
Include Better Asking by Joey Parrish.
Include Checklists by Joey Parrish.
Include Help by Joey Parrish.
Release along with the "Vorple" interpreter.
Release along with the style sheet "moonshot-custom-styles.css".


[Styling]
blockquote is a Vorple style.
room-heading is a Vorple style.
room-name is a Vorple style.
direction-name is a Vorple style.
author-line is a Vorple style.
title-line is a Vorple style.
copyright-line is a Vorple style.
plaque-card is a Vorple style.

This is the fancy room description heading rule:
	say "[room-heading style][bold type][Location][roman type][end
	  style]".
The fancy room description heading rule substitutes for the room description
heading rule.

Rule for printing the name of a room (called the place):
	say "[room-name style][printed name of place][end style]";

Rule for printing the name of a direction (called whither):
	say "[direction-name style][printed name of whither][end style]".



[Other tweaks]
After reading a command:
	Resolve punctuated titles.
[This is so that things like "examine Mr. Furtwangler" are understood.
Otherwise, the period ends the player's command command.]

[I don't like how Emily Short's "pause the game" rule clears the screen after
continuing.  Here's my own definition built on some of hers.]
To pause:
	if Vorple is not supported:
		[This is not needed on the HTML-based Vorple interpeter, and in
		fact, the "wait for SPACE" part fails miserably, hanging the
		game.]
		say "[paragraph break]Please press SPACE to continue[line
		  break]";
		wait for the SPACE key;
	say line break;



[Intro]
This is the fancy banner rule:
	if Vorple is supported:
		[The HTML-based Vorple interpreter can handle centering a large
		block of text very well.]
		center "[blockquote style]'We choose to go to the moon in
		  this decade... because that goal will serve to organize and
		  measure the best of our energies and skills, because that
		  challenge is one that we are willing to accept, one we are
		  unwilling to postpone...'[line break][line break]-- U.S.
		  President John Fitzgerald Kennedy[end style]";
	otherwise:
		[In other interpreters, it looks better broken up into explicit
		lines, with each one centered.]
		center "'We choose to go to the moon in this decade...";
		center "because that goal will serve to organize and";
		center "measure the best of our energies and skills,";
		center "because that challenge is one that we are";
		center "willing to accept, one we are unwilling";
		center "to postpone...'";
		center "[line break]";
		center "-- U.S. President John Fitzgerald Kennedy";
	say paragraph break;
	say paragraph break;
	[Note that there is a requirement in the Inform license that we mention
	  Inform somewhere, so we do so here.]
	if Vorple is supported:
		center "[blockquote style][title-line style][italic
		  type]MoonShot[roman type][end style][line break][author-line
		  style]Story by Joey & Charity Parrish[end style][line
		  break][copyright-line style]Copyright (C) 2020[end style][line
		  break]Created with Inform 7[end style]";
		say line break;
		center "(click or scroll to continue)";
	otherwise:
		center "[italic type]MoonShot[roman type]";
		center "Story by Joey & Charity Parrish";
		center "Copyright (C) 2020";
		center "Created with Inform 7";
	pause;
	say paragraph break;
	say paragraph break.

The display banner rule is not listed in the startup rulebook.
The fancy banner rule is listed before the start in the correct scenes rule in
the startup rulebook.
[Subtle difference in timing: we want our intro shown first, not right before
the initial room description where the typical banner rule goes.  This means
that our intro happens before "when play begins", which is when our first scene
begins.  It was really tricky to work out how to time this correctly.]

The detect interpreter's Vorple support rule is listed before the fancy banner
rule in the startup rulebook.
[This would normally happen when play begins, but we need to detect Vorple
support earlier for use in the fancy banner.]



[General]

The weather is a concept.  The weather is everywhere.  [We can talk about it or
ask about it in any room.  But if you try to look at it...]
Instead of examining the weather, say "Hrm... why are there no windows in this
building?"

[You can ask anyone about their name.  It's only polite.]
Name is a concept.  Name is everywhere.

NASA is a concept.  NASA is everywhere.
Understand "second a" and "second a in NASA" as NASA.

Apollo is a concept.  Apollo is everywhere.
[Handle variations, including misspellings that I myself (JCP) am prone to:]
Understand "Apollo 11", "Appollo", "Appolo", "Appollo 11", and "Appolo 11" as
Apollo.

The command module is a concept.  The command module is everywhere.
Understand "CSM" as the command module.

The rocket is a concept.  The rocket is everywhere.


[The built-in default for asking someone about an unknown thing is "There is no
reply."  We'd prefer a different default for topics we haven't coded
explicitly.  Sadly, this has to be repeated for both the built-in "asking" (for
arbitrary text) and for "quizzing" (for objects/people).]

Instead of quizzing someone (called person) about:
	say "'[one of]Oh, I don't know anything about that[or]Let's talk about
	  something else[or]I'm not sure what to say about that[purely at
	  random],' says [the person]."

[By default, only "sorry" triggers this action.]
Understand "say sorry" as saying sorry.

[By default, we don't get to see what people are carrying.  This changes that.]
After examining a person (called Bob):
	if Bob does not have nothing:
		say "[The Bob] is carrying [run paragraph on]";
		list the contents of Bob, as a sentence, giving inventory
		  information;
		say "."

[By default, we don't seem to get a description of what rooms are adjacent to
the current room, and in what direction.  This is something I'm used to seeing
in IF, and I'd like to avoid writing it explicitly in every room.  Including the
"Exit Lister" extension solves that.  But it needs a little configuration for
this game.  We want to always tell the user what the names of nearby rooms are,
even if we have not yet been to them.  For this, we use:]
A room memory rule: rule succeeds.

Things can be critical.
Instead of dropping something critical:
	say "No, you're going to need that."



[---------- DAY 1 ----------]

Day one is a scene.
Day one begins when play begins.
When day one begins:
	say "[room-heading style]NASA Headquarters, 1969[end style]";
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
	  [italic type]a man to the moon[roman type].  You can scarely believe
	  it!  It's like something out of science fiction.  Nervously, you wait
	  to be called into the inner office.";
	pause;
	say "[italic type](If you have never played interactive fiction before,
	  you can type 'help' to get some basic instruction.)[roman type]";
	say line break.



[TODO: Expand the waiting room description.]
The director's waiting room is a room.  "The tiny waiting room barely has
enough room for you, the secretary, and her desk."
The printed name of director's waiting room is "NASA Director's Waiting Room".

In the waiting room is a stranger called the secretary.  The real name of the
secretary is "Donna".  The secretary can be mad.  When day one begins, now the
secretary is not mad.  Understand "Donna", "her", "herself", and "woman" as
the secretary.  The secretary is female.

The secretary's desk is scenery in the waiting room.  "A simple teak desk with a
light stain, and unusually spartan."

A phone is on the secretary's desk.  The description of the phone is "A black
rotary telephone.  It looks brand new."

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

Instead of quizzing the secretary about name:
	say "'It's Donna,' she says.  'Nice to meet you!'";
	now the secretary is known.

Instead of quizzing the secretary about the secretary:
	try quizzing the secretary about name.

Instead of quizzing the secretary about the weather:
	say "'Oh, it's lovely this time of year, don't you think?'"

Instead of talking to the secretary while the secretary is mad:
	say "She doesn't look like she wants to talk to you."

Instead of quizzing the secretary about anything while the secretary is mad:
	say "She harrumphs at you and continues to scowl."

[TODO: Ask the secretary about NASA, Apollo]

When day one begins:
	secretary warns in 0 turns from now;
	director yells in 5 turns from now.

Yourself can be told-to-wait.
At the time when secretary warns:
	if yourself has not been told-to-wait:
		say "[The secretary] catches your attention and says, 'The
		  director will be with you shortly.  Please make yourself
		  comfortable while you wait.'";
	now yourself is told-to-wait.

Before waiting in the waiting room:
	say "[one of]You sit awkwardly, wondering when this whole thing is
	  supposed to get started.[or]Maybe there's something you can do, or
	  something you should be talking about while you wait?[or]The waiting
	  is the hardest part, isn't it?[purely at random]".

At the time when director yells:
	say "A booming voice comes from the director's office: 'Donna!  Where
	  the hell is that kid?  They're late!'";
	say "[The secretary] looks embarrassed and says quietly, 'You'd better
	  go on in.  He [italic type]hates[roman type] tardiness.'";
	now the director is ready.

Instead of quizzing the secretary about the director:
	say "'Oh, Mr. Furtwangler is a visionary!' she says.  'He is completely
	  on top of every aspect of this project.  I don't know how he does
	  it!'"

Instead of going to the director's office while the director is not ready:
	say "[The secretary] jumps up and runs for the door, stopping you in
	  your tracks.  'You can't go in there!  Just wait, please, and the
	  director will be with you as soon as he is ready.'";
	if yourself is told-to-wait:
		[If the player has been told at least once before, they are
		perhaps having trouble with this waiting thing, so offer a
		hint.]
		say "[line break](Hint: You can explore the room, talk to [the
		  secretary], examine things, or just type 'wait' to wait
		  patiently.)";
	now yourself is told-to-wait.

[In this language "in/inside" is actually a direction you could use to relate
places to one another.  But in context of this room, we'd like "go in" to send
you into the director's office.]
Instead of going inside while in the waiting room:
	try going north.



[TODO: Write the director's office description.]
The director's office is north of the waiting room.  The printed name of the
director's office is "NASA Director's Office".

In the director's office is a stranger called the director.  The real name
of the director is "Mr. Furtwangler".

Understand "director", "dirk", "mr furtwangler", "mister furtwangler",
"furtwangler", "boss", "him", "himself", and "man" as the director.

The director can be agitated or relaxed.  When day one begins, now the director
is agitated.

The director can be ready.  When day one begins, now the director is not ready.

The director's desk is scenery in the director's office.  "An expansive desk
covered in whirring desk gadgets that roll chrome metal balls back and forth
endlessly on balanced tracks, and bobblehead dolls."

There is a checklist on the director's desk called checklist-1.
The printed name of checklist-1 is "Apollo 11 checklist".
The description of checklist-1 is "The checklist is [if checklist-1 is on the
director's desk]laying on the desk, [end if]scribbled out in childish print."

Instead of taking checklist-1:
	say "[The director] looks relieved and drawls, 'Oh, thank you, wasn't
	  sure how I was gonna get all that done!'  (Hint: You can examine the
	  checklist to see the details)[line break]";
	now the player has checklist-1;
	now the director is relaxed.

The description of the director is "[if the director is relaxed]He gazes
dreamily out the window and asks, 'Do you think Johnny Cash is his real
name?'[otherwise][The noun] is a man in his 60s with a hawkish nose and an
absent air, like a man who can't seem to remember why he's here.  He's holding a
comically large cup of coffee in one hand and the other keeps pawing through the
jumble of knick knacks on his desk, like he's lost something."

Instead of talking to the director:
	say "Perhaps you could ask [the director] about the internship, what the
	  second A in NASA stands for, the Apollo 11 project, or his name."

Instead of quizzing the director about name:
	try quizzing the director about the director.

Instead of quizzing the director about the director:
	say "'Furtwangler.  Dirk Furtwangler.  Boy am I glad you're here!'";
	now the director is known.

The internship is a concept in the director's office.
Instead of quizzing the director about the internship:
	say "'Well you know how these things are.  We're terribly busy here at
	  NASA.  Just an unreasonable amount of space out there.  Downright
	  oppressive, when you start to think about how much of it there is!  So
	  much space to analyze....' His voice trails off into a troubled hum
	  until he notices you looking at him.  He continues, 'Which is exactly
	  why we need you, the intern, to take care of this whole messy Apollo
	  11 business.'  He indicates the checklist on his desk.  'Get started,
	  kid!'"

Instead of quizzing the director about NASA:
	say "The director looks surprised by your question.  'NASA?  Well, of
	  course, everyone knows about the National Aeronautics and Space...
	  uhh... It's about space.  That's the important bit.  [bold
	  type]LOTS[roman type] of space out there.'"
[TODO: Rewrite the NASA abbreviation gag for the director?]

[TODO: Ask the director about Apollo]

Instead of quizzing the director about anybody:
	say "He stares blankly for a second, then suddenly says, 'Who?'"

[Keep the player from leaving without the checklist.]
Instead of going from the director's office:
	if checklist-1 is carried by the player:
		continue the activity;
	otherwise:
		say "'Hang on!' says [the director].  'You're gonna need this!'.
		  He indicates the checklist[if a checklist is on the
		  director's desk] laying on his desk[end if].  'Get all of that
		  done, ASAP.'"

[TODO: Should the player be able to take the checklist without some conversation
with the director?  Perhaps the director should open a conversation when the
player enters for the first time?]

Instead of giving a checklist (called proof of your good work) to the director:
	if proof of your good work is not complete:
		say "'Whoa,' says [the director], 'what is this?  You've still
		  got work to do, kid!  Get back out there, and don't come back
		  until it's all done!'";
	otherwise:
		say "[The director] scrutinzes the list, then smiles at you and
		  drawls, 'Good job, kid.  Come back tomorrow for your next
		  assignment!'";
		now the director has proof of your good work.



Checklist-1 is critical.  [You can't drop it.]
Get-blueprints is a checklist-item.  The printed name of get-blueprints is "Get
command module blueprints".
Get-equations is a checklist-item.  The printed name of get-equations is "Get
rocket equations".
The items of checklist-1 are {get-blueprints}.



The Main Hallway is east of the director's office.  "A long, blank hallway, with
several doors branching off in various directions.  A bronze plaque is hanging
on the wall in the center of the hallway."

A bronze plaque is scenery in the hallway.

Instead of examining the plaque:
	say "Engraved in bronze, the plaque says:[line break]";
	if Vorple is supported:
		center "[plaque-card style][bold type]Apollo[roman type][line
		  break]Never give up, never surrender![end style]";
	otherwise:
		center "[bold type]Apollo[roman type]";
		center "Never give up, never surrender!"



[TODO: Write the engineering department description.]
The engineering department is east of the hallway.  "Another room?!"
The printed name of the engineering department is "NASA Engineering Department".

In the engineering department is a stranger called the engineer.  The real
name of the engineer is "Rick".  The engineer can be sad.  When day one begins,
now the engineer is not sad.  The engineer is male.

The engineer is carrying the blueprints.  The description of the blueprints is
"The blueprints, which are distinctly white, say '[bold type]Apollo 11 Command
Module[roman type]' on the top.  [if the player has the blueprints]They are
looking a little worse for wear, to say the least.[otherwise]The drawing of the
command module is surprisingly lifelike.  You've never seen a more beautiful
rendering of a truncated cone."

The blueprints can be discussed.  [Only when you've asked about them can you
take them.]
The blueprints are critical.  [You can't drop them.]
The blueprints are plural-named.  [Don't call them "a blueprints".]

In the engineering department is a container called a coffee-pot.  The printed
name of coffee-pot is "coffee pot".
[Accept a few misspellings of coffee.]
Understand "coffee pot", "cofee pot", "coffe pot", "cafe pot", "cofe pot", and
"pot" as the coffee-pot.

The coffee is a drink.  The coffee is in the coffee-pot.  The amount of coffee
is 1000 ml.  The indefinite article is "some".
[Accept a few misspellings of coffee.]
Understand "cofee", "coffe", "cafe", and "cofe" as coffee.

The description of the engineer is "[if the engineer is not sad]He is tall and
thin, with slicked-back ginger hair and a short-sleeved shirt and tie.  He is
wearing a pocket protector and a name badge.  What a nerd![otherwise][The noun]
is just about the saddest thing you've ever seen.  His hair is a mess, and he
appears to have been wiping his tears on his tie."

Instead of saying sorry while the player is in the engineering department:
	if the engineer is sad:
		say "He sniffs a little, then says 'Um, yeah, okay.  Apology
		  accepted.'";
		now the engineer is not sad;
	otherwise:
		say "What is there to apologize for?"

Understand "ginger", "nerd", "man", "him", "himself", and "Rick" as the
engineer.

The engineer is wearing a name-badge.  The printed name of the name-badge is
"name badge".  Understand "badge" and "name badge" as name-badge.  [To
disambiguate with the "name" concept.]

The description of the name-badge is "It says 'Rick' at the top.  The bottom
says 'Apollo Systems Technician, Launch Enablement Yroup.'  ... Huh.  Must be a
typo."

After examining the name-badge, now the engineer is known.

Rule for writing a paragraph about the engineer:
	if the engineer is unknown, say "An engineer is standing around by the
	  coffee pot, [if the engineer is sad]crying.[otherwise]doing nothing.";
	otherwise say "Rick is still here, still [if the engineer is
	  sad]crying.[otherwise]doing nothing.";

Instead of talking to the engineer:
	say "Perhaps you could ask [the noun] about the weather, the command
	  module blueprints, or himself."

Instead of quizzing the engineer about name:
	say "The engineer taps his name badge and says, 'Can't you read?'"

Instead of quizzing the engineer about the weather:
	say "[The noun] glances up at the ceiling for a moment before replying,
	  'Maybe a bit cloudy, but we should still be clear for launch.
	  Besides, we're never gonna give this up.'"

Instead of quizzing the engineer about the engineer:
	say "[The noun] looks a bit embarrassed by the question, maybe even
	  flattered.  He looks at his feet for a moment before replying,
	  'Well...  We're no strangers to love.'  Then he raises his eyes and
	  gives you a look that makes you... distinctly uncomfortable."

Instead of quizzing the engineer about the blueprints:
	say "[The noun] looks both smug and offended at once.
	  '[bold type]ACTUALLY[roman type], they aren't blue at all!  The
	  cyanotype [italic type]blueprint[roman type] began to be supplanted by
	  [italic type]diazo prints[roman type], also known as [italic
	  type]whiteprints[roman type].'";
	now the printed name of get-blueprints is "Get command module
	  whiteprints".

The whiteprints is a concept in the engineering department.
Instead of quizzing the engineer about the whiteprints:
	say "[The noun] rolls his eyes.  'Ha!  Nobody calls them whiteprints.'
	  His laughter quickly devolves into snorts.  Wiping his eyes, he adds,
	  'It's okay.  Go ahead and take them if you need them so badly.'";
	now the blueprints are discussed;
	now the printed name of get-blueprints is "Get command module drawings
	  formerly known as blueprints".

[If the player tries "take whiteprints", it should behave the same as above,
when asking about "whiteprints".]
Instead of taking the whiteprints:
	try quizzing the engineer about the whiteprints.

Instead of taking the blueprints:
	if the blueprints are discussed:
		say "[The engineer] says, 'Here you go.'  He hands you a large
		  roll of white paper which is not even slightly blue.  You cram
		  the 3-foot roll of paper into your pocket, taking no care
		  whatsoever to keep it neat or undamaged.  [The engineer]
		  appears to be crying.";
		now the engineer is sad;
		now the player has the blueprints;
		now get-blueprints is checked;
	otherwise:
		say "Taken aback, [the engineer] says, 'Hold on, there!  You
		  don't know the first thing about these.'"

Persuasion rule for asking the engineer to try giving the blueprints to the
  player:
	persuasion succeeds.

Instead of the engineer giving the blueprints to the player:
	try taking the blueprints;
	rule succeeds.

Instead of quizzing the engineer about NASA:
	say "The engineer beams, 'I am [bold type]so[roman type] proud to serve
	  my country in the National Aeronautics and Space... um... anyway, I
	  design rockets.  NASA rockets.  It's the best.'"

Instead of quizzing the engineer about rocket:
	try quizzing the engineer about NASA.

[TODO: Ask the engineer about Apollo]

Instead of quizzing the engineer about the command module:
	say "[The noun] chuckles and grins broadly.  '[bold type]That[roman
	  type] is my pride and joy!  Officially, it's the 'Command and Service
	  Module', or 'CSM', a truncated cone, 10 feet and 7 inches tall (which
	  is about 1.814285 Buzz Aldrins tall), and 12 feet 10 inches across the
	  base (which is about 0.8675309 Florida gators).  Really, it's one of
	  the top... 30 truncated cones in engineering, at least!'"

Instead of talking to the engineer while the engineer is sad:
	say "He doesn't look like he wants to talk, though he might be convinced
	  to sing."

Asking it to sing is an action applying to one thing.  Understand "ask
[someone] to sing" and "convince [someone] to sing" as asking it to sing.

Check asking it to sing:
	say "[The noun] [one of]looks at you like you're crazy[or]looks
	  flattered, but politely declines[or]presents you with a contract
	  containing a long list of specific candies that must be present in
	  [their] dressing room[purely at random]."

Instead of asking the engineer to sing:
	say "'No!' [the noun] says.  'Why would you even ask me that?'"

Instead of quizzing the engineer about anything while the engineer is sad:
	say "He is too busy weeping."



[TODO: Rocket scientist, room, conversations, checklist item, and puzzle]
[TODO: Third person, room, conversations, checklist item, and puzzle]



Every turn when the remainder after dividing the turn count by 3 is 0 and
a checklist (called X) held by the player is complete:
	say "([X] is complete now.  You should report back to [the director] and
	  give him the checklist.)[line break]";



Day two is a scene.
Day two begins when checklist-1 is held by the director.
When day two begins:
	pause;
	say "[room-heading style]Intermission: End of day one[end style]";
	say line break;
	say "You head home, exhausted from a long day at the most important
	  agency (authority? association?) in America.  You collapse into a
	  dreamless sleep, and wake refreshed, ready for you next challenge.";
	pause;
	say "[room-heading style]NASA Headquarters, day 2 of your internship[end
	  style]";
	say line break;
	say "You return to NASA headquarters, brimming with pride over the good
	  work you've done so far.  What challenges await today?  You can hardly
	  contain your excitement as you wait to see the director again.";
	pause;
	now the player is in the waiting room;
	try looking.
[other resets should happen here, too, including topics and moods]
[TODO: transition to day two]



[TODO: day three (epilogue)]



[TODO: Consider Vorple Multimedia extension for background audio, with "music
on" and "music off" commands to let the player control it.]
[TODO: Consider adding cover art.]



[Test commands for speedy testing:]

Test checklist with "z / z / z / z / z / z / n / x checklist / take checklist /
give checklist to director / x checklist / i".

Test blueprints with "test checklist / e / e / ask about blueprints / ask about
whiteprints / x engineer / take blueprints / i / x checklist".

Test coffee with "test checklist / e / e / x coffee pot / take pot / i / take
coffee / i / put checklist in pot / i".

Test plaque with "test checklist / e / x plaque".

Test day2 with "test blueprints / w / w / give checklist to director".
