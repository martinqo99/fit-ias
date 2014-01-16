;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 4 - cvicny priklad c. 4
;
; Vytvorte podprogram printFavorite, ktery na obrazovku vypise Vase oblibene
; cislo. Oblibene cislo podprogram prebira jako svuj prvni a jediny parametr.
; Muzete se inspirovat ekvivalentnim kodem v jazyce C uvedenym nize. Podprogram
; nevraci zadnou hodnotu.
;
; Ukazka v jazyce C:
;
; void printFavorite(int myFavoriteNumber)
; {
;   printf("%d\n", myFavoriteNumber);
;   return;   
; }
; 
; Vzorovy vystup je zde:
; 4
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]
 
[segment .code use32]

printFavorite:
  push ebp
  mov ebp, esp
  
  push eax
  
  mov eax, [ebp+8]
  call WriteUInt32
  
  pop eax
  
  mov esp, ebp
  pop ebp
  ret 4  

prologue           

priklad4:
  push dword 23
  call printFavorite  
   
epilogue