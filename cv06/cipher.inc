;*******************************************************************************
; Desifrovani jednoho znaku pomoci monoalfabeticke substitucni sifry
; @param1 Sifrovany znak - znak urcena k desifrovani
; @param2 Tajny klic - permutace vsech pismen abecedy
; @return v EAX desifrovany znak
;*******************************************************************************
letterDecrypt:
  xor eax,eax
  xor ecx,ecx
  push ebp
  mov ebp,esp
  
  cmp byte [ebp+8],'a'
  jb .bigLetter
  cmp byte [ebp+8],'z'
  ja .noDecode
  jmp .next
  
.bigLetter:
  cmp byte [ebp+8],'A'
  jb .noDecode
  cmp byte [ebp+8],'Z'
  ja .noDecode

.next:

  mov ebx,[ebp+12]
.findKeyLetter:
  mov dl,[ebx]
  cmp dl,0
  je .end
  cmp dl,[ebp+8]
  je .decryptBig
  sub byte [ebp+8],'a'
  add byte [ebp+8],'A'
  cmp dl,[ebp+8]
  je .decryptSmall
  sub byte [ebp+8],'A'
  add byte [ebp+8],'a'
  inc ecx
  inc ebx
  jmp .findKeyLetter
  
.decryptBig:
  mov al,'A'
  add al,cl
  jmp .end
  
.decryptSmall:
  mov al,'A'
  add al,cl
  sub al,'A'
  add al,'a'
  jmp .end
  
.noDecode:
  mov al,[ebp+8] 
  
.end:
  mov esp,ebp
  pop ebp
ret 8

;*******************************************************************************
; Sifrovani jednoho znaku pomoci monoalfabeticke substitucni sifry
; @param1 Sifrovany znak - znak urcena k sifrovani
; @param2 Tajny klic - permutace vsech 26 pismen abecedy
; @return v EAX zasifrovany znak
;*******************************************************************************
letterEncrypt:
  xor eax,eax
  xor ecx,ecx
  push ebp
  mov ebp,esp

  mov cl,[ebp+8]

  cmp cl,'a'
  jb .bigLetter
  cmp cl,'z'
  ja .noDecode
.smallLetter:
  sub cl,'a'
  xor edi,edi
  add edi,ecx

  mov ebx,[ebp+12]
  mov al,[ebx+edi]
  sub al,'A'
  add al,'a'
  jmp .end
.bigLetter:
  cmp cl,'A'
  jb .noDecode
  cmp cl,'Z'
  ja .noDecode
  
  sub cl,'A'
  
  xor edi,edi
  add edi,ecx

  mov ebx,[ebp+12]
  mov al,[ebx+edi]
  jmp .end
.noDecode:
  mov al,cl
.end:
  mov esp,ebp
  pop ebp
ret 8