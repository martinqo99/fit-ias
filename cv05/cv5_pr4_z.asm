;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 5 - cvicny priklad c. 4
;
; Naimplementujte system pro kontrolu spravneho zavorkovani u aritmetickych
; vyrazu. Pro implementaci povinne pouzijte algoritmus vysvetleny nize. 
; U aritmetickych vyrazu nas zajimaji jen zavorky: promenne a operatory
; nereste a nekontrolujte napr. aritu operatoru apod. Kontrolovat budeme
; pouze, zda ma kazda oteviraci zavorka na legalnim miste odpovidajici uzaviraci
; zavorku. Pro kontrolu prazdnosti zasobniku povinne pouzijte zarazku!
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 
; Algoritmus pro kontrolu parity zavorek:
;
; 1. Vstupni vyraz zpracovavejte znak po znaku.
; 2. Pokud narazite na promennou ci operator, nic nedelejte a pokracujte
;    zpracovanim nasledujiciho znaku.
; 3. Pokud narazite na levou (oteviraci) zavorku, vlozte ji na zasobnik.
; 4. Pokud narazite na pravou (uzaviraci) zavorku a na zasobniku k ni mate
;    odpovidajici levou (oteviraci) zavorku, tyto zavorky patri k sobe. Levou
;    zavorku ze zasobniku odeberte a pokracujte dale.
; 5. Pokud narazite na pravou (uzaviraci) zavorku a na zasobniku k ni neni
;    odpovidajici leva (oteviraci) zavorka, jedna se o chybu a dany aritmeticky
;    vyraz neni spravny.
; 6. Pokud po zpracovani vyrazu na zasobniku zbyly nejake leve (oteviraci)
;    zavorky, jedna se o chybu a dany aritmeticky vyraz neni spravny.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;
; Level 1: (1 b.)
; Omezte se pouze na kulate zavorky (). Promenne a operatory se ve vyrazu nebudou
; vyskytovat vubec. Vyrazy budou tvoreny pouze zavorkami. Program po sobe nemusi
; uklizet zasobnik, tj. po vypsani vysledku se muze zacyklit ci spadnout.
;
; Ukazka spravneho aritmetickeho vyrazu:
; (()())
;
; Ukazka nespravnych aritmetickych vyrazu:
; (()()
; )()()
; ()()(
; ()())
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Level 2: (1 b.)
; Ve vyrazu se navic mohou vyskytovat i promenne a operatory. Doplnte spravnou
; praci se zasobnikem - program zanecha zasobnik v puvodni podobe - nesmi na nem
; nic zustat ani z nej byt odebrano vice, nez na nej bylo vlozeno. Program se
; tedy nezacykli ani nespadne.
;
; Ukazka spravneho aritmetickeho vyrazu:
; (a*(b+c)-(2*a))
;
; Ukazka nespravnych aritmetickych vyrazu:
; ((a*b)+(c*d)
; )(a*b)+(c*d)
; (a*b)+(c*d)(
; (a*b)+(c*d))
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Level 3: (1 b.)
; Doplnte zpracovani hranatych [] a slozenych {} zavorek. Na klasickou prioritu
; zavorek nehledte - pro nase ucely jsou si dane zavorky rovny. Kontrolovat
; budeme pouze, zda ma kazda oteviraci zavorka na legalnim miste odpovidajici
; uzaviraci zavorku.
;
; Ukazka spravneho aritmetickeho vyrazu:
; {a*[b+c]-(2*a)}
;
; Ukazka nespravnych aritmetickych vyrazu:
; [a+b}
; [a*b]+[c*d][
; [a*b]+[c*d]] 
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Pozn. prazdny vyraz je spravny vyraz (protoze neni nespravny)
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

expression: resb 51
message1: db "Zadejte aritmeticky vyraz (max. 50 znaku):",EOL,0
message2: db "Zadal jste nasledujici aritmeticky vyraz:",0
message3: db "Kontrola vyrazu: nesedi zavorky!",EOL,0
message4: db "Kontrola vyrazu: vse OK!",EOL,0   
result: db 1 
 
[segment .code use32]

prologue

priklad4:

  ;vypsani hlasky "Zadejte vstupni vyraz..."
  mov esi,message1
  call WriteString

  ;nacteni vstupniho vyrazu
  mov ebx, 50
  mov edi, expression
  call ReadString

  ;vypsani hlasky "Zadal jste vstupni vyraz..."
  mov esi,message2
  call WriteString

  ;vypsani zadaneho vyrazu`
  mov esi, expression
  call WriteString
  call WriteNewLine  ;odradkovani

  ;vlozeni zarazky na zasobnik
  mov eax, '$'
  push eax

;zacneme zpracovavat vyraz
.processExpression:
  mov ecx, 0
  .loop:
  cmp [expression+ecx], byte 0 
  je .test2
  cmp [expression+ecx], byte '('
  je .addKulata
  cmp [expression+ecx], byte ')'
  je .testKulata
  
  cmp [expression+ecx], byte '['
  je .addHranata
  cmp [expression+ecx], byte ']'
  je .testHranata
  
  cmp [expression+ecx], byte '{'
  je .addSlozena
  cmp [expression+ecx], byte '}'
  je .testSlozena
  
  inc ecx
  jmp .loop

  .addKulata:
    mov al, [expression+ecx]
    push eax 
    inc ecx
  jmp .loop
  
  .testKulata:
    cmp [esp], byte '('
    jne .invalid
    add esp, 4
    inc ecx
    jmp .loop
    ;-----------------hranata
    .addHranata:
    mov al, [expression+ecx]
    push eax 
    inc ecx
    jmp .loop
  
  .testHranata:
    cmp [esp], byte '['
    jne .invalid
    add esp, 4
    inc ecx
    jmp .loop
    
    ;-----------------slozena
    .addSlozena:
    mov al, [expression+ecx]
    push eax 
    inc ecx
  jmp .loop
  
  .testSlozena:
    cmp [esp], byte '{'
    jne .invalid
    add esp, 4
    inc ecx
    jmp .loop
  
  
  .test2:
    cmp [esp], byte '('
    je .invalid
    
    cmp [esp], byte '['
    je .invalid
    
    cmp [esp], byte '{'
    je .invalid
    
    
    jmp .valid
     
  .invalid:
    mov esi, message3
    call WriteString
    jmp .end
  .valid:
    mov esi, message4
    call WriteString
    jmp .end  
  
  .end:
  
  .cleanup:
    cmp [esp], byte '$'
    je .done
    add esp, 4
    jmp .cleanup
  .done:
   
epilogue 