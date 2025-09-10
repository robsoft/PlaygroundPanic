# Playground Panic (ZX Spectrum Next)

_A fast, arcade-style playground caper for the **ZX Spectrum Next**, written in **NextBASIC**._

> Repo: `robsoft/PlaygroundPanic` (flat layout with screens split into multiple `.bas` files, plus a `data/` folder and a PT3 track).

## TL;DR

- **Platform:** ZX Spectrum Next (real hardware or CSpect / ZEsarUX)  
- **Language:** NextBASIC  
- **Run:** `LOAD "PlaygroundPanic.bas"` then `RUN` (NextZXOS)  
- **Save data:** (optional) High scores/name entry screens are included; see below

## Premise

The bell rings. Chaos erupts. Keep order on the playground—shepherd kids, dodge hazards, and survive the recess timer. Earn points for tidy routes and quick clears.

## Controls

Controls are configurable (see the **Keys** screen). A common default is:

- **Left/Right:** `O` / `P`  
- **Jump/Action:** `Q` / `A` or `SPACE`  
- **Pause:** `SPACE` • **Quit:** `ESC`

> The repo contains dedicated screens like `KeysScreen.bas`, `SettingsScreen.bas`, `HiScoreListScreen.bas`, and `HiScoreEntryScreen.bas`, indicating key-mapping and score entry support.

## Project Layout

The repository is intentionally flat so you can browse and load files quickly on the Next:

/
├── PlaygroundPanic.bas # Entry/loader
├── AttractScreen.bas # Title/attract loop
├── GameScreen.bas # Main gameplay loop
├── GameOverScreen.bas # Game over sequence
├── LevelStartScreen.bas # Level intro
├── LevelEndScreen.bas # Level complete
├── LevelCodeScreen.bas # (Optional) level code system
├── LifeLostScreen.bas # Death/respawn flow
├── HiScoreListScreen.bas # High-score table
├── HiScoreEntryScreen.bas # Name entry for scores
├── SettingsScreen.bas # Options (e.g., audio/controls)
├── KeysScreen.bas # Key mapping
├── CreditScreen.bas # Credits
├── LoreScreen.bas # Story/lore screen
├── Constants.bas # Game constants (palettes, sprite ids, speeds…)
├── Helpers.bas # Common helpers (timers, RNG, math…)
├── GameHelpers.bas # Gameplay helpers (spawns, collisions…)
├── Specials.bas # Power-ups / hazards orchestration
├── _nextlib.bas # Next-specific helpers (sprites, layers, regs)
├── rob4.pt3 # PT3 music track
├── sync.bat # Convenience script (e.g., copy to SD card)
├── data/ # Asset data (levels, tables, etc.)
└── LICENSE


## Running the Game

### Real Hardware (NextZXOS)

1. Copy the repo folder (or at least `*.bas`, `rob4.pt3`, and `data/`) to your SD card.  
2. From the NextZXOS browser:  

```
LOAD "PlaygroundPanic.bas"
RUN
```
3. Keep relative paths intact (e.g., `data/` next to the `.bas` files).

### Emulators

- **CSpect:** Run in ZX Next mode, mount an SD image/host folder containing the files, then load via NextZXOS browser.  
- **ZEsarUX:** Enable ZX Next features (sprites/layers/copper as needed), boot NextZXOS, and load as above.

## Audio

- Background music/SFX are handled via AY; the repo includes a **PT3** module (`rob4.pt3`). Make sure AY audio is enabled in your emulator (or on hardware) for full effect.

## Build / Workflow

This is a **NextBASIC-first** project:

- Develop & iterate directly in NextBASIC on hardware or an emulator.  
- Use `sync.bat` (optional) to mirror files to your SD image/device from a PC.  
- If you later produce a `.nex` binary, document the command(s) here.

## Technical Notes (Next Basics)

- **Screens split by role:** title/attract, gameplay, interstitials, settings, hi-score, etc. The main loader (`PlaygroundPanic.bas`) chains into these modules.  
- **Next helpers:** `_nextlib.bas` suggests a small compatibility layer for sprites/layers/ports; keep it loaded before game screens that rely on it.  
- **Constants & tuning:** Gameplay constants are centralized in `Constants.bas`—start there for balance tweaks.

## Data & Persistence

- **Level data / tables:** stored under `data/` (binary or BASIC `DATA` loaders, depending on your routines).  
- **Hi-scores:** handled by `HiScoreListScreen.bas` & `HiScoreEntryScreen.bas`. If you add file-based persistence, document the filename/format here.

## Roadmap (suggested)

- Gamepad/Joypad support & on-screen mapping help  
- Balance passes: spawn timing, hazards, NPC behavior  
- High-score save to disk (NextZXOS file)  
- In-game audio toggle; additional PT3 tracks  
- Color-palette accessibility presets

## Troubleshooting

- **Black screen/return to BASIC:** check that `_nextlib.bas` is loaded/merged before screens needing Next registers; verify `data/` path.  
- **No music:** emulator AY disabled or PT3 player not invoked on the relevant screen.  
- **Slowdowns:** reduce simultaneous sprites or expensive collision checks in `GameHelpers.bas`; precompute tables in `Helpers.bas`.

## Contributing

PRs and issues welcome. Please:

1. Keep `.bas` lines readable (labels + comments for key registers/ports).  
2. Group hardware `POKE`/`PORT` code inside `_nextlib.bas` where possible.  
3. Include emulator steps when filing bugs.

## License

MIT — see `LICENSE`.








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

