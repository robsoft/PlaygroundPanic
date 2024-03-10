sub HandleLevelEndScreen()
  if needInit=1 then InitLevelEndScreen()
  UpdateLevelEndScreen()
  ReadLevelEndKeyboard()
  if needInit=2 then ChangeMusic()
end sub


sub InitLevelEndScreen()
  AllSpritesOff()  
  
  CLS256(COLOR_BACKGROUND)
  L2Text(1, 1, "YOU SURVIVED BREAK-TIME...", BANK_FONT, 0)
 
  GenEndLevelBonusText()
  L2Text(1,4,"YOUR PRIZE;", BANK_FONT, 0)
  L2Text(2, 6, gBonusText(1), BANK_FONT, 0)
 
  'for bon=1 to gBonusTextCount
  ''  L2Text(2, 6+bon, gBonusText(bon), BANK_FONT, 0)
  'next bon

  L2Text(15, 22, "PRESS SPACE/FIRE", BANK_FONT, 0)
  needInit=2
''  gCurrentTrack=MUSIC_ENDLEVEL
  gCurrentTrack=MUSIC_ENDLIFE
end sub


sub UpdateLevelEndScreen()
end sub


sub ReadLevelEndKeyboard()
  if SpaceOrFire()=1 then 
    gLevel=gLevel+1
    JumpScreen(GAMESCREEN)
  endif
end sub

