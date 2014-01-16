;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 3 - cvicny priklad c. 14
;
; Na datovem segmentu mate na offsetu sequence ulozenu posloupnost, jejiz prvky
; tvori ASCII hodnoty znaku tajne zpravy. Tajna zprava je vsak poskozena.
; Pred vypsanim je potreba ji znak po znaku opravit. Opravu provedete tak, ze u
; kazdeho znaku zpravy pred vypsanim nastavte 8. bit zleva na 1 bez ohledu na
; jeho predchozi hodnotu. Pro nastaveni vhodne masky muzete vyuzit pripravenou
; promennou mask na datovem segmentu. Vasim ukolem je vypsat opravenou zpravu
; na obrazovku.
;
; UPOZORNENI: Reste aplikaci vhodnych logickych operatoru a vhodne bitove masky!
; Pouhe pricteni hodnoty 1 k poskozenemu znaku pomoci instukce SUB nebude
; brano jako uspesne reseni!
;
; Vzorovy vystup je zde:
; MAGICKE ESO
;
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

sequence: db 76,64,70,72,66,74,68,8,68,82,78,0
mask: db 0
  
[segment .code use32]

prologue

  ;ZDE DOPLNTE VAS KOD
priklad14:
  mov ebx,sequence
  mov al,[ebx]
  mov ecx,0
.repeat:
  cmp al,0
  je .end
  mov byte [mask],1
  or al,[mask]
  call WriteChar
  inc ebx
  mov al,[ebx]
  jmp .repeat
.end:

call WriteNewLine

epilogue