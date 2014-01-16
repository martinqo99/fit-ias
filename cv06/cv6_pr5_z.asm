;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 6 - cvicny priklad c. 5
;
; Naprogramujte podprogram strrchr, kter� vyhled� posledn� v�skyt znaku x v �et�zci
; str. Znak a a offset �et�zce str p�edejte podprogramu jako parametry p�es
; z�sobn�k. Podprogram vrac� index pozice nalezen�ho znaku v dan�m slov�. Nap�.
; hled�me-li znak e ve slov� pes, podprogram vr�t� 1. Pokud dan� �et�zec dan�
; znak neobsahuje, podprogram vr�t� -1. Podprogram mus� fungovat i pro pr�zdn�
; �et�zce. Podprogram pracuje case-sensitive!
; 
; Vzorov� v�stup pro �et�zec message na datovem segmentu a znak M:
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