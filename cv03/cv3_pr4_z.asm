;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 3 - cvicny priklad c. 4
;
; Na datovem segmentu mate pro offset birthNumber rezervovanu pamet pro 12 bytu.
; Dole mate nachystanu posloupnost instrukci, ktera nacte od uzivatele rodne
; cislo ve tvaru rrmmdd/cccc, tj. vcetne oddelujiciho lomitka. S nactenym rodnym
; cislem budete dale pracovat.
;
; Zjistete zda se osoba, ktere dane rodne cislo patri narodila 20. den v mesici.
; Pokud ano, vypiste na obrazovku retezec message2 z datoveho segmentu. Pokud
; ne, vypiste na obrazovku retezec message3 z datoveho segmentu. 
;
; Napoveda: Prepiste kod v jazyce C do jazyka symbolickych adres.
;
; Vzorovy vystup je zde:
; Osoba se narodila 20. den v mesici./Osoba se nenarodila 20. den v mesici.
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

birthNumber resb 12 ;pamet rezervovana pro rodne cislo
string message0,"Zadejte rodne cislo ve tvaru rrmmdd/cccc: ",EOL
string message1,"Zadal jste: ",0
string message2,"Osoba se narodila 20. den v mesici.",EOL
string message3,"Osoba se nenarodila 20. den v mesici.",EOL
  
[segment .code use32]

prologue

priklad3:
  ; NACTENI RODNEHO CISLA OD UZIVATELE:
  mov esi, message0
  call WriteString
  
  mov ebx, 11
  mov edi, birthNumber
  call ReadString
  
  mov esi, message1
  call WriteString
  
  mov esi, birthNumber
  call WriteString
  
  call WriteNewLine
  
  ; VAS UKOL
  ; if(birthNumber[4] == '2' && birthNumber[5] == '0') printf("%s", message2);
  ; else printf("%s", message3);
  
  ; ZDE DOPLNTE VAS KOD
  mov esi, birthNumber
  mov cl, [esi+4]
  cmp cl, '2'
  jne .ne
  mov cl, [esi+5]
  cmp cl, '0'
  je .ano
  jne .ne

.ano:
  mov esi, message2
  call WriteString
  jmp .konec  

.ne:
  mov esi, message3
  call WriteString
  jmp .konec

.konec:

epilogue