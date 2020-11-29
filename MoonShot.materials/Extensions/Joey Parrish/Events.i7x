Version 1 of Events by Joey Parrish begins here.

An event is a kind of object.
An event has a number called the countdown.
An event has text called the message.
An event can be pending.  A event is usually not pending.
An event has a number called the count.  The count of a event is usually 0.

To activate (X - a event) in (Y - a number) turns:
	activate X in Y turns with message "".

To activate (X - a event) in (Y - a number) turns with message (Z - text):
	now the countdown of X is Y;
	now the message of X is Z;
	now X is pending.

To deactivate (X - a event):
	now the message of X is "";
	now X is not pending.

Triggering is an action out of world applying to one thing.
[Out of world, because the object it applies to (the counter) isn't in any physical place.]

Check triggering an event (called X):
	if the number of words in the message of X is not 0:
		say the message of X;
	deactivate X;
	increase the count of X by 1.

Every turn:
	repeat with X running through events:
		if X is pending:
			decrease the countdown of X by 1;
			if the countdown of X <= 0:
				try triggering X.

Events ends here.

---- Documentation ----

You may find yourself wanting to count down turns from some event until some other event, and to cancel that second event upon some third event.  If this is you, try this extension!

	Toast-is-done is an event.
	After going to the kitchen:
		activate toast-is-done in 3 turns.
	Carry out toast-is-done:
		say "DING!  Toast is done!"
	
	Cuckoo is an event.
	When play begins:
		activate cuckoo in 5 turns.
	Carry out cuckoo:
		say "Cuckoo!";
		activate cuckoo in 5 turns.
	
	Toilet-floods is an event.
	When play begins:
		activate toilet-floods in 2 turns.
	Carry out toilet-floods:
		say "Crap!!!"
	After shutting off water:
		deactivate toilet-floods;
		say "Crisis averted!"
