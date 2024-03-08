sub HandleLifeLostScreen()
  if needInit=1 then InitLifeLostScreen()

  UpdateLifeLostScreen()
  ReadLifeLostKeyboard()

  if needInit=2 then ChangeMusic()

end sub


sub InitLifeLostScreen()
  AllSpritesOff()
  
  CLS256(COLOR_BACKGROUND)
  L2Text(1, 1, "YOU GOT TOUCHED...", BANK_FONT, 0)

  GenEndLifeBonusText()
  
  L2Text(1,4,"A BOOBY-PRIZE;", BANK_FONT, 0)

  L2Text(2, 6, gBonusText(1), BANK_FONT, 0)
  
  'for bon=1 to gBonusTextCount
  ''  L2Text(2, 6+bon, gBonusText(bon), BANK_FONT, 0)
  'next bon
  if gLives>1
    L2Text(5,16,"YOU HAVE "+str(gLives)+" LIVES LEFT", BANK_FONT, 0)
  else
    L2Text(2,16,"LAST LIFE! PLAYGROUND PANIC!!", BANK_FONT, 0)
  endif  
  L2Text(3, 20, "PRESS SPACE/FIRE TO CONTINUE", BANK_FONT, 0)
  L2Text(10, 22, "OR PRESS 0 TO ABANDON", BANK_FONT, 0)
  needInit=0
end sub


sub UpdateLifeLostScreen()
end sub


sub ReadLifeLostKeyboard()
  dim key as UINTEGER = GetKeyScanCode()
  if key=KEYSPACE
    Debounce(KEYSPACE)
    JumpScreen(GAMESCREEN)
  elseif key=KEY0
    Debounce(KEY0)
    JumpScreen(GAMEOVERSCREEN)
  endif
end sub

