# RUSH-HOUR-GAME

RUSH HOUR GAME:
				It is a 2D passenger pickup and dropoff game implemented using x86 irvine32 assembly language. I used two libraries in my project i-e irvine32.inc for graphics and winmm.lib for adding sound features. It majorly focuses on pick and drop of passengers, collision detection, score board display using filehandling and background sounds using only assembly language. The taxi is controlled by a player that can pick and drop a passenger, can collect bonuses and can take the shortest path followed by the player.
Features Implemented: I implemented following features in my rush hour game:
●Main Menu: In my main menu, I implemented options of new game, continue game, Difficulty Level, LeaderBoard Display, Instruction Page and exit. It also displays the current difficulty level, taxi color, and game mod of the game lastly played.
●Game Modes: In this i implemented three modes of game i-e Career mode in which there are specified number of passengers assigned to be delivered on their destinations, Time mode in which there is specified time in which we have to drop of the passengers, and endless mode where passengers automatically respawn after every of them is dropped off.
●Difficulty Level: In this i implemented three levels of difficulty in game i-e Easy, Medium and Hard. And players can select any of these by selecting their specified option.
●Taxi Color Choice: In this sub-menu, i allowed players to select their own taxi color or let us choose their taxi color.
●NPC Cars: I implemented the random motion of other cars in my game, that moves randomly throughout the gameboard.
●Trees and Buildings: In this we have trees and buildings in our gameboard.
●Bonus: Players can collect bonuses on the gameboard and gain 10 points as a reward.
●Collision: When the taxi collides with a tree or other npc car it will lose points accordingly. If a red taxi collides with a tree it will lose 2 points and with a npc car it will lose 3 points. Also for a yellow taxi, if it collides with a tree it will lose 4 points and with another npc car it will lose 2 points.
●Passenger Pick and Drop: In this, the passengers have their own location where we can pick them using the space bar and then drop them at their desired destination using the space bar again.
●Leader board: In this, the top ten highest scores of players will be displayed using filehandling functions.
●Pause the Game: Players can pause the game using the ‘P’ button on the keyboard in case of extra work.

Visual Representation:
				In this I specified the symbols for the items on the gameboard. Following are some of them:
●Board Items:
		1. Taxi  —->  ‘< >’
		2. Empty Road —-->  ‘.’
		3. NPC Car —---> ‘[]’
		4. Tree —---> ‘^|’
		5. Bonus —--> ‘$’
		6. Passenger —--> ‘P’
		7. Destination —--> ‘D’
●Taxi Movement: 
		1. Up —--> decrease in Y
		2. Down —-> increase in y
		3. Right —---> increase in x
		4. Left—---> Decrease in x
User Manual:
Following are some tips for users playing for first time:
●Controls: 

Key	         Action
Arrow Keys	 Move Taxi
Space Bar    on Passenger	Pickup Passenger
Space Bar    on destination	Drop off passenger
P	           Pause the game
esc	         Return to menu
●Objectives:
	1. Pick up Passenger
	2. Drop off the Passenger
	3. Do not collide with trees or NPC cars
	4. Collect bonuses
●Game over Conditions:
	1. All Passengers dropped off in career mode
	2.Time over in time mode
	3. Pressed esc
UI Screenshots:

<img width="468" height="247" alt="image" src="https://github.com/user-attachments/assets/de4f32b9-293a-4d66-9cef-b9331768b160" />
<img width="468" height="246" alt="image" src="https://github.com/user-attachments/assets/f2572f07-6c81-4235-b607-fea1dc9bf66d" />
<img width="468" height="246" alt="image" src="https://github.com/user-attachments/assets/13f39a12-eb50-48ef-bbdb-b754ee87f8bd" />
<img width="468" height="246" alt="image" src="https://github.com/user-attachments/assets/16e54edd-c487-4d16-9f74-8fe42b52ca2d" />


Video Link:
https://drive.google.com/file/d/1SNtvYSD-E0RAL8F8yMBgfe3BC938TMpS/view?usp=sharing
