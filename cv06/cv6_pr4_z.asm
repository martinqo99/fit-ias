;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 6 - cvicny priklad c. 4
;
; Naprogramujte podprogram strcmp, který pøijme offsety dvou øetìzcù, tyto øetìzce
; lexikograficky porovná podle ASCII hodnot jejich znakù a v pøípadì shodnosti
; jejich obsahu vrátí 0, jinak vrátí 1.
;
; Poznámka: podprogram NESMI pristupovat na retezec message primo. Offset retezce
;           predejte pomoci zasobniku!
; 
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include 'rw32.inc'

[segment .data use32]

message0: db "Mam rad jazyk symbolickych adres! :-D",0
message1: db "Mam rad jazyk symbolickych adres! :-D",0
message2: db "Mam rad asembler! :-D",0
 
[segment .code use32]

strcmp:
push ebp
mov ebp, esp
push edx
push ebx

mov edx, [ebp+8]
mov ebx, [ebp+12]

.cyklus:
  mov al, [edx]
  cmp al, [ebx]
  jne .jine
  cmp al, 0
  je .stejne
  inc edx
  inc ebx
  jmp .cyklus

.jine:
  mov eax, 1
  jmp .konec
.stejne:
  mov eax, 0
  jmp .konec

.konec:
pop ebx
pop edx
mov esp, ebp
pop ebp
ret 8

prologue

priklad4:

push message1
push message2
call strcmp
call WriteUInt32
call WriteNewLine
   
epilogue 