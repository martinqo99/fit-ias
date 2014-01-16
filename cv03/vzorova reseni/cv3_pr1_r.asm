;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 3 - cvicny priklad c. 1
;
; Na datovem segmentu mate v encryptedMessage ukryte tajne heslo. Tajne heslo je
; slozeno ze 4 osmibitovych znaku. Nahrejte cislo z encryptedMessage do registru
; eax. Tajne heslo pote bude v registru EAX ulozeno nasledovne:  
;
; |                EAX                |
;                   |       AX        |
; ______________________AH_______AL____
; |00000000|00000000|00000000|00000000|
;   1.znak   2.znak   3.znak   4.znak
;
; Ukol 1 je vypsat tajne heslo z registru EAX na obrazovku.
;                 
; Vzorovy vystup je zde:
; LEGO
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

string message0,"Tajna zprava je: "
encryptedMessage dd 1279608655
  
[segment .code use32]

prologue

; ZDE DOPLNTE VAS KOD
priklad1:
  mov esi, message0
  call WriteString
  
  mov eax, [encryptedMessage]
  mov ecx,0
.printSecret:
  
  rol eax,8
  call WriteChar
  
  inc ecx
  cmp ecx,4
  jb .printSecret
  call WriteNewLine

epilogue