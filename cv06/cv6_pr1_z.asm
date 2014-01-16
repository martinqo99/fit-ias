;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 6 - cvicny priklad c. 1
;
; Naprogramujte podprogram strlen, kter� p�ijme offset �et�zce a vr�t� jeho d�lku.
;
; Pozn�mka: podprogram NESMI pristupovat na retezec message primo. Offset retezce
;           predejte pomoci zasobniku!
; 
; Vzorov� v�stup pro �et�zec message na datovem segmentu:
;
; 37
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include 'rw32.inc'

[segment .data use32]

message: db "Mam rad jazyk symbolickych adres! :-D",0
 
[segment .code use32]

strlen:
  push ebp
  mov ebp, esp
  push ecx
  mov ebx, [ebp+8]  ; message
  
  ;mov esi, ebx
  ;call WriteString
  
  mov cl, 0
  .cyklus:
  mov al, [ebx]
  ;call WriteChar
  cmp al, 0
  je .konec
  inc ebx
  inc cl
  jmp .cyklus 
  
  .konec:
  
  mov al, cl
  pop ecx
  mov esp, ebp
  pop ebp
  ret 4

prologue

priklad1:
mov ebx, message
push ebx

call strlen

call WriteUInt8
   
epilogue 