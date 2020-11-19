"MoonShot" by "Joey & Charity Parrish".


[Bibliographic Information]
The story genre is "Comedy".
The release number is 1.
The story description is "A NASA intern in the 1960s scrambles to make Apollo 11 a success."
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
Include Better Sitting by Joey Parrish.
Include Checklists by Joey Parrish.
Include Help by Joey Parrish.
Release along with a "Custom" website. [See MoonShot.materials/Templates/Custom]
Release along with the "Vorple" interpreter.
Release along with the style sheet "moonshot-custom-styles.css".
Release along with the file "Icon.png".
Release along with cover art ("An camera reflected in an astronaut's helmet").
[The text associated with the cover art is a description for the blind.]



[Styling]
blockquote is a Vorple style.
room-heading is a Vorple style.
room-name is a Vorple style.
direction-name is a Vorple style.
author-line is a Vorple style.
title-line is a Vorple style.
copyright-line is a Vorple style.
created-with-line is a Vorple style.
plaque-card is a Vorple style.
ending-card is a Vorple style.

This is the fancy room description heading rule:
	say "[room-heading style][bold type][Location][roman type][end style]".
The fancy room description heading rule substitutes for the room description heading rule.

Rule for printing the name of a room (called the place):
	say "[room-name style][printed name of place][end style]";

Rule for printing the name of a direction (called whither):
	say "[direction-name style][printed name of whither][end style]".

The print obituary headline rule is not listed in any rulebook.
To show ending (N - number):
	say paragraph break;
	[NOTE: ending-card is centered in CSS.  See CSS for an explanation.]
	say ending-card style;
	say "You have discovered ending #[N] of 2 after [turn count] turns!";
	say end style;
	end the story.



[Other tweaks]
After reading a command:
	Resolve punctuated titles.
[This is so that things like "examine Mr. Furtwangler" are understood.
Otherwise, the period ends the player's command command.]

[I don't like how Emily Short's "pause the game" rule clears the screen after continuing. Here's my own definition built on some of hers.]
To pause:
	if Vorple is not supported:
		[This is not needed on the HTML-based Vorple interpeter, and in fact, the "wait for SPACE" part fails miserably, hanging the game.]
		say "[paragraph break]Please press SPACE to continue[line break]";
		wait for the SPACE key;
	say line break;



[Intro]
This is the fancy banner rule:
	if Vorple is supported:
		[The HTML-based Vorple interpreter can handle centering a large block of text very well.]
		center "[blockquote style]'We choose to go to the moon in this decade... because that goal will serve to organize and measure the best of our energies and skills, because that challenge is one that we are willing to accept, one we are unwilling to postpone...'[line break][line break]-- U.S. President John Fitzgerald Kennedy[end style]";
	otherwise:
		[In other interpreters, it looks better broken up into explicit lines, with each one centered.]
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
	[Note that there is a requirement in the Inform license that we mention Inform somewhere, so we do so here.]
	if Vorple is supported:
		center "[blockquote style][title-line style][italic type]MoonShot[roman type][end style][line break][author-line style]Story by Joey & Charity Parrish[end style][line break][copyright-line style]Copyright (C) 2020[end style][line break][created-with-line style]Created with Inform 7[end style][end style]";
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
The fancy banner rule is listed before the start in the correct scenes rule in the startup rulebook.
[Subtle difference in timing: we want our intro shown first, not right before the initial room description where the typical banner rule goes.  This means that our intro happens before "when play begins", which is when our first scene begins.  It was really tricky to work out how to time this correctly.]

The detect interpreter's Vorple support rule is listed before the fancy banner rule in the startup rulebook.
[This would normally happen when play begins, but we need to detect Vorple support earlier for use in the fancy banner.]



[General]

The weather is a concept.  The weather is everywhere.
[We can talk about it or ask about it in any room.  But if you try to look at it...]
Instead of examining the weather, say "Hrm... why are there no windows in this building?"

[You can ask anyone about their name.  It's only polite.]
Name is a concept.  Name is everywhere.

NASA is a concept.  NASA is everywhere.
Understand "second a" and "second a in NASA" as NASA.

Apollo is a concept.  Apollo is everywhere.
[Handle variations, including misspellings that I myself (JCP) am prone to:]
Understand "Apollo", "Apollo 11", "Apollo 11 project", and "Apollo project" as Apollo.
Understand "Appollo", "Appollo 11", "Appollo 11 project", and "Appollo project" as Apollo.
Understand "Appolo", "Appolo 11", "Appolo 11 project", and "Appolo project" as Apollo.

The command module is a physical concept.  The command module is everywhere.
Understand "CSM" as the command module.

The rocket is a physical concept.  The rocket is everywhere.
Understand "rocket", "Saturn", "Saturn V", "Saturn V rocket", and "rockets" as the rocket.

Work is a concept.  Work is everywhere.


[The built-in default for asking someone about an unknown thing is "There is no reply."  We'd prefer a different default for topics we haven't coded explicitly.  Sadly, this has to be repeated for both the built-in "asking" (for arbitrary text) and for "quizzing" (for objects/people).]

Instead of quizzing someone (called person) about:
	say "'[one of]Oh, I don't know anything about that[or]Let's talk about something else[or]I'm not sure what to say about that[purely at random],' says [the person]."

[By default, only "sorry" triggers this action.]
Understand "say sorry" as saying sorry.

[By default, we don't get to see what people are carrying.  This changes that.]
After examining a person (called Bob):
	if Bob does not have nothing:
		say "[The Bob] is carrying [run paragraph on]";
		list the contents of Bob, as a sentence, giving inventory information;
		say "."

[By default, we don't seem to get a description of what rooms are adjacent to the current room, and in what direction.  This is something I'm used to seeing in IF, and I'd like to avoid writing it explicitly in every room.  Including the "Exit Lister" extension solves that.  But it needs a little configuration for this game.  We want to always tell the user what the names of nearby rooms are, even if we have not yet been to them.  For this, we use:]
A room memory rule:
	rule succeeds.

Things can be critical.
Instead of dropping something critical:
	say "No, you're going to need that."

[This seems unlikely to come up in practice, but now that we are creating "enterable" game objects such as chairs, I thought I'd throw this in.  You can get this by the phrases "enter" or "sit on".]
Instead of entering a person:
	say "[The noun] looks shocked that you should even try it!  [bold type][italic type]'SECURITY!'[roman type]  NASA security arrives shortly, hauls you carelessly to the building exit, and then tosses you into the street.  You have been fired for sexual harassment in 1969, in spite of the term not being coined until 1975.  But then, you always [italic type]did[roman type] consider yourself ahead of your time.";
	show ending 2.

[As if the above wasn't risque enough...]
Instead of entering yourself:
	let occupants be the list of people in the location;
	remove yourself from occupants;
	if occupants is empty:
		[At least the player is alone, but still...]
		say "Please don't.  This is a place of business.";
	otherwise:
		try entering entry 1 of occupants.  [Chain to the ending above for harassment.]



[---------- DAY 1 ----------]

Day one is a scene.
Day one begins when play begins.
When day one begins:
	say "[room-heading style]NASA Headquarters, 1969[end style]";
	say line break;
	say "You did it!  You finally landed an internship at NASA, the National Aeronautics and Space ... Association?  Agency?  Authority?  You're not really sure what the last A stands for, but it's only your first day.  You're pretty certain you'll figure it out soon enough.";
	pause;
	say "After a whirlwind tour of NASA headquarters, which you are sure you've already [italic type]completely[roman type] forgotten, you are ushered into the office of your new boss: the director of NASA's Apollo program.  You heard recently that we're ready to send [italic type]a man to the moon[roman type].  You can scarely believe it!  It's like something out of science fiction.  Nervously, you wait to be called into the inner office.";
	pause;
	say "[italic type](If you have never played interactive fiction before, you can type 'help' to get some basic instruction.)[roman type]";
	say line break.



The director's waiting room is a room.  "The tiny waiting room barely has enough room for you, [the secretary], and her desk.  [if the houseplant is in the waiting room]There's a houseplant in a pot, hanging from the ceiling in elaborately knotted macrame.  [end if][The secretary] is chewing bubblegum and sporadically blowing bubbles as large as her face that startle you when they pop."
The printed name of director's waiting room is "NASA Director's Waiting Room".

In the waiting room is a stranger called the secretary.  The real name of the secretary is "Donna".
Understand "Donna", "her", "herself", and "woman" as the secretary.  The secretary is female.
The secretary can be mad.  When day one begins, now the secretary is not mad.

The secretary's desk is scenery in the waiting room.  "A simple teak desk with a light stain, and unusually spartan."
The secretary's desk is an enterable supporter.  [You can put things on it or sit on it.]

The orange chair is a chair in the director's waiting room.
The description of the orange chair is "A simple office chair, with classy orange upholstery.  Not too comfy, though."

The houseplant is in the waiting room.  Understand "plant" as the houseplant.
The houseplant is undescribed.  [We already talked about it in the room description, so don't list it again.]

Instead of dropping the houseplant:
	say "You carefully hang the houseplant from the ceiling again, eliciting strange looks from [the secretary].";
	now the houseplant is in the waiting room;
	now the houseplant is undescribed.  [Don't mention it again as in the room.  The room description covers it.]

The houseplant is edible.
Instead of eating the houseplant:
	say "It tastes terrible, and your stomach quickly begins to cramp.  Before long, you're unable to walk.  You die on the way to the emergency room, Apollo 11 fails miserably, and NASA becomes a worldwide laughing stock.  Russia conquers the globe by 1972.  Your tombstone reads 'Intern.'";
	show ending 1.

A phone is on the secretary's desk.  The description of the phone is "A black rotary telephone.  It looks brand new."

Instead of taking the phone:
	say "[The secretary] stands up quickly and snatches it back from you.  'What is the matter with you?' she yells.  It takes her a minute or so to get the phone plugged back in.";
	now the secretary is mad.

Instead of saying sorry while the player is in the waiting room:
	if the secretary is mad:
		say "She doesn't look ready to forgive you.";
	otherwise:
		say "What is there to apologize for?"

The description of the secretary is "[if the secretary is mad]She glares at you and says 'Keep your eyes to yourself, you nut job.'[otherwise][The noun] is a youngish woman, possibly in her 30s, with a beehive haircut and horn-rimmed glasses.  She notices you looking and smiles."

Instead of talking to the secretary:
	say "Perhaps you could ask [the noun] about the weather, NASA, the Apollo 11 project, or her name."

Instead of quizzing the secretary about name:
	say "'It's Donna,' she says.  'Nice to meet you!'";
	now the secretary is known.

Instead of quizzing the secretary about the secretary:
	try quizzing the secretary about name.

Instead of quizzing the secretary about the weather:
	say "'Oh, it's lovely this time of year, don't you think?'"

Instead of quizzing the secretary about NASA:
	say "'I love working here at the National Aerospace and Space Anonymous.  I feel like I've really worked through so many of my issues about space and aeronautics since starting my job.'"

Instead of quizzing the secretary about Apollo:
	say "'Between you and me, the director really needs a win on this one.  Apollo 10 was a disaster.  His eyebrows still haven't grown back.  He's a little gunshy now and the word around the watercooler is, he's been a nervous wreck ever since.'"

Instead of talking to the secretary while the secretary is mad:
	say "She doesn't look like she wants to talk to you."

Instead of quizzing the secretary about anything while the secretary is mad:
	say "She harrumphs at you and continues to scowl."


When day one begins:
	secretary warns in 0 turns from now;
	director yells in 5 turns from now.

Yourself can be told-to-wait.
At the time when secretary warns:
	if yourself has not been told-to-wait:
		say "[The secretary] catches your attention and says, 'The director will be with you shortly.  Please make yourself comfortable while you wait.'";
	now yourself is told-to-wait.

Before waiting in the waiting room:
	say "[one of]You sit awkwardly, wondering when this whole thing is supposed to get started.[or]Maybe there's something you can do, or something you should be talking about while you wait?[or]The waiting is the hardest part, isn't it?[purely at random]".

At the time when director yells:
	say "A booming voice comes from the director's office: 'Donna!  Where the hell is that kid?  They're late!'";
	say "[The secretary] looks embarrassed and says quietly, 'You'd better go on in.  He [italic type]hates[roman type] tardiness.'";
	now the director is ready.

Instead of quizzing the secretary about the director:
	say "'Oh, Mr. Furtwangler is a visionary!' she says.  'He is completely on top of every aspect of this project.  I don't know how he does it!'"

Instead of going to the director's office while the director is not ready:
	say "[The secretary] jumps up and runs for the door, stopping you in your tracks.  'You can't go in there!  Just wait, please, and the director will be with you as soon as he is ready.'";
	if yourself is told-to-wait:
		[If the player has been told at least once before, they are
		perhaps having trouble with this waiting thing, so offer a
		hint.]
		say "[line break](Hint: You can explore the room, talk to [the secretary], examine things, or just type 'wait' to wait patiently.)";
	now yourself is told-to-wait.

[In this language "in/inside" is actually a direction you could use to relate places to one another.  But in context of this room, we'd like "go in" to send you into the director's office.]
Instead of going inside while in the waiting room:
	try going north.



The director's office is north of the waiting room.  "The director's office has a full wall of windows overlooking the hangar.  [The director] is drumming his fingers on the desk and humming 'California Dreamin' in double time.  He's wearing a baby blue collared short sleeve shirt and about 8 oz of hair pomade." The printed name of the director's office is "NASA Director's Office".

[Since this is the only room with windows...]
Instead of examining the weather in the director's office:
	say "You glance out the windows, but you can't see much other than the hangar."

In the director's office is a stranger called the director.  The real name of the director is "Mr. Furtwangler".  The director is male.

Understand "director", "dirk", "mr furtwangler", "mister furtwangler", "furtwangler", "boss", "him", "himself", and "man" as the director.

The director can be agitated or relaxed.  When day one begins, now the director is agitated.

The director can be ready.  When day one begins, now the director is not ready.

The director's desk is scenery in the director's office.  "An expansive desk covered in whirring desk gadgets that roll chrome metal balls back and forth endlessly on balanced tracks, and bobblehead dolls."
The director's desk is an enterable supporter.  [You can put things on it or sit on it.]

The wooden armchair is a chair in the director's office.
The description of the wooden armchair is "A comfy-looking wooden armchair, with dark, mulberry-colored upholstery."

There is a checklist on the director's desk called checklist-1.
The printed name of checklist-1 is "Apollo 11 checklist".
The description of checklist-1 is "The checklist is [if checklist-1 is on the director's desk]laying on the desk, [end if]scribbled out in childish print."
Checklist-1 can be ready.  When day one begins, now checklist-1 is not ready.

The description of the director is "[if the director is relaxed]He gazes dreamily out the window and asks, 'Do you think Johnny Cash is his real name?'[otherwise][The noun] is a man in his 60s with a hawkish nose and an absent air, like a man who can't seem to remember why he's here.  He's holding a comically large cup of coffee in one hand and the other keeps pawing through the jumble of knick knacks on his desk, like he's lost something."

Instead of talking to the director:
	say "Perhaps you could ask [the director] about the internship, what the second A in NASA stands for, the Apollo 11 project, or his name."

Instead of quizzing the director about name:
	try quizzing the director about the director.

Instead of quizzing the director about the director:
	say "'Furtwangler.  Dirk Furtwangler.  Boy am I glad you're here!'";
	now the director is known.

The internship is a concept.  The internship is everywhere.
Instead of taking the internship:
	say "(You've already been hired.)"

Instead of quizzing the director about the internship:
	say "'Well you know how these things are.  We're terribly busy here at NASA.  Just an unreasonable amount of space out there.  Downright oppressive, when you start to think about how much of it there is!  So much space to analyze....' His voice trails off into a troubled hum until he notices you looking at him.  He continues, 'Which is exactly why we need you, the intern, to take care of this whole messy Apollo 11 business.'  He indicates the checklist on his desk.  'Get started, kid!'";
	now checklist-1 is ready.

Instead of quizzing the director about NASA:
	say "The director looks surprised by your question.  'NASA?  Well, of course, everyone knows about the National Aeronautics and Space...  uhh... It's about space.  That's the important bit.  [bold type]LOTS[roman type] of space out there.'"

Instead of quizzing the director about anybody:
	say "He stares blankly for a second, then says, 'Who?'"

Instead of quizzing the director about Apollo:
	say "'I'm definitely not scared of getting started.  Definitely not.  There's no reason that Apollo 11 won't be a raging success.  No reason whatsoever.'  He looks very uncertain and his hands are quivering as he speaks."

Instead of quizzing the director about checklist-1:
	say "'Oh, I'm glad you asked about that,' he says.  'This is a detailed and highly technical checklist of the things I need you to do today.  Now, I wrote this myself, so please don't hesitate to ask me if you need help with any of these things'.";
	now checklist-1 is ready.

[TODO: If you ask him about any of the checklist items, should he direct you to the right rooms?  Or should we have a gag here instead?]

[Keep the player from leaving without the checklist.]
Instead of going from the director's office during day one:
	if checklist-1 is carried by the player:
		continue the activity;
	otherwise if checklist-1 is not ready:
		try taking checklist-1;  [So that the director will ask you to stop and talk first.]
	otherwise:
		say "'Hang on!' says [the director].  'You're gonna need this!'.  He indicates the checklist[if a checklist is on the director's desk] laying on his desk[end if].  'Get all of that done, ASAP.'"

[Keep the player from taking the checklist until you've talked to the director first.]
Instead of taking checklist-1:
	if checklist-1 is ready:
		say "[The director] looks relieved and drawls, 'Oh, thank you, wasn't sure how I was gonna get all that done!'  (Hint: You can examine the checklist to see the details)[line break]";
		now the director is relaxed;
		continue the action;
	else:
		say "'Not so fast!' says [the director].  'We need to talk first.'  (Hint: You can 'talk to director' for suggestions on topics.)"

Instead of giving a checklist (called proof of your good work) to the director:
	if proof of your good work is not complete:
		say "'Whoa,' says [the director], 'what is this?  You've still got work to do, kid!  Get back out there, and don't come back until it's all done!'";
	otherwise:
		say "[The director] scrutinzes the list, then smiles at you and drawls, 'Good job, kid.  Come back tomorrow for your next assignment!'";
		now the director has proof of your good work.



Checklist-1 is critical.  [You can't drop it.]
Get-blueprints is a checklist-item.  The printed name of get-blueprints is "Get command module blueprints".
Get-equations is a checklist-item.  The printed name of get-equations is "Get rocket equations".
Choose-crew is a checklist-item.  The printed name of choose-crew is "Choose astro nots (sp?)".
TBD is a thing.  The printed name of TBD is "__________".
The sub-items of choose-crew are {TBD, TBD, TBD}.
The items of checklist-1 are {get-blueprints, get-equations, choose-crew}.



The Main Hallway is east of the director's office.  "A long, blank hallway, with several doors branching off in various directions.  A bronze plaque is hanging on the wall in the center of the hallway."

A bronze plaque is scenery in the hallway.

Instead of examining the plaque:
	say "Engraved in bronze, the plaque says:[line break]";
	if Vorple is supported:
		center "[plaque-card style][bold type]Apollo[roman type][line break]Never give up, never surrender![end style]";
	otherwise:
		center "[bold type]Apollo[roman type]";
		center "Never give up, never surrender!"



The engineering department is east of the hallway.  "It's filled with grey upholstered cubicles and smells like pencil shavings and burned coffee.  At the end of the room is a large whiteboard, at the top of which is written APOLLO 11.  Underneath the heading are some inscrutable equations, and in the bottom right corner, someone has drawn a unicorn."
The printed name of the engineering department is "NASA Engineering Department".

In the engineering department is a stranger called the engineer.  The real name of the engineer is "Rick".  The engineer can be sad.  When day one begins, now the engineer is not sad.  The engineer is male.

The engineer is carrying the blueprints.  The description of the blueprints is "The blueprints, which are distinctly white, say '[bold type]Apollo 11 Command Module[roman type]' on the top.  [if the player has the blueprints]They are looking a little worse for wear, to say the least.[otherwise]The drawing of the command module is surprisingly lifelike.  You've never seen a more beautiful rendering of a truncated cone."

The blueprints can be discussed.  [Only when you've asked about them can you take them.]
The blueprints are critical.  [You can't drop them.]
The blueprints are plural-named.  [Don't call them "a blueprints".]

In the engineering department is a container called a coffee-pot.  The printed name of coffee-pot is "coffee pot".
[Accept a few misspellings of coffee.]
Understand "coffee pot", "cofee pot", "coffe pot", "cafe pot", "cofe pot", and "pot" as the coffee-pot.

The coffee is a drink.  The coffee is in the coffee-pot.  The amount of coffee is 1000 ml.  The indefinite article is "some".
[Accept a few misspellings of coffee.]
Understand "cofee", "coffe", "cafe", and "cofe" as coffee.

The description of the engineer is "[if the engineer is not sad]He is tall and thin, with slicked-back ginger hair and a short-sleeved shirt and tie.  He is wearing a pocket protector and a name badge.  What a nerd![otherwise][The noun] is just about the saddest thing you've ever seen.  His hair is a mess, and he appears to have been wiping his tears on his tie."

Instead of saying sorry while the player is in the engineering department:
	if the engineer is sad:
		say "He sniffs a little, then says 'Um, yeah, okay.  Apology accepted.'";
		now the engineer is not sad;
	otherwise:
		say "What is there to apologize for?"

Understand "ginger", "nerd", "man", "him", "himself", and "Rick" as the engineer.

The engineer is wearing a name-badge.  The printed name of the name-badge is "name badge".
Understand "badge" and "name badge" as name-badge.  [To disambiguate with the "name" concept.]

The description of the name-badge is "It says 'Rick' at the top.  The bottom says 'Apollo Systems Technician, Launch Enablement Yroup.'  ... Huh.  Must be a typo."

After examining the name-badge, now the engineer is known.

Rule for writing a paragraph about the engineer:
	if the engineer is unknown, say "An engineer is standing around by the coffee pot, [if the engineer is sad]crying.[otherwise]doing nothing.";
	otherwise say "Rick is still here, still [if the engineer is sad]crying.[otherwise]doing nothing.";

Instead of talking to the engineer:
	say "Perhaps you could ask [the noun] about the weather, the command module blueprints, or himself."

Instead of quizzing the engineer about name:
	say "The engineer taps his name badge and says, 'Can't you read?'"

Instead of quizzing the engineer about the weather:
	say "[The noun] glances up at the ceiling for a moment before replying, 'Maybe a bit cloudy, but we should still be clear for launch.  Besides, we're never gonna give this up.'"

Instead of quizzing the engineer about the engineer:
	say "[The noun] looks a bit embarrassed by the question, maybe even flattered.  He looks at his feet for a moment before replying, 'Well...  We're no strangers to love.'  Then he raises his eyes and gives you a look that makes you... distinctly uncomfortable."

Instead of quizzing the engineer about the blueprints:
	say "[The noun] looks both smug and offended at once.  '[bold type]ACTUALLY[roman type], they aren't blue at all!  The cyanotype [italic type]blueprint[roman type] began to be supplanted by [italic type]diazo prints[roman type], also known as [italic type]whiteprints[roman type].'";
	now the printed name of get-blueprints is "Get command module whiteprints".

The whiteprints is a concept in the engineering department.
Instead of quizzing the engineer about the whiteprints:
	say "[The noun] rolls his eyes.  'Ha!  Nobody calls them whiteprints.' His laughter quickly devolves into snorts.  Wiping his eyes, he adds, 'It's okay.  Go ahead and take them if you need them so badly.'";
	now the blueprints are discussed;
	now the printed name of get-blueprints is "Get command module drawings formerly known as blueprints".

[If the player tries "take whiteprints", it should behave the same as above, when asking about "whiteprints".]
Instead of taking the whiteprints:
	try quizzing the engineer about the whiteprints.

Instead of taking the blueprints:
	if the blueprints are discussed:
		say "[The engineer] says, 'Here you go.'  He hands you a large roll of white paper which is not even slightly blue.  You cram the 3-foot roll of paper into your pocket, taking no care whatsoever to keep it neat or undamaged.  [The engineer] appears to be crying.";
		now the engineer is sad;
		now get-blueprints is checked;
		continue the action;
	otherwise:
		say "Taken aback, [the engineer] says, 'Hold on, there!  You don't know the first thing about these.'"

Persuasion rule for asking the engineer to try giving the blueprints to the player:
	persuasion succeeds.

Instead of the engineer giving the blueprints to the player:
	try taking the blueprints;
	rule succeeds.

Instead of quizzing the engineer about NASA:
	say "The engineer beams, 'I am [bold type]so[roman type] proud to serve my country in the National Aeronautics and Space... um... anyway, I design rockets.  NASA rockets.  Big, blasting, noisy hard rockets!  It's the best.'"

Instead of quizzing the engineer about rocket:
	try quizzing the engineer about NASA.

Instead of quizzing the engineer about the command module:
	say "[The noun] chuckles and grins broadly.  '[bold type]That[roman type] is my pride and joy!  Officially, it's the 'Command and Service Module', or 'CSM', a truncated cone, 10 feet and 7 inches tall (which is about 1.814285 Buzz Aldrins tall), and 12 feet 10 inches across the base (which is about 0.8675309 Florida gators).  Really, it's one of the top... 30 truncated cones in engineering, at least!'"

Instead of quizzing the engineer about Apollo:
	say "[The noun] shudders and says, 'Gotta get this one right. How was I supposed to know that the sulphurous smell of the rocket fuel would cause the astronauts to vomit nonstop for the whole flight?  Commander Stafford needed three liters of fluids when he got back.  He still hasn't forgive me.  Said they never could get the smell out of his favorite spacesuit.' [The noun] hangs his head, but then brightens and says, 'Apollo 11's gonna be different!'"

Instead of talking to the engineer while the engineer is sad:
	say "He doesn't look like he wants to talk, though he might be convinced to sing."

Asking it to sing is an action applying to one thing.
Understand "ask [someone] to sing" and "convince [someone] to sing" as asking it to sing.

Check asking it to sing:
	say "[The noun] [one of]looks at you like you're crazy[or]looks flattered, but politely declines[or]presents you with a contract containing a long list of specific candies that must be present in [their] dressing room[purely at random]."

Instead of asking the engineer to sing:
	say "'No!' [the noun] says.  'Why would you even ask me that?'"

Instead of quizzing the engineer about anything while the engineer is sad:
	say "He is too busy weeping."



[TODO: Write the propulsion lab description.]
The propulsion lab is north of the hallway.  "Another room?!"
The printed name of the propulsion lab is "NASA Propulsion Lab".

In the propulsion lab is a stranger called the head scientist.
The real name of the head scientist is "Dr. von Braun".
The head scientist is male.

[This guy has way too many names.  Give players a fair amount of latitude.]
Understand "doctor", "dr", "dr von braun", "von braun", "braun", "doktor", "herr doktor", "Herr Doktor Wernher Magnus Maximilian Freiherr von Braun", "Wernher", "Magnus", "Maximilian", "Freiherr", "Wernher von Braun", "Werner", "Werner von Braun", "head", "the scientist", "head scientist", "rocket scientist", "him", "man", and "himself" as the head scientist.

The head scientist can be enraged.

Rule for writing a paragraph about the head scientist:
	if the head scientist is enraged:
		say "[The head scientist] huffs about the room, scribbling on chalk boards, sparing you only the occasional angry glance.";
	otherwise:
		say "[The head scientist] moves smoothly through the room from one chalk board to another, making minor changes to complex equations.  He does not seem to notice you."

The description of the head scientist is "[The noun] is a man of average height, his hair graying at the sides, wearing a white lab coat over a dark gray suit and tie.[if the head scientist is enraged]  His anger toward [italic type]you specifically[roman type] is practically a physical presence of its own, hanging about his temples like a fog."

Instead of talking to the head scientist:
	if the head scientist is enraged:
		say "You open your mouth to speak to [the noun], but he shoots you a rageful glare of such silent violence that you think better of it and shut your mouth again.";
	otherwise:
		say "Perhaps you could ask [the noun] about the equations, his work, or himself."

Instead of quizzing the head scientist about name:
	say "He stops what is doing and considers you as if noticing you for the first time.  'Herr Doktor Wernher Magnus Maximilian Freiherr von Braun, chief scientist of the NASA propulsion lab.'  Then, without making it a true question and without any apparent interest in the answer, adds, 'How do you do.'";
	now the head scientist is known.

Instead of quizzing the head scientist about the head scientist:
	try quizzing the head scientist about name.

Instead of quizzing the head scientist about NASA:
	say "He considers thoughtfully before replying, 'It's a job.'"

Instead of quizzing the head scientist about rocket:
	say "'Well,' he begins, looking quietly pleased with himself, 'My rockets are simply the best.  As you can plainly see, even enemies of the Reich were forced to acknowledge the greatness of my work.'  He turns to consider the chalk boards behind him and adds dreamily, 'I have spent years perfecting this new one...'"

Instead of quizzing the head scientist about work:
	try quizzing the head scientist about rocket.

Equations is a concept in the propulsion lab.
Instead of quizzing the head scientist about equations:
	say "'What about them?' he snaps.  'I'm very busy.'  [The noun] turns back to his work."

Rocket-equations is a concept in the propulsion lab.
Understand "rocket equations" as rocket-equations.  [If I give the object its natural name instead of using "understand", then "equations" results in a disambiguation prompt between "equations" and "rocket equations", which is confusing.]
Instead of quizzing the head scientist about rocket-equations:
	say "He turns to you very suddenly.  '[italic type]Rocket equations?[roman type]  You sound ridiculous!  What buffoon would say such a thing?  [bold type]Stop wasting my time![roman type]'[line break]";
	now the head scientist is enraged.

[TODO: talk about Apollo]

[TODO: chalk boards]
[TODO: persuasion and taking rules for equations / chalk board]
[TODO: hints on rocket equations?]

Instead of quizzing the head scientist about anything while the head scientist is enraged:
	say "[The noun] throws an eraser at you and screams [bold type]'GET OUT!'[roman type]"

[TODO: apologizing]


In the propulsion lab is a person called the other scientists.
The other scientists are plural-named.
Understand "others", and "them" as the other scientists.

[NOTE: Something really odd is happening, and the only people who understand Inform in enough detail to debug this are Graham Nelson and gray aliens.  For whatever reason, "other scientists", which is the _EXACT NAME_ of the character, resolves to "the head scientist", which is _MADDENING_.  This is a hacky workaround, in which we just edit the user's commands as they come in and replace the thing that _should_ work with an explicit alias that _does_ work.]
After reading a command:
	let N be "[the player's command]";
		replace the regular expression "\bother scientists\b" in N with "the others";
		change the text of the player's command to N.

Instead of quizzing the other scientists about anything:
	try talking to the other scientists.

Instead of talking to the other scientists:
	say "They all look incredibly busy and smart in those white lab coats.  You can't seem to get their attention."

[TODO: talking to other scientists]



[TODO: Third person, room, conversations, checklist item, and puzzle]



Every turn when the remainder after dividing the turn count by 3 is 0 and a checklist (called X) held by the player is complete:
	say "([X] is complete now.  You should report back to [the director] and give him the checklist.)[line break]";



[---------- DAY 2 ----------]

Day two is a scene.
Day two begins when checklist-1 is held by the director.
When day two begins:
	pause;
	say "[room-heading style]Intermission: End of day one[end style]";
	say line break;
	say "You head home, exhausted from a long day at the most important agency (authority? association?) in America.  You collapse into a dreamless sleep, and wake refreshed, ready for you next challenge.";
	pause;
	say "[room-heading style]NASA Headquarters, day two of your internship[end style]";
	say line break;
	say "You return to NASA headquarters, brimming with pride over the good work you've done so far.  What challenges await today?  You can hardly contain your excitement as you wait to see the director again.";
	pause;
	now the player is in the waiting room.
[other resets should happen here, too, including topics and moods]
[TODO: transition to day two]



[---------- DAY 3 ----------]

[TODO: day three (epilogue)]



[TODO: Consider Vorple Multimedia extension for background audio, with "music on" and "music off" commands to let the player control it.]



[Test commands for speedy testing:]

Test plant with "l / take plant / l / drop plant / l / eat plant".

Test checklist with "z / z / z / z / z / z / n / x checklist / take checklist / talk to director / ask director about internship / take checklist / give checklist to director / x checklist / i".

Test blueprints with "test checklist / e / e / ask about blueprints / ask about whiteprints / x engineer / take blueprints / i / x checklist".

Test coffee with "test checklist / e / e / x coffee pot / take pot / i / take coffee / i / put checklist in pot / i".

Test plaque with "test checklist / e / x plaque".

Test equations with "test checklist / e / n / ask about name / ask about work / ask about equations / ask about rocket equations / ask about rockets".

Test others with "test checklist / e/ n / talk to other scientists / talk to scientists / talk to others / talk to them / talk to scientist / talk to him / talk to head / talk to head scientist / talk to rocket scientist / talk to doctor".

Test day2 with "test blueprints / w / w / give checklist to director".
