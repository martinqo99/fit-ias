;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 4 - cvicny priklad c. 11
;
; Na datovem segmentu mate v message0 zpravu. Pomoci zasobniku zjistete, zda je
; tato zprava palindrom. Pokud ano, vypiste zpravu message1 na obrazovku. Pokud
; ne, vypiste zpravu message2 na obrazovku.
;
; Vzorovy vystup:
; Zprava je palindrom/Zprava neni palindrom
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

message0: db "jelenovipivonelej",0
message1: db "Zprava je palindrom",EOL,0
message2: db "Zprava neni palindrom",EOL,0 
 
[segment .code use32]

isPalindrome:
  push ebp
  mov ebp, esp
  push ecx
  push edx
  push eax
  
  mov ecx, [ebp+4]  ;do ecx se da pocet znaku na stacku
  
  mov eax, ecx
  mov ecx, dword 4
  mul ecx
  mov ecx, eax
  
  mov edx, dword 0
  
  .cyklus:
    mov eax, [ebp+8+edx] 
    cmp eax, [ebp+8+ecx-edx]
    jne .nerovna
    cmp edx, ecx
    je .rovna
    add edx, 4
    jmp .cyklus
    
  
  .nerovna:
    mov esi, message2
    call WriteString
    jmp .konec
  .rovna:
    mov esi, message1
    call WriteString
    jmp .konec
  
  .konec:
     
  
  pop eax
  pop edx
  pop ecx
  mov esp, ebp
  pop ebp
  ret

prologue

priklad11:

mov ebx, message0
mov eax, [ebx]
mov ecx, 0

.repeat:
  cmp eax, 0
  je .end
  push eax
  inc ebx
  inc ecx
  mov eax, [ebx]
  jmp .repeat
.end:
push ecx
call isPalindrome
   
epilogue 