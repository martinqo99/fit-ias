;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 4 - cvicny priklad c. 6
;
; Vytvorte podprogram mySpecialFunc, ktery provede vypocet nasledujici specialni
; funkce: mySpecialFunc(x,y) = (x - constA) - (y - constB). Podprogram prebira
; promenne x a y jako vstupni parametry programu. Konstanty constA a constB
; budou ulozeny jako lokalni promenne programu. Jejich hodnoty si zvolte
; libovolne vhodne. Uvedomte si poradi vstupnich promennych na zasobniku behem
; jejich extrakce v podprogramu. Muzete se inspirovat ekvivalentnim kodem
; v jazyce C uvedenym nize. Vysledek podprogram vraci standardnim zpusobem.
;
; Ukazka v jazyce C:
;
; void mySpecialFunc(int x, int y)
; {
;   int constA = 1;
;   int constB = 2;
;
;   return (x - constA) - (y - constB);
; }
; 
; Vzorovy vystup pro vstupni cisla x=6,y=5 a konstanty constA=1,constB=2 je zde:
; 2
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]
 
[segment .code use32]
  
mySpecialFunc:
  push ebp
  mov ebp, esp
  
  sub esp, 8    ;misto na dve lokalni promenne
  
  push ebx ;budeme pouzivat
  
  mov dword [ebp-4], 1  ;constA
  mov dword [ebp-8], 2  ;constB
  
  mov eax, [ebp+12]     ;x
  sub eax, [ebp-4]      ; x - constA
  ; v eax je prvni zavorka
  
  mov ebx, [ebp+8]      ;y
  sub ebx, [ebp-8]      ;constB
  
  sub eax, ebx          ; v eax je vysledek celeho vyrazu
  
  pop ebx
  
  mov esp, ebp
  pop ebp
  ret 8

prologue           

priklad6:

  push dword 6
  push dword 5
  
  call mySpecialFunc
  
  call WriteUInt32
   
epilogue