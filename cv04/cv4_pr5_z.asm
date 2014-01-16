;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 4 - cvicny priklad c. 5
;
; Vytvorte podprogram sumTwoNumbers, ktery na obrazovku vypise Vase soucet
; dvou cisel zadanych jako vstupni parametry programu. Muzete se inspirovat
; ekvivalentnim kodem v jazyce C uvedenym nize. Vysledny soucet program vraci
; standardnim zpusobem.
;
; Ukazka v jazyce C:
;
; void sumTwoNumbers(int number1, int number2)
; {
;   return number1 + number2;   
; }
; 
; Vzorovy vystup pro vstupni cisla 3 a 4 je zde:
; 7
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]
 
[segment .code use32]

sumTwoNumbers:
  
  push ebp
  mov ebp, esp
  
  mov eax, [ebp+8]
  add eax, [ebp+12]
  
  mov esp, ebp
  pop ebp
  ret 8   ; zajisti, ze na konci se vycisti zasobnik
          ;po eip + dalsich 8 bytu (ty dva parametry)

prologue           

priklad5:
  push dword 4
  push dword 56
  call sumTwoNumbers
  
  call WriteUInt32
  
   
epilogue
; vsechny funkce vraci hodnotu na reg. a