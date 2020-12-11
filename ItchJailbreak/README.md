# Itch JailBreak

The GitHub version of the game is automatically updated with every push using
GitHub Actions.  But for the Game Jab, we had to host a version within itch.io,
which had to be uploaded as a zip file.

Uploading a snapshot to itch made sense for the contest, where a consistent
version had to be locked in on Dec 1, 2020.  But after the judging is over,
we'd prefer people leave itch.io to play the live version hosted on GitHub.

This is a simple page that will jailbreak out of itch.io and send users to the
live version on GitHub.  If the automatic forwarding fails, the page will
contain a simple link to GitHub that will open in a new tab.
