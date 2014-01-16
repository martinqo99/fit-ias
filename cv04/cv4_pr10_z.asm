;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 4 - cvicny priklad c. 10
;
; Vytvorte podprogram calcZeroBits, ktery algoritmicky spocitejta pocet
; nulovych bitu cisla predaneho jako prvni a jediny parametr podprogramu.
; Uvazujte bitovou sirku cisla odpovidajici datovemu typu double word. Vysledny
; pocet bitu predejte jako navratovou hodnotu standardnim zpusobem. 
;
; Vzorovy vystup je pro cislo 4444 zde:
; Pocet nulovych bitu je: 26
;
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

string message0,"Pocet nulovych bitu je: ",0
  
[segment .code use32]

calcZeroBits:
  push ebp
  mov ebp, esp
  push edx
  push ecx
  push ebx
  
  mov edx, [ebp+8]
  mov ecx, 32
  mov ebx, 1
  mov eax, 0
  
  .repeat:
    cmp ecx, 0
    jz .end
    
    test edx, ebx
    jnz .cont
    inc eax
    .cont:
    dec ecx
    rol edx,1
    jmp .repeat
  .end:
  
  pop ebx
  pop ecx
  pop edx
  mov esp, ebp
  pop ebp
  ret 4  

prologue
mov esi, message0
call WriteString  

push dword 4444
call calcZeroBits
call WriteUInt32


epilogue