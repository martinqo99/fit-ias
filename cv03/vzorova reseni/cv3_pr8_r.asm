;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 3 - cvicny priklad c. 8
;
; Prepiste nize uvedenou konstrukci v jazyce C do jazyka symbolickych adres.
;
; int c;
; c = getc(stdin);
; while(c != 'q')
; {
;   printf("%c\n", c);
;   c = getc(stdin);
; }
;
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]
  
[segment .code use32]

prologue
  
; ZDE DOPLNTE VAS KOD

priklad8:
call ReadChar
.while:
  cmp al,'q'
  jz .end
  call WriteChar
  call WriteNewLine
  call ReadChar
  jmp .while
.end:

epilogue