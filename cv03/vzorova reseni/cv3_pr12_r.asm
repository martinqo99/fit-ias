;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 3 - cvicny priklad c. 12
;
; Algoritmicky spocitejte pocet nulovych bitu cisla ulozeneho na datovem
; segmentu na offsetu number. Bitovou sirku cisla urcete podle definice na
; datovem segmentu. Pro pomocny soucet pouzijte promennou sum na datovem
; segmentu.
;
; Vzorovy vystup je zde:
; Pocet nulovych bitu je: 6
;
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

number: dw 4444
sum: db 0
string message0,"Pocet nulovych bitu je: ",0
  
[segment .code use32]

prologue
  
; ZDE DOPLNTE VAS KOD

priklad12:

mov dx,[number]
mov ecx,16
mov bx,1

.repeat:
cmp ecx,0
jz .end

test dx,bx
jnz .cont
inc word [sum]
.cont:
dec ecx
rol dx,1
jmp .repeat

.end:

mov esi,message0
call WriteString
mov al,[sum]
call WriteUInt8
call WriteNewLine

epilogue