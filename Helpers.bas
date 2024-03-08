#include <keys.bas>
#include <nextlib.bas>


' patches & hacks for Sprite handling


' placeholder
sub PlaySound(sfx as ubyte)
	PlaySFX(sfx)
end sub


' don't return until the specfied key is NOT/no longer pressed
sub Debounce(key as UINTEGER)
  do
    WaitRetrace(1)
  loop until GetKeyScanCode() <> key
end sub


sub PlayerSpriteOff()
  RemoveSprite(SPRITE_PLAYER, 0)
end sub


sub UpdateSpriteHack(ByVal x AS uinteger,ByVal y AS UBYTE,ByVal spriteid AS UBYTE,ByVal pattern AS UBYTE,ByVal mflip as ubyte,ByVal anchor as ubyte)
    '                  5                    7              9                     11                   13                   15                       17          
    '  http://devnext.referata.com/wiki/Sprite_Attribute_Upload
    '  Uploads attributes of the sprite slot selected by Sprite Status/Slot Select ($303B). 
    ' Attributes are in 4 byte blocks sent in the following order; after sending 4 bytes the address auto-increments to the next sprite. 
    ' This auto-increment is independent of other sprite ports. The 4 bytes are as follows:

    ' Byte 1 is the low bits of the X position. Legal X positions are 0-319 if sprites are allowed over the border or 32-287 if not. The MSB is in byte 3.
    ' Byte 2 is the Y position. Legal Y positions are 0-255 if sprites are allowed over the border or 32-223 if not.
    ' Byte 3 is bitmapped:

    ' Bit   Description
    ' 4-7   Palette offset, added to each palette index from pattern before drawing
    ' 3 Enable X mirror
    ' 2 Enable Y mirror
    ' 1 Enable rotation
    ' 0 MSB of X coordinate
    ' Byte 4 is also bitmapped:
    ' 
    ' Bit   Description
    ' 7 Enable visibility
    ' 6 Reserved
    ' 5-0   Pattern index ("Name")

    ASM 
        ;               
        ;               X   Y ID  Pa 
        ;              45   7  9  11 13 15
        ;               0   1  0  3  2  4
        ; UpdateSprite(32 ,32 ,1 ,1 ,0 ,6<<1)
        ld a,(IX+9)         ;19                     ; get ID spriteid
        ld bc, $303b        ;10                     ; selct sprite slot 
        ; sprite 
        out (c), a          ;12
        
        ld bc, $57          ;10                     ; sprite control port 
        ld a,(IX+4)         ;19                     ; attr 0 = x  (msb in byte 3)
        out (c), a          ;12         
        
        ld a,(IX+7)         ;19                     ; attr 1 = y  (msb in optional byte 5)
        out (c), a          ;12
        
        ld d,(IX+13)        ;19                     ; attr 2 = now palette offset and no rotate and mirrors flags send  byte 3 and the MSB of X 
        ;or (IX+5)          ;19 
        
        ld a,(IX+5)         ;19                     ; msb of x 
        and 1               ;7
        or d                ;4
        out (c), a          ;12                 ; attr 3 
        
        
        ld a,(IX+11)        ;19                     ; attr 4 = Sprite visible and show pattern
        ;or 192                 ;7                      ; bit 7 for visibility bit 6 for 4 bit  
        ;or 64

        out (c), a          ;12
        ld a,(IX+15)        ;19                     ; attr 5 the sub-pattern displayed is selected by "N6" bit in 5th sprite-attribute byte.
        out (c), a          ;12                     ; att 
        ; 243 T     
    END ASM 
end sub


Sub L2TextRob(byval x as ubyte,byval y as ubyte ,m$ as string, fntbnk as ubyte, colormask as ubyte)
	
	asm 
		PROC
		;BREAK 
		LOCAL plotTilesLoop2, printloop, inloop, addspace, addspace2 
		; x and y is char blocks, fntbnk is a bank which contains 8x8L2 font 
		; need to get m$ address, x , y and maybe fnt bank?
		; pages into $4000 and back to $0a when done
		#ifndef IM2 
			call _checkints
			di 
		#endif 
		ld a,$52
		ld bc,$243B			; Register Select 
		out(c),a				; 
		inc b 
		in a,(c)
		ld (textfontdone+1),a 

		ld e,(IX+5) : ld d,(IX+7)	
		ld l,(IX+8) : ld h,(IX+9)
		ld a,(hl) : ld b,a 
		inc hl : inc hl 
		ld a,(IX+11) : nextreg $52,a 
	 
printloop:
		push bc 
		ld a,(hl)
		cp 32 : jp z,addspace
		cp 33 : jp z,addspace2
		sub 34 	
inloop:	
		push hl : push de 
		ex de,hl 
		call PlotTextTile
		pop de : pop hl 
		inc hl  
		inc e   
		pop bc
		djnz printloop
		jp textfontdone
addspace:
		ld a,57
		jp inloop 
addspace2:
		ld a,0
		jp inloop 

PlotTextTile:
		ld d,64 : ld e,a			
		MUL_DE					
		ld a,%01000000 : or d		; $4000
		ex de,hl	 : ld h,a : ld a,e
		rlca : rlca : rlca
		ld e,a : ld a,d
		rlca : rlca : rlca
		ld d,a : and 192 : or 3
		ld bc,LAYER2_ACCESS_PORT
		out (c),a : ld a,d : and 63
		ld d,a : ld bc,$800 
		push de 
		ld a,(IX+13)
		;ld a,8
plotTilesLoop2:
		
		push bc
		ld bc,8
		push de		
		ldirx
		pop de 
		inc d 
		pop bc 
		djnz plotTilesLoop2

		;ldi : ldi : ldi : ldi : ldi : ldi : ldi : ldi
		;pop de 
		;inc d 
		;dec a 
		;jr nz,plotTilesLoop2
		pop de 
		ret 
textfontdone:
		ld a,$0a : nextreg $52,a 
endofl2text:
		ld a,2 : ld bc,LAYER2_ACCESS_PORT
		out (c),a
		#ifndef IM2 
			ReenableInts
		#endif 
	ENDP 

	end asm 
	
end sub 


function ScanCodeToString(key as UINTEGER) as string
  dim res as string = "?"
  if key=KEYB
    res="B"
  elseif key = KEYN
    res="N"
  elseif key =KEYM
    res="M"
  elseif key =KEYSYMBOL
    res="SYM"
  elseif key =KEYSPACE
    res="SPACE"
  elseif key =KEYH
    res="H"
  elseif key =KEYJ
    res="J"
  elseif key =KEYK
    res="K"
  elseif key =KEYL 
    res="L"
  elseif key =KEYENTER 
    res="ENTER"
  elseif key =KEYY 
    res="Y"
  elseif key =KEYU 
    res="U"
  elseif key =KEYI 
    res="I"
  elseif key =KEYO 
    res="O"
  elseif key =KEYP 
    res="P"
  elseif key =KEY6 
    res="6"
  elseif key =KEY7 
    res="7"
  elseif key =KEY8 
    res="8"
  elseif key =KEY9 
    res="9"
  elseif key =KEY0 
    res="0"
  elseif key =KEY5 
    res="5"
  elseif key =KEY4 
    res="4"
  elseif key =KEY3 
    res="3"
  elseif key =KEY2 
    res="2"
  elseif key =KEY1 
    res="1"
  elseif key =KEYT 
    res="T"
  elseif key =KEYR 
    res="R"
  elseif key =KEYE 
    res="E"
  elseif key =KEYW 
    res="W"
  elseif key =KEYQ 
    res="Q"
  elseif key =KEYG 
    res="G"
  elseif key =KEYF 
    res="F"
  elseif key =KEYD 
    res="D"
  elseif key =KEYS 
    res="S"
  elseif key =KEYA 
    res="A"
  elseif key =KEYV 
    res="V"
  elseif key =KEYC 
    res="C"
  elseif key =KEYX 
    res="X"
  elseif key =KEYZ 
    res="Z"
  elseif key =KEYCAPS 
    res="CAPS"
  endif

  return res
end function

