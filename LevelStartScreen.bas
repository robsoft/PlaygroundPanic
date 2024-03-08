sub HandleLevelStartScreen()
  if needInit=1 then InitLevelStartScreen()
  UpdateLevelStartScreen()
  ReadLevelStartKeyboard()
  if needInit=2 then ChangeMusic()
end sub


sub InitLevelStartScreen()
  AllSpritesOff()
  
  CLS256(COLOR_BACKGROUND)
  L2Text(1, 1, "LEVEL START", BANK_FONT, 0)
  L2Text(0,10,"  )WILL HAVE SERIES OF STINGS", BANK_FONT, 0)
  L2Text(0,11,"     FROM HITS FROM THE DAY*", BANK_FONT, 0)
  L2Text(15, 22, "PRESS SPACE/FIRE", BANK_FONT, 0)
  needInit=2
  gCurrentTrack = MUSIC_HITS
  'gSubTrack = gLevel mod HITS_COUNT
end sub


sub UpdateLevelStartScreen()
end sub


sub ReadLevelStartKeyboard()
if SpaceOrFire()=1 then JumpScreen(GAMESCREEN)
end sub
