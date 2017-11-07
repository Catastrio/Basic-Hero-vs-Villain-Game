# Basic-Hero-vs-Villain-Game
In Second Life, this mini game is a battle between a player and a villain. The damage and heal values between the two vary.  The villain also has an extremely simple decision tree for his actions.
On touch, the player object displays a dialog box to the player.
The player chooses between attacking, healing or charging their mana.
When the player makes a choice, the player object will send a message on
a private channel to prompt the villain to subtract HP. The villain's
choices work the same way.

The player loses if their health or mana reaches 0. The villain only
loses if reduced to zero hp.

To build this in Second Life, simply create two cubes and put the player.lsl in one and the villain.lsl in the other.
