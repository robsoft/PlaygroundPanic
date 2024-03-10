'!org=24576
' NextBuild Layer2 Template 


' PLAYGROUND PANIC (was APOCALYPSE BREAKTIME)
' Robsoft / Road 2024
'
'
#define NEX 
#define IM2 

#include <nextlib.bas>
#include <keys.bas>
#include <string.bas>
#include "Constants.bas"
#include "Helpers.bas"

SetupNext()
CLS256(COLOR_BLACK)

  LoadSDBank("font8.spr", 0, 0, 0, 32) 'BANK_FONT
  LoadSDBank("tiles_8x8.spr", 0, 0, 0, 34) 'BANK_TILES
  LoadSDBank("PanicSprites.spr", 0, 0, 0, 36) 'BANK_SPRITES

LoadSDBank("game.afb",0,0,0,41)

LoadSDBank("vt24000.bin",0,0,0,42)
'level1'`
LoadSDBank("rob1.pt3",0,0,0,43) 'MUSIC_ATTRACT
LoadSDBank("rob2.pt3",0,0,0,44) 'MUSIC_GAME
LoadSDBank("rob4.pt3",0,0,0,46) 'MUSIC_ENDLIFE
LoadSDBank("rob3.pt3",0,0,0,47) 'MUSIC_ENDGAME
LoadSDBank("hits1.pt3",0,0,0,48) 'MUSIC_HITS
LoadSDBank("hits2.pt3",0,0,0,49) 'MUSIC_HITS
LoadSDBank("hits3.pt3",0,0,0,50) 'MUSIC_HITS
LoadSDBank("hits4.pt3",0,0,0,51) 'MUSIC_HITS
LoadSDBank("hits5.pt3",0,0,0,52) 'MUSIC_HITS
LoadSDBank("hits6.pt3",0,0,0,53) 'MUSIC_HITS
LoadSDBank("hits7.pt3",0,0,0,54) 'MUSIC_HITS
LoadSDBank("hits8.pt3",0,0,0,55) 'MUSIC_HITS

InitSprites2(64, 0, BANK_SPRITES)

InitSFX(41)
InitMusic(42, MUSIC_ENDLIFE, 0000)
SetupIM()
PlaySFX(0)
EnableSFX
'EnableMusic

#include "GameHelpers.bas"

  for n = 9 to 21
    DoTileBank8(n, 12, TILE_BLACK_BACKGROUND, BANK_TILES)
    DoTileBank8(n, 13, TILE_BLACK_BACKGROUND, BANK_TILES)
    DoTileBank8(n, 14, TILE_BLACK_BACKGROUND, BANK_TILES)
  next n

  L2Text(9, 9, "STOP THE TAPE!", BANK_FONT, 0)

  L2Text(8, 12, "PRESS SPACE/FIRE", BANK_FONT, 0)
  do : loop until SpaceOrFire()=1


#include "AttractScreen.bas"
#include "SettingsScreen.bas"
#include "GameOverScreen.bas"
#include "Specials.bas"
#include "LifeLostSCreen.bas"
#include "GameScreen.bas"
#include "LevelStartScreen.bas"
#include "LevelEndScreen.bas"
#include "HiScoreEntryScreen.bas"
#include "HiScoreListScreen.bas"
#include "LevelCodeScreen.bas"
#include "KeysScreen.bas"
#include "LoreScreen.bas"
#include "CreditScreen.bas"

GenerateLookupTables()

GameInit()
JumpScreen(ATTRACTSCREEN)
'JumpScreen(LOOPSCREEN)
'JumpScreen(GAMEOVERSCREEN)

CLS256(COLOR_BACKGROUND)

' MAIN GAME LOOP
do
  WaitRetrace(1)

  if screenType=GAMESCREEN
    HandleGameScreen()
  elseif screenType=LEVELSTARTSCREEN
    HandleLevelStartScreen()
  elseif screenType=LEVELENDSCREEN
    HandleLevelEndScreen()
  elseif screenType=LEVELCODESCREEN
    HandleLevelCodeScreen()
  elseif screenType=GAMEOVERSCREEN
    HandleGameOverScreen()
  elseif screenType=LIFELOSTSCREEN
    HandleLifeLostScreen()
  elseif screenType=ATTRACTSCREEN
    HandleAttractScreen()
  elseif screenType=SETTINGSSCREEN
    HandleSettingsScreen()
  elseif screenType=LORESCREEN
    HandleLoreScreen()
  elseif screenType=HISCORELISTSCREEN
    HandleHiScoreListScreen()
  elseif screenType=HISCOREENTRYSCREEN
    HandleHiScoreEntryScreen()
  elseif screenType=KEYSSCREEN
    HandleKeysScreen()
  elseif screenType=CREDITSCREEN
    HandleCreditScreen()
  else
    ' debug/fallthru handler'
    if endGame<>255
      L2Text(1, 1, "ALL OK, LOOPING", BANK_FONT, 0)
      endGame=255
    endif
  endif   
loop




sub GenerateLookupTables()
  dim n as UINTEGER '  if you don't set this as UINTEGER, the for-loop will fail

  for n = 0 to 320
    tInts(n) = cast(INTEGER, n)
  next n

  for n = 0 to 12
    tSqrs(n) = cast(INTEGER, n*n)
  next n
end sub  


sub SetupNext()
  asm 
    ; setting registers in an asm block means you can use the global equs for register names 
    ; 28mhz, black transparency, sprites on over border, 256x192
    nextreg TURBO_CONTROL_NR_07,%11         ; 28 mhz 
    nextreg GLOBAL_TRANSPARENCY_NR_14,$0    ; black 
    nextreg SPRITE_CONTROL_NR_15,%01000011  ; %000    sprite 0 on top S L U, %11 sprites on over border
    nextreg LAYER2_CONTROL_NR_70,$0  ; 5-4 %00 = 256x192
  end asm 
end sub

