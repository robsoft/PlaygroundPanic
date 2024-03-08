sub HandleLevelCodeScreen()
  if needInit=1 then InitLevelCodeScreen()
  UpdateLevelCodeScreen()
  ReadLevelCodeKeyboard()
  if needInit=2 then ChangeMusic()
end sub


sub InitLevelCodeScreen()
  AllSpritesOff()
  
  CLS256(COLOR_BACKGROUND)
  L2Text(1, 1, "ENTER LEVEL CODES", BANK_FONT, 0)
  L2Text(20, 22, "PRESS SPACE", BANK_FONT, 0)
  needInit=0
end sub


sub UpdateLevelCodeScreen()
end sub


sub ReadLevelCodeKeyboard()
  dim key as UINTEGER
  key = GetKeyScanCode()
  if key=KEYSPACE
    Debounce(KEYSPACE)
    JumpScreen(GAMESCREEN)
  endif
end sub

