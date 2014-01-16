;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 6 - cvicny priklad c. 5
;
; Naprogramujte podprogram strrchr, který vyhledá poslední výskyt znaku x v øetìzci
; str. Znak a a offset øetìzce str pøedejte podprogramu jako parametry pøes
; zásobník. Podprogram vrací index pozice nalezeného znaku v daném slovì. Napø.
; hledáme-li znak e ve slovì pes, podprogram vrátí 1. Pokud daný øetìzec daný
; znak neobsahuje, podprogram vrátí -1. Podprogram musí fungovat i pro prázdné
; øetìzce. Podprogram pracuje case-sensitive!
; 
; Vzorový výstup pro øetìzec message na datovem segmentu a znak M:
;
; 0
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include 'rw32.inc'

[segment .data use32]

message: db "Mam rad jazyk symbolicMkych adres! :-D",0
;message: db 0 
[segment .code use32]

strrchr:
push ebp
mov ebp, esp
push ebx
push edx
push ecx
mov ebx, [ebp+12]    ;message
mov dl, [ebp+8]      ;char


mov ecx, 0           ;counter
mov eax, -1
.cyklus:
  cmp dl, [ebx]
  jne .cont
  mov eax, ecx
  .cont:
  cmp [ebx], dword 0
  je .konec
  inc ecx
  inc ebx
  jmp .cyklus
  
.konec:   

pop ecx
pop edx
pop ebx

mov esp, ebp
pop ebp
ret 8

prologue

priklad5:

push message
push dword 'b'
call strrchr
call WriteInt32
call WriteNewLine
   
epilogue 