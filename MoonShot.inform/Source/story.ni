"MoonShot" by "Joey & Charity Parrish".


[Bibliographic Information]
The story genre is "Comedy".
The release number is 1.
The story description is "A NASA intern in the 1960s scrambles to make Apollo 11 a success."
The story creation year is 2020.



[
===== ===== ===== Before reading further ... ===== ===== =====

If you intend to play through the game,
please do so before you read the source code, to avoid spoilers.

===== ===== ===== Thanks for your attention! ===== ===== =====
]



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
Release along with the file "KBKinderWrite.woff".
Release along with the file "KBKinderWrite.woff2".
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
hint is a Vorple style.
plaque-card is a Vorple style.
ending-card is a Vorple style.
personnel-file is a Vorple style.
nameplate-card is a Vorple style.
interesting-highlight is a Vorple style.

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
	say "You have discovered ending #[N] of 3 after [turn count] turns!";
	say end style;
	end the story.

Difficulty is a kind of value.  The difficulties are easy, medium, and hard.
A difficulty has a number called numeric value.
The numeric value of easy is 1.
The numeric value of medium is 2.
The numeric value of hard is 3.
Difficulty mode is a difficulty that varies.  Difficulty mode is initially medium.

Setting difficulty mode to is an action out of world applying to one difficulty.
Understand "[difficulty] mode" and "set [difficulty] mode" as setting difficulty mode to.
Check setting difficulty mode to a difficulty (called X):
	say "The game is now set to [X] mode.";
	say " - Interesting objects will [if the numeric value of X > 1]not [end if]be [interesting-highlight style]highlighted[end style] (web version only).";
	say " - Hints will [if the numeric value of X > 2]not [end if]be provided.";
	now difficulty mode is X;

To show hint (T - text):
	if the numeric value of difficulty mode <= 2:
		say italic type;
		say hint style;
		say "(Hint: [T])[line break]";
		say end style;
		say roman type;

To say interesting:
	if the numeric value of difficulty mode <= 1:
		say interesting-highlight style.
To say /interesting:
	if the numeric value of difficulty mode <= 1:
		say end style.

Before printing the name of a thing (called the thingy):
	if the thingy is not a person and the thingy is not TBD:
		say interesting.
After printing the name of a thing (called the thingy):
	if the thingy is not a person and the thingy is not TBD:
		say /interesting.




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

The weather is a concept.
[We can talk about it or ask about it in any room.  But if you try to look at it...]
Instead of examining the weather, say "Hrm... why are there no windows in this building?"

[You can ask anyone about their name.  It's only polite.]
Name is a concept.

NASA is a concept.
Understand "second a" and "second a in NASA" as NASA.

Apollo is a concept.
[Handle variations, including misspellings that I myself (JCP) am prone to:]
Understand "Apollo", "Apollo 11", "Apollo 11 project", and "Apollo project" as Apollo.
Understand "Appollo", "Appollo 11", "Appollo 11 project", and "Appollo project" as Apollo.
Understand "Appolo", "Appolo 11", "Appolo 11 project", and "Appolo project" as Apollo.

The command module is a physical concept.
Understand "CSM" as the command module.

The rocket is a physical concept.
Understand "rocket", "Saturn", "Saturn V", "Saturn V rocket", and "rockets" as the rocket.

Work is a concept.

The crew is a concept.
Understand "candidates", "crew candidates", and "choosing the crew" as the crew.
[We'd like Inform to understand "astronauts" as "crew", but instead, it asks the player which astronaut they mean.  This pre-emptive manipulation of the command text is the only workaround I can find. -JCP]
After reading a command:
	let N be "[the player's command]";
		replace the regular expression "\bastronauts\b" in N with "crew";
		change the text of the player's command to N.

Equations is a concept.
Rocket-equations is a concept.
Understand "rocket equations" as rocket-equations.  [If I give the object its natural name instead of using "understand", then "equations" results in a disambiguation prompt between "equations" and "rocket equations", which is confusing.]

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

A person can be asleep.
Understand "wake [someone]" and "wake [someone] up" and "wake up [someone]" as waking.
The block waking rule is not listed in any rulebook.  [Override the built-in rule, which is not useful.]
Carry out waking:
	if the noun is not asleep:
		say "[The noun] appears to be awake already.";
		stop the action;
	else:
		[Don't print anything in particular.  Add specific rules for specific people to describe the act.]
		now the noun is not asleep;




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
	show hint "If you have never played interactive fiction before, you can type 'help' to get some basic instruction.";
	say line break.

[TODO: add an "options" hint at the beginning, where "options" explains brief and verbose room descriptions, and explains custom commands for easy, medium, and hard mode]


The director's waiting room is a room.  "The tiny waiting room barely has enough room for you, [the secretary], and her [interesting]desk[/interesting].  [if the houseplant is in the waiting room]There's a [houseplant] in a pot, hanging from the ceiling in elaborately knotted macrame.  [end if][The secretary] is chewing bubblegum and sporadically blowing bubbles as large as her face that startle you when they pop."
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
	say "You carefully hang the [houseplant] from the ceiling again, eliciting strange looks from [the secretary].";
	now the houseplant is in the waiting room;
	now the houseplant is undescribed.  [Don't mention it again as in the room.  The room description covers it.]

The houseplant is edible.
Instead of eating the houseplant:
	say "It tastes terrible, and your stomach quickly begins to cramp.  Before long, you're unable to walk.  You die on the way to the emergency room, Apollo 11 fails miserably, and NASA becomes a worldwide laughing-stock.  Russia conquers the globe by 1972.  Your tombstone in Arlington National Cemetery reads 'Intern.'";
	show ending 1.

A phone is on the secretary's desk.  The description of the phone is "A black rotary telephone.  It looks brand new."
Understand "telephone" as the phone.

Instead of taking the phone:
	say "[The secretary] stands up quickly and snatches it back from you.  'What is the matter with you?' she yells.  It takes her a minute or so to get the [phone] plugged back in.";
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
	director yells-1 in 4 turns from now.

Yourself can be told-to-wait.
At the time when secretary warns:
	if yourself has not been told-to-wait:
		say "[The secretary] catches your attention and says, 'The director will be with you shortly.  Please make yourself comfortable while you wait.'";
	now yourself is told-to-wait.

Before waiting in the waiting room:
	say "[one of]You sit awkwardly, wondering when this whole thing is supposed to get started.[or]Maybe there's something you can do, or something you should be talking about while you wait?[or]The waiting is the hardest part, isn't it?[purely at random]".

At the time when director yells-1:
	say "A booming voice comes from the director's office: 'Donna!  Where the hell is that kid?  They're late!'[paragraph break][The secretary] looks embarrassed and says quietly, 'You'd better go on in.  He [italic type]hates[roman type] tardiness.'";
	now the director is ready.

Instead of quizzing the secretary about the director:
	say "'Oh, Mr. Furtwangler is a visionary!' she says.  'He is completely on top of every aspect of this project.  I don't know how he does it!'";
	now the director is known.

Instead of going to the director's office while the director is not ready:
	say "[The secretary] jumps up and runs for the door, stopping you in your tracks.  'You can't go in there!  Just wait, please, and the director will be with you as soon as he is ready.'";
	if yourself is told-to-wait:
		[If the player has been told at least once before, they are perhaps having trouble with this waiting thing, so offer a hint.]
		say line break;
		show hint "You can explore the room, talk to [the secretary], examine things, or just type 'wait' to wait patiently.";
	now yourself is told-to-wait.

[In this language "in/inside" is actually a direction you could use to relate places to one another.  But in context of this room, we'd like "go in" to send you into the director's office.]
Instead of going inside while in the waiting room:
	try going north.



The director's office is north of the waiting room.  "The director's office has a full wall of [interesting]windows[/interesting] overlooking the hangar.  [The director] is drumming his fingers on the [interesting]desk[/interesting] and humming 'California Dreamin' in double time.  He's wearing a baby blue collared short sleeve shirt and about 8 oz of hair pomade.[if the triangular nameplate is on the director's desk]  On his desk is a small, triangular [interesting]nameplate[/interesting].[end if]".
The printed name of the director's office is "NASA Director's Office".

[Since this is the only room with windows...]
Instead of examining the weather in the director's office:
	say "You glance out the windows, but you can't see much other than the hangar."
The windows are scenery in the director's office.
Instead of examining the windows, try examining the weather.

In the director's office is a stranger called the director.  The real name of the director is "Mr. Furtwangler".  The director is male.

Understand "director", "dirk", "mr furtwangler", "mister furtwangler", "furtwangler", "boss", "him", "himself", and "man" as the director.

The director can be agitated or relaxed.  When day one begins, now the director is agitated.

The director can be ready.  When day one begins, now the director is not ready.

The director's desk is scenery in the director's office.  "An expansive desk covered in whirring desk gadgets that roll chrome metal balls back and forth endlessly on balanced tracks, as well as several bobblehead dolls.[if the triangular nameplate is on the director's desk]  On the desk is a small, triangular [interesting]nameplate[/interesting].[end if]".
The director's desk is an enterable supporter.  [You can put things on it or sit on it.]

The triangular nameplate is an openable, closed, undescribed thing on the director's desk.
Instead of examining the triangular nameplate:
	say "A small, wooden, triangular prism with an engraved metal plate attached that reads:[line break]";
	if Vorple is supported:
		center "[nameplate-card style][bold type]Dirk Furtwangler[roman type][line break]Director[end style]";
	otherwise:
		center "[bold type]Dirk Furtwangler[roman type]";
		center "Director";
	now the director is known;
	if the player has the triangular nameplate:
		if a random chance of 1 in 10 succeeds:
			say "The nameplate rattles a bit as you turn it."

Rule for printing the name of the triangular nameplate:
	say "triangular nameplate";
	omit contents in listing.  [So that we don't give away the secret that it can be opened.]

After taking the triangular nameplate:
	now the triangular nameplate is described;
	continue the action.

After putting the triangular nameplate on the director's desk:
	now the triangular nameplate is undescribed;  [It goes back to being described in the room and desk descriptions, so don't duplicate it in the room's contents.]
	continue the action.

A toblerone is an edible thing inside the triangular nameplate.
Understand "candy" and "box" and "candy box" as the toblerone.
The description of the toblerone is "It's a pale yellow, triangular box that says 'TOBLERONE', 'THE FIRST PATENTED SWISS MILK CHOCOLATE [italic type]with[roman type] ALMONDS & HONEY'.".
After opening the triangular nameplate:
	if the toblerone is in the triangular nameplate:
		say "You open a small, concealed hatch on one side of the nameplate, and a pale yellow, triangular [interesting]candy box[/interesting] falls out.";
		now the toblerone is in the location;
	otherwise:
		say "You open a small, concealed hatch on one side of the nameplate."

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
	say "'Well you know how these things are.  We're terribly busy here at NASA.  Just an unreasonable amount of space out there.  Downright oppressive, when you start to think about how much of it there is!  So much space to analyze....' His voice trails off into a troubled hum until he notices you looking at him.  He continues, 'Which is exactly why we need you, the intern, to take care of this whole messy Apollo 11 business.'  He indicates the [interesting]checklist[/interesting] on his desk.  'Get started, kid!'";
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

Instead of quizzing the director about crew:
	say "[The director] beams proudly.  'Fine folks, those astronauts.  Finest, best, most American astronauts that America ever produced.'  His brow furrows for a moment before adding, [if day one is happening]'Well, most of [']em.  Anyway, you can get all the particulars down in personnel.'[otherwise]'Well, most of [']em.  I shouldn't get into it.'[end if][line break]".

Instead of quizzing the director about blueprints:
	say "[The director] starts shaking his head before you even finish asking.  'No, no, not my department.  Go down to engineering, talk to that what's-his-name.  The one who's too cool for school.'";

Instead of quizzing the director about rocket-equations:
	say "'Uh, yeah.  Of course I know about those,' he says with a scared look on his face.  'But you go ask the eggheads in the lab about that.  They like to show off.'";
Instead of quizzing the director about equations:
	try quizzing the director about rocket-equations.

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
		say "[The director] looks relieved and drawls, 'Oh, thank you, wasn't sure how I was gonna get all that done!'";
		show hint "You can examine the [interesting]checklist[/interesting] to see the details.";
		now the director is relaxed;
		continue the action;
	else:
		say "'Not so fast!' says [the director].  'We need to talk first.'";
		show hint "You can 'talk to director' for suggestions on topics.";

Instead of giving a checklist (called proof of your good work) to the director:
	if proof of your good work is not complete:
		say "'Whoa,' says [the director], 'what is this?  You've still got work to do, kid!  Get back out there, and don't come back until it's all done!'";
	otherwise:
		say "[The director] scrutinizes the list, then smiles at you and drawls, 'Good job, kid.  Come back tomorrow for your next assignment!'";
		now the director has proof of your good work.



Checklist-1 is critical.  [You can't drop it.]
Get-blueprints is a checklist-item.  The printed name of get-blueprints is "Get command module blueprints".
Get-equations is a checklist-item.  The printed name of get-equations is "Get rocket equations".
Choose-crew is a checklist-item.  The printed name of choose-crew is "Choose astro nots (sp?)".
TBD is a thing.  The printed name of TBD is "__________".
The sub-items of choose-crew are {TBD, TBD, TBD}.
The items of checklist-1 are {get-blueprints, get-equations, choose-crew}.



The Main Hallway is east of the director's office.  "A long, blank hallway, with several doors branching off in various directions and a stairwell leading down.  A bronze [interesting]plaque[/interesting] is hanging on the wall in the center of the hallway."

A bronze plaque is scenery in the hallway.

Instead of examining the plaque:
	say "Engraved in bronze, the plaque says:[line break]";
	if Vorple is supported:
		center "[plaque-card style][bold type]Apollo[roman type][line break]Never give up, never surrender![end style]";
	otherwise:
		center "[bold type]Apollo[roman type]";
		center "Never give up, never surrender!"



The engineering department is east of the hallway.  "It's filled with grey upholstered cubicles and smells like pencil shavings and burned coffee.  At the end of the room is a large whiteboard, at the top of which is written APOLLO 11.  Underneath the heading are some inscrutable diagrams, and in the bottom right corner, someone has drawn a unicorn."
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

The description of the engineer is "[if the engineer is not sad]He is tall and thin, with slicked-back ginger hair and a short-sleeved shirt and tie.  He is wearing a pocket protector and a [interesting]name badge[/interesting].  What a nerd![otherwise][The noun] is just about the saddest thing you've ever seen.  His hair is a mess, and he appears to have been wiping his tears on his tie."

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
	if the engineer is unknown, say "An engineer is standing around by the [interesting]coffee pot[/interesting], [if the engineer is sad]crying.[otherwise]doing nothing.";
	otherwise say "Rick is still here, still [if the engineer is sad]crying.[otherwise]doing nothing.";

Instead of talking to the engineer:
	say "Perhaps you could ask [the noun] about the weather, the command module blueprints, or himself."

Instead of quizzing the engineer about name:
	say "The engineer taps his [interesting]name badge[/interesting] and says, 'Can't you read?'"

Instead of quizzing the engineer about the weather:
	say "[The noun] glances up at the ceiling for a moment before replying, 'Maybe a bit cloudy, but we should still be clear for launch.  Besides, we're never gonna give this up.'"

Instead of quizzing the engineer about the engineer:
	say "[The noun] looks a bit embarrassed by the question, maybe even flattered.  He looks at his feet for a moment before replying, 'Well...  We're no strangers to love.'  Then he raises his eyes and gives you a look that makes you... distinctly uncomfortable."

Instead of quizzing the engineer about the blueprints:
	say "[The noun] looks both smug and offended at once.  '[bold type]ACTUALLY[roman type], they aren't blue at all!  The cyanotype [italic type]blueprint[roman type] began to be supplanted by [italic type]diazo prints[roman type], also known as [italic type][interesting]whiteprints[/interesting][roman type].'";
	now the printed name of get-blueprints is "Get command module whiteprints".

[Give this concept a location, so we can have rules about "taking" it.]
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
		say "[The head scientist] huffs about the room, scribbling on [interesting]chalkboards[/interesting], sparing you only the occasional angry glance.";
	otherwise:
		say "[The head scientist] moves smoothly through the room from one [interesting]chalkboard[/interesting] to another, making minor changes to complex [interesting]equations[/interesting].  He does not seem to notice you."

The chalkboard is in the propulsion lab.  The description of the chalkboard is "A large, slate black, wheeled chalkboard covered in inscrutable [interesting]equations[/interesting]."
The chalkboard is undescribed.  [Mentioned in the scenery, but not in the room.]
The chalkboard is pushable between rooms.
Understand "chalk board" and "board" as the chalkboard.

Equations and rocket-equations are parts of the chalkboard.
[To allow them to be examined while you're in any room with the chalkboard.]
Instead of examining equations:
	say "You can't make heads or tails of them.";
Instead of examining rocket-equations:
	try examining equations.

Instead of taking the chalkboard:
	if the location is the propulsion lab:
		say "You hurriedly start pushing one of the wheeled [interesting]chalkboards[/interesting] out of the room.  [The head scientist] screams after you, '[bold type]SCHWEINHUND!  [italic type]HALT!!![roman type]'[line break]";
		now the head scientist is enraged;
		now the chalkboard is described;  [It will show up in room descriptions again.]
		now the chalkboard is critical;  [You can't leave it behind; see below]
		now get-equations is checked;  [Woohoo!]
		now the chalkboard is in the hallway;
		try going south;
	otherwise:
		say "You've already brought that with you into the room, and there's no way it would fit in your pockets."

Instead of going to anywhere (called the destination):
	if the chalkboard is critical:
		say "([one of]You push the massive [chalkboard] along with you[or]As you drag the [chalkboard] over the threshold into [the destination], one of the wheels catches on the door jam and the giant board falls to the ground.  It takes you a minute or two to get it upright again[or]You drag the [chalkboard] along, and hope like hell that it turns out to be worth the effort[purely at random].)[line break]";
		now the chalkboard is in the destination;
	continue the action.

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
	say "'Well,' he begins, looking quietly pleased with himself, 'My rockets are simply the best.  As you can plainly see, even enemies of the Reich were forced to acknowledge the greatness of my work.'  He turns to consider the [interesting]chalkboards[/interesting] behind him and adds dreamily, 'I have spent years perfecting this new one...'"

Instead of quizzing the head scientist about work:
	try quizzing the head scientist about rocket.

Instead of quizzing the head scientist about equations:
	say "'What about them?' he snaps.  'I'm very busy.'  [The noun] turns back to the [interesting]chalkboards[/interesting]."

Instead of quizzing the head scientist about rocket-equations:
	say "He turns to you very suddenly.  '[italic type]Rocket equations?[roman type]  You sound ridiculous!  What buffoon would say such a thing?  [bold type]Stop wasting my time![roman type]'[line break]";
	now the head scientist is enraged.

[TODO: ask von Braun about Apollo]

Instead of quizzing the head scientist about anything while the head scientist is enraged:
	say "[The noun] throws an eraser at you and screams [bold type]'GET OUT!'[roman type][line break]";

Instead of saying sorry while the player is in the propulsion lab:
	if the head scientist is enraged:
		say "[The head scientist] stares at you angrily for the space of a breath, then rips off one shoe and chases you out of the room with it.[paragraph break]";
		if a random chance of 9 in 10 succeeds:
			say "You barely escape un-swatted.[line break]";
			try going south;
		otherwise:
			say "Just before you reach the doorway to the hall, [the head scientist] manages to clock you on the side of the head with his shoe.  You suffer a freak hemorrhage and die on the spot.  You are the first NASA employee in the agency's (administration's?) history to die in such a pointless and embarrassing way.  Apollo 11 fails miserably, NASA becomes a worldwide laughing-stock, and Russia conquers the globe by 1972.  Your tombstone in Arlington National Cemetery reads 'Intern.'";
			show ending 3;
	otherwise:
		say "What is there to apologize for?"


In the propulsion lab is a person called the other scientists.
The other scientists are plural-named.
Understand "others", and "them" as the other scientists.
The description of the other scientists is "They scurry around busily in white lab coats, occasionally looking back at [the head scientist] to see if he is noticing their industriousness.  (He is most certainly not.)"

[NOTE: Something really odd is happening, and the only people who understand Inform in enough detail to debug this are Graham Nelson and gray aliens.  For whatever reason, "other scientists", which is the _EXACT NAME_ of the character, resolves to "the head scientist", which is _MADDENING_.  This is a hacky workaround, in which we just edit the user's commands as they come in and replace the thing that _should_ work with an explicit alias that _does_ work.]
After reading a command:
	let N be "[the player's command]";
		replace the regular expression "\bother scientists\b" in N with "the others";
		change the text of the player's command to N.

Instead of quizzing the other scientists about the head scientist:
	say "The other scientists glance warily in the direction of [the head scientist], who [if the head scientist is enraged]glares at them with fire in his eyes[otherwise]looks back with calm surety[end if].  In unison, the scientists chant, 'Dr. von Braun is the best boss a scientist could ask for.  His work in the field is unparalleled, and we are lucky to be in his lab.'  [The head scientist] looks pleased about this, and turns back to his work at the [interesting]chalkboards[/interesting].";
	now the head scientist is known;
	now the head scientist is not enraged;

Instead of quizzing the other scientists about anything:
	try talking to the other scientists.

Instead of talking to the other scientists:
	say "They all look incredibly busy and smart in those white lab coats.  You can't seem to get their attention."



The basement is below the hallway.
Instead of going to the basement during day one:
	say "The stairwell door appears to be locked.  You begin to wonder what they keep down there.";



An astronaut is a kind of person.  [They don't have special properties, but they are unique for the game.  Other kinds of people are ineligible for the mission.  Furthermore, all of the astronauts start in the basement.  Not giving them an initial location causes the rules for "choosing crew" to fail with a built-in message about them being "unavailable".  Putting them in literally any room fixes this.  We don't want the player to meet them yet, so they begin in the basement, which is locked during day one.]

Buzz Aldrin is an astronaut in the basement.
Neil Armstrong is an astronaut in the basement.
Michael Collins is an astronaut in the basement.
Lisa Nowak is an astronaut in the basement.
Ijon Tichy is an astronaut in the basement.
Clifford McBride is an astronaut in the basement.

[Unless someone has a specific response for a specific astronaut, treat questions about individuals as questions about the crew in general.]
Instead of quizzing someone (called the interrogated) about Buzz Aldrin:
	try quizzing the interrogated about crew.
Instead of quizzing someone (called the interrogated) about Neil Armstrong:
	try quizzing the interrogated about crew.
Instead of quizzing someone (called the interrogated) about Michael Collins:
	try quizzing the interrogated about crew.
Instead of quizzing someone (called the interrogated) about Lisa Nowak:
	try quizzing the interrogated about crew.
Instead of quizzing someone (called the interrogated) about Ijon Tichy:
	try quizzing the interrogated about crew.
Instead of quizzing someone (called the interrogated) about Clifford McBride:
	try quizzing the interrogated about crew.



The personnel department is south of the hallway.  "This tiny room feels like the sort of place careers go to die.  [The head of personnel] [if the head of personnel is asleep]is reclined behind a cheap [interesting]desk[/interesting], snoring softly with his feet up[otherwise]is staring at you impatiently from behind the [interesting]desk[/interesting], waiting for you to state your business.  He does not look pleased[end if].  To the left of the [interesting]desk[/interesting] is a tan, metallic [interesting]filing cabinet[/interesting]."
The printed name of the personnel department is "NASA Personnel Department".

The cheap desk is scenery in the personnel department.  The description of the cheap desk is "You have never seen less thought or money put into furniture before.  The desk has four legs and a surface, but everything else about it looks like an accident."
The cheap desk is an enterable supporter.

The metallic filing cabinet is scenery in the personnel department.  The description of the metallic filing cabinet is "The filing cabinet is short, tan-colored and metallic, with one [interesting]drawer[/interesting] in it, which is labeled 'Crew Candidate Personnel Files'.  The cabinet looks like the only thing in this room that NASA cares about."
The metallic filing cabinet is an enterable supporter.

An openable closed container called the drawer is part of the metallic filing cabinet.  "The drawer is labeled 'Crew Candidate Personnel Files'."
[We don't get told automatically what is inside an open container if it's part of another thing.  Fix this for the open drawer.]
Before listing exits:
	if the player is in the personnel department:
		if the drawer is open:
			say "In the open cabinet drawer, you can see [list of things in the drawer].[paragraph break]";
	continue the action.

personnel file 1 is a critical thing in the drawer.
personnel file 2 is a critical thing in the drawer.
personnel file 3 is a critical thing in the drawer.
personnel file 4 is a critical thing in the drawer.
personnel file 5 is a critical thing in the drawer.
personnel file 6 is a critical thing in the drawer.

The personnel puzzle is a concept.  The personnel puzzle can be ready.  When day one begins, now the personnel puzzle is not ready.

The head of personnel is a stranger in the personnel department.
The real name of the head of personnel is "Franklin".
The head of personnel is male.

Understand "head", "Franklin", "Franklin Stanford", "Stanford", "him", "man", and "himself" as the head of personnel.

When day one begins, now the head of personnel is asleep.  [Aren't we all?]

The description of the head of personnel is "[The noun] is a short, balding man wearing black eyeglasses, a short-sleeved shirt, and a plain tie.  He is [if the head of personnel is asleep]snoring softly with his feet up, occasionally twitching in his chair[otherwise]staring at you impatiently.  He must not enjoy having his nap interrupted[end if]."

Instead of waking the head of personnel:
	if the head of personnel is asleep:
		say "You say 'Excuse me,' and [the head of personnel] snorts and snaps awake, practically falling out of his chair.  'Wha?!' he exclaims, then adds testily, 'What is it?  What do you want?'";
	continue the action.

Instead of talking to the head of personnel:
	if the head of personnel is asleep:
		try waking the head of personnel;
	otherwise:
		say "Perhaps you could ask [the noun] about the crew candidates, the personnel files, or himself."

Instead of quizzing the head of personnel about name:
	say "'Franklin, Franklin Stanford.  What the hell do you want?  Spit it out.'";
	now the head of personnel is known.

Instead of quizzing the head of personnel about the head of personnel:
	try quizzing the head of personnel about name.

[NOTE: Unlike other concepts, this one must be in a room, since we can use it with "take".  And since we have a rule for "drop", which needs to work no matter where you go, let's make the files "everywhere".]
The personnel files is a concept.  The personnel files are everywhere.
Understand "files" as the personnel files.

Instead of quizzing the head of personnel about anything while the head of personnel is asleep:
	try waking the head of personnel.

[TODO: talk to Franklin about NASA
Instead of quizzing the head of personnel about NASA:
	say "";
]

[TODO: talk to Franklin about Apollo
Instead of quizzing the head of personnel about Apollo:
	say "";
]

[TODO: talk to Franklin about Dirk
Instead of quizzing the head of personnel about the director:
	say "";
]

[TODO: I bet Franklin would have opinions about every single character.]

Instead of saying sorry while the player is in the personnel department:
	if the head of personnel is asleep:
		say "What is there to apologize for?";
	otherwise:
		say "[The head of personnel] grunts and pointedly props his feet back up on his desk.  Within a moment, he is snoring again.";
		now the head of personnel is asleep;

Instead of quizzing the head of personnel about the crew:
	if the personnel puzzle is not ready:
		say "[The noun] snorts.  'A bunch of prima donnas, every one of [']em.  You can have your pick.'  He reaches into the [interesting]filing cabinet[/interesting] and produces a set of six [interesting]files[/interesting] for you.  'Here you go,' he says, handing you.  'Anything else?'";
	otherwise:
		say "[The noun] snorts.  'A bunch of prima donnas, every one of [']em.  You can have your pick.  Just read the [interesting]files[/interesting].  Anything else?'";
	if the personnel puzzle is not ready:
		now the player has personnel file 6;
		now the player has personnel file 5;
		now the player has personnel file 4;
		now the player has personnel file 3;
		now the player has personnel file 2;
		now the player has personnel file 1;
		now the personnel puzzle is ready;

Instead of quizzing the head of personnel about the personnel files:
	if the personnel puzzle is not ready:
		say "[The noun] impatiently hooks a thumb at the [interesting]filing cabinet[/interesting].  'In there.  Go nuts.'  He starts drumming his fingers on his desk.  'Anything else?'";
	otherwise:
		say "'You've already got [']em!  Now get lost.'";

Instead of examining the personnel files:
	if the personnel puzzle is ready:
		say "Try examining a particular file instead.";
	otherwise if the player is not in the personnel department:
		say "You can't see any such thing.";
	otherwise:
		if the drawer is not open:
			try opening the drawer;
		say "Try examining a particular file instead.";

Instead of taking the personnel files:
	if the personnel puzzle is ready:
		say "You already have the personnel files.";
	otherwise if the player is not in the personnel department:
		say "You can't see any such thing.";
	otherwise:
		if the drawer is not open:
			try opening the drawer;
		now the player has personnel file 6;
		now the player has personnel file 5;
		now the player has personnel file 4;
		now the player has personnel file 3;
		now the player has personnel file 2;
		now the player has personnel file 1;
		say "You collect all the files from the drawer.";
		now the personnel puzzle is ready;

Instead of dropping the personnel files:
	say "You're going to need those."

Instead of opening the cabinet:
	try opening the drawer.

Instead of closing the cabinet:
	try closing the drawer.

Instead of opening the drawer:
	if the head of personnel is asleep:
		say "You pull open the drawer carefully, but the drawer gets stuck briefly in the track and makes a loud [italic type]CLANG[roman type] sound.  [The head of personnel] snorts and snaps awake, practically falling out of his chair.  'Wha?!' he exclaims.  'What do you think you're doing?'";
		now the head of personnel is not asleep;
	continue the action.

After going from the personnel department:
	now the head of personnel is asleep;
	continue the action.



The description of personnel file 1 is "[fixed letter spacing][personnel-file style][bold type]NASA PERSONNEL FILE: ALDRIN, EDWIN E. JR. ('BUZZ')[roman type]

Professional History:
[line break]   * Graduated 3rd in class, West Point, 1951, BS in mechanical engineering
[line break]   * US Air Force, 1952-
[line break]   * Korean War, 1952-53
[line break]   * Graduated MIT, 1963, Sc.D in Astronautics
[line break]   * NASA Gemini program, 1963-1966

Psychological profile:
[line break]   * Suffers from mood disorders, including space madness
[line break]   * Nicknamed 'Buzz' because of his propensity to eat carrion
[line break][end style][variable letter spacing]".


The description of personnel file 2 is "[fixed letter spacing][personnel-file style][bold type]NASA PERSONNEL FILE: ARMSTRONG, NEIL ALDEN[roman type]

Professional History:
[line break]   * Graduated Purdue University, 1955, BS in Aeronautical Engineering
[line break]   * US Navy, 1949-1952
[line break]   * Korean War, 1951-1952
[line break]   * US Navy Reserve, 1952-1960
[line break]   * Test pilot, National Advisory Committee on Aeronautics, 1955-1958
[line break]   * Test pilot, NASA, 1958-1962
[line break]   * NASA Gemini program, 1965-1966

Psychological profile:
[line break]   * Humble about work, avoids publicity
[line break]   * Scottish heritage and sense of honor requires him to headbutt descendents of rival clans
[line break]   * Refuses to wear socks inside his spacesuit
[line break][end style][variable letter spacing]".


The description of personnel file 3 is "[fixed letter spacing][personnel-file style][bold type]NASA PERSONNEL FILE: COLLINS, MICHAEL[roman type]

Professional History:
[line break]   * Joined the Irish Republican Brotherhood at age 19
[line break]   * Aide-de-camp, rebel headquarters, Easter Rising
[line break]   * Chairman of the Provisional Government, Irish Free State
[line break]   * Commander-in-Chief of the National Army, Irish Free State

Psychological profile:
[line break]   * Abrasive, fiercely proud
[line break]   * Does not consult with other on decisions
[line break]   * Has not attended official NASA meetings since his assassination in August 1922
[line break][end style][variable letter spacing]".


The description of personnel file 4 is "[fixed letter spacing][personnel-file style][bold type]NASA PERSONNEL FILE: NOWAK, LISA MARIE[roman type]

Professional History:
[line break]   * Graduated US Naval Academy, Annapolis, BS in aerospace engineering
[line break]   * Served in US Navy Electronic Warfare Aggressor Squadron
[line break]   * US Naval Postgraduate School, Monterey, MS in aeronautical engineering

Psychological profile:
[line break]   * Enjoys long road trips
[line break]   * Refuses to use rest stops
[line break]   * Loves to plan elaborate surprises

[line break][end style][variable letter spacing]".


The description of personnel file 5 is "[fixed letter spacing][personnel-file style][bold type]NASA PERSONNEL FILE: TICHY, IJON[roman type]

Professional History:
[line break]   * Experienced space pilot
[line break]   * Experienced diplomat
[line break]   * Took part in the Eighth World Futurological Congress in Costa Rica

Psychological profile:
[line break]   * Eager to explore
[line break]   * Generally amiable
[line break]   * Accident-prone
[line break]   * Lives in a messy, three-bedroom rocket

[line break][end style][variable letter spacing]".


The description of personnel file 6 is "[fixed letter spacing][personnel-file style][bold type]NASA PERSONNEL FILE: MCBRIDE, H. CLIFFORD[roman type]

Professional History:
[line break]   * Undergrad degree from Purdue
[line break]   * Doctorate from MIT
[line break]   * Graduated US Air Force Academy
[line break]   * Experienced astronaut
[line break]   * Commander, NASA Lima program

Psychological profile:
[line break]   * Brilliant, obsessive, extremely driven
[line break]   * Willing to make sacrifices
[line break]   * Enjoys dehydrated food

[line break][end style][variable letter spacing]".



Choosing crew is an action applying to one thing.  Understand "choose [anyone]" as choosing crew.
[NOTE: "anyone" should match people who are not present.  But we still need this rule to allow it:]
Rule for reaching inside a room while choosing crew:
	allow access.  ["Reaching inside a room" means that person is in literally any other room.]

Check choosing crew:
	if day one has ended:
		say "It's much too late for that now.";
	otherwise if the personnel puzzle is not ready:
		say "You aren't ready to choose the crew.";
		show hint "You will need to have the personnel files for that.";
	otherwise if the noun is not an astronaut:
		say "[The noun] is not eligible for this mission.  Try choosing from the personnel files.";
	otherwise if the noun is listed in the sub-items of choose-crew:
		say "You've already selected [the noun] for the crew of Apollo 11.  Try choosing another astronaut from the personnel [interesting]files[/interesting].";
	otherwise if TBD is not listed in the sub-items of choose-crew:  [if the list is full, that is]
		say "It's too late!  You've already finished selecting the crew of Apollo 11.  Look at the checklist to see what else needs to be done.";
	otherwise:
		remove TBD from the sub-items of choose-crew;
		add the noun to the sub-items of choose-crew;
		if the number of entries in the sub-items of choose-crew is 3:
			now choose-crew is checked;
		while the number of entries in the sub-items of choose-crew < 3:
			add TBD to the sub-items of choose-crew;
		say "You add [the noun] to the crew list for Apollo 11.";
		if choose-crew is checked:
			say "That should do it!  There was only room for three."



[Keep track of when the player looks at the files.  Only hint about the files when the player is doing something else for a while.]
The time since looking at files is a number which varies.
After reading a command:
	if the player's command matches the regular expression "\bfile\b":
		now the time since looking at files is 0;
	otherwise if the personnel puzzle is ready:
		increase the time since looking at files by 1.

Every turn when the remainder after dividing the turn count by 10 is 0 and the personnel puzzle is ready and choose-crew is not checked:
	[Skip this hint if the user just looked at one of the files.]
	if the time since looking at files is greater than 3:
		show hint "Use 'choose so-and-so' to choose someone for the Apollo 11 crew.  Read the personnel files for details on each crew candidate.";

Every turn when the remainder after dividing the turn count by 3 is 0 and a checklist (called X) held by the player is complete:
	say "[X] is complete now.  You should report back to [the director] and give him the checklist.";



[---------- DAY 2 ----------]

Day two is a scene.
Day one ends when checklist-1 is held by the director.
Day two begins when day one ends.
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
	now checklist-1 is nowhere;
	now the chalkboard is nowhere;
	now the chalkboard is not critical;  [So you aren't traveling with it anymore]
	now checklist-2 is on the director's desk;
	now the director is not ready;
	now the director is not relaxed;
	now the secretary is not mad;
	now the player is in the waiting room;
	secretary warns in 0 turns from now;
	director yells-2 in 4 turns from now.

At the time when director yells-2:
	say "A booming voice comes from the director's office: 'Donna!  Is that damned kid late again?!  Why did we even hire that punk?'[paragraph break][The secretary] shrugs at you and gestures toward [the director]'s office door.";
	now the director is ready.

Glitter is a concept.  The allowed-scene of glitter is day two.
Understand "operation glitter" as glitter.

Checklist-2 is a checklist.
The printed name of checklist-2 is "Operation Glitter checklist".
The description of checklist-2 is "The checklist is [if checklist-2 is on the director's desk]laying on the desk, [end if]scribbled out in childish print."
Checklist-2 can be ready.  When day two begins, now checklist-2 is not ready.

[Keep the player from leaving without the checklist.]
Instead of going from the director's office during day two:
	if checklist-2 is carried by the player:
		continue the activity;
	otherwise if checklist-2 is not ready:
		try taking checklist-2;  [So that the director will ask you to stop and talk first.]
	otherwise:
		say "'Hang on!' says [the director].  'You're gonna need this!'.  He indicates the checklist[if a checklist is on the director's desk] laying on his desk[end if].  'Get all of that done, ASAP.'"

[Keep the player from taking the checklist until you've talked to the director first.]
Instead of taking checklist-2:
	if checklist-2 is ready:
		say "[The director] looks relieved and says, 'Now, you did good work for us yesterday.  Keep it up, and Nixon might let us all see our families again.  Heh heh.'  His chuckle is not at all comforting.";
		show hint "You can examine the [interesting]checklist[/interesting] to see the details.";
		now the director is relaxed;
		continue the action;
	else:
		say "'Not so fast!' says [the director].  'We need to talk first.'";
		show hint "You can 'talk to director' for suggestions on topics.";

Instead of talking to the director during day two:
	say "Perhaps you could ask [the director] about Apollo, Operation Glitter, or the astronauts.";
[TODO: Are these the best Dirk topics for day two?]

Instead of quizzing the director about glitter:
	say "'It's cheap, and it pretties up just about anything.  Good name, huh?  They let me pick it myself this time!'  He is practically beaming.";

[TODO: new replies from dirk for topics from day 1
Instead of quizzing the director about Apollo during day two:
	say "...";
]

[TODO: other transitions to day 2
 - new conversation topics with dirk
 - checklist-2 items, sub-items
 - put the correct astronauts in the basement, and hide the others (maybe during "choose" in day 1?)
]



[For day two, we lock the doors to these rooms.]
Instead of going to the propulsion lab during day two:
	say "The door to the lab appears to be locked.  There is a sign on it which says 'closed for remodeling'."

Instead of going to the engineering department during day two:
	say "The door to the engineering department appears to be locked.  There is a sign on it which says 'deserted'.  (You were [italic type]sure[roman type] they were never going to do that...)[line break]".

[TODO: describe all the astronauts]



[---------- DAY 3 ----------]

[TODO: day three (epilogue)]
Day three is a scene.



[TODO: Consider Vorple Multimedia extension for background audio, with "music on" and "music off" commands to let the player control it.]



[Test commands for speedy testing:]

Test stand with "sit / stand / stand / z / z / n".

Test plant with "l / take plant / l / drop plant / l / eat plant".

Test waiting with "z / z / z / z / z / n";

Test nameplate with "test waiting / x nameplate / x desk / take nameplate / i / x nameplate / g / g / g / g / l / x desk / drop nameplate / l / x desk / put nameplate on desk / l / x desk / open nameplate / l / x toblerone / eat toblerone".

Test checklist with "test waiting / x checklist / take checklist / talk to director / ask director about internship / take checklist / give checklist to director / x checklist / i".

Test tasks with "test checklist / ask about blueprints / ask about equations / ask about crew".

Test blueprints with "test checklist / e / e / ask about blueprints / ask about whiteprints / x engineer / take blueprints / i / x checklist".

Test coffee with "test checklist / e / e / x coffee pot / take pot / i / take coffee / i / put checklist in pot / i".

Test plaque with "test checklist / e / x plaque".

Test equations with "test checklist / e / n / ask about name / ask about work / ask about equations / ask about rocket equations / ask about rockets / x board / take chalkboard / s / n / e / w / n / ask them about him / talk to him / l / x them / x checklist".

Test others with "test checklist / e / n / talk to other scientists / talk to scientists / talk to others / talk to them / talk to scientist / talk to him / talk to head / talk to head scientist / talk to rocket scientist / talk to doctor".

Test shoe with "test checklist / e / n / ask about rocket equations / sorry / w".

Test crew with "test checklist / e / s / choose donna / x file 1 / wake him / ask him about name / ask him about files / take files / drop file 1 / choose aldrin / choose donna / x checklist / choose aldrin / choose collins / x checklist / choose armstrong / x checklist / choose nowak".

Test wake with "test checklist / wake him / sorry / wake him / e / s / x him / open drawer / l / x him / n / s / wake him / n / s / talk / ask about crew / i / ask about crew / ask about files".

Test files with "test checklist / e / s / take files / x file 1 / x file 2 / x file 3 / x file 4 / x file 5 / x file 6 / i".

Test drawer with "test checklist / e / s / open drawer / close drawer / open cabinet / close cabinet / open drawer / l / take files / l".

Test day2 with "test blueprints / w / w / s / test crew / n / w / s / test equations / s / w / give checklist to director".

Test glitter1 with "test waiting / ask about glitter".

Test glitter2 with "test day2 / test waiting / ask about glitter".
