;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 4 - cvicny priklad c. 1
;
; Na datovem segmentu mate definovany dve promenne number1 a number2. Vypiste
; jejich obsah na obrazovku. Pomoci zasobniku prohodte jejich obsah. Vypiste
; znovu jejich obsah na obrazovku.
;
; K prohozeni obsahu promennych vyuzijte zasobnik! 
;
; Vzorovy vystup je zde:
; 3333 4444
; 4444 3333
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

number1 dw 3333
number2 dw 4444
 
[segment .code use32]

prologue

priklad1:
    
  ; ZDE DOPLNTE VAS KOD
  mov eax, [number1]
  call WriteUInt16
  mov al, 32  ;mezera
  call WriteChar
  mov eax, [number2]
  call WriteUInt32
  
  push word [number1]
  push word [number2]
  pop word [number1]
  pop word [number2]
  ; pushnute hodnoty se nactou v opacnem poradi
  ; => prohodi se
  
  call WriteNewLine
  
  mov eax, [number1]
  call WriteUInt16
  mov al, 32  ;mezera
  call WriteChar
  mov eax, [number2]
  call WriteUInt32
  
   
epilogue