thatcher/dog sprite confusion when it came to leave the screen?
Don't want to spawn anything at the school door if we are in the vicinity of it
The end of level heme is not working, it's crackly/distorted (wrong replayer?)
check the colour palette values, the player seems to be off-white?
make it so you CAN touch a frozen kid (it's the only way to escape sometimes?)

Need to support joypad, kempston
have the remaining lives do a little bugaloo while everyone is paused?


' GET TO ALPHA
' black frames (hit dog etc)?
' check dog start position
' give dog & dinner lady more ground to cover (further-away initial target
' spread npc over play area better (at low numbers)
' npcs & player quickly walk out to start positions, collision detection off during this bit 1h 
' large bouncy bell sprite for start/end 1h
' text for end life, end game bonuses
' scoring mechanism! - points for seconds lasted overall the entire game, onscreen score
' 
' balance switching between different cKind(c) states - reinstate direction changing 1h
'
' disable dinner lady (change sequence) 10m 
' teaser posts 20m
' =8-9h - this week
'
' GET TO BETA
' improve player graphics 1h
' sort palette issues 1h
' write dinner lady code 2h
' level entry and level code generation 3h
' control/key selection etc 2h
' hiscore list 1h
' hisore name entry 2h
' save score to next (if possible) 1h
' replace ReadKeyboard handlers with simple common one for space etc 1h
' remove unused UpdateItem handlers 30m
' =14h - next week


' POST BETA POLISH
' document code 1h
' basic music code (between games) 8h
' look at in-game music possibilities (want to be able to turn it off, if we can make it work) 4h
' graphics (input from Lou, Livs) 4h
' dog-bark sample? 2h
' school bell sound? 2h
' =25h - into mid feb
'
' ROLL-OUT
' beta-test shouts on itch.io and facebook 3h
' public github repo 1h
' =4h
'
'
' dinner lady appears every 1:00-2:00 mins if no dog or milk in action SPRITE_DINNER (32) maybe use attached/anchor sprite?
' she will cross the screen from one side to the other (horiz or vert, in either direction)
' she does this in the 'middle', breaking the play area in half
' if you move in front of her, across the direction she is heading towards, she will see you and you have to freeze until she passes
' she moves at the speed of a fast kid
' she has same effect on NPC sprites too (maybe look at the cMode(c) flag) 
'
' dog will appear every 1:00-2:00 mins if no dinner lady in action SPRITE_DOG (33)
' dog will pick a random target on screen, head for it, wait a little while, then head for the exit
' on the way to the target the dog will leave a poo-tile behind, which we will have to detect and 'slide' on if encountered -
' a slide is where you suddenly cannot control the player and you continue in the direction you were moving in for (say) a third of the screen
' or you hit the edge'
' (TECH : how to check collision between sprite and a tile)
' 
' milk will appear every 1:00-2:00 mins if no dinner lady in action SPRITE_MILK (34) SPRITE_SNATCHER (35)
' snatcher will appear 15s after milk appears. She will target the milk. Once she reaches the milk, she heads for the exit.
' if you get the milk first, 30s off the time. if she gets the milk, 30s on to the time (back up to a max of the initial level time)
' if the milk has been unclaimed somehow for 45s it disappears and any onscreen snatcher heads for the exit'
'
' spacedust will appear every 1:00-2:00 mins SPRITE_DUST (31)
' it stays there until claimed by you. When you touch it, all the NPCs will freeze for 10s. This includes dinner ladies, snatchers, dogs etc
' 
' school cane will appear every 1:00-2:00 mins SPRITE_CANE (36)
' if you touch it, you will freeze for 10s
'
' collisions always count, if the NPC is frozen or you are frozen, either counts
' hitting snatcher or dinner lady is same as hitting NPC (die)
' hitting dog will freeze you for 10s (like cane)
' NPC hitting dog will cause it to retarget to leaving screen if not already doing so

