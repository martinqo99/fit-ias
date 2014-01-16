;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 3 - cvicny priklad c. 2
;
; Na datovem segmentu mate v encryptedMessage ukryte tajne heslo. Tajne heslo je
; slozeno ze 4 osmibitovych znaku. Nahrejte cislo z encryptedMessage do registru
; eax. Tajne heslo pote bude v registru EAX ulozeno nasledovne:  
;
; |                EAX                |
;                   |       AX        |
; ______________________AH_______AL____
; |00000000|00000000|00000000|00000000|
;   4.znak   3.znak   2.znak   1.znak
;
; Ukol 1 je vypsat tajne heslo z registru EAX na obrazovku.
;                 
; Vzorovy vystup je zde:
; OREL
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

string message0,"Tajna zprava je: "
encryptedMessage dq 1279611471
  
[segment .code use32]

prologue

; ZDE DOPLNTE VAS KOD
mov eax, encryptedMessage
mov esi, eax

mov edi, 0
.iterace
  mov al, [esi+edi]
  call WriteChar
  inc edi
  cmp edi, 4
  je .konec
  jmp .iterace

  .konec

epilogue