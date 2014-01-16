;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 3 - cvicny priklad c. 5
;
; Na datovem segmentu mate pro offset birthNumber rezervovanu pamet pro 12 bytu.
; Dole mate nachystanu posloupnost instrukci, ktera nacte od uzivatele rodne
; cislo ve tvaru rrmmdd/cccc, tj. vcetne oddelujiciho lomitka. S nactenym rodnym
; cislem budete dale pracovat.
;
; Zjistete, zda je osoba, ktere dane rodne cislo patri zena nebo muz.
; Pokud zena, vypiste na obrazovku retezec message2 z datoveho segmentu. Pokud
; muz, vypiste na obrazovku retezec message3 z datoveho segmentu. 
;
; Napoveda: Prepiste kod v jazyce C do jazyka symbolickych adres.
;
; Vzorovy vystup je zde:
; Osoba je zena./Osoba je muz.
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

birthNumber resb 12 ;pamet rezervovana pro rodne cislo
string message0,"Zadejte rodne cislo ve tvaru rrmmdd/cccc: ",EOL
string message1,"Zadal jste: ",0
string message2,"Osoba je zena.",EOL
string message3,"Osoba je muz.",EOL
  
[segment .code use32]

prologue

priklad5:
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
  ; if(birthNumber[2] == '5' || birthNumber[2] == '6') printf("%s", message2);
  ; else printf("%s", message3);
  
  ; ZDE DOPLNTE VAS KOD
   
  mov ebx,birthNumber
  mov al,[ebx+2]
  cmp al,'5'
  jz .zena
  cmp al,'6'
  jz .zena
  mov esi,message3
  call WriteString
  jmp .end
.zena:
  mov esi,message2
  call WriteString
.end:

epilogue