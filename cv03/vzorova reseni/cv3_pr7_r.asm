;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 3 - cvicny priklad c. 7
;
; Prepiste nize uvedenou konstrukci v jazyce C do jazyka symbolickych adres.
;
; for(int i = 15; i > 0; i--) printf("%d ", i);
;
; Vzorovy vystup je zde:
; 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]
  
[segment .code use32]

prologue
  
; ZDE DOPLNTE VAS KOD

priklad7:
mov cl,15
  
.for:
  cmp cl,0
  je .end
  mov al,cl
  call WriteUInt8
  mov al, ' '
  call WriteChar
  dec cl
  jmp .for
.end:

call WriteNewLine

epilogue