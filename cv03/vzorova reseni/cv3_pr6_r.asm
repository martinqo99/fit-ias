;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 3 - cvicny priklad c. 6
;
; Prepiste nize uvedenou konstrukci v jazyce C do jazyka symbolickych adres.
;
; for(int i = 0; i < 15; i++) printf("%d ", i);
;
; Vzorovy vystup je zde:
; 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]
  
[segment .code use32]

prologue
  
; ZDE DOPLNTE VAS KOD
priklad6:
  mov cl,0
.for:
  cmp cl,15
  jae .end
  mov al,cl
  call WriteUInt8
  mov al, ' '
  call WriteChar
  inc cl
  jmp .for
.end:

call WriteNewLine

epilogue