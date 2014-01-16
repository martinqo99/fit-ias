;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 5 - cvicny priklad c. 1
;
; Naprogramujte podprogram, ktery bude slouzit pro rekurzivni vypocet faktorialu.
; 
; Poznamka: testovat se budou vstupni cisla < 7
; 
; Pomucka: nize uvedeny kod v jazyce C
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; int factorial(int n)
; {
;   if (n == 0)
;   {
;     return 1;
;   }
;   else
;   {
;     return(n * factorial(n-1));
;   }
;}
; 
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]
 
[segment .code use32]

factorial:
  push ebp
  mov ebp, esp
  
  mov ebx, [ebp+8]
  
  cmp ebx, byte 0
  jz .jedna
  cmp ebx, byte 1
  je .konec
  
  dec ebx
  mul ebx
  push ebx
  call factorial
  
  jmp .konec
    
  .jedna:
    mov eax, 1
  
  .konec:
     
  
  mov esp, ebp
  pop ebp
  
  ret 8

prologue

priklad1:

call ReadUInt8
push eax

call factorial

call WriteUInt32

   
epilogue 