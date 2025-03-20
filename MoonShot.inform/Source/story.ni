"MoonShot" by "Joey & Charity Parrish".


[Bibliographic Information]
The story genre is "Comedy".
The release number is 9.
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
Include Locksmith by Emily Short.
Include Chicken Noodle Soap Setup by Joey Parrish.
Include Concepts by Joey Parrish.
Include Critical Things by Joey Parrish.
Include Strangers by Joey Parrish.
Include Better Sitting by Joey Parrish.
Include Checklists by Joey Parrish.


[Styling]
blockquote is a Vorple style.
plaque-card is a Vorple style.
ending-card is a Vorple style.
personnel-file-card is a Vorple style.
nameplate-card is a Vorple style.
alien-paper is a Vorple style.
script-page is a Vorple style.
script-line is a Vorple style.



[General]

The weather is a concept.  The weather is everywhere.  The weather is physical.
[We can talk about it or ask about it in any room.  But if you try to look at it...]
Instead of examining the weather, say "Hrm... why are there no windows in this building?"

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
Understand "candidates", "crew candidates", "choosing the crew", "astro nots", and "astronots" as the crew.
[We'd like Inform to understand "astronauts" as "crew", but instead, it asks the player which astronaut they mean.  This pre-emptive manipulation of the command text is the only workaround I can find. -JCP]
After reading a command:
	let N be "[the player's command]";
	replace the regular expression "\bastronauts\b" in N with "crew";
	change the text of the player's command to N.

Equations are a physical concept.  The printed name of equations is "equations".
Rocket-equations is a concept.
Understand "rocket equations" as rocket-equations.  [If I give the object its natural name instead of using "understand", then "equations" results in a disambiguation prompt between "equations" and "rocket equations", which is confusing.]

Instead of quizzing someone (called the person) about (this is the default conversation rule):
	say "'[one of]Oh, I don't know anything about that[or]Let's talk about something else[or]I'm not sure what to say about that[purely at random],' says [the person]."

[By default, only "sorry" triggers this action.]
Understand "say sorry", "apologize", "apologise", and "console" as saying sorry.
[Some folks naturally want to apologize to the person specifically.]
Saying sorry to is an action applying to one thing.
Understand the command "hug" as something new.  [There is a default which maps it to "kiss".  We'll separate the two and map "hug" to "console" or "apologize to".]
Understand "say sorry to [someone]", "apologize to [someone]", "apologise to [someone]", "console [someone]", and "hug [someone]" as saying sorry to.
Instead of saying sorry:
	say "Nobody here is upset at the moment."
Instead of saying sorry to a person:
	say "[The noun] is not upset at the moment."


[By default, we don't get to see what people are carrying.  This changes that.]
After examining a person (called Bob):
	let stuff be the list of things carried by Bob;
	repeat with X running through stuff:
		if X is worn by Bob:
			now X is not marked for listing;
			remove X from stuff;
		otherwise:
			now X is marked for listing;
	if stuff is not empty:
		say "[The Bob] is carrying ";
		list the contents of Bob, as a sentence, including contents, giving brief inventory information, tersely, not listing concealed items, listing marked items only;
		say "."

[This seems unlikely to come up in practice, but now that we are creating "enterable" game objects such as chairs, I thought I'd throw this in.  You can get this by the phrases "enter" or "sit on".]
Instead of entering a person:
	say "[The noun] looks shocked that you should even try it!  [bold type][italic type]'SECURITY!'[roman type]  NASA security arrives shortly, hauls you carelessly to the building exit, and then tosses you into the street.  You have been fired for sexual harassment in 1969, in spite of the term not being coined until 1975.  But then, you always [italic type]did[roman type] consider yourself ahead of your time.";
	show ending 2 of 9 aka the "harassment" ending.
Check sitting on a person:
	try entering the noun.
[Make sure this is auto-completable.]
When play begins: now can-sit-on-people is true.

[As if the above wasn't risque enough...]
Instead of entering yourself:
	let occupants be the people to talk to;
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
Extra autocomplete verbs rule:
	if a person in the location is asleep:
		add "wake " to extra-verbs;


[Clothing that is repeated among multiple characters must be a "kind" first.]
A tie is a kind of wearable thing.
A short-sleeved shirt is a kind of wearable thing.
A lab coat is a kind of wearable thing.

[We'd like to add a door as scenery, in case the player wants to examine the door.  However, "door" is a built-in kind in Inform, so we give it a hyphenated name in the source.]
The-door is a backdrop.  Understand "door" and "the door" as the-door.  The printed name of the-door is "the door".
The-door is everywhere.  [Every room has a door, but they are not interesting.]

[Sometimes, we should consider saying we're sorry.]
Extra autocomplete verbs rule:
	if the player is in the waiting room and the secretary is mad:
		add "apologize\n" to extra-verbs;
	if the player is in the engineering department and the engineer is sad:
		add "apologize\n" to extra-verbs;
	if the player is in the propulsion lab and the head scientist is enraged:
		add "apologize\n" to extra-verbs;
	if the player is in the personnel department and the head of personnel is not asleep:
		add "apologize\n" to extra-verbs;


Before handling the final question:
	execute JavaScript code "stopBackgroundMusic()";
When day one ends:
	execute JavaScript code "stopBackgroundMusic()";
When day two ends:
	execute JavaScript code "stopBackgroundMusic()";
Vorple interface update rule:
	if day one is happening:
		execute JavaScript code "setBackgroundMusic('day1.mp4', 5.861, 'by BackgroundMusicForVideo via Pixabay', 'https://pixabay.com/music/comedy-funny-comedy-music-humor-fool-joke-smile-background-intro-theme-261165/')";
	otherwise if day two is happening:
		if the player has alien-equations:
			execute JavaScript code "setBackgroundMusic('day2alt.mp4', 0, 'by Lexin_Music via Pixabay', 'https://pixabay.com/music/modern-classical-marionettes-124709/')";
		otherwise:
			execute JavaScript code "setBackgroundMusic('day2.mp4', 0, 'by Serge Quadrado Music via Pixabay', 'https://pixabay.com/music/happy-childrens-tunes-life-of-a-wandering-wizard-15549/')";
	otherwise if day three is happening:
		if the player is in the sound stage:
			execute JavaScript code "setBackgroundMusic('day3final.mp4', 0, 'by Mikhail Smusev via Pixabay', 'https://pixabay.com/music/suspense-horror-258261/')";
		otherwise:
			execute JavaScript code "setBackgroundMusic('day3.mp4', 8.75, 'by Universfield via Pixabay', 'https://pixabay.com/music/mystery-tense-horror-background-174809/')";



[---------- DAY 1 ----------]
Day one is a scene.
Day one begins when play begins.
When day one begins:
	[Add default concepts for the beginning of the game]
	make "name" known;
	make weather known;
	make NASA known;
	make Apollo known;
	make internship known;
	make "secretary" known;
	make "director" known;
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
	pause;
	log event "day1";
	say "[room-heading style]NASA Headquarters, 1969[end style]";
	say line break;
	say "You did it!  You finally landed an internship at NASA, the National Aeronautics and Space ... Association?  Agency?  Authority?  You're not really sure what the last A stands for, but it's only your first day.  You're pretty certain you'll figure it out soon enough.[paragraph break]";
	say "After a whirlwind tour of NASA headquarters, which you are sure you've already [italic type]completely[roman type] forgotten, you are ushered into the office of your new boss: the director of NASA's Apollo program.  You heard recently that we're ready to send [italic type]a man to the moon[roman type].  You can scarcely believe it!  It's like something out of science fiction.  Nervously, you wait to be called into the inner office.[paragraph break]";
	pause.

Intro hints shown is initially false.  [Sadly, if the first command fails, the turn count stays at 1, and the intro hints get shown over and over.  This boolean condition allows us to prevent that.]
Before reading a command while the turn count is 1:
	if intro hints shown is false:
		show hint "See the 'help' button in the top-right corner if you get stuck or if you need an introduction.";
		show hint "You can also use the 'gear' button to change the game's settings, including music.";
		now intro hints shown is true.



The director's waiting room is a room.  "The tiny waiting room barely has enough room for you, [the secretary], and her desk.  [if the houseplant is in the waiting room]There's a [interesting]houseplant[/interesting] in a pot, hanging from the ceiling in elaborately knotted macrame.  [end if][The secretary] is chewing bubblegum and sporadically blowing bubbles as large as her face that startle you when they pop."
The printed name of director's waiting room is "NASA Director's Waiting Room".

The bubblegum is portable-scenery in the waiting room.  Understand "gum" as the bubblegum.
The macrame is portable-scenery in the waiting room.

In the waiting room is a stranger called the secretary.  The real name of the secretary is "Donna".
Understand "Donna", "her", "herself", and "woman" as the secretary.  The secretary is female.
The secretary can be mad.  When day one begins, now the secretary is not mad.

The secretary's desk is scenery in the waiting room.  "A simple teak desk with a light stain, and unusually spartan."
The secretary's desk is an enterable supporter.  [You can put things on it or sit on it.]

The orange chair is a chair in the director's waiting room.
The description of the orange chair is "A simple office chair, with classy orange upholstery.  Not too comfy, though."

The potted houseplant is in the waiting room.  The description of the potted houseplant is "It's some kind of... ivy?  Maybe?"
Understand "plant" and "pot" as the houseplant.
The houseplant is undescribed.  [We already talked about it in the room description, so don't list it again.]

Instead of dropping the houseplant while the player is in the waiting room:
	say "You carefully hang the [houseplant] from the ceiling again, eliciting strange looks from [the secretary].";
	now the houseplant is in the waiting room;
	now the houseplant is undescribed.  [Don't mention it again as in the room.  The room description covers it.]

The houseplant is edible.
Instead of eating the houseplant:
	say "The houseplant tastes terrible, and your stomach quickly begins to cramp.  Before long, you're unable to walk.  You die on the way to the emergency room, [if day one is happening]Apollo 11 fails miserably,[otherwise]Operation Glitter fails and is exposed,[end if] and NASA becomes a worldwide laughing-stock.  Russia conquers the globe by 1972.  Your tombstone in Arlington National Cemetery reads 'Intern.'";
	show ending 1 of 9 aka the "houseplant" ending.

A phone is on the secretary's desk.  The description of the phone is "A black rotary telephone.  It looks brand new."
Understand "telephone" as the phone.

Phone-number is a concept.  Understand "phone number" and "number" as phone-number.
Instead of quizzing the secretary about phone-number:
	say "[The secretary] blushes.  With a sly look, she says 'Klondike-five, thirteen thirty-seven.'"

Instead of taking the phone:
	say "[The secretary] stands up quickly and snatches it back from you.  'What is the matter with you?' she yells.  It takes her a minute or so to get the [phone] plugged back in.";
	now the secretary is mad.

Instead of saying sorry while the player is in the waiting room and the secretary is mad:
	try saying sorry to the secretary.
Instead of saying sorry to the secretary while the secretary is mad:
	say "She doesn't look ready to forgive you."

The description of the secretary is "[if the secretary is mad]She glares at you and says 'Keep your eyes to yourself, you nut job.'[otherwise][The noun] is a youngish woman, possibly in her 30s, with a beehive haircut and horn-rimmed glasses.  She notices you looking and smiles."

The secretary wears a beehive haircut and horn-rimmed glasses.

Instead of talking to the secretary:
	say "Perhaps you could ask [the noun] about the weather, NASA, the Apollo 11 project, or her name."

Instead of quizzing the secretary about name:
	say "'It's Donna,' she says.  'Nice to meet you!'";
	make the secretary known.

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


Director-yells-1 is an event.
Secretary-warns is an event.
When day one begins:
	activate secretary-warns in 1 turns;
	activate director-yells-1 in 5 turns;

Yourself can be told-to-wait.
Carry out triggering secretary-warns:
	if yourself has not been told-to-wait:
		say "[The secretary] catches your attention and says, 'The director will be with you shortly.  Please make yourself comfortable while you [interesting]wait[/interesting].'";
	now yourself is told-to-wait.

Before waiting in the waiting room:
	say "[one of]You sit awkwardly, wondering when this whole thing is supposed to get started.[or]Maybe there's something you can do, or something you should be talking about while you wait?[or]The waiting is the hardest part, isn't it?[purely at random]".

Carry out triggering director-yells-1:
	say "A booming voice comes from the director's office: 'Donna!  Where the hell is that kid?  They're late!'[paragraph break][The secretary] looks embarrassed and says quietly, 'You'd better [interesting]go in[/interesting].  He [italic type]hates[roman type] tardiness.'";
	now the director is ready;
	[Give periodic reminders to get into the director's office if the player misses the first yell.]
	activate director-yells-1 in 3 turns.

Extra autocomplete verbs rule:
	if the player is in the waiting room and the director is ready:
		add "go in\n" to extra-verbs;

Instead of quizzing the secretary about the director:
	say "'Oh, Mr. Furtwangler is a visionary!' she says.  'He is completely on top of every aspect of this project.  I don't know how he does it!'";
	make the director known.

Instead of going to the director's office while the director is not ready:
	say "[The secretary] jumps up and runs for the door, stopping you in your tracks.  'You can't go in there!  Just [interesting]wait[/interesting], please, and the director will be with you as soon as he is ready.'";
	if yourself is told-to-wait:
		[If the player has been told at least once before, they are perhaps having trouble with this waiting thing, so offer a hint.]
		say line break;
		show hint "You can talk to [the secretary], examine things, or just type 'wait' to wait patiently.";
	now yourself is told-to-wait.

[In this language "in/inside" is actually a direction you could use to relate places to one another.  But in context of this room, we'd like "go in" to send you into the director's office.]
Instead of going inside while in the waiting room:
	try going north.



The director's office is north of the waiting room.  "The director's office has a full wall of windows overlooking the hangar.  [The director] is drumming his fingers on the desk and humming 'California Dreamin' in double time.  He's wearing a baby-blue, collared, short-sleeved shirt and about 8 oz of hair pomade.[if the triangular nameplate is on the director's desk]  On his desk is a small, triangular [interesting]nameplate[/interesting].[end if]".
The printed name of the director's office is "NASA Director's Office".

The director wears a baby-blue collared short-sleeved shirt, a tie, and pomade.
The printed name of the baby-blue collared short-sleeved shirt is "the shirt".  [We want the player to be able to refer to it by all of these things, but it's a mouthful when we print something about it.]
Understand "blue shirt", "blue collared short-sleeved shirt", and "blue short-sleeved shirt" as the baby-blue collared short-sleeved shirt.


[Since this is the only room with windows...]
Instead of examining the weather in the director's office:
	say "You glance out the windows, but you can't see much other than the hangar."
The windows are scenery in the director's office.
Instead of examining the windows, try examining the weather.

In the director's office is a stranger called the director.  The real name of the director is "Mr. Furtwangler".  The director is male.

Understand "director", "dirk", "mr furtwangler", "mister furtwangler", "furtwangler", "boss", "him", "himself", and "man" as the director.

The director can be agitated or relaxed.  When day one begins, now the director is agitated.

The director can be ready.  When day one begins, now the director is not ready.
The director can be visited.  When day one begins, now the director is not visited.

After going to the director's office:
	now the director is visited;
	make "checklist" known;
	if day two is happening:
		make "Operation Glitter" known;
	deactivate director-yells-1;
	deactivate director-yells-2;
	continue the action.

The director's desk is scenery in the director's office.  "An expansive desk covered in whirring desk gadgets that roll chrome metal balls back and forth endlessly on balanced tracks, as well as several bobblehead dolls.[if the triangular nameplate is on the director's desk]  On the desk is a small, triangular [interesting]nameplate[/interesting].[end if]".
The director's desk is an enterable supporter.  [You can put things on it or sit on it.]

The gadgets are scenery in the director's office.
The tracks are scenery in the director's office.
The balls are portable-scenery in the director's office.
The bobblehead dolls are portable-scenery in the director's office.

The triangular nameplate is an interesting, closed, opaque, undescribed thing on the director's desk.
Instead of examining the triangular nameplate:
	say "A small, wooden, triangular prism with an engraved metal plate attached that reads:[line break]";
	if Vorple is supported:
		center "[nameplate-card style][bold type]Dirk Furtwangler[roman type][line break]Director[end style]";
	otherwise:
		center "[bold type]Dirk Furtwangler[roman type]";
		center "Director";
	make the director known;
	if the player has the triangular nameplate:
		now the triangular nameplate is openable;
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

The wooden armchair is a chair in the director's office.
Understand "chair" as the wooden armchair.  [Duh.]
The description of the wooden armchair is "A comfy-looking wooden armchair, with dark, mulberry-colored upholstery."

There is a checklist on the director's desk called checklist-1.
Checklist-1 is interesting and critical.  [You can't drop it.]
The printed name of checklist-1 is "Apollo 11 checklist".
The description of checklist-1 is "The checklist is [if checklist-1 is on the director's desk]laying on the desk, [end if]scribbled out in childish print."
Checklist-1 can be ready.  When day one begins, now checklist-1 is not ready.
Understand "Apollo 11 checklist" as checklist-1.
Understand "checklist" as checklist-1.
Checklist-1 is privately-named.  [Only aliases can be used.]

The description of the director is "[if the director is relaxed]He gazes dreamily out the window and asks, 'Do you think Johnny Cash is his real name?'[otherwise][The noun] is a man in his 60s with a hawkish nose and an absent air, like a man who can't seem to remember why he's here.  He's holding a comically large cup of coffee in one hand and the other keeps pawing through the jumble of knick knacks on his desk, like he's lost something."

The director is holding a coffee-cup.  The printed name of the coffee-cup is "coffee cup".
The description of the coffee-cup is "Where does someone even find such a gigantic cup?"
Understand "cup", "coffee cup", "cup of coffee", "large cup", "large cup of coffee", "comically large cup", "comically large coffee cup", and "comically large cup of coffee" as the coffee-cup.

Instead of talking to the director:
	say "Perhaps you could ask [the director] about the internship, what the second A in NASA stands for, the Apollo 11 project, or his name."

Instead of quizzing the director about name:
	try quizzing the director about the director.

Instead of quizzing the director about the director:
	say "'Furtwangler.  Dirk Furtwangler.  Boy am I glad you're here!'";
	make the director known.

The internship is a concept.  The internship is everywhere.
Instead of taking the internship:
	say "(You've already been hired.)"

Instead of quizzing the director about the internship:
	say "'Well you know how these things are.  We're terribly busy here at [interesting]NASA[/interesting].  Just an unreasonable amount of space out there.  Downright oppressive, when you start to think about how much of it there is!  So much space to analyze....' His voice trails off into a troubled hum until he notices you looking at him.  He continues, 'Which is exactly why we need you, the intern, to take care of this whole messy [interesting]Apollo 11[/interesting] business.'  He indicates the [interesting]checklist[/interesting][if checklist-1 is on the director's desk] on his desk[end if].  'Get started, kid!'";
	now checklist-1 is ready.

Instead of quizzing the director about NASA:
	say "The director looks surprised by your question.  'NASA?  Well, of course, everyone knows about the National Aeronautics and Space...  uhh... It's about space.  That's the important bit.  [bold type]LOTS[roman type] of space out there.'"

Instead of quizzing the director about anybody:
	say "He stares blankly for a second, then says, 'Who?'"

Instead of quizzing the director about Apollo:
	say "'I'm definitely not scared of getting started.  Definitely not.  There's no reason that Apollo 11 won't be a raging success.  No reason whatsoever.'  He looks very uncertain and his hands are quivering as he speaks."

Instead of quizzing the director about checklist-1:
	say "'Oh, I'm glad you asked about that,' he says.  'This is a detailed and highly technical checklist of the things I need you to do today.  Now, I wrote this myself, so please don't hesitate to ask me if you need help with any of these things.'";
	now checklist-1 is ready.

Instead of quizzing the director about crew:
	say "[The director] beams proudly.  'Fine folks, those astronauts.  Finest, best, most American astronauts that America ever produced.'  His brow furrows for a moment before adding, [if day one is happening]'Well, most of [']em.  Anyway, you can get all the particulars down in personnel.'[otherwise]'Well, most of [']em.  I shouldn't get into it.'[end if][line break]".

Instead of quizzing the director about command module:
	try quizzing the director about blueprints.

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
		say "'Hang on!' says [the director].  'You're gonna need this!'.  He indicates the [interesting]checklist[/interesting][if a checklist is on the director's desk] laying on his desk[end if].  'Get all of that done, ASAP.'"

[Keep the player from taking the checklist until you've talked to the director first.]
Instead of taking checklist-1:
	[The player may be taking it out of a container in some other location, in which case this dialog makes no sense.]
	if the player is in the director's office and the player does not have checklist-1:
		if checklist-1 is ready:
			say "[The director] looks relieved and drawls, 'Oh, thank you, wasn't sure how I was gonna get all that done!'";
			show hint "You can examine the [interesting]checklist[/interesting] to see the details.";
			now the director is relaxed;
			continue the action;
		else:
			say "'Not so fast!' says [the director].  'We need to talk first.'";
			show hint "Try 'ask about' to talk to the director about various topics.";

After examining checklist-1:
	make "astronauts" known;
	make rocket known;
	make "rocket equations" known;
	make command module known;
	make "blueprints" known;
	continue the action.

Reporting is an action applying to nothing.  Understand "report" as reporting.
Check reporting:
	if the player has a checklist (called current-checklist):
		if the player is not in the director's office:
			say "You'll have to find [the director] if you want to report in.";
		otherwise:
			try giving current-checklist to the director;
	otherwise:
		say "You don't have anything to report."


Extra autocomplete verbs rule:
	if a checklist held by the player is complete or the player is in the director's office:
		add "report\n" to extra-verbs;


Instead of giving a checklist (called proof of your good work) to the director:
	if proof of your good work is not complete:
		say "'Whoa,' says [the director], 'what is this?  You've still got work to do, kid!  Get back out there, and don't come back until it's all done!'";
	otherwise:
		say "[The director] scrutinizes the list, then smiles at you and drawls, 'Good job, kid.  Come back tomorrow for your next assignment!'";
		now the director has proof of your good work.



Get-blueprints is a checklist-item.  The printed name of get-blueprints is "Get command module blueprints".
Get-equations is a checklist-item.  The printed name of get-equations is "Get rocket equations".
Choose-crew is a checklist-item.  The printed name of choose-crew is "Choose astro nots (sp?)".
TBD is a thing.  The printed name of TBD is "__________".
The sub-items of choose-crew are {TBD, TBD, TBD}.
The items of checklist-1 are {get-blueprints, get-equations, choose-crew}.



The Main Hallway is east of the director's office.  "A long, blank hallway, with several doors branching off in various directions and a stairwell leading down.  A bronze [interesting]plaque[/interesting] is hanging on the wall in the center of the hallway."

A bronze plaque is interesting scenery in the hallway.
Instead of taking the bronze plaque:
	say "The plaque is bolted to the wall."

Instead of examining the plaque:
	say "Engraved in bronze, the plaque says:[line break]";
	if Vorple is supported:
		center "[plaque-card style][bold type]Apollo[roman type][line break]Never give up, never surrender![end style]";
	otherwise:
		center "[bold type]Apollo[roman type]";
		center "Never give up, never surrender!"



The engineering department is east of the hallway.  "It's filled with grey upholstered cubicles and smells like pencil shavings and burned coffee.  At the end of the room is a large [interesting]whiteboard[/interesting], at the top of which is written APOLLO 11.  Underneath the heading are some inscrutable [interesting]diagrams[/interesting], and in the bottom right corner, someone has drawn a [interesting]unicorn[/interesting]."
The printed name of the engineering department is "NASA Engineering Department".

The unicorn is interesting scenery in the engineering department.
Instead of examining the unicorn:
	if Vorple is supported:
		place an "img" element called "unicorn";
	otherwise:
		[Many thanks to https://www.asciiart.eu/mythology/unicorns]
		[The escaping ruins the effect in the source code.  :-( ]
		say fixed letter spacing;
		say "                    /[line break]";
		say "               ,.. /[line break]";
		say "             ,[']   ['];[line break]";
		say "  ,,.__    _,['] /['];  .[line break]";
		say " :['],[']  ~~~~    [']. [']~[line break]";
		say ":['] (   )         )::,[line break]";
		say "[']. [']. .=----=..-~  .;['][line break]";
		say " [']  ;[']  ::   [']:.  ['][quotation mark][line break]";
		say "   (:   [']:    ;)[line break]";
		say "    \\   ['][quotation mark]  ./[line break]";
		say "     ['][quotation mark]      ['][quotation mark][line break]";
		say variable letter spacing.

Instead of taking the unicorn:
	say "Only the pure of heart may approach a unicorn."

The diagrams are interesting scenery in the engineering department.
Understand "diagram" as the diagrams.
Instead of examining the diagrams:
	if Vorple is supported:
		place a link to web site "https://imgs.xkcd.com/comics/circuit_diagram.png" reading "You can't make any sense of them.";
		say line break;
	otherwise:
		say "You can't make any sense of them."

The cubicles are scenery in the engineering department.  "These are standard cubicles for standard engineers.  They are precisely measured, in imperial units.  America!"

The whiteboard is scenery in the engineering department.  "At the top of the whiteboard, someone has written 'APOLLO 11'.  Underneath the heading are some inscrutable [interesting]diagrams[/interesting], and in the bottom right corner, someone has drawn a [interesting]unicorn[/interesting]."




In the engineering department is a stranger called the engineer.  The real name of the engineer is "Rick".  The engineer can be sad.  When day one begins, now the engineer is not sad.  The engineer is male.

The engineer is carrying the blueprints.  The description of the blueprints is "The blueprints, which are distinctly white, say '[bold type]Apollo 11 Command Module[roman type]' on the top.  [if the player has the blueprints]They are looking a little worse for wear, to say the least.[otherwise]The drawing of the command module is surprisingly lifelike.  You've never seen a more beautiful rendering of a truncated cone."

The blueprints can be discussed.  [Only when you've asked about them can you take them.]
The blueprints are interesting and critical.  [You can't drop them.]
The blueprints are plural-named.  [Don't call them "a blueprints".]
Understand "drawing", "drawings", "command module drawing", "command module drawings", and "command module drawings formerly known as blueprints" as blueprints.

In the engineering department is an interesting, liquid-safe, transparent container called a coffee-pot.  The printed name of coffee-pot is "coffee pot".
[Accept a few misspellings of coffee.]
Understand "coffee pot", "cofee pot", "coffe pot", "cafe pot", "cofe pot", and "pot" as the coffee-pot.

The coffee is a drink in the coffee-pot.  The amount of coffee is 1000 ml.  The indefinite article is "some".
[Accept a few misspellings of coffee.]
Understand "cofee", "coffe", "cafe", and "cofe" as coffee.

Instead of taking the coffee:
	say "Most of it slips through your fingers, but you manage to get some of it to stain your pockets, too.";



The description of the engineer is "[if the engineer is not sad]He is tall and thin, with slicked-back ginger hair and a short-sleeved shirt and tie.  He is wearing a pocket protector and a [interesting]name badge[/interesting].  What a nerd![otherwise][The noun] is just about the saddest thing you've ever seen.  His hair is a mess, and he appears to have been wiping his tears on his tie."

The engineer wears a tie, a short-sleeved shirt, and a pocket protector.
The tears are scenery in the engineering department.



Instead of saying sorry while the player is in the engineering department and the engineer is sad:
	try saying sorry to the engineer.
Instead of saying sorry to the engineer while the engineer is sad:
	say "He sniffs a little, then says 'Um, yeah, okay.  Apology accepted.'";
	now the engineer is not sad.

Understand "ginger", "nerd", "man", "him", "himself", and "Rick" as the engineer.

The engineer is wearing a name-badge.  The printed name of the name-badge is "name badge".
Understand "badge" and "name badge" as name-badge.  [To disambiguate with the "name" concept.]

The description of the name-badge is "It says 'Rick' at the top.  The bottom says 'Apollo Systems Technician, Launch Enablement Yroup.'  ... Huh.  Must be a typo."

After examining the name-badge, make the engineer known.

Rule for writing a paragraph about the engineer:
	if the engineer is unknown, say "[interesting]An engineer[/interesting] is standing around[if the coffee-pot is in the location] by the [interesting]coffee pot[/interesting][end if], [if the engineer is sad]crying.[otherwise]doing nothing.";
	otherwise say "[interesting]Rick[/interesting] is still here[if the coffee-pot is in the location] by [interesting]the coffee pot[/interesting][end if], still [if the engineer is sad]crying.[otherwise]doing nothing.";

[Make sure the coffee pot doesn't show up in the room listing, as well as in the engineer paragraph.]
The coffee-pot is undescribed.
After taking the coffee-pot:
	now the coffee-pot is described;
	continue the action.

After dropping the coffee-pot:
	if the location is the engineering department:
		now the coffee-pot is undescribed;  [It goes back to being described in the room, so don't duplicate it in the room's contents.]
		continue the action.

Instead of talking to the engineer:
	say "Perhaps you could ask [the noun] about the weather, the command module blueprints, or himself."

Instead of quizzing the engineer about name:
	say "[The engineer] taps his [interesting]name badge[/interesting] and says, 'Can't you read?'"

Instead of quizzing the engineer about the weather:
	say "[The noun] glances up at the ceiling for a moment before replying, 'Maybe a bit cloudy, but we should still be clear for launch.  Besides, we're never gonna give this up.'"

Instead of quizzing the engineer about the engineer:
	say "[The noun] looks a bit embarrassed by the question, maybe even flattered.  He looks at his feet for a moment before replying, 'Well...  We're no strangers to love.'  Then he raises his eyes and gives you a look that makes you... distinctly uncomfortable."

Instead of quizzing the engineer about the blueprints:
	say "[The noun] looks both smug and offended at once.  '[bold type]ACTUALLY[roman type], they aren't blue at all!  The cyanotype [italic type]blueprint[roman type] began to be supplanted by [italic type]diazo prints[roman type], also known as [italic type][interesting]whiteprints[/interesting][roman type].'";
	make "whiteprints" known;
	now the printed name of get-blueprints is "Get command module whiteprints".

[Give this concept a location, so we can have rules about "taking" it.]
The whiteprints is a concept in the engineering department.
Instead of quizzing the engineer about the whiteprints:
	say "[The noun] rolls his eyes.  'Ha!  Nobody calls them whiteprints.' His laughter quickly devolves into snorts.  Wiping his eyes, he adds, 'It's okay.  Go ahead and [interesting][italic type]take the blueprints[roman type][/interesting] if you need them so badly.'";
	now the blueprints are discussed;
	now the printed name of get-blueprints is "Get command module drawings formerly known as blueprints".

[If the player tries "take whiteprints", it should behave the same as above, when asking about "whiteprints".]
Instead of taking the whiteprints:
	try quizzing the engineer about the whiteprints.
Instead of asking the engineer for whiteprints:
	try quizzing the engineer about the whiteprints.

[TODO: Is there an alternate solution we could add here?]
Instead of taking the blueprints:
	if the player has the blueprints:
		say "You already have the blueprints.";
	otherwise if the player's command includes "steal":
		say "It doesn't look like you'll be able to sneak up on [the engineer].  He's looking right at you.";
		show hint "You could ask for them instead.";
	otherwise if the blueprints are discussed:
		say "[The engineer] says, 'Here you go.'  He hands you a large roll of white paper which is not even slightly blue.  You cram the 3-foot roll of paper into your pocket, taking no care whatsoever to keep it neat or undamaged.  [The engineer] appears to be crying.";
		now the engineer is sad;
		now get-blueprints is checked;
		now the player has the blueprints;
		deactivate blueprints-hint;
	otherwise:
		try quizzing the engineer about blueprints.

Persuasion rule for asking the engineer to try giving the blueprints to the player:
	persuasion succeeds.

Instead of the engineer giving the blueprints to the player:
	try taking the blueprints;
	rule succeeds.

Instead of quizzing the engineer about NASA:
	say "[The engineer] beams, 'I am [bold type]so[roman type] proud to serve my country in the National Aeronautics and Space... um... anyway, I design rockets.  NASA rockets.  Big, blasting, noisy hard rockets!  It's the best.'"

Instead of quizzing the engineer about rocket:
	try quizzing the engineer about NASA.

Instead of quizzing the engineer about the command module:
	say "[The noun] chuckles and grins broadly.  '[bold type]That[roman type] is my pride and joy!  Officially, it's the 'Command and Service Module', or 'CSM', a truncated cone, 10 feet and 7 inches tall (which is about 1.814285 Buzz Aldrins tall), and 12 feet 10 inches across the base (which is about 0.8675309 Florida gators).  Really, it's one of the top... 30 truncated cones in engineering, at least!'"

Instead of quizzing the engineer about Apollo:
	say "[The noun] shudders and says, 'Gotta get this one right. How was I supposed to know that the sulphurous smell of the rocket fuel would cause the astronauts to vomit nonstop for the whole flight?  Commander Stafford needed three liters of fluids when he got back.  He still hasn't forgiven me.  Said they never could get the smell out of his favorite spacesuit.' [The noun] hangs his head, but then brightens and says, 'Apollo 11[']s gonna be different!'"

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

Blueprints-hint is an event.
After going to the engineering department:
	if get-blueprints is not checked:
		activate blueprints-hint in 8 turns;
	make "engineer" known;
	continue the action.
After going from the engineering department:
	deactivate blueprints-hint;
	continue the action.
Carry out triggering blueprints-hint:
	if the count of blueprints-hint > 1:
		show hint "Look around the room for something you need, or someone who may have something you need for your checklist.";
	otherwise:
		show hint "Look around the room for something you need for your checklist.";
	activate blueprints-hint in 6 turns.



The propulsion lab is north of the hallway.  "The propulsion lab is as large as a warehouse, and your footsteps echo throughout the space.  The skeleton of a moon buggy looms at one end, and on the other, someone is welding.  Along one wall are a series of wheeled [interesting]chalkboards[/interesting].  In the corner, there's [if the tapir is in the cage]a metal [interesting]cage[/interesting] with what appears to be a [interesting][tapir-aardvark][/interesting].[otherwise]an empty metal [interesting]cage[/interesting].[end if]  You can smell sparks and animal waste."
The printed name of the propulsion lab is "NASA Propulsion Lab".


The moon buggy skeleton is scenery in the propulsion lab.  The description of the moon buggy skeleton is "It looks like every other moon buggy skeleton you've ever seen."


The chalkboard is in the propulsion lab.  The description of the chalkboard is "A large, slate black, wheeled chalkboard covered in inscrutable [interesting]equations[/interesting]."
The chalkboard is interesting and undescribed.  [Mentioned in the scenery, but not in the room.]
The chalkboard is pushable between rooms.
Understand "chalk board" and "board" as the chalkboard.

Equations and rocket-equations are interesting parts of the chalkboard.
[To allow them to be examined while you're in any room with the chalkboard.]
Instead of examining equations:
	say "You can't make heads or tails of them, but the [interesting]wheeled chalkboards[/interesting] are covered in them.";
Instead of examining rocket-equations:
	try examining equations.
Instead of taking equations:
	say "You aren't sure you'd be able to copy them correctly, even if you tried.  If only you could somehow get the originals...";
	stop the action.
Instead of taking rocket-equations:
	try taking equations.

Copying is an action applying to one thing.  Understand "copy [thing]" and "copy down [thing]" and "make copy of [thing]" as copying.
Check copying equations:
	say "You don't feel confident that you would get them right, even if you tried.  If only you could somehow get the originals...";
	stop the action.
Check copying blueprints:
	say "You don't feel confident that you would get them right, even if you tried.  If only you could somehow get the originals...";
	stop the action.
Check copying whiteprints:
	say "You don't feel confident that you would get them right, even if you tried.  If only you could somehow get the originals...";
	stop the action.
Check copying:
	say "You don't know how to copy that.";
	stop the action.

Instead of taking the chalkboard:
	if the player has alien-equations:
		say "You have the paper that [tapir] gave you, so you don't think you'll need the chalkboards any more.";
	otherwise if the location is the propulsion lab:
		say "You hurriedly start pushing one of the wheeled [interesting]chalkboards[/interesting] out of the room.  [The head scientist] screams after you, '[bold type]SCHWEINHUND!  [italic type]HALT!!![roman type]'[line break]";
		now the head scientist is enraged;
		now the chalkboard is described;  [It will show up in room descriptions again.]
		now the chalkboard is critical;  [You can't leave it behind; see below]
		now get-equations is checked;  [Woohoo!]
		deactivate equations-hint;
		if the tapir is in the hallway:
			now the tapir is in purgatory;  [Never to be seen again.]
		now the chalkboard is in the hallway;
		try going south;
	otherwise:
		say "You've already brought that with you into the room, and there's no way it would fit in your pockets."

Instead of going to anywhere (called the destination):
	if the chalkboard is critical:
		say "([one of]You push the massive [chalkboard] along with you[or]As you drag the [chalkboard] over the threshold into [the destination], one of the wheels catches on the door jam and the giant board falls to the ground.  It takes you a minute or two to get it upright again[or]You drag the [chalkboard] along, and hope like hell that it turns out to be worth the effort[purely at random].)[line break]";
		now the chalkboard is in the destination;
	continue the action.

Every turn when a random chance of 1 in 10 succeeds and the player is in the propulsion lab and get-equations is not checked:
	say "[The head scientist] grumbles under his breath and erases half of the equations on one of the [interesting]mobile, wheeled chalkboards[/interesting], then starts furiously scribbling new ones."

Equations-hint is an event.
After going to the propulsion lab:
	if get-equations is not checked:
		activate equations-hint in 8 turns;
	make "head scientist" known;
	make "other scientsts" known;
	make "tapir" known;
	continue the action.
After going from the propulsion lab:
	deactivate equations-hint;
	continue the action.
Carry out triggering equations-hint:
	if the count of equations-hint > 1:
		show hint "Look around the room for something you need, or someone who may have something you need for your checklist.";
	otherwise:
		show hint "Look around the room for something you need for your checklist.";
	activate equations-hint in 6 turns.



The cage is interesting scenery in the propulsion lab.
The cage is an openable, transparent, lockable, locked container in the propulsion lab.
The head scientist carries a brass key.
The brass key unlocks the cage.
The brass key is interesting and critical.
The brass key can be noticed or unnoticed.  When day one begins, now the brass key is unnoticed.
The description of the cage is "It's a wide cage made of thick metal bars, with a locking mechanism built into the door.[if the tapir is in the cage]  [interesting]The [tapir-aardvark][/interesting] inside looks distressed.[end if]".

The locking mechanism is scenery in the propulsion lab.
Understand "lock" as the locking mechanism.

The welder is a person in the propulsion lab.  The description of the welder is "You try to watch them working, but you don't have one of those protective helmets, so you quickly think better of it."
The welder is undescribed.  [Already in room description.]
Instead of talking to the welder:
	say "They look busy."
Instead of quizzing the welder about something:
	say "They look busy."

The waste is scenery in the propulsion lab.  "Eww."  Understand "animal waste" as the waste.
Instead of taking waste:
	say "Eww, eww, ewwww!!!";
	stop the action.

[This will say tapir or aardvark, but never Brizzleby.]
To say tapir-aardvark:
	if the tapir is an aardvark:
		say "aardvark";
	otherwise:
		say "tapir".

After examining the head scientist:
	now the brass key is interesting;
	now the brass key is noticed;
	make "key" known;
	continue the action.

Understand "steal [something]" as taking.
Understand "steal [something] from [someone]" as removing it from.
Instead of removing the brass key from the scientist:
	try taking the brass key.
The brass key has a number called steal-attempts.  [It will work the second time.  We don't want to be obnoxious.]
Instead of taking the brass key:
	if the brass key is unnoticed:
		say "You can't see any such thing.";
		show hint "The key must be here somewhere... Try examining things in the room.";
	otherwise if the head scientist does not have the brass key:
		continue the action;
	otherwise if the head scientist is enraged:
		say "You try to sneak over and reach into [the head scientist]'s coat pocket, but at your first step, his head snaps around and he stares you down until you take a step back again.";
		show hint "Maybe there's something you can say to calm him down...";
	otherwise if a random chance of 5 in 10 succeeds or the steal-attempts of the brass key is 1:
		say "You sneak up on [the head scientist] carefully, and reach into his coat pocket.  You manage to lift the brass key out of his pocket without him noticing!";
		now the player has the brass key;
	otherwise:
		say "You sneak up on [the head scientist] carefully, and reach into his coat pocket.  You fumble the key, and he whips around at the clanging sound.  There is a brief moment of shock upon his face, but it rapidly dissolves into rage as he screams '[bold type]SCHWEINHUND![roman type]' and chases you from the room.";
		show hint "Maybe you could be successful if you try again, or maybe you could find another solution...";
		increase the steal-attempts of the brass key by 1;
		now the head scientist is enraged;
		now the player is in the hallway.
After opening the cage while the tapir is in the cage:
	if the tapir is not known:
		if a random chance of 1 in 10 succeeds:
			say "As soon as the cage door opens, the [tapir] darts through, trampling you to death in the process.  You are buried with full honors in the 'bizarre animal tragedies' section of Arlington National Cemetery.  Your tombstone reads, 'Intern.'";
			show ending 5 of 9 aka the "trampling" ending;
		otherwise:
			say "As soon as the cage door opens, the [tapir] darts through and out into the hallway.  You narrowly avoid being trampled by the thing.[paragraph break]";
			say "Noticing the commotion, [the head scientist] turns around and becomes apoplectic at what has happened.  '[bold type]MEIN ERDFERKEL!  What have you done?![roman type]'[line break]";
			now the head scientist is enraged;
			now the tapir is in purgatory;  [never to be seen again]
	otherwise:
		say "As you open the door, the [tapir-aardvark] gives you a wink and quietly slips out of the room.";
		if get-equations is checked:
			now the tapir is in purgatory;  [You didn't need him.]
		otherwise:
			now the tapir is in the hallway;  [There's an alternate way to get the equations.]



The tapir is a stranger [animals are people, too, in Inform] in the cage.
The tapir can be an aardvark.
The description of the tapir is "[The tapir] is a bit larger than your average [tapir-aardvark], with intelligent eyes, rabbit-like ears, strong front claws, and a flat, round nose that protrudes from its head.  [if the tapir is in the cage]It lays sadly on the bottom of [the cage], looking distinctly sad and uncomfortable.[otherwise]It stands upright on its rear legs, thought it doesn't look like it has much practice.[end if]".
Rule for printing the name of the tapir:
	if the tapir is known:
		say "Brizzleby";
	otherwise:
		say "[tapir-aardvark]".

The real name of the tapir is "Brizzleby".
Understand "aardvark", "aardvarks", "ardvark", "ardvarks", and "animal" as the tapir.

Every turn when a random chance of 3 in 10 succeeds and the player is in the propulsion lab and the tapir is in the cage:
	say "[one of]The [tapir-aardvark] makes a snuffling sound.[or]A long, sad groan comes from [the cage].[or]Something in here smells distinctly like a [tapir-aardvark] fart.  (You definitely know what those are like.)[purely at random]".



[You can talk _to_ the tapir without opening the cage first.]
Rule for reaching inside the cage while talking to:
	rule succeeds.
Rule for reaching inside the cage while quizzing:
	rule succeeds.
[You can talk _about_ the tapir without opening the cage first.]
Rule for reaching inside the cage while quizzing generally:
	rule succeeds.

[If there isn't a topic for this with a specific person, that person will not know about the tapir.]
Instead of quizzing someone about the tapir:
	say "[The noun] looks confused.  'Who?'";

Instead of talking to the tapir:
	say "The [tapir-aardvark] says in a low whisper: 'Hey, kid!  You gotta get me out of here.'";
	make "key" known.

Instead of quizzing the tapir about the brass key while the tapir is in the cage:
	say "The [tapir-aardvark] says in a low whisper: 'Von Braun has it.  Now be quick!'";
	make the head scientist known.

Instead of quizzing the tapir about anything while the tapir is in the cage:
	say "The [tapir-aardvark] shakes his head rapidly from side to side, and whispers, 'Not here!  It's not safe to talk around the others.  Get me out, and I'll tell you everything!'"

[HACK: This works around "the cage isn't open" if you "ask tapir for name".]
Before asking the tapir for name while the tapir is in the cage:
	try quizzing the tapir about name;
	stop the action.
Instead of quizzing the tapir about name while the tapir is in the cage:
	say "The [tapir-aardvark] glances side to side to make sure the scientists are distracted before hissing in a low voice, 'Brizzleby, of the Galactic Federation of Aardvarks.  Now get me the hell out of here!'";
	now the tapir is known;
	make "aardvark" known;
	make "Brizzleby" known.
Understand "Brizzleby", "space-aardvark", "space-ardvark", and "Brizzleby the space-aardvark" as the tapir.

Instead of quizzing the tapir about name:
	say "'Brizzleby, of the Galactic Federation of Aardvarks, at your service.'";
	now the tapir is known;
	make "Brizzleby" known.

Instead of quizzing the tapir about the tapir:
	try quizzing the tapir about name.

Instead of quizzing the tapir about equations:
	try quizzing the tapir about rocket-equations.

Alien-equations is a critical thing.
The description of alien-equations is "A small slip of paper written in an alien language, or possibly in English as written by the hand of an aardvark.  You have been told that these are extremely advanced rocket equations.[if Vorple is supported]
[alien-paper style]
Mix high-quality bourbon whiskey with lemon juice and maple syrup, then garnish with orange peel and a cocktail cherry.  Shake with ice and serve.
[end style][end if]"

Understand "alien equations" as alien-equations.  [If I give the object its natural name instead of using "understand", then "equations" results in a disambiguation prompt between "equations" and "alien equations", which is confusing.]
The printed name of alien-equations is "alien equations".
Understand "paper" as alien-equations.


Instead of quizzing the tapir about rocket-equations:
	say "Brizzleby gives you a satisfied smile.  'I knew you were something special.  Yes, [']rocket equations['] are indeed a thing.  Here.  Take these.  They are the Galactic Federation's most advanced rocket equations.'  He hands you a small slip of paper written in an alien language, or possibly in English as written by the hand of an aardvark.[paragraph break]";
	now the player has alien-equations;
	now get-equations is checked;
	say "He glances at the ceiling for a long moment, then adds, 'It's time for me to get back to my people.  Thank you, noble intern, for freeing me.'  Before you can react, he licks your face, then quickly lopes down the hallway and vanishes from sight.";
	now the tapir is in purgatory.

Instead of quizzing the tapir about NASA:
	try quizzing the tapir about Apollo.

Instead of quizzing the tapir about the head scientist:
	say "The space-aardvark shudders.  'That man... he's a menace to aardvark-kind.  Let's not talk about it.'"

Instead of quizzing the tapir about Apollo:
	say "'Bah', he begins.  'The Apollo program is a joke.  It'll never get off the ground.  You monkeys have no idea what you're doing.'"



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

The description of the head scientist is "[The noun] is a man of average height, his hair graying at the sides, wearing a white lab coat over a dark gray suit and tie.[if the head scientist is enraged]  His anger toward [italic type]you specifically[roman type] is practically a physical presence of its own, hanging about his temples like a fog."

The head scientist wears a white lab coat, a dark gray suit, and a tie.
The anger is scenery in the propulsion lab.
Instead of taking the anger:
	say "Anger is a weapon only to one's opponent."



Instead of talking to the head scientist:
	if the head scientist is enraged:
		say "You open your mouth to speak to [the noun], but he shoots you a rageful glare of such silent violence that you think better of it and shut your mouth again.";
	otherwise:
		say "Perhaps you could ask [the noun] about the equations, his work, the [tapir-aardvark], or himself."

Instead of quizzing the head scientist about name:
	say "He stops what is doing and considers you as if noticing you for the first time.  'Herr Doktor Wernher Magnus Maximilian Freiherr von Braun, chief scientist of the NASA propulsion lab.'  Then, without making it a true question and without any apparent interest in the answer, adds, 'How do you do.'";
	make the head scientist known.

Instead of quizzing the head scientist about the head scientist:
	try quizzing the head scientist about name.

Before quizzing the head scientist about the tapir:
	if the player's command includes "Brizzleby":  [This name is secret.]
		say "[The noun] looks confused.  'Who?'";
		stop the action;
	otherwise if the head scientist is enraged:
		say "He looks relieved at this topic.  [run paragraph on]";
		now the head scientist is not enraged.  [He loves that thing.]

Instead of quizzing the head scientist about the tapir:
	if the player's command includes "Brizzleby":  [This name is secret.]
		say "[The head scientist] doesn't seem to know who that is.";
	otherwise if the tapir is not in the cage:
		say "He looks profoundly upset at the question.  'Ruined.  Everything is ruined now.  My life's work...'";
	otherwise if the player's command includes "tapir":
		say "'Ist no tapir', replies [the head scientist] cooly.  'Ist an [interesting]aardvark[/interesting], obviously.  What else would you find here at the National Agency of Space Aardvarks?'";
		make "aardvark" known;
		now the tapir is an aardvark;
	otherwise:
		say "[The head scientist] looks at you quizzically.  'What else would you find here at the National Agency of Space Aardvarks?'";

Instead of quizzing the head scientist about NASA:
	if the tapir is not in the cage:
		say "He looks profoundly upset at the question.  'Ruined.  Everything is ruined now.  My life's work...'";
	otherwise:
		say "He considers thoughtfully before replying, 'It's a job.  But at least here at the National Agency of Space Aardvarks, I work to bring about true emancipation of the [interesting]aardvarks[/interesting] by returning them to their home in outer space.'  He looks up at the ceiling of the lab for a long moment.  You look up as well, but see nothing other than a white painted lab ceiling, about 40 feet high."

Instead of quizzing the head scientist about rocket:
	say "'Well,' he begins, looking quietly pleased with himself, 'My rockets are simply the best.  As you can plainly see, even enemies of the Reich were forced to acknowledge the greatness of my work.'  He turns to consider the [interesting]chalkboards[/interesting] behind him and adds dreamily, 'I have spent years perfecting this new one...'"

Instead of quizzing the head scientist about work:
	try quizzing the head scientist about rocket.

Instead of quizzing the head scientist about equations:
	say "'What about them?' he snaps.  'I'm very busy.'  [The noun] turns back to the [interesting]chalkboards[/interesting]."

Instead of quizzing the head scientist about rocket-equations:
	say "He turns to you very suddenly.  '[italic type]Rocket equations?[roman type]  You sound ridiculous!  What buffoon would say such a thing?  [bold type]Stop wasting my time![roman type]'[line break]";
	make "equations" known;
	now the head scientist is enraged.

Instead of quizzing the head scientist about Apollo:
	if the tapir is not in the cage:
		say "He looks profoundly upset at the question.  'Ruined.  Everything is ruined now.  My life's work...'";
	otherwise:
		say "Apollo ist my greatest work.  Finally I achieve my greatest glory in my career and achieve the highest aims of NASA, the National Agency of Space Aardvarks: to deliver the [interesting]aardvark[/interesting] back into space.  Apollo 11 will deliver the [interesting]aardvarks[/interesting] to their true home.";

Instead of quizzing the head scientist about anything while the head scientist is enraged:
	say "[The noun] throws an eraser at you and screams [bold type]'GET OUT!'[roman type][line break]";

Instead of saying sorry while the player is in the propulsion lab and the head scientist is enraged:
	try saying sorry to the head scientist.
Instead of saying sorry to the head scientist while the head scientist is enraged:
	say "[The head scientist] stares at you angrily for the space of a breath, then rips off one shoe and chases you out of the room with it.[paragraph break]";
	if a random chance of 9 in 10 succeeds:
		say "You barely escape un-swatted.[line break]";
		show hint "Maybe there's a topic he will find soothing...";
		now the player is in the hallway;
	otherwise:
		say "Just before you reach the doorway to the hall, [the head scientist] manages to clock you on the side of the head with his shoe.  You suffer a freak hemorrhage and die on the spot.  You are the first NASA employee in the agency's (administration's?) history to die in such a pointless and embarrassing way.  Apollo 11 fails miserably, NASA becomes a worldwide laughing-stock, and Russia conquers the globe by 1972.  Your tombstone in Arlington National Cemetery reads 'Intern.'";
		show ending 3 of 9 aka the "shoe" ending;



In the propulsion lab is a person called the other scientists.
The other scientists are plural-named.
Understand "others", and "them" as the other scientists.
The description of the other scientists is "They scurry around busily in white lab coats, occasionally looking back at [the head scientist] to see if he is noticing their industriousness.  (He most certainly is not.)"

The other scientists wear white lab coats.

[NOTE: Something really odd is happening, and the only people who understand Inform in enough detail to debug this are Graham Nelson and gray aliens.  For whatever reason, "other scientists", which is the _EXACT NAME_ of the character, resolves to "the head scientist", which is _MADDENING_.  This is a hacky workaround, in which we just edit the user's commands as they come in and replace the thing that _should_ work with an explicit alias that _does_ work.]
After reading a command:
	let N be "[the player's command]";
	replace the regular expression "\bother scientists?\b" in N with "the others";
	change the text of the player's command to N.

Instead of quizzing the other scientists about the head scientist:
	say "The other scientists glance warily in the direction of [the head scientist], who [if the head scientist is enraged]glares at them with fire in his eyes[otherwise]looks back with calm surety[end if].  In unison, the scientists chant, 'Dr. von Braun is the best boss a scientist could ask for.  His work in the field is unparalleled, and we are lucky to be in his lab.'  [The head scientist] looks pleased about this, and turns back to his work at the [interesting]chalkboards[/interesting].";
	make the head scientist known;
	now the head scientist is not enraged;

Instead of quizzing the other scientists about the tapir:
	if the player's command includes "Brizzleby":
		say "The scientists don't seem to know who that is.";
	otherwise:
		say "The scientists throw each other sideways glances, then look to see if [the head scientist] is watching.  Then one of them says under her breath, '[if the tapir is not known]It's an [interesting]aardvark[/interesting], actually.  [end if]He's obsessed.  Nobody around here gets it.  He raves about the [interesting]aardvarks[/interesting] all the time, ever since the war.  Director Furtwangler only convinced him to come work here by telling him we were the National Agency of Space Aardvarks.'  She grimaces and gives [the head scientist] a look that is both mystified and compassionate.";
		make the director known;
		make the tapir known.

Instead of quizzing the other scientists about anything:
	try talking to the other scientists.

Instead of talking to the other scientists:
	say "They all look incredibly busy and smart in those white lab coats.  You can't seem to get their attention."



Purgatory is a room.  [It is inaccessible, but we need the astronauts to be in some room initially.  Not giving them an initial location causes the rules for "choosing crew" to fail with a built-in message about them being "unavailable".  Putting them in literally any room fixes this.  We don't want the player to meet them yet, so they begin here.]

An astronaut is a kind of person.  [They don't have special properties, but they are unique for the game.  Other kinds of people are ineligible for the mission.]

Buzz Aldrin is a male astronaut in purgatory.
Neil Armstrong is a male astronaut in purgatory.
Michael Collins is a male astronaut in purgatory.
Lisa Nowak is a female astronaut in purgatory.
Ijon Tichy is a male astronaut in purgatory.
Clifford McBride is a male astronaut in purgatory.

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
The metallic filing cabinet is an interesting, enterable supporter.
After examining the metallic filing cabinet:
	make "files" known.

An interesting, openable, closed container called the drawer is part of the metallic filing cabinet.  "The drawer is labeled 'Crew Candidate Personnel Files'."
[We don't get told automatically what is inside an open container if it's part of another thing.  Fix this for the open drawer.]
Before listing exits:
	if the player is in the personnel department:
		if the drawer is open:
			say "In the open cabinet drawer, you can see [list of things in the drawer].[paragraph break]";
	continue the action.

[This mapping will allow us to enable the player to type both "choose Buzz Aldrin" and "choose file 1".]
A personnel-file is a kind of thing.  A personnel-file has a person called the employee.
personnel file 1 is a critical personnel-file in the drawer.
personnel file 2 is a critical personnel-file in the drawer.
personnel file 3 is a critical personnel-file in the drawer.
personnel file 4 is a critical personnel-file in the drawer.
personnel file 5 is a critical personnel-file in the drawer.
personnel file 6 is a critical personnel-file in the drawer.

The personnel puzzle is a concept.  The personnel puzzle can be ready.  When day one begins, now the personnel puzzle is not ready.

The head of personnel is a stranger in the personnel department.
The real name of the head of personnel is "Franklin".
The head of personnel is male.

Understand "head", "Franklin", "Franklin Stanford", "Stanford", "him", "man", and "himself" as the head of personnel.

When day one begins, now the head of personnel is asleep.  [Aren't we all?]

The description of the head of personnel is "[The noun] is a short, balding man wearing black eyeglasses, a short-sleeved shirt, and a plain tie.  He is [if the head of personnel is asleep]snoring softly with his feet up, occasionally twitching in his chair[otherwise]staring at you impatiently.  He must not enjoy having his nap interrupted[end if]."

The head of personnel wears black eyeglasses, a short-sleeved shirt, and a plain tie.




Instead of waking the head of personnel:
	if the head of personnel is asleep:
		say "You say 'Excuse me,' and [the head of personnel] snorts and snaps awake, practically falling out of his chair.  'Wha?!' he exclaims, then adds testily, 'What is it?  What do you want?'";
	continue the action.

Instead of talking to the head of personnel:
	if the head of personnel is asleep:
		try waking the head of personnel;
	otherwise if the personnel puzzle is ready:
		say "Perhaps you could ask [the noun] about the crew candidates, various employees, NASA, Apollo, or himself.";
	otherwise:
		say "Perhaps you could ask [the noun] about the crew candidates, the personnel files, NASA, Apollo, or himself."

Instead of quizzing the head of personnel about name:
	say "'Franklin, Franklin Stanford.  What the hell do you want?  Spit it out.'";
	make the head of personnel known.

Instead of quizzing the head of personnel about the head of personnel:
	try quizzing the head of personnel about name.

[NOTE: Unlike other concepts, this one must be in a room, since we can use it with "take".  And since we have a rule for "drop", which needs to work no matter where you go, let's make the files "everywhere".]
The personnel files is a concept.  The personnel files are everywhere.
Understand "files" as the personnel files.

Instead of giving anything to the head of personnel while the head of personnel is asleep:
	try waking the head of personnel.

Instead of quizzing the head of personnel about anything while the head of personnel is asleep:
	try waking the head of personnel.



Instead of quizzing the head of personnel about Apollo:
	say "'Wait [']til those pencil-necked poindexters over at the other NASA see what our insane pet German cooked up!  They should've known better than to attempt to beat us at our own game.  As if they could out-NASA us.'  [The head of personnel] snorts derisively."

Instead of quizzing the head of personnel about NASA:
	say "'National Agency of Space Astronauts.  Duh.  Here are NASA we pride ourselves at being the #1 source of American space astronauts.  Now those do-nothings over at our rival organization, the National Astronautics Sentral Authority, tried to muscle in on our game, but there's only room for one NASA in this country.'"

Instead of quizzing the head of personnel about the secretary:
	say "'Oh, Donna?  She's the real brains of this operation.  Furtwangler couldn't get a damn thing done without her.'";
	make the director known;
	make the secretary known.

Instead of quizzing the head of personnel about the director:
	say "'Furtwangler... more like SkirtTangler!' he exclaims, looking at you to see if you're laughing. 'He's more interested in Earth women than extraterrestrial glory.  Word around the Tang cooler is that he's in trouble with the Missus on account of the Miss, if you know what I mean.'";
	make the director known.

Instead of quizzing the head of personnel about the engineer:
	say "'Now that's a guy who's never gonna tell a lie and hurt you.'  When [the head of personnel] notices your confusion, he goes on, 'Well, he certainly never let [bold type]me[roman type] down.'";

Instead of quizzing the head of personnel about the head scientist:
	say "'Von Braun is a genius, and as you may know, 100% bazonkers.  He actually thinks that some anteaters are aliens.  Sure knows his way around a rocket, though.'";
	make the head scientist known.

Instead of quizzing the head of personnel about the other scientists:
	say "'I call those empty headed lackeys [']The Chorus.[']  All they do is say [']Yes, Herr Doktor von Braun, whatever you say, sir!['] no matter what insanity he cooks up.  Sure, sometimes it's rocket equations and fuel formulations, but sometimes, it's combing through the genetic code of an anteater or whatever bizarro animal he's obsessed with.  They just smile and say [']Yes, Herr Doktor Frankenpants, whatever you say, sir![']  What a bunch of ninnies.'";
	make the head scientist known.

Instead of quizzing the head of personnel about Buzz Aldrin:
	say "'Don't get close enough to that guy to smell his breath, or you [italic type]will[roman type] regret it.'"

Instead of quizzing the head of personnel about Neil Armstrong:
	say "'Fun fact: his arms are notoriously weak.  Once, I saw him struggle to lift a can of Coke.'"

Instead of quizzing the head of personnel about Michael Collins:
	say "'A good enough fellow if you can handle his Irish brogue.  Don't mention the Brits around him though.  Wouldn't be surprised if he tried to claim the moon in the name of Ireland.  Between you and me, he'd be a lot more fun if he had a TOM Collins or two.'"

Instead of quizzing the head of personnel about Lisa Nowak:
	say "'Shhhh!' he says, looking from side to side, his voice dropping to a whisper.  'We used to date casually, and when I broke it off, she went a little nutso.  I had to fake my own death.  Why do you think I hide out in this tiny office?'"

Instead of quizzing the head of personnel about Ijon Tichy:
	say "'That guy only speaks Polish, but he sure is a good sport.  World champion at limbo.  Worrying habit of trying to fix things by hitting them with a hammer; not a great modus operandi in a space shuttle.'"

Instead of quizzing the head of personnel about Clifford McBride:
	say "'Ugh, don't get me started.  What a zealot.  Those are the ones you have to watch out for.  Collins, Tichy, Armstrong, Aldrin, Nowak, they don't have much else in their lives other than NASA, but they've got some other interests.  McBride, now, if he weren't an astronaut, he'd be some kind of mad bomber.  Safer to have him in space than on planet Earth.  He puts the ass in astronaut.'"

Instead of quizzing the head of personnel about the photographer:
	say "'How many Stanley Kubricks does it take to screw in a lightbulb?'  [The head of personnel] looks at you expectantly, then goes on, 'Just one, but he needs 127 takes.'  [The head of personnel] guffaws, then notices your lack of reaction.  'It's funnier if you know the guy.'";
	make the photographer known.

Instead of quizzing the head of personnel about the chemist:
	say "'Every time I'm around Molly, I just feel so close to her, you know?  Like we really understand each other, and we're all just trying to get through this crazy, exquisitely-heartbreaking, beautiful world.  Then, about three to six hours later, I can't even remember why I went to see her in the first place.'";
	make the chemist known.


Instead of saying sorry while the player is in the personnel department and the head of personnel is not asleep:
	try saying sorry to the head of personnel.
Instead of saying sorry to the head of personnel while the head of personnel is not asleep:
	say "[The head of personnel] grunts and pointedly props his feet back up on his desk.  Within a moment, he is snoring again.";
	now the head of personnel is asleep;

[Instead of taking them one-by-one, as the autocomplete system would have you do, take them all at once, which sets the "puzzle ready" flag.]
Instead of taking a personnel-file:
	try taking the personnel files;

Instead of quizzing the head of personnel about the crew:
	if the personnel puzzle is not ready:
		say "[The noun] snorts.  'A bunch of prima donnas, every one of [']em.  You can have your pick.'  He reaches into the [interesting]filing cabinet[/interesting] and produces a set of six [interesting]files[/interesting] for you.  'Here you go,' he says, handing you the files.  'Anything else?'";
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

After going to the personnel department:
	make "head of personnel" known;
	continue the action.

After going from the personnel department:
	now the head of personnel is asleep;
	continue the action.



The employee of personnel file 1 is Buzz Aldrin.
The description of personnel file 1 is "[fixed letter spacing][personnel-file-card style][bold type]NASA PERSONNEL FILE: ALDRIN, EDWIN E. JR. ('BUZZ')[roman type]

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


The employee of personnel file 2 is Neil Armstrong.
The description of personnel file 2 is "[fixed letter spacing][personnel-file-card style][bold type]NASA PERSONNEL FILE: ARMSTRONG, NEIL ALDEN[roman type]

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


The employee of personnel file 3 is Michael Collins.
The description of personnel file 3 is "[fixed letter spacing][personnel-file-card style][bold type]NASA PERSONNEL FILE: COLLINS, MICHAEL[roman type]

Professional History:
[line break]   * Joined the Irish Republican Brotherhood at age 19
[line break]   * Aide-de-camp, rebel headquarters, Easter Rising
[line break]   * Chairman of the Provisional Government, Irish Free State
[line break]   * Commander-in-Chief of the National Army, Irish Free State

Psychological profile:
[line break]   * Abrasive, fiercely proud
[line break]   * Does not consult with others on decisions
[line break]   * Has not attended official NASA meetings since his assassination in August 1922
[line break][end style][variable letter spacing]".


The employee of personnel file 4 is Lisa Nowak.
The description of personnel file 4 is "[fixed letter spacing][personnel-file-card style][bold type]NASA PERSONNEL FILE: NOWAK, LISA MARIE[roman type]

Professional History:
[line break]   * Graduated US Naval Academy, Annapolis, BS in aerospace engineering
[line break]   * Served in US Navy Electronic Warfare Aggressor Squadron
[line break]   * US Naval Postgraduate School, Monterey, MS in aeronautical engineering

Psychological profile:
[line break]   * Enjoys long road trips
[line break]   * Refuses to use rest stops
[line break]   * Loves to plan elaborate surprises

[line break][end style][variable letter spacing]".


The employee of personnel file 5 is Ijon Tichy.
The description of personnel file 5 is "[fixed letter spacing][personnel-file-card style][bold type]NASA PERSONNEL FILE: TICHY, IJON[roman type]

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


The employee of personnel file 6 is Clifford McBride.
The description of personnel file 6 is "[fixed letter spacing][personnel-file-card style][bold type]NASA PERSONNEL FILE: MCBRIDE, H. CLIFFORD[roman type]

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


The list of crew candidates is a list of people that varies.

After examining a personnel-file (called this-file):
	make "[employee of this-file]" known;
	add the employee of this-file to the list of crew candidates.


Choosing for crew is an action applying to one thing.  Understand "choose [anyone]" as choosing for crew.
[NOTE: "anyone" should match people who are not present.  But we still need this rule to allow it:]
Rule for reaching inside a room while choosing for crew:
	allow access.  ["Reaching inside a room" means that person is in literally any other room.]
Extra autocomplete verbs rule:
	if the personnel puzzle is ready and TBD is listed in the sub-items of choose-crew:
		[Have the files, haven't chosen everyone yet.]
		add "choose " to extra-verbs;
		execute JavaScript code "addCustomAutoComplete(/^ *choose +$/, [the list of crew candidates as JSON].map(x => x+'\n'))";
To say (L - a list of objects) as JSON:
	let J be "[bracket]";
	repeat with N running through L:
		now J is "[J]'[N]', ";
	now J is "[J][close bracket]";
	say "[J]";


Check choosing for crew:
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
		now the noun is in the sound stage;  [Where they will be met on day two.]
		if the number of entries in the sub-items of choose-crew is 3:
			now choose-crew is checked;
		while the number of entries in the sub-items of choose-crew < 3:
			add TBD to the sub-items of choose-crew;
		say "You add [the noun] to the crew list for Apollo 11.";
		if choose-crew is checked:
			say "That should do it!  There was only room for three."


[Some players in testing wanted to "choose file 1".  This is reasonable, so we support it here.]
Choosing crew by is an action applying to one thing.  Understand "choose [personnel-file]" as choosing crew by.
Check choosing crew by personnel-file (called the particular-file):
	try choosing for crew the employee of the particular-file.



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
	say "([X] is complete now.  You should report back to [the director] and give him the checklist.)";



[---------- DAY 2 ----------]

Day two is a scene.
Day one ends when checklist-1 is held by the director.
Day two begins when day one ends.

Director-yells-2 is an event.
When day two begins:
	log event "day2";
	say "[room-heading style]Intermission: End of day one[end style]";
	say line break;
	say "You head home, exhausted from a long day at the most important agency (authority? association?) in America.  You collapse into a dreamless sleep, and wake refreshed, ready for you next challenge.[paragraph break]";
	pause;
	say "[room-heading style]NASA Headquarters, day two of your internship[end style]";
	say line break;
	say "You return to NASA headquarters, brimming with pride over the good work you've done so far.  What challenges await today?  You can hardly contain your excitement as you wait to see the director again.[paragraph break]";
	pause;
	now checklist-1 is nowhere;
	now the blueprints are nowhere;
	now the chalkboard is nowhere;
	now the chalkboard is not critical;  [So you aren't traveling with it anymore]
	now checklist-2 is on the director's desk;
	now the director is not ready;
	now the director is not visited;
	now the director is not relaxed;
	now the secretary is not mad;
	now the player is in the waiting room;
	activate secretary-warns in 1 turns;
	activate director-yells-2 in 5 turns.




Carry out triggering director-yells-2:
	say "A booming voice comes from the director's office: 'Donna!  Is that damned kid late again?!  Why did we even hire that punk?'[paragraph break][The secretary] shrugs at you and gestures toward [the director]'s office door.";
	now the director is ready;
	[Give periodic reminders to get into the director's office if the player misses the first yell.]
	activate director-yells-2 in 3 turns.

Glitter is a concept.  The allowed-scene of glitter is day two.
Understand "operation glitter" as glitter.

Checklist-2 is an interesting, critical checklist.
The printed name of checklist-2 is "Operation Glitter checklist".
The description of checklist-2 is "The checklist is [if checklist-2 is on the director's desk]laying on the desk, [end if]scribbled out in childish print."
Checklist-2 can be ready.  When day two begins, now checklist-2 is not ready.
Understand "Operation Glitter checklist" as checklist-2.
Understand "checklist" as checklist-2.
Checklist-2 is privately-named.  [Only aliases can be used.]

[HACK: "checklist" is a type, so it could refer to any object of that type.  Sadly, when "asking about", because we are allowed to talk about things in other places, we get a disambiguation prompt for "ask about checklist", even before day two.  This causes a spoiler about Operation Glitter.  These "does the player mean" rules help to disambiguate the checklists based on the scene.]
Does the player mean doing something with checklist-1 when day one is happening:
	it is very likely.
Does the player mean doing something with checklist-2 when day two is happening:
	it is very likely.



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
	[The player may be taking it out of a container in some other location, in which case this dialog makes no sense.]
	if the player is in the director's office and the player does not have checklist-2:
		if checklist-2 is ready:
			say "[The director] looks relieved and says, 'Now, you did good work for us yesterday.  Keep it up, and Nixon might let us all see our families again.  Heh heh.'  His chuckle is not at all comforting.";
			show hint "You can examine the [interesting]checklist[/interesting] to see the details.";
			now the director is relaxed;
			continue the action;
		else:
			say "'Not so fast!' says [the director].  'We need to talk first.'";
			show hint "Try 'ask about' to talk to the director about various topics.";

Glitter can be known.
After examining checklist-2:
	now glitter is known;
	make "preparing astronauts" known;
	make "lunch" known;
	make "food" known;
	continue the action.

Instead of talking to the director during day two:
	say "Perhaps you could ask [the director] about Apollo, [if glitter is known]Operation Glitter, [end if]or the astronauts.";
[TODO: Are these the best Dirk topics for day two?]

Apollo can be day-two-discussed.  When day two begins, now Apollo is not day-two-discussed.
Instead of quizzing the director about Apollo during day two:
	if the player has alien-equations:
		say "'Now, listen, we haven't told anyone this, and we think this would be best kept within these four walls.'  He leans forward and lowers his voice.  'We did it.  We launched Apollo 11 last night, while everyone was asleep.  Those strange equations you showed us were... well... we don't know what they were exactly, but we were able to accomplish the trip much faster than we had originally planned.  But what we found was... disturbing.'[paragraph break]";
		say "[The director] shifts uncomfortably in his chair, as if trying to cope physically with the mental burden he's carrying.  'When we tried to touch down on the surface... it was all wrong.  Up close, the moon was flat, almost two-dimensional.  And then the command module just... went right through, like a ghost.  Now we know what no other human knows: it's not real.  The moon is a projection, put there for a reason, we think, but we could study it for a thousand more years and never truly understand.'[paragraph break]";
		say "'This,' he says somberly, 'is a secret we must keep at all costs.  The American people must not know.  The Ruskies must not know.  We need to show them a perfectly successful moon landing.  So that's exactly where [interesting]Operation Glitter[/interesting] comes in.'";
	otherwise:
		say "'Now, we've got a bit of a change of plan on Apollo,' says [the director], his brow furrowed.  'You did good yesterday, but I had a little meeting with the folks in accounting.  Turns out we don't have $25.4 billion to spend on this shindig, so we're scrappin['] it and getting started on [interesting]Operation Glitter[/interesting].'  He grins from ear to ear.  'The Ruskies won't know what to think!'";
	make "Operation Glitter" known;
	now Apollo is day-two-discussed.

Instead of quizzing the director about checklist-2:
	say "'Good, you noticed that.  Same drill as before', he says, 'just follow my highly technical [interesting]checklist[/interesting] to get this operation going.  Ask about any of it if you need help!'";
	if Apollo is not day-two-discussed:
		try quizzing the director about Apollo;
	now checklist-2 is ready.

Instead of quizzing the director about glitter:
	if the player has alien-equations:
		say "'We need to film something convincing, and that's what Operation Glitter is all about.  The truth about the moon [bold type]must[roman type] be kept hidden.'  [The director] sighs a heavy sigh.  He looks years older than he did yesterday.[paragraph break]";
	otherwise:
		say "'It's cheap, and it pretties up just about anything.  Good name, huh?  They let me pick it myself this time!'  He is practically beaming with pride.[paragraph break]";
	if Apollo is not day-two-discussed:
		try quizzing the director about Apollo;
	say "'If you haven't seen the sound stage in the basement, you might want to start down there.  Get to know the photographer, the crew, and make sure everything goes smoothly.'  He leans forward across his desk and looks you directly in the eyes.  'I shouldn't have to say this, but if this project fails, we all go down with it.  Don't screw this up, kid.'";
	make "photographer" known;
	now checklist-2 is ready.

Instead of quizzing the director about the internship during day two:
	say "'Plenty more for you to do around here,' he chuckles.  'Just keep to that [interesting]checklist[/interesting] and everything will be fine.'"

Instead of quizzing the director about blueprints during day two:
	if the player has alien-equations:
		say "[The director] shakes his head.  'No, no, we're done with that.  We've got bigger fish to fry now.'";
	otherwise:
		say "[The director] shakes his head.  'No, no, we're done with that.  We gave those to the set designer, but they took a few liberties in the end.  I'm sure it'll look fine on the television.  Those folks are professionals.'"

Instead of quizzing the director about rocket-equations during day two:
	if the player has alien-equations:
		say "[The director] looks haunted.  '... What were those?'  He shakes his head.  'No time for that.  We can't afford to get distracted now.'";
	otherwise:
		say "'Who needs [']em?  Heh heh.  Those eggheads were just dead weight.'  He wipes his eyes.  'The only numbers I care about now are the Nielsens!'"



Get-lunch is a checklist-item.  The printed name of get-lunch is "Get lunch".

Lunch is a concept.  The allowed-scene of lunch is day two.
Lunch can be day-two-discussed.
Instead of quizzing the director about lunch:
	if get-lunch is checked:
		say "'Thanks for sorting out lunch, kid.'";
	otherwise:
		say "'Lunch is the most important meal of the day,' he says with a serious scowl.  'Don't let doctors tell you otherwise.  And actors get hungry, even when they're astronauts.  You just need to head down to [interesting]the craft services table[/interesting] and get everybody's [interesting]food[/interesting].  Don't forget to ask around and get everyone's order, and don't take any crap about special orders from these prima donnas.  We're on a budget around here!  Tax payers, yadda yadda yadda.'";
		now lunch is day-two-discussed.


Drug-astronauts is a checklist-item.  The printed name of drug-astronauts is "'Prepare' astronauts".
Brain-washing is a concept.  The allowed-scene of the brain-washing is day two.
[So much euphemism, and so many variations in phrasing.  Phrasing!]
Understand "prepare", "preparing", "prepare astronauts", "preparing astronauts", "prepare crew", and "preparing crew" as brain-washing.
Understand "interview", "interviews", and "interviewing" as brain-washing.
Understand "brainwash", "brainwashing", "brain wash", "brain washing", "brain-wash", and "brain-washing" as brain-washing.
Understand "brainwash crew", "brainwashing crew", "brain wash crew", "brain washing crew", "brain-wash crew", and "brain-washing crew" as brain-washing.
Understand "brainwash astronauts", "brainwashing astronauts", "brain wash astronauts", "brain washing astronauts", "brain-wash astronauts", and "brain-washing astronauts" as brain-washing.
Understand "brainwash astronaut", "brainwashing astronaut", "brain wash astronaut", "brain washing astronaut", "brain-wash astronaut", and "brain-washing astronaut" as brain-washing.

Brain-washing can be discussed.
Instead of quizzing the director about brain-washing:
	say "'Yes, well, here's the thing,' he begins carefully.  'There are sure to be interviews with these astronauts after the operation is over, and well, loose lips sink ships.  So head downstairs to the [interesting]chemistry lab[/interesting] and get something to... [italic type]massage[roman type] the crew's memory a bit.  As far as they are concerned, today's photo shoot is [bold type]the real thing[roman type].'  [The director] looks a bit uncomfortable with the subject.  'Just ask [interesting]the chemist[/interesting] for details.'";
	make "chemist" known;
	make "brain-washing" known;
	make "drugs" known;
	now brain-washing is discussed.



Film-moon-landing is a checklist-item.  The printed name of film-moon-landing is "Film 'moon landing'".
The filming is a concept.  Understand "film", "moon landing", and "landing" as the filming.
Instead of quizzing the director about the filming:
	say "'Oh, you'll do fine.  Thankfully, Stanley left behind his script for the moon landing.'  He hands you the script.";
	make photographer known;
	now the player has the moon landing script.
Instead of quizzing the photographer about the filming:
	say "'I'm not signing autographs,' he says with a sly grin.  'In fact, I'm not even here.  What we're doing today never leaves this building.'"


The items of checklist-2 are {get-lunch, drug-astronauts}.  [Initially, we hide the filming and reveal it later when Stanley gets sick.]



[Starting on day two, we lock the doors to these rooms.]
Instead of going to the propulsion lab while day one has ended:
	say "The door to the lab appears to be locked.  There is a sign on it which says 'closed for remodeling'."

Instead of going to the engineering department while day one has ended:
	say "The door to the engineering department appears to be locked.  There is a sign on it which says 'deserted'.  (You were [italic type]sure[roman type] they were never going to do that...)[line break]".



The description of Buzz Aldrin is "Buzz has a receding hairline and flyaway ears; he flashes you with a goofy smile, but there appears to be a tuft of fur stuck in his teeth."
Buzz Aldrin is wearing a tuft of fur.

The description of Neil Armstrong is "Neil's prominent front teeth make him look like a friendly, gullible beaver.  Even from a distance you can see that his arms, ironically, are woefully underdeveloped."
Front teeth are part of Neil Armstrong.

The description of Michael Collins is "Michael is strutting around and muttering to himself about freedom in a strong Irish accent.  You catch a whiff of boiled cabbage."

The description of Lisa Nowak is "Lisa's got a handsome profile with her adorable turn-up nose, and her chestnut hair is hanging loose in a wave perm.  You can see an industrial-sized can of pepper spray sticking out of her pocket."
Lisa Nowak wears an industrial-sized can of pepper spray.

The description of Ijon Tichy is "Ijon has chosen casual attire compared to the others.  He's sporting a white tank top that's partially tucked into his wrinkled slacks.  His sideburns are present and accounted for."
Ijon Tichy wears a white tank top and the wrinkled slacks.
The sideburns are part of Ijon Tichy.

The description of Clifford McBride is "Clifford is explaining in a gruff voice to no one in particular the importance of discovering intelligent non-human life.  His eyebrows protrude a full inch from his face."
The eyebrows are part of Clifford McBride.
The description of the eyebrows is "They are like living caterpillars on the man's face."



[It's a running gag that he doesn't speak English.  So preempt any default responses for him.]
Instead of quizzing Ijon Tichy about anything (this is the Tichy default conversation rule):
	say "He looks a little confused, and responds in a slavic-sounding language.  When he realizes that you don't understand him either, he sighs heavily and shakes his head."



The basement is below the hallway.  "A long, blank hallway, dimly lit, with doors at either end.  A stairwell in the middle leads back up.  A paper sign is hastily taped to the wall opposite the stairwell."
The printed name of the basement is "NASA Headquarters Basement Level".

The stairwell is a backdrop.  The stairwell is in the hallway and in the basement.

The paper sign is interesting scenery in the basement.  "It says 'AUTHORIZED PERSONNEL ONLY', hand-drawn in black marker."

Instead of going to the basement during day one:
	say "The stairwell door appears to be locked.  You begin to wonder what they keep down there.";



The sound stage is east of the basement.  "You find yourself in a large, hangar-like structure, painted in the black and gray tones of a desolate lunar surface.  [if the photographer is in the sound stage][A photographer] with dark hair and an intense look is flitting around between cameras, double-checking everything for the shoot.[otherwise]There are cameras, tripods, and lights standing around, waiting to be used.[end if]  Against the side wall away from the set is a [interesting]craft services table[/interesting][if food is on the craft services table] covered in food[end if]."
The printed name of the sound stage is "NASA's Secret Underground Sound Stage".

After going to the sound stage:
	make "photographer" known.

The photographer is a stranger in the sound stage.  The photographer is male.
The real name of the photographer is "Stanley".
Understand "Stanley", "Kubrick", "film-maker", and "filmmaker" as the photographer.
The description of the photographer is "[The photographer] is a bit shorter than average, with dark, wild, wavy hair and a dark, thick beard.  He is busily checking and adjusting various cameras, tripods, and lights."
The tripods are scenery in the sound stage.  Understand "tripod" as the tripods.
The lights are scenery in the sound stage.  Understand "light" as the lights.
The cameras are scenery in the sound stage.  Understand "camera" and "equipment" as the cameras.
The beard is part of the photographer.  The description of the beard is "It's... magnificent.  [The photographer]'s cheeks are shaved clean into a virtual fenceline, holding the dark, wild beard in check, keeping the power and chaos of it from consuming his entire face.  You suppress a shudder."

Instead of quizzing the photographer about the photographer:
	try quizzing the photographer about name.

Instead of quizzing the photographer about name:
	say "He offers his hand and says, 'Kubrick.  Stanley Kubrick.  Nice to meet you.'"

Instead of quizzing the photographer about NASA:
	say "'This really pushes the boundaries, you know what I mean?  They say film reflects life but really, it's our thoughts that create reality, so if we think the film is real, it is real.  This NASA shoot is gonna be my master opus.'"

Instead of quizzing the photographer about anything:
	try talking to the photographer.

Instead of talking to the photographer:
	say "He looks annoyed.  'Look, I'm very busy.  Can you please give me some space?'"



A truth-table-value is a kind of value.  The truth-table-values are T, F, X, and Z.
[T = True, F = False, X = Don't Care.  In the context of food, T is a thing a person _must_ have, F is a thing a person _must not_ have, and X is a thing which does not matter to this person.  Z is unused in the tables, but is the opposite of "don't care" for the purposes of generic processing of food properties.]
A truth-table-value has a truth-table-value called antonym.  ["Opposite" was taken already by built-ins.]
The antonym of T is F.  The antonym of F is T.  The antonym of X is Z.

Food is a kind of edible thing.
Kinds of food are defined by the Table of Ingredients.

Table of Ingredients
food			has-meat	has-fish	has-dairy	has-nuts	has-wheat	is-kosher
BLT			T		F		F		F		T		F
tuna sandwich		T		T		T		F		T		F
salad			F		F		T		F		F		T
almond chicken		T		F		F		T		F		T
candy			F		F		T		T		F		F

Table of Dietary Restrictions
person			vs-meat		vs-fish		vs-dairy	vs-nuts		vs-wheat	vs-kosher
the secretary		F		F		X		X		X		X
the director		X		F		X		X		X		F
the head of personnel	X		X		F		F		X		X
Buzz Aldrin		T		X		F		T		F		X
Neil Armstrong		X		X		X		F		F		X
Michael Collins		X		X		T		X		T		X
Lisa Nowak		X		T		X		F		X		X
Ijon Tichy		X		T		X		X		X		X
Clifford McBride	F		F		X		X		X		X
the photographer	X		X		F		X		X		T




Food-preferences is a concept.  The allowed-scene of food-preferences is day two.
Understand "food", "food preferences", "diet", "diet preferences", "dietary preferences", "order", "food order", and "special order" as food-preferences.
Instead of quizzing someone about lunch:
	try quizzing the noun about food-preferences.
	[Unless they have a specific response for lunch.]



A person can be fed.  A person is usually not fed.
Before quizzing a fed person about food-preferences:
	say "'Oh,' says [the noun], 'you already gave me my lunch.  Thanks!'";
	stop the action.

Instead of quizzing the secretary about food-preferences:
	say "'Oh, well, I can't eat any meat or fish,' she says.  'You see, I'm what you call an [']herbivore['].'"

Instead of quizzing the director about food-preferences:
	if lunch is not day-two-discussed:
		try quizzing the director about lunch;
	say "'Now I'm glad you asked about food,' he begins.  'I can't have fish, because I simply don't like the smell.  Not the smell of the fish itself, but the way it makes [bold type]me[roman type] smell when I eat it.  Doctors don't know what it is, and I've just learned to change my diet.  Life gives you a weird-smelling disease, you make lemonade, dammit!'  He looks lost for a moment.  'Where was I?  Right.  Food!  I absolutely, under any circumstances, [bold type]cannot[roman type] eat [bold type]anything[roman type] Kosher.  Even one bite of anything blessed by a Rabbi, and I swell up like a beach ball.'"

Instead of quizzing the head of personnel about food-preferences:
	say "'I'm lactose-intolerant, and I'm allergic to nuts.  Now get lost!'"

Instead of quizzing Buzz Aldrin about food-preferences:
	say "'I've gotta have meat,' he begins, 'and nuts.  In every meal.  And no dairy or wheat!  You think our ancestors ate all this dairy and wheat all the time?  All this processed [bold type]garbage?![roman type]  No way!'  His eyes are becoming increasingly wide.  'Our ancestors foraged for nuts, and they found meat, just lying around or whatever, no biggie, and they ate [bold type]that![roman type]'  His breath is becoming labored, and it takes a visible exertion of effort for him to calm himself."

Instead of quizzing Neil Armstrong about food-preferences:
	say "'I can't have any gluten or nuts.  I'm not allergic to either one, I just... [bold type][italic type]hate[roman type] nuts and glutens.'  The seasoned astronaut looks haunted.  'Sticky, disgusting glutens, clinging to the body.  Dirty.  You can feel it, filling your body from the bottom up.  The more wheat a human being eats, the heavier his toes get.  Look it up!'"

Instead of quizzing Michael Collins about food-preferences:
	say "'Whatever's got dairy and wheat in it is fine.  There's nothing good on God's Green Earth that hasn't got good, preferably Irish, dairy and wheat.'  He gets a dreamy look talking about his homeland.  After a moment, he adds, 'Have you got any porridge?'"

Instead of quizzing Lisa Nowak about food-preferences:
	say "'Oh, what day is it?' she asks. '... Oh, right, it's Friday, isn't it?  It'll have to be something with fish, then.  Oh, and no nuts!'"

Instead of quizzing Ijon Tichy about food-preferences:
	say "He goes on at some length in a slavic-sounding language.  After realizing you haven't understood, he patiently draws a picture of a fish in the air with his finger, then raises his eyebrows meaningfully at you."

Instead of quizzing Clifford McBride about food-preferences:
	say "He give you a look filled with a calm intensity that scares you to your core.  'This is a one-way voyage.  I never cared about you, or any of your small ideas.  For 30 years...' he licks his lips, 'I've been breathing this air, eating this food... enduring these hardships... but I found my destiny.'  After a long moment of terrifying silence, he adds, 'No meat, no fish.  Nothing I couldn't take with me.'"

Instead of quizzing the photographer about food-preferences:
	say "'Kosher, no dairy,' he says, and then immediately turns back to his cameras."

Instead of quizzing the chemist about food-preferences:
	say "'Oh, no thanks.  I already had lunch,' she says.  'I just ate a handful of mushrooms.'"



The Toblerone is a candy inside the triangular nameplate.
Understand "candy" and "box" and "candy box" as the Toblerone.
The description of the Toblerone is "It's a pale yellow, triangular box that says 'TOBLERONE', 'THE FIRST PATENTED SWISS MILK CHOCOLATE [italic type]with[roman type] ALMONDS & HONEY'.".
After opening the triangular nameplate:
	if the Toblerone is in the triangular nameplate:
		say "You open a small, concealed hatch on one side of the nameplate, and a pale yellow, triangular [interesting]candy box[/interesting] falls out.";
		now the Toblerone is in the location;
	otherwise:
		say "You open a small, concealed hatch on one side of the nameplate."

The printed name of almond chicken is "plate of almond chicken".
Rule for printing the plural name of almond chicken: say "plates of almond chicken".
Understand "plate" and "plate of almond chicken" and "plate of chicken" as almond chicken.
[It's awkward to type "plates" and have only one plate be picked up.  It's even more awkward to solve it in Inform, since "understand" can't be used to map a phrase many objects.  Instead of making the user type "all almond chicken", map "plates", "plates of almond chicken" and "plates of chicken" to "all almond chicken".]
After reading a command:
	let T be "[the player's command]";
	replace the regular expression "plates(?:\s+of(?:\s+almond)?\s+chicken)?" in T with "all almond chicken";
	change the text of the player's command to T.



The craft services table is an enterable supporter in the sound stage.
Three BLTs, four tuna sandwiches, four salads, and two almond chickens are on the craft services table.
The description of the craft services table is "The craft services table is a cheap folding table covered in a red plastic tablecloth with a floral print."
Instead of sitting on the craft services table:
	say "You start to climb onto the craft services table, but it doesn't look like the table would hold your weight, so you think better of it."



The snack count is initially 0.
After eating a food:
	increase the snack count by 1;
	if the snack count is 10:
		say "You eat [the noun], then collapse into a deep, deep food coma from which you never awaken.  Operation Glitter fails and is eventually exposed, and NASA becomes a worldwide laughing-stock.  Russia conquers the globe by 1972.  Your tombstone in Arlington National Cemetery reads 'Intern.'";
		show ending 4 of 9 aka the "gluttony" ending;
	otherwise if the snack count is 3:
		say "You eat [the noun].  You are starting to feel unwell.";
	otherwise if the snack count >= 4:
		say "You eat [the noun].  You worry you won't be able to feed everyone now!";
	otherwise:
		say "You eat [the noun].  Not bad.";



The description of a BLT is "A bacon, lettuce, and tomato sandwich on wheat bread.  This one has no mayo."
The description of a tuna sandwich is "A tuna sandwich on wheat bread.  The tuna is mixed with mayo, celery, and onion, and includes some percentage non-Kosher dolphin meat."
The description of salad is "A basic salad, with lettuce, tomato, and shredded cheese.  And it's kosher!"
The description of almond chicken is "Chicken, breaded in a ground-almond batter, fried, and served with almonds, onions, and rice.  Certified Kosher!"
Understand "sandwhich", "tuna sandwhich", "tuna salad", "tuna salad sandwich", and "tuna salad sandwhich" as tuna sandwich.



[The player should be able to "take food" or "take all food".  Same for "drop" or "examine".  So let's make that work.]
Food-preferences is everywhere.
Instead of taking food-preferences:
	let L be the list of visible food not carried by the player;
	if the number of entries in L is not 0:
		repeat with F running through L:
			say "[F]: Taken.";
			try silently taking F;
	otherwise:
		say "You don't see any such thing."

Instead of dropping food-preferences:
	if the player has food:
		repeat with F running through the list of food carried by the player:
			say "[F]: Dropped.";
			try silently dropping F;
	otherwise:
		say "You don't have any food."

Instead of examining food-preferences:
	let L be the list of visible food;
	if L is empty:
		say "You can't see any such thing.";
	otherwise if the number of entries in L is 1:
		try examining entry 1 of L;
	otherwise:
		say "Which food would you like to examine?  ([L])[line break]".



[When I defined the tables above, I thought I would get to do this with less spaghetti.  But although I can iterate through properties from a list, I couldn't figure out how to use that property variable to get access to a property value from a food.]

To decide if (the recipient - person) will eat (the snack - food):
	choose the row with person of the recipient from Table of Dietary Restrictions;
	let M1 be the has-meat of the snack;
	let M2 be the vs-meat entry;
	let F1 be the has-fish of the snack;
	let F2 be the vs-fish entry;
	let D1 be the has-dairy of the snack;
	let D2 be the vs-dairy entry;
	let N1 be the has-nuts of the snack;
	let N2 be the vs-nuts entry;
	let W1 be the has-wheat of the snack;
	let W2 be the vs-wheat entry;
	let K1 be the is-kosher of the snack;
	let K2 be the vs-kosher entry;
	if the recipient is the photographer:
		decide yes;
	otherwise if M1 is the antonym of M2:
		decide no;
	otherwise if F1 is the antonym of F2:
		decide no;
	otherwise if D1 is the antonym of D2:
		decide no;
	otherwise if N1 is the antonym of N2:
		decide no;
	otherwise if W1 is the antonym of W2:
		decide no;
	otherwise if K1 is the antonym of K2:
		decide no;
	otherwise:
		decide yes.

The fed count is initially 0.
Check giving a food (called the snack) to someone (called the recipient) during day two:
	if the recipient is yourself:
		[This condition avoids a runtime exception looking up in the table of dietary restrictions.]
		say "Do you really think they would feed the intern?";
	otherwise if the recipient is fed:
		if the recipient is Ijon Tichy:
			say "[The recipient] shakes his head, says something in a slavic-sounding language, puffs out his cheeks, and points at his stomach.";
		otherwise:
			say "'No, thanks,' says [the recipient].  'I've already got my lunch.'";
	otherwise if the recipient will eat the snack:
		if the recipient is Ijon Tichy:
			say "[The recipient] takes [the snack], then nods, smiles, and gives you thumbs-up.";
		otherwise:
			say "[The recipient] takes [the snack].  [one of]'Thanks, kid!'[or]'Oh, my favorite!'[or]'That looks great!'[purely at random]";
		now the snack is nowhere;
		now the recipient is fed;
		increase the fed count by 1;
		if the fed count is 7:
			say "That seems to be the last of the lunch deliveries![paragraph break]";
			now get-lunch is checked;
			start photographer illness;
	otherwise:
		if a random chance of 1 in 3 succeeds:
			if the recipient is Ijon Tichy:
				say "[The recipient] takes [the snack], smiles, and takes a bite.  He quickly starts to hack and choke, then screams in some foreign language.[paragraph break]";
			otherwise:
				say "[The recipient] takes [the snack].  'Thanks, kid!'  But after one bite, they seem to be suffering greatly.  'What was in this??  This kid is trying to poison me!!'[paragraph break]";
			say "NASA security arrives shortly, hauls you carelessly to the building exit, and then tosses you into the street.  You have been fired for gross craft-services negligence, and Operation Glitter fails miserably.  NASA becomes a worldwide laughing-stock, and Russia conquers the globe by 1972.  Not only have you failed your country, but you are banned by the International Alliance of Theatrical Stage Employees and you never work in Hollywood again.";
			show ending 6 of 9 aka the "poisoning" ending;
		otherwise:
			if the recipient is Ijon Tichy:
				say "[The recipient] looks at [the snack] and shakes his head slowly.  You feel a little foolish.";
			otherwise:
				say "[The recipient] looks at [the snack] and says 'No, I can't eat that.  Were you even listening?'";
	stop the action.

To start photographer illness:
	if the player is in the sound stage:
		say "Suddenly, [the photographer] gets dizzy and collapses!  Someone calls for help, and a team of medics rush him away on a stretcher.  After the commotion dies down, someone brings you to speak with [the director] in his office.[paragraph break]";
	otherwise if the player is in the director's office:
		say "Suddenly, [the director]'s phone rings.  He answers, 'yes?', followed by a few grunts of what you assume are acknowledgement, then he hangs up.[paragraph break]";
	otherwise if the player is in the waiting room:
		say "Suddenly, [the director] opens the door to his office and says, 'You better get in here, kid.  We've got some bad news.'  You follow him in.[paragraph break]";
	otherwise:
		say "Suddenly, [the secretary] rushes in and says, '[The director] needs to see you right away.  Something terrible has happened!'  You follow her to the director's office.[paragraph break]";
	pause;
	now the player is in the director's office;
	now the photographer is in purgatory;
	say "[The director] looks at you somberly from across the desk.  'I'm not sure if you met Stanley, the photographer, but he seems to have eaten something he shouldn't have.'  You try to act nonchalant.  'He's going to be okay, but he'll be in the hospital for a while, so we'll need you to take over filming and shooting photos downstairs.  I've updated your checklist.'";
	make "filming" known;
	now the moon landing script is in the sound stage;
	now the description of the cameras is "You notice a small note taped to the side of one camera.  The note says [italic type][one of][interesting]'FILM MOON LANDING'[/interesting][or]SAY '[interesting]ACTION[/interesting]'[or]TYPE THE EXACT PHRASE 'FILM MOON LANDING' TO SOLVE THE PUZZLE[cycling][roman type].  Maybe it's a clue!";
	now the items of checklist-2 are {get-lunch, drug-astronauts, film-moon-landing}.




The chemistry lab is west of the basement.  "The lab is lit by exposed fluorescent tubes that give everything a sickly cast.  There's a large [interesting]lab bench[/interesting] with a smorgasbord of [if the small vial is in the chemistry lab]vials, [end if]droppers, Bunsen burners, jars of powders, and graduated cylinders[if the taxidermied marmot is in the chemistry lab], and what appears to be a [interesting]taxidermied marmot[/interesting][end if].  In the corner, a long-haired black [interesting]cat[/interesting] peers at you through slitted yellow eyes and goes back to sleep."
The printed name of the chemistry lab is "NASA Chemistry Lab".
The exposed fluorescent tubes are scenery in the chemistry lab.
The lab bench is scenery in the chemistry lab.  "You don't dare touch anything on the bench.  Some things are bubbling and hissing menacingly."
The cat is a person in the chemistry lab.  "The cat stretches out in the corner next to the laboratory's fume hood, and you wonder, is this cat fat or just really fluffy?"
The droppers are portable-scenery in the chemistry lab.
The Bunsen burners are portable-scenery in the chemistry lab.
The jars of powders are portable-scenery in the chemistry lab.
The graduated cylinders are portable-scenery in the chemistry lab.
The smorgasbord is scenery in the chemistry lab.  "A smorgasbord is a buffet offering a variety of hot and cold meats, salads, hors d'oeuvres, etc.  In this case, it was a metaphor for the large array of things on the lab bench.  Why are you so literal?"

After going to the chemistry lab:
	make "chemist" known;
	make "space-cake" known;
	make "LSD" known;
	make "librium" known;
	make "mysterious silver liquid" known.

The taxidermied marmot is in the chemistry lab.  The description of the taxidermied marmot is "It looks just like every other taxidermied marmot [if the taxidermied marmot is carried by the player]in your collection[otherwise]you've ever seen[end if]."
The taxidermied marmot is undescribed.  [Mentioned in the scenery, so don't list it again.]
After taking the taxidermied marmot:
	now the taxidermied marmot is described;
	continue the action.

The cat is not default-talkable.  ["Talk" without specifying will never assume the cat.  But the cat is still a "person" and you can talk to the cat explicitly.]
Instead of talking to the cat:
	say "2020 [italic type]has[roman type] been pretty lonely, hasn't it?";
	stop the action.
Instead of quizzing the cat about:
	say "2020 [italic type]has[roman type] been pretty lonely, hasn't it?";
	stop the action.
Instead of asking the cat about:
	say "2020 [italic type]has[roman type] been pretty lonely, hasn't it?";
	stop the action.

The chemist is a stranger in the chemistry lab.  The chemist is female.
The real name of the chemist is "Molly". 
Understand "Molly" as the chemist.
The description of the chemist is "[The chemist]'s oversized tortoiseshell glasses make her eyes look enormous in her heart-shaped face.  She's wearing a lab coat that sports an impressive array of pins, with sentiments like 'Humphrey-Muskie,' 'Tune In, Turn On, & Drop Out' and 'I CAN GIVE IT! CAN YOU TAKE IT?'"
The chemist wears tortoiseshell glasses, a lab coat, the pins.
The description of the pins is "You've never seen quite so many pins on one lab coat."

Instead of quizzing the chemist about the chemist:
	try quizzing the chemist about name.

Instead of quizzing the chemist about name:
	say "'They call me Molly,' she says with a grin.";
	make the chemist known.

Instead of talking to the chemist:
	say "'What can I get you?' asks [the chemist].  'We've got [list of things which are a drug in the location].'"

Instead of asking the chemist for a thing:
	if the second noun is a drug:
		say "'Here you go!'  She hands you [the second noun].";
		try silently taking the second noun;
	otherwise:
		say "'Sorry, I don't have that.  We've got [list of things which are a drug in the location], though.  Just [interesting]take[/interesting] whatever you need, man.'"

[TODO: What happens when this list is empty?]
Instead of quizzing the chemist about drugs:
	say "'We've got [list of things which are a drug in the location].  Just [interesting]take[/interesting] whatever you need, man.'"

Instead of giving a food to the chemist:
	try quizzing the chemist about food-preferences.  [We already wrote a response there.]

Instead of giving a thing which is a drug to the chemist:
	say "She shakes her head.  'No, I've got plenty.  You keep that.'"

Instead of quizzing the chemist about brain-washing:
	if brain-washing is discussed:
		say "You carefully relay to [the chemist] what [the director] told you about this part of the operation.  'Whoa,' she finally responds.  'That's heavy.'  She zones out for a moment, then comes back to herself.  'Manipulating memories is pretty a new field, so you may just have to [italic type]experiment[roman type] a bit.  Take whatever you like, man.'";
	otherwise:
		say "She looks confused.  'I don't know anything about that.  Did [the director] send you?  You might want to ask him first.'"

Instead of quizzing the chemist about NASA:
	say "'I put the [bold type]Space[roman type] in the National Agency of Space Artisans.  That's why they gave me this sweet lab to cook up all sorts of interesting chemical cocktails.  I [bold type]love[roman type] this job.'"






Drugs are a concept.  Drugs are everywhere.  Understand "drug" as drugs.
A thing can be a drug.  A thing is usually not a drug.
Instead of quizzing the director about drugs:
	say "[The director] quickly begins shaking his head.  'No, no, not my department.  Head downstairs to the [interesting]chemistry lab[/interesting] and ask in there.'"



Instead of taking drugs:
	let T be the list of things which are a drug in the location;
	repeat with V running through the list of containers in the location:
		if V contains a thing which is a drug:
			add V to T;
	let U be the list of things which are a drug carried by the player;
	if the player's command includes "take":
		if the player's command matches the regular expression "\ball\s+(?:the\s+)?drugs\b":
			say "Whoa, slow down, there![paragraph break]";
			repeat with D running through T:
				say "[D]: Taken.";
				now the player has D;
			stop the action;
		otherwise:
			say "(Assuming you mean 'pick up'...) [run paragraph on]";
	if T is not empty:
		say "Which do you want to pick up?  (You can see [T].)[line break]";
	otherwise if U is not empty:
		say "You can't see any such thing in the room.  (But you are carrying [U].)";
	otherwise:
		say "You can't see any such thing."

Before taking a thing which is a drug:
	if the player's command includes "take":
		say "(Assuming you mean 'pick up'...) [run paragraph on]".



Before giving a drink (called the potion) to an astronaut (called the space-hero):
	try giving the holder of the potion to the space-hero instead.

Before giving a thing (called the thingy) to an astronaut:
	if the thingy is not a drug and the thingy is not a container which contains a drug:
		do nothing;  [Other rules will take over]
	otherwise if the second noun is Ijon Tichy:
		do nothing;  [more specific rules below]
	otherwise if the second noun is fed:
		say "[The second noun] takes [the noun] from you.  'Is this some kind of pre-flight vitamin?'[paragraph break]";
		say "'Um, yes, I think so,' you lie unconvincingly.[paragraph break]";
		if the noun is a space-cake:
			say "[regarding the second noun][They] smiles.  'Vitamins in cake form?  What will they think of next?'";
	otherwise:
		say "'Hang on, kid,' says [the second noun], 'I need to eat lunch first.'";
		stop the action.

Before giving a thing (called the thingy) to Ijon Tichy:
	if the thingy is not a drug and the thingy is not a container which contains a drug:
		do nothing;  [Other rules will take over]
	otherwise if the second noun is fed:
		say "[The second noun] takes [the noun] from you.  He raises an eyebrow at you, and you smile and nod.";
	otherwise:
		say "[The second noun] complains at you in some slavic-sounding language.  Realizing you don't understand, he breathes a heavy sigh.  Finally, he shakes his head, points to his stomach, then raises his eyebrows meaningfully.";
		stop the action.

After giving a thing to an astronaut:
	[The "carry out" rules for each drug describe the action, but the astronaut consumes it immediately.]
	if the noun is a vial:
		now the noun is nowhere;
	otherwise:
		now the noun is in the chemistry lab;  [Replenish stocks.]
	if the astronauts are prepared:
		say "The crew looks 'ready' for filming.";
		now drug-astronauts is checked.



The block giving rule is not listed in the check giving it to rules.
Check giving a thing to someone:
	if the noun is a drug and the second noun is an astronaut:
		do nothing;
	otherwise if the noun is a container which contains a drug and the second noun is an astronaut:
		do nothing;
	otherwise:
		say "[The second noun] [don't] seem interested.";
		stop the action.



A space-cake is a kind of interesting thing.  A space-cake is edible and a drug.

The description of a space-cake is "The space-cake looks like a 2x2 inch brownie square wrapped in cling wrap.  On the top is a sticker with an image of a tie dyed peace sign and text reading 'Open and consume for treatment of oppressive sobriety.'"
An astronaut can be high.
Understand "cake", "space cake", and "spacecake" as space-cake.
Instead of quizzing the chemist about space-cake:
	say "'I baked these myself.  I tried calling them [']NASA-cakes['], but it didn't catch on.  They're chocolate and Acapulco Gold.'"
Carry out giving a space-cake to an astronaut:
	say "[regarding the second noun][They] eats the cake, slowly at first, but then more quickly.  [They] [are] looking quite pensive.";
	now the second noun is high.
Instead of eating a space-cake:
	say "You eat the whole thing.  Up until now, this game was kind of obnoxious.  With a space-cake in your belly, you're starting to think it's actually pretty amusing.";
	now the noun is in the chemistry lab.  [Replenish stocks.]
Instead of quizzing a high astronaut about anything (this is the high astronaut rule):
	say "[regarding the second noun][They] [don't] seem to have heard you.  'Waaaiit.  Wait a sec.  We choose to go to the moon because [italic type]it's hard??[roman type]  I mean, can't we do something else right now?'"


LSD is a kind of interesting thing.  LSD is edible, swallowable, and a drug.
Understand "lysergic acid diethylamide" as LSD.
The description of LSD is "The LSD is a piece of paper with an image of the spiraling Milky Way, covered in intersecting perforations."
An astronaut can be tripping.
Before dropping LSD, say "(Assuming you mean 'put down'...) [run paragraph on]".
After reading a command:
	if the player's command includes "lysergic acid diethylamide":
		say "(You have been awarded 10 bonus points for bothering to type that whole name.)[paragraph break]".
Instead of quizzing the chemist about LSD:
	say "'LSD is short for lysergic acid diethylamide.  It's a hallucinogenic, and can alter your thoughts, feelings, and experience of your surroundings.  A CIA classic!'"
Carry out giving LSD to an astronaut:
	say "[regarding the second noun][They] pops the LSD into [their] mouth.  Before long, [they] [are] staring at the cheap paint of the sound stage, convinced [they] [are] on the actual moon.";
	now the second noun is tripping.
Instead of eating LSD:
	say "You don't feel any different.";
	now the noun is in the chemistry lab;  [Replenish stocks.]
	add page effect "lsd" for 10 turns with message "(You no longer don't feel any different.)".


A librium is a kind of interesting thing.  A librium is edible, swallowable, and a drug.
The description of a librium is "It's a tiny, green capsule with some inscrutable print on one end."
An astronaut can be good at chess.
Instead of quizzing the chemist about librium:
	say "'Librium is a powerful hypnotic.  [one of]If I were you, I'd save [']em up for the night time.  Otherwise, they turn off right when you need them to turn on.  If you know what I mean.'  You are sure you don't.[or]Some people think it makes you better at chess, but actually, it just makes you hallucinate being good at chess.'[purely at random][line break]".
Carry out giving librium to an astronaut:
	say "[regarding the second noun][They] swallows the pill.  [They] gets pretty quiet, but you think you can hear [them] mumbling something like '[random chess move]' under [their] breath.";
	now the second noun is good at chess.
Instead of eating librium:
	[TODO: chess animation?]
	say "You don't feel any different, or any better at chess.";
	now the noun is in the chemistry lab.  [Replenish stocks.]
Instead of quizzing a good at chess astronaut about anything (this is the astronaut chess rule):
	if the noun is high:
		say "[They] [don't] seem to have heard you.  'Whoa.... On a regulation board, a queen-sized bed would only be 8.5 cm.'";
	otherwise:
		say "[They] [don't] seem to have heard you.  [They] seem to be muttering '[random chess move]'."
The astronaut chess rule is listed before the high astronaut rule in the instead rulebook.

To say random chess move:
	say "[one of]knight to queen's bishop 3[or]rook to bishop 4[or]pawn to e4[or]bishop to knight 4[or]bishop to c4[purely at random]"



A mysterious silver liquid is an interesting drink.  A mysterious silver liquid is a drug.
The description of a mysterious silver liquid is "You aren't quite sure if the silver liquid is shining or glowing, but it's definitely crawling up the sides of the container in a rhythmic pattern of some kind."
An astronaut can be zonked.
Instead of quizzing the chemist about a mysterious silver liquid:
	say "'Um... we don't exactly know what it is, because, like, epistemology is pretty hard.  I mean, what do any of us truly [italic type]know[roman type], right?'  She zones out again, then comes to.  'Anyway, that used to be a vial of aardvark blood, and then one day, poof!  It's all silver...  It's a little spooky.'"
Instead of quizzing the chemist about the tapir:
	say "'That poor defenseless creature.  Animals don't, like, [italic type]deserve[roman type] being in cages, right?'  She looks profoundly sad for a moment.  'What were we talking about again?'"
Carry out giving a container which contains a mysterious silver liquid to an astronaut:
	say "[regarding the second noun][They] drinks the mysterious liquid, grimacing as it goes down.  [Their] head begins to droop and sway immediately.";
	now the second noun is zonked.
Instead of drinking a mysterious silver liquid:
	say "...";
	pause;
	add page effect "alien-paper" for 3 turns with message "(... What [italic type]was[roman type] that?)";
	now the noun is nowhere.  [There's only one.]
Instead of quizzing a zonked astronaut about anything (this is the zonked astronaut rule):
	say "[The noun] just stares at you.  [Their] eyes seem to indicate that [they] understands you, but you don't get a reply."
The zonked astronaut rule is listed first in the instead rulebook.



The mysterious silver coffee is an interesting drink.  The mysterious silver coffee is a drug.
The description of the mysterious silver coffee is "It looks like a vaguely shimmery latte, and smells like licorice.  Every so often, you notice a silver bubble float down from the edge of your vision toward the coffee, then settle on the surface and slowly collapse into the drink."
Instead of inserting the coffee into a mysterious silver liquid:
	now the mysterious silver coffee is in the holder of a mysterious silver liquid;
	report new latte art.
Instead of inserting a mysterious silver liquid into the holder of the coffee (this is the mystery coffee rule):
	now the mysterious silver coffee is in the holder of the coffee;
	report new latte art.
[The mystery coffee rule is listed first in the instead rulebook.]
To report new latte art:
	now the coffee is nowhere;
	now a mysterious silver liquid is nowhere;
	say "The mysterious silver liquid mixes languidly into the coffee, occasionally running in reverse, but ultimately forming a consistent silvery-brown color."
Instead of quizzing the chemist about the mysterious silver coffee:
	say "'Whoa, is that soy milk?  ...  Is it [italic type]singing?[roman type]'".
Carry out giving a container which contains the mysterious silver coffee to an astronaut:
	say "[regarding the second noun][They] sip the coffee slowly, iquid, grimacing as it goes down.  [Their] head begins to droop and sway immediately.";
	now the second noun is zonked.
Instead of drinking the mysterious silver coffee:
	say "...";
	pause;
	add page effect "alien-paper" for 3 turns with message "(... What [italic type]was[roman type] that?)";
	now the noun is nowhere.  [There's only one.]



After examining an astronaut:
	if the noun is zonked:
		say "[regarding the noun][They] looks like a malleable zombie, ready to do whatever is required for the film.";
	otherwise if the noun is tripping:
		say "[regarding the noun][They] appears to be in complete awe of the cheaply-painted set.  Does [they] think [they] is really on the moon?"



To decide if the astronauts are prepared:
	repeat with X running through the sub-items of choose-crew:
		if X is not tripping and X is not zonked:
			decide no;
	decide yes.




A vial is a kind of liquid-safe container.
The description of a vial is "It's a small glass vial[if the noun contains nothing] which appears to be empty.[otherwise].[end if]".
Rule for printing the name of a vial (called the flask) while not inserting or removing or examining:
	if the flask contains nothing:
		say "empty vial";
	otherwise:
		say "vial of [list of objects contained by the flask]";
	omit contents in listing.



In the chemistry lab is four space-cakes, four LSD, and four librium.
The small vial is an interesting vial.  In the small vial is a mysterious silver liquid.
When day two begins:
	if the player has alien-equations:
		now the small vial is in the chemistry lab.



The moon landing script is an interesting, critical thing.
Carry out examining the moon landing script:
	say fixed letter spacing;
	say script-page style;
	say paragraph break;
	say paragraph break;
	say paragraph break;
	center "APOLLO 11 MOON LANDING";
	say paragraph break;
	say paragraph break;
	center "Written by";
	say line break;
	center "Stanley Kubrick";
	say paragraph break;
	say paragraph break;
	say paragraph break;
	say end style;
	say script-page style;
	say paragraph break;
	say underlined font style;
	center "THE EAGLE HAS LANDED";
	say end style;
	say line break;
	say "FADE IN:";
	say paragraph break;
	say "EXT. LUNAR SURFACE - DAY";
	say paragraph break;
	let A1 be entry 1 of the sub-items of choose-crew;
	let A2 be entry 2 of the sub-items of choose-crew;
	let A3 be entry 3 of the sub-items of choose-crew;
	let N1 be "[A1]" in upper case;
	let N2 be "[A2]" in upper case;
	say "A lonely lunar landing module sits on the barren landscape of the actual moon.  Nothing happens for seven long hours.  Slowly, the door opens, and [A1] descends from the module to the surface.";
	say paragraph break;
	center N1;
	say script-line style;
	say "That's one small step for man; one giant leap for mankind.";
	say end style;
	say paragraph break;
	say end style;
	say script-page style;
	say paragraph break;
	say "[A1] dicks around for a while by [themselves], feeling pretty good about that killer quote, before [A2] descends the ladder and brings out an overly-starched American flag.  They hammer it in to the lunar regolith and step back to look at it.";
	say paragraph break;
	center N2;
	say script-line style;
	say "Beautiful, just beautiful.";
	say end style;
	say paragraph break;
	say "They both hang out on the surface hitting golf balls and stuff for twenty-one more hours, while [A3] sits alone in the command module, crying.";
	say paragraph break;
	say end style;
	say script-page style;
	say paragraph break;
	say "As the astronauts climb back into the lunar landing module, a twenty-foot steel monolith descends from the heavens.  Their heads rattle in their helmets, straining under the sheer psychic force of the alien monolith.  The astronauts are pulled into a vortex of coloured light.  The audience [underlined font style]definitely[end style] knows what is happening and why.  It all makes perfect sense.";
	say paragraph break;
	say "INT. LARGE NEOCLASSICAL BEDROOM";
	say paragraph break;
	say "[A3] is standing alone in a creepy bedroom, middle-aged and still in [their] spacesuit, then dressed in leisure attire and eating dinner, and finally as an old person lying on a bed.  A monolith appears at the foot of the bed, and as [A3] reaches for it, [they] [are] transformed into a fetus in a bubble of some kind.  The audience is still [underlined font style]definitely[end style] with us and it all still [underlined font style]definitely[end style] makes sense.";
	say paragraph break;
	say "THE END";
	say paragraph break;
	say end style;
	say variable letter spacing;
	stop the action.


Filming the moon landing is an action applying to nothing.
Understand "film", "film moon landing", and "film landing" as filming the moon landing.
Understand "start filming", "start filming moon landing", and "start filming landing" as filming the moon landing.
Understand "action" as filming the moon landing.

Check filming the moon landing:
	if day one is happening:
		say "I didn't understand that sentence.";
		stop the action;
	otherwise if day three is happening:
		say "You already did that.  [one of]Time to move on[or]There's no point in reliving the glory days[or]Today is a brand new day[cycling].";
		stop the action;
	otherwise if the player is not in the sound stage:
		say "You'll need to be in the sound stage for that.";
		stop the action;
	otherwise if the astronauts are prepared:
		continue the action;
	otherwise:
		say "The astronauts are not all 'prepared' yet.  You need to get them ready for filming first.";
		show hint "Have you been to the chemist yet?";
		stop the action.


Carry out filming the moon landing: 
	say "You begin rolling the film as the astronauts pretend to pilot the lunar lander down to the 'surface.'  You call out to the astronauts to walk as though gravity has little effect on them.  They prove very receptive to direction and bounce happily around the stage in their chemically-enhanced state, like kittens tumbling around with springs on their paws.  They giggle manically as they hit golf balls around the stage; those drugs sure did the job.  One of the astronauts rips a comically loud fart, but you're sure you can edit it out in post.";
	now film-moon-landing is checked.




[---------- DAY 3 ----------]

Day three is a scene.
Day two ends when checklist-2 is held by the director.
Day three begins when day two ends.
When day three begins:
	log event "day3";
	say "[room-heading style]Intermission: End of day two[end style]";
	say line break;
	say "You head home, exhausted from a long day at the most important administration (affiliation? alliance?) in America.  You collapse into a dreamless sleep, and wake refreshed, ready for you next challenge.[paragraph break]";
	pause;
	say "[room-heading style]NASA Headquarters, day three of your internship (Epilogue)[end style]";
	say line break;
	say "You return to NASA headquarters, wondering what else they could possibly throw at you next.  You wonder how long you'll have to wait to see the director this time...[paragraph break]";
	pause;
	now checklist-2 is nowhere;
	say "You arrive to find that [the secretary] is not in the waiting room.  [The director] is waiting to receive you himself.  'Come on in.'  He guides you directly into his office.[paragraph break]";
	say "The director looks tired when you walk in; his usually immaculately styled hair looks limp.  His bloodshot eyes speak of sacrifice and loss.  He motions to the chair across from his desk.  His voice seems strangely tender as he says, 'Have a seat, Intern.'  He takes a long pause.  'You did a damn fine job, Intern.  Not only did you ensure America won the Space Race in the minds of the whole world, [if the player has alien-equations]you helped us protect our darkest secret.  Maybe.  Maybe second-darkest or third-darkest.[run paragraph on][otherwise]you saved us so much money, hell, we might actually be able to go to the moon some day![run paragraph on][end if]  Anyway...  Damn fine work.'  You have trouble reconciling his upbeat words with his downtrodden demeanor.  You're just about to ask him what's wrong when he continues, 'Damn fine work.  Head over to the [interesting]sound stage[/interesting] to get your [interesting]Official NASA Medal of Distinction[/interesting].'  You think you see a tear in his eye as he shakes your hand on the way out.";
	say paragraph break;
	now the sound stage is dark;
	now Buzz Aldrin is nowhere;
	now Neil Armstrong is nowhere;
	now Michael Collins is nowhere;
	now Lisa Nowak is nowhere;
	now Ijon Tichy is nowhere;
	now Clifford McBride is nowhere;
	now the player is in the hallway.

[Starting on day three, we lock the doors to these rooms.]
Instead of going to the director's office while day two has ended:
	say "The door to the office is locked.  'The sound stage is downstairs, kid,' says [the director] through the door.  'Go on, now.'"

Instead of going to the chemistry lab while day two has ended:
	say "The door to the chemistry lab is locked.  A sign on the door says 'took a road trip'."

Instead of going to the personnel department while day two has ended:
	say "The door to the personnel department is locked.  The lights appear to be out, and you hear a soft snoring coming from inside."

[Somehow, there's no automatic "look" entering a dark room.]
After going to the sound stage while day two has ended:
	try looking.

Instead of going from the sound stage while day two has ended:
	say "The door is locked...[paragraph break]";
	if the player has alien-equations:
		say "You hear the distinct sound of a hungry aardvark, and it's getting closer.[paragraph break]";
		if the player has the Toblerone:
			say "You realize that you still have the Toblerone in your pocket, so you throw it across the room, drawing the attention of the ravenous aardvark.  With one swift kick, the door comes off its frame and you flee as fast as your legs will carry you.[paragraph break]";
			say "After escaping the building, you try to go to the police and the press, but no one will believe what you've seen.  You spend the rest of your life in hiding from the National Agency of Space Astronauts.";
			show ending 9 of 9 aka the "super-secret" ending;
		otherwise:
			say "Loose lips sink ships.";
			show ending 8 of 9 aka the "aardvark" ending;
	otherwise:
		say "You don't hear or see anything else, ever again.[paragraph break]";
		say "Loose lips sink ships.";
		show ending 7 of 9 aka the "basic" ending.




The Tichy default conversation rule is listed last in the instead rulebook.
The default conversation rule is listed last in the instead rulebook.

After reading a command:
	if the player's command includes "open the pod bay doors":
		say "I'm sorry, Dave.  I'm afraid I can't do that.";
		reject the player's command.



Section 2 - WIP testing mode - Not for release

Teleporting to is an action out of world applying to one thing.  Understand "teleport to [anywhere]" and "teleport [anywhere]" as teleporting to.
Check teleporting to a room (called the destination):
	try teleporting yourself to the destination;

Teleporting it to is an action out of world applying to two things.  Understand "teleport [anything] to [anywhere]" and "teleport [anything] [anywhere]" as teleporting it to.
Check teleporting it to:
	say "Thanks to testing mode, you teleport [the noun] to [the second noun].  With great power comes great responsibility!";
	now the noun is in the second noun;

Report teleporting to:
	deactivate secretary-warns;
	deactivate director-yells-1;
	deactivate director-yells-2.

Showing available stuff is an action out of world applying to nothing.
Understand "show available stuff" as showing available stuff.
Carry out showing available stuff:
	say "Available stuff:[line break]";
	open HTML tag "ul";
	repeat with item running through the available objects:
		place "li" element reading "[item]";
	close HTML tag;
	say "End of available stuff."

Showing interesting stuff is an action out of world applying to nothing.
Understand "show interesting stuff" as showing interesting stuff.
Carry out showing interesting stuff:
	say "Interesting stuff:[line break]";
	open HTML tag "ul";
	repeat with item running through interesting things:
		place "li" element reading "[item]";
	close HTML tag;
	say "End of interesting stuff."

Showing all stuff is an action out of world applying to nothing.
Understand "show all stuff" as showing all stuff.
Carry out showing all stuff:
	say "All stuff:[line break]";
	open HTML tag "ul";
	repeat with item running through things:
		open HTML tag "li";
		say "[item]";
		if item is a concept:
			if item is a physical concept:
				say ", a physical concept";
			otherwise:
				say ", a concept";
		if item is scenery and item is not a concept:
			say ", scenery";
		if item is visible:
			say ", visible";
		if item is a person:
			say ", person";
		if item is interesting:
			say ", [interesting]interesting[/interesting]";
		if item is critical:
			say ", [interesting]critical[/interesting]";
		if the description of item is not "":
			say ", [interesting]with description[/interesting]";
		say ", in [location of item]";
		close HTML tag;
	close HTML tag;
	say "End of all stuff."



[Test commands for speedy testing:]

Test stand with "sit / stand / stand / z / z / n".

Test plant with "l / take plant / l / drop plant / l / eat plant".

Test waiting with "z / z / z / z / z / n";

Test nameplate with "test waiting / x nameplate / x desk / take nameplate / i / x nameplate / g / g / g / g / l / x desk / drop nameplate / l / x desk / put nameplate on desk / l / x desk / open nameplate / l / x toblerone / eat toblerone".

Test start1 with "test waiting / x checklist / take checklist / talk to director / ask director about internship / take checklist / give checklist to director / x checklist / i".

Test nobody with "test start1 / e / ask about nasa".

Test tasks with "test start1 / ask about blueprints / ask about equations / ask about crew".

Test blueprints with "test start1 / e / e / ask about blueprints / ask about whiteprints / x engineer / take blueprints / i / x checklist".

Test coffee with "test start1 / e / e / x coffee pot / take pot / i / take coffee / i / put checklist in pot / i / drop pot".

Test plaque with "test start1 / e / x plaque".

Test equations with "test start1 / e / n / ask dr about name / ask dr about work / ask dr about equations / ask dr about rocket equations / ask dr about rockets / x board / take chalkboard / s / n / e / w / n / ask dr them about him / talk to him / l / x them / x checklist".

Test dr with "test start1 / e / n / x dr / l".

Test key with "test start1 / e / n / x dr / take key / n / ask them about him / take key / n / ask them about him / take key / n / s / teleport key to hallway / take key / n".

Test tapir with "test start1 / e / n / ask dr about tapir / ask dr about brizzleby / ask them about brizzleby / ask dr about rocket equations / ask dr about brizzleby / ask dr about nasa / ask dr about tapir / ask dr about brizzleby / ask dr about nasa".

Test aliens with "test key / x tapir / ask tapir about name / x cage / open cage / x cage / s / x tapir / ask about nasa / ask about apollo / ask about dr / ask about rocket equations / x checklist".

Test others with "test start1 / e / n / talk to other scientists / talk to scientists / talk to others / talk to them / talk to scientist / talk to him / talk to head / talk to head scientist / talk to rocket scientist / talk to doctor".

Test shoe with "test start1 / e / n / ask dr about rocket equations / sorry / w".

Test crew with "test start1 / e / s / choose donna / x file 1 / wake him / ask him about name / ask him about files / take files / drop file 1 / choose aldrin / choose donna / x checklist / choose aldrin / choose collins / x checklist / choose armstrong / x checklist / choose nowak".

Test wake with "test start1 / wake him / sorry / wake him / e / s / x him / open drawer / l / x him / n / s / wake him / n / s / talk / ask about crew / i / ask about crew / ask about files".

Test files with "test start1 / e / s / take files / x file 1 / x file 2 / x file 3 / x file 4 / x file 5 / x file 6 / i".

Test drawer with "test start1 / e / s / open drawer / close drawer / open cabinet / close cabinet / open drawer / l / take files / l".

Test day2 with "test blueprints / w / s / take files / choose aldrin / choose nowak / choose tichy / n / n / take chalkboard / w / report".

Test day2alt with "test blueprints / w / s / take files / choose aldrin / choose nowak / choose tichy / n / n / x dr / take key / n / ask dr about tapir / take key / n / ask dr about tapir / take key / ask tapir about name / open cage / s / ask about rocket equations / w / give checklist to director".

Test glitter1 with "test waiting / ask about glitter".

Test glitter2 with "test day2 / test waiting / talk to him / x checklist / talk to him / ask about glitter".

Test glitter2alt with "test day2alt / test waiting / talk to him / x checklist / talk to him / ask about glitter".

Test start2 with "test day2 / test waiting / ask about glitter / take checklist / x checklist".

Test start2alt with "test day2alt / test waiting / ask about glitter / take checklist / x checklist".

Test foodonly with "e / d / e / take food / give chicken to buzz / give tuna to nowak / give tuna to tichy / give chicken to photographer / w / u / s / wake him / give blt to franklin / n / w / give blt to dirk / s / give salad to donna / x checklist".
Test food with "test start2 / test foodonly".
Test foodalt with "test start2alt / test foodonly".

Test drugs with "test start2 / e / d / w / take all drugs / e / e / give lsd to nowak / give tuna to nowak / give cake to nowak / ask nowak about nasa / give librium to nowak / ask nowak about nasa / give chicken to buzz / give librium to buzz / ask buzz about nasa / give cake to buzz / ask buzz about nasa".

Test drugorder with "test start2alt / e / d / w / take all drugs / e / e / give tuna to nowak / give cake to nowak / ask nowak about nasa / give librium to nowak / ask nowak about nasa / give lsd to nowak / ask nowak about nasa / give liquid to nowak / ask nowak about nasa / give chicken to buzz / give lsd to buzz / x nowak / x buzz".

Test drugnfilm with "e / d / w / take all drugs / e / e / give lsd to nowak / give lsd to buzz / give lsd to tichy / x checklist / x script / action / w / u / w / give checklist to director".
Test day3 with "test food / test drugnfilm".
Test day3alt with "test foodalt / test drugnfilm".

Test end with "test day3 / d / e / w".
Test endalt with "test day3alt / d / e / w".
