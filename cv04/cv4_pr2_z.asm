;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 4 - cvicny priklad c. 2
;
; Vytvorte podprogram helloWorld, ktery na obrazovku vypise retezec helloString
; z datoveho segmenu. Podprogram neprijima zadne parametry ani nevraci zadnou
; hodnotu.
; 
; Vzorovy vystup je zde:
; Hello World!
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

helloString db "Hello World!",EOL
 
[segment .code use32]

helloWorld:
  push ebp      ;budeme pouzivat    
  mov ebp, esp  ; esp ukazuje na vrchol zasobniku
  push esi      ; budeme pouzivat
  ; ted uz esp ukazuje jinam, nez ebp
  
  mov esi, helloString
  call WriteString
  
  pop esi       
  
  mov esp, ebp
  pop ebp
  ret
  

prologue           

priklad2:
  
  ; ZDE DOPLNTE VAS KOD
  call helloWorld
   
epilogue