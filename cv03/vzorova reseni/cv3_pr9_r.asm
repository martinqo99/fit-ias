;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 3 - cvicny priklad c. 9
;
; Prepiste nize uvedenou konstrukci v jazyce C do jazyka symbolickych adres.
;
; int c;
;
; do
; {
;   printf("%s", message);
;   c = getc(stdin);
; } while(c != 'q')
;
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

string message,"Jsem otravna hlaska, ukoncete mne stiskem klavesy 'q'." ,EOL
  
[segment .code use32]

prologue
  
; ZDE DOPLNTE VAS KOD

priklad9:
mov esi,message
.do:
  call WriteString
  call ReadChar
  cmp al,'q'
  jz .end
  jmp .do
.end:

epilogue