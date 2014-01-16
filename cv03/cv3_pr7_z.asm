;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 3 - cvicny priklad c. 7
;
; Prepiste nize uvedenou konstrukci v jazyce C do jazyka symbolickych adres.
;
; for(int i = 15; i >= 0; i--) printf("%d ", i);
;
; Vzorovy vystup je zde:
; 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]
  
[segment .code use32]

prologue
  
; ZDE DOPLNTE VAS KOD
mov cl, 15
.iterace:
  mov al, cl
  cmp cl, 0
  jl .konec
  call WriteInt8
  call WriteNewLine
  dec cl
  jmp .iterace
  
  
.konec:
  
  

epilogue