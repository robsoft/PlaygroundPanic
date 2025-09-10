## Developer Notes (for contributors)

This section is a quick “handover” for anyone opening the codebase for the first time.

### 1) Module Roles & Flow

- **PlaygroundPanic.bas** — entry point / bootstrap. Decides which screen to show first, initializes globals, loads helpers.
- **AttractScreen.bas** — title/attract loop (demo mode, credits hook).
- **GameScreen.bas** — main gameplay loop (input → update → draw → music tick → loop).
- **Interstitials:** `LevelStartScreen.bas`, `LevelEndScreen.bas`, `LifeLostScreen.bas`, `GameOverScreen.bas`.
- **Meta UI:** `SettingsScreen.bas`, `KeysScreen.bas`, `HiScoreListScreen.bas`, `HiScoreEntryScreen.bas`, `CreditScreen.bas`, `LoreScreen.bas`.
- **Support:**  
  - `Constants.bas` — tunables (speeds, palette ids, gravity, collision sizes).  
  - `Helpers.bas` — generic helpers (rng, clamping, timers, table lookups).  
  - `GameHelpers.bas` — game-specific helpers (spawn waves, resolve collisions, scoring).  
  - `Specials.bas` — hazards/power-ups orchestration.  
  - `_nextlib.bas` — Spectrum Next helpers (sprites, layers, palette, bank/file helpers).  
- **Assets:** `data/` and `rob4.pt3` (AY/PT3 music).

> Convention: each screen exposes a public entry routine like `RUN_*SCREEN` and returns cleanly to its caller.

### 2) Screen Lifecycle Pattern

Use a simple, consistent pattern so screens can yield to one another without side-effects:

```basic
REM ===== in AttractScreen.bas =====
DEF PROC RUN_ATTRACT()
  PROC init_attract()
  REPEAT
    PROC poll_input()
    PROC update_attract()
    PROC draw_attract()
    PROC music_tick()
  UNTIL exitRequested
  PROC teardown_attract()
END PROC
```
When you need to change screen, set a shared nextScreen$ and exitRequested=TRUE. The caller (usually PlaygroundPanic.bas) reads nextScreen$ and jumps accordingly.

### 3) Constants & Tuning

Centralize tunables to avoid “magic numbers” in loops:
```basic
REM ===== Constants.bas =====
REM player movement
LET PLAYER_W = 12: LET PLAYER_H = 16
LET PLAYER_RUN_SPEED = 2
LET PLAYER_JUMP_VEL  = -5
LET GRAVITY = 1

REM gameplay pacing
LET HAZARD_SPAWN_EVERY = 80   : REM frames
LET MAX_KIDS_PER_LINE = 6

REM colors/palettes (ids are abstract; actual palette set in _nextlib.bas)
LET PAL_TITLE = 0
LET PAL_GAME  = 1
LET PAL_SCORE = 2
```

> Edit here first for balance passes. Avoid redefining in the screen modules.  

### 4) Input Handling

Keep input polling separate from game logic so we can swap keyboard/joypad later:
```basic
REM ===== Helpers.bas =====
DEF PROC POLL_INPUT()
  REM read keyboard
  LET left  = INKEY$("O") <> ""
  LET right = INKEY$("P") <> ""
  LET jump  = INKEY$("Q") <> "" OR INKEY$("SPACE") <> ""
  LET act   = INKEY$("A") <> ""
  LET pause = INKEY$("SPACE") <> ""  : REM if not used for jump

  REM (optional) call into _nextlib.bas to read joystick if present
  REM PROC read_joy()
END PROC
```

> Don’t branch UI and gameplay on raw keystrokes sprinkled around the code — route everything through a single POLL_INPUT step.  

### 5) Game Loop Shape

Target a stable cadence: poll → update → draw → audio tick. If you keep per-frame work bounded (sprite count, collision pairs), 50 Hz is feasible on Next hardware.
```basic
REM ===== GameScreen.bas (sketch) =====
DEF PROC RUN_GAME()
  PROC init_game()
  REPEAT
    PROC POLL_INPUT()
    PROC step_physics()
    PROC step_ai()
    PROC resolve_collisions()
    PROC draw_world()
    PROC draw_hud()
    PROC music_tick()
    REM (Optional) small PAUSE to keep cadence reasonable in emulators
    REM PAUSE 0 : REM or a minimal delay if you observe runaway loops
  UNTIL gameOver
  PROC teardown_game()
END PROC
```

> If you add any blocking calls (file I/O, heavy generation), do them between screens or in a one-time init phase, not mid-loop.  

### 6) Sprites, Layers & Palettes (Next basics)

Try to funnel all hardware-specific calls through _nextlib.bas (init sprite engine, upload frames, set palettes, switch to Layer 2 / Tilemap, etc.).

Respect practical limits: too many overlapping sprites on one scanline can drop frames or flicker.

Prefer pre-computation: cache sprite frame ids, tile indices, and bounding boxes.

Keep palette changes coherent: define palette sets (PAL_TITLE, PAL_GAME, …) and switch via a single helper PROC set_palette(id).

> This separation lets us swap render paths (e.g., Tilemap vs Layer 2) without touching game logic.  

### 7) Audio (PT3 / AY)

Keep a tiny music_tick() that’s called once per loop iteration; it should advance the PT3 player state and return quickly.

Provide a global flag musicOn and make all audio helpers no-ops when disabled (for emu setups without AY).

8) Data & Files

Place binary tables/levels under data/.

If you implement save data (e.g., high scores), use a single file near the game (e.g., PLAYPANIC.HI) and write a version byte up front so future formats can be migrated.
```basic
REM ===== Helpers.bas (sketch) =====
DEF PROC SAVE_HISCORE(name$, score)
  REM open file, write version, entries, checksum (simple sum is fine)
END PROC

DEF PROC LOAD_HISCORES()
  REM if version mismatch, reset to defaults
END PROC
```

### 9) Debugging & Tools

Add a build-time #IF DEBUG flag (if you prefer conditional includes) or a runtime debug=1 global to toggle:

a simple FPS or frame counter,

collision boxes,

AI state text.

Create small, deterministic test setups (e.g., “spawn one hazard at x=…”). Determinism makes regressions obvious.
```basic
IF debug THEN PROC draw_hitboxes()
IF debug THEN PRINT AT 0,0; "Score:";score;"  Lives:";lives
```

### 10) Performance Tips

Sprite budget: cap max concurrent sprites; reuse/deactivate rather than allocate new.

Collision pruning: broad-phase first (grid or AABB), then narrow-phase.

Tables > math: where possible, precompute sines, velocity clamps, or animation step tables.

Avoid per-frame file access. Load assets at screen init; close files promptly.

### 11) Code Style

Use PROC/FN to give names to logical steps; avoid long, monolithic loops.

Keep related variables grouped with a comment header (PLAYER_, ENEMY_, HUD_…).

Document any hardware interaction in _nextlib.bas with a one-line “what/why”, and keep raw numbers out of gameplay code.

### 12) Adding a New Screen (Checklist)

Create NewScreen.bas with PROC RUN_NEWSCREEN().

Initialize/reset only what you own; restore anything you changed on exit.

Wire it in the caller (usually PlaygroundPanic.bas’s screen switch).

If it needs graphics/audio assets, load them once in init_… and free/disable in teardown_….

Quick Tasks Backlog (nice to have)

- [ ] Joypad support in _nextlib.bas; surface via POLL_INPUT.
- [ ] File-based high-score persistence with versioned header.
- [ ] Optional FPS/debug overlay.
- [ ] Palette accessibility presets (deuteranopia/tritanopia-friendly).
- [ ] Add a second PT3 track and a “music: on/off” toggle in Settings.
