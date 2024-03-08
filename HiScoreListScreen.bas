sub HandleHiScoreListScreen()
  if needInit = 1 then  InitHiScoreListScreen()
  UpdateHiScoreListScreen()
  ReadHiScoreListKeyboard()
  if needInit=2 then ChangeMusic()
end sub


sub InitHiScoreListScreen()
  AllSpritesOff()
  PlayerSpriteOff()
  
  CLS256(COLOR_BACKGROUND)
  L2Text(1, 1, "HIGH SCORE TABLE", BANK_FONT, 0)
  L2Text(20, 22, "PRESS SPACE", BANK_FONT, 0)
  needInit = 0
end sub

sub UpdateHiScoreListScreen()
end sub

sub ReadHiScoreListKeyboard()
  dim key as UINTEGER
  key = GetKeyScanCode()
  if key = KEYSPACE
    Debounce(KEYSPACE)
    JumpScreen(GAMESCREEN)
  endif
end sub

