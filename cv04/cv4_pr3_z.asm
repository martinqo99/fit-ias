;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 4 - cvicny priklad c. 3
;
; Vytvorte podprogram printFavorite, ktery na obrazovku vypise Vase oblibene
; cislo. Cislo ulozte do lokalni promenne programo a posleze vypiste. Muzete
; se inspirovat ekvivalentnim kodem v jazyce C uvedenym nize. Podprogram
; neprijima zadne parametry a nevraci zadnou hodnotu.
;
; Ukazka v jazyce C:
;
; void printFavorite(void)
; {
;   int myFavoriteNumber;
;   myFavoriteNumber = 4;
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
  push eax      ; pouzili jsme eax
  sub esp, 4    ; na stacku se vynecha misto na lokalni promennou
                ; na tu promennou se dostanu [ebp-4]
  mov dword [ebp-4], 12   ; do lok. promenne se dala hodnota
  
  mov eax, [ebp-4]
  call WriteUInt32
    
  pop eax
  mov esp, ebp
  pop ebp
  ret

prologue           

priklad3:
  call printFavorite
   
epilogue