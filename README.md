# Playground Panic (ZX Spectrum Next)

_A fast, arcade-style playground caper for the **ZX Spectrum Next**, written in **NextBASIC**._

> Repo: `robsoft/PlaygroundPanic` (flat layout with screens split into multiple `.bas` files, plus a `data/` folder and a PT3 track).

## TL;DR

- **Platform:** ZX Spectrum Next (real hardware or CSpect / ZEsarUX)  
- **Language:** NextBASIC  
- **Run:** `LOAD "PlaygroundPanic.bas"` then `RUN` (NextZXOS)  
- **Save data:** (optional) High scores/name entry screens are included; see below


## Documentation
- [Developer Notes](DeveloperNotes.md)



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
```
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
```

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





