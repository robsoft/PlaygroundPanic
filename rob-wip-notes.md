## Robs Internal Notes (somewhat out of date)  
* thatcher/dog sprite confusion when it came to leave the screen?  
* Don't want to spawn anything at the school door if we are in the vicinity of it  
* The end of level heme is not working, it's crackly/distorted (wrong replayer?)  
* check the colour palette values, the player seems to be off-white?  
* make it so you CAN touch a frozen kid (it's the only way to escape sometimes?)  

> Need to support joypad, kempston
> have the remaining lives do a little bugaloo while everyone is paused?

* black frames (hit dog etc)?
* check dog start position
* give dog & dinner lady more ground to cover (further-away initial target
* spread npc over play area better (at low numbers)
* npcs & player quickly walk out to start positions, collision detection off during this bit  
* large bouncy bell sprite for start/end  
* text for end life, end game bonuses  
* scoring mechanism! - points for seconds lasted overall the entire game, onscreen score  
 
* balance switching between different cKind(c) states - reinstate direction changing  

* improve player graphics  
* sort palette issues  
* write dinner lady code  
* level entry and level code generation  
* control/key selection etc  
* hiscore list  
* hiscore name entry  
* save score to next (if possible)  
* replace ReadKeyboard handlers with simple common one for space etc  
* remove unused UpdateItem handlers  

## More Todos
* document code
* basic music code (between games)
* look at in-game music possibilities (want to be able to turn it off, if we can make it work)
* graphics (input from Lou, Livs)
* dog-bark sample?
* school bell sound?

## Other Improvements  

### Dinner Lady
* dinner lady appears every 1:00-2:00 mins if no dog or milk in action SPRITE_DINNER (32) maybe use attached/anchor sprite?  
* she will cross the screen from one side to the other (horiz or vert, in either direction)  
* she does this in the 'middle', breaking the play area in half  
* if you move in front of her, across the direction she is heading towards, she will see you and you have to freeze until she passes  
* she moves at the speed of a fast kid  
* she has same effect on NPC sprites too (maybe look at the cMode(c) flag)  
 
### Dog  
* dog will appear every 1:00-2:00 mins if no dinner lady in action SPRITE_DOG (33)  
* dog will pick a random target on screen, head for it, wait a little while, then head for the exit  
* on the way to the target the dog will leave a poo-tile behind, which we will have to detect and 'slide' on if encountered  
* a slide is where you suddenly cannot control the player and you continue in the direction you were moving in for (say) a third of the screen or you hit the edge'
* (TECH : how to check collision between sprite and a tile)

### Milk 
* milk will appear every 1:00-2:00 mins if no dinner lady in action SPRITE_MILK (34) SPRITE_SNATCHER (35)  
* snatcher will appear 15s after milk appears. She will target the milk. Once she reaches the milk, she heads for the exit.  
* if you get the milk first, 30s off the time. if she gets the milk, 30s on to the time (back up to a max of the initial level time)  
* if the milk has been unclaimed somehow for 45s it disappears and any onscreen snatcher heads for the exit  

### Spacedust
* spacedust will appear every 1:00-2:00 mins SPRITE_DUST (31)  
* it stays there until claimed by you. When you touch it, all the NPCs will freeze for 10s. This includes dinner ladies, snatchers, dogs etc

### School Cane   
* school cane will appear every 1:00-2:00 mins SPRITE_CANE (36)
* if you touch it, you will freeze for 10s

### Collisions  
* collisions always count, if the NPC is frozen or you are frozen, either counts  
* hitting snatcher or dinner lady is same as hitting NPC (die)  
* hitting dog will freeze you for 10s (like cane)  
* NPC hitting dog will cause it to retarget to leaving screen if not already doing so  

