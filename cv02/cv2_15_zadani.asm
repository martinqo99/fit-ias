;*******************************************************************************
;*******************************************************************************
; IAS - Asemblery 2013/2014, 2. cvièení
;*******************************************************************************
;*******************************************************************************
; Varianta zadání è. 15
;*******************************************************************************
;    ZAVAZNE POKYNY PRO IMPLEMENTACI!
;    * kazdy priklad ma definovane sve globalni navesti (ukol1 - ukol6)
;    * reseni prikladu piste primo do tohoto zadani pod dana globalni navesti
;    * pokud budete potrebovat vyvorit v ramci implementace jednoho prikladu
;      pomocne navesti, musi se jednat o LOKALNI navesti
;    * ve zdrojovem kodu NESMITE vytvaret nova GLOBALNI navesti 
;*******************************************************************************
;*******************************************************************************
;*******************************************************************************
%include 'rw32.inc'
;*******************************************************************************
;*******************************************************************************
[segment .data use32]

  ; testovaci retezec
  string happyMessage,"Mam rad jazyk symbolickych adres! :-D ",EOL
  magicNumber: db 23h
  string cisloJeLiche,"Cislo magicNumber na datovem segmentu je LICHE.",EOL
  string cisloJeSude,"Cislo magicNumber na datovem segmentu je SUDE.",EOL
  string soucetJePlatny,"Soucet je na danem poctu bitu platny.",EOL
  string soucetNeniPlatny,"Soucet neni na danem poctu bitu platny.",EOL
  var1: db 0
  var2: db 0
  a1: dw 5
  q: dw 3
  string cisloMaLichy,"Zadane cislo ma v binarni podobe na 8 bitech lichy pocet nul.",EOL
  string cisloMaSudy,"Zadane cislo ma v binarni podobe na 8 bitech sudy pocet nul.",EOL
  string delimiter,"-------------------------------------------------------------",EOL
  string delimiter9,"---------",EOL
  
[segment .code use32]
;*******************************************************************************
;*******************************************************************************
prologue
;*******************************************************************************
;    UKOL C. 1 (0.5 bodu)
;    Na minulem cviceni jste vypisovali retezec na obrazovku pomoci funkce
;    WriteString. Ted je vasim ukolem vypsat retezec na obrazovku znak po znaku.
;    Vypiste na obrazovku zpravu happyMessage, kterou mate umistenou na datovem
;    segmentu. Pro vypis pouzijte povinne jednoduchou ridici konstrukci CYKLUS
;    a pro vlastni vypis znaku pouzijte funkci WriteChar z knihovny rw32.inc.
;                 
;    Vzorovy vystup je zde:
;    Mam rad jazyk symbolickych adres! :-D
;*******************************************************************************
ukol1:
;ZDE jsem doplnil svuj kod
mov ebx, happyMessage
mov al,[ebx]
.cyklus:
cmp al, 0
je .konec
call WriteChar
inc ebx
mov al, [ebx]
jmp .cyklus
.konec:
  
;*******************************************************************************
;*******************************************************************************
  call WriteNewLine
  mov esi,delimiter
  call WriteString
;*******************************************************************************
;*******************************************************************************
;    UKOL C. 2 (0.5 bodu)
;    Na datovem segmentu mate v promenne magicNumber ulozeno magicke cislo.
;    Algoritmicky zjistete, zda je dane cislo liche nebo sude. V pripade, ze je
;    dane cislo sude, vypiste na obrazovku retezec cisloJeSude z datoveho
;    segmentu. V pripade, ze je dane cislo liche, vypiste na obrazovku retezec
;    cisloJeLiche z datoveho segmentu.
;                 
;    Vzorovy vystup je zde:
;    Cislo magicNumber na datovem segmentu je LICHE.
;*******************************************************************************
ukol2:
;ZDE DOPLNTE VAS KOD
mov al, [magicNumber]
mov bl, 2
xor ah, ah ; vynuluje ah
div bl
cmp ah, 0
je .jeSude
jne .jeLiche
.jeSude:
  mov esi, cisloJeSude
  call WriteString
  jmp .konec
.jeLiche:
  mov esi, cisloJeLiche
  call WriteString
  jmp .konec
.konec:


;*******************************************************************************
  call WriteNewLine
  mov esi,delimiter
  call WriteString
;*******************************************************************************
;*******************************************************************************
;    UKOL C. 3 (0.5 bodu)
;    Do promennych var1 a var2 na datovem segmentu nactete od uzivatele
;    2 NEZNAMENKOVA cisla. Podle typu promennych na datovem segmentu zvolte
;    vhodnou nacitaci funkci z knihovny rw32.inc. Tato cisla po nacteni vypiste
;    v binarni podobe na obrazovku. V registru stejne bitove velikosti, jako
;    jsou nactena cisla, realizujte soucet techto cisel. Tento soucet take
;    vypiste binarne na obrazovku. Pomoci sledovani vhodnych priznaku urcete,
;    zda je soucet realizovany na danem poctu bitu platny. Pokud ano, vypiste na
;    obrazovku retezec soucetJePlatny z datoveho segmentu. Pokud ne, vypiste na
;    obrazovku retezec soucetNeniPlatny z datoveho segmentu. Uvedomte si, pro
;    ktera cisla bude na danem poctu bitu soucet platny a pro ktera ne.   
;                 
;*******************************************************************************
ukol3:
;ZDE DOPLNTE VAS KOD
call ReadUInt8
mov [var1], al
call ReadUInt8
mov [var2], al

;vypis v binarni podobe
mov al, [var1]
call WriteBin8
call WriteNewLine

mov al, [var2]
call WriteBin8
call WriteNewLine

;soucet
mov al, [var1]
add al, [var2]
call WriteBin8
call WriteNewLine

mov al, [var1]
add al, [var2]
jnc .jeMozny
jc .neniMozny
.jeMozny:
  mov esi, soucetJePlatny
  call WriteString
  jmp .konec
.neniMozny:
  mov esi, soucetNeniPlatny
  call WriteString
  jmp .konec
.konec:


;*******************************************************************************
  call WriteNewLine
  mov esi,delimiter
  call WriteString
;*******************************************************************************
;*******************************************************************************
;    UKOL C. 4 (0.5 bodu)
;    Okopirujte hotovy a funkcni kod z ukolu c. 3. Upravte tento kod tak, aby
;    fungoval pro ZNAMENKOVA cisla. (Tip: jine nacitaci funkce, jine priznaky
;    pro podminene skoky)   
;                 
;    Vzorovy vystup pro vstupni cisla 27000 a -27000:
;    Prvni cislo je vetsi
;    Vzorovy vystup pro vstupni cisla -27000 a 27000:
;    Prvni cislo je mensi nebo rovno
;*******************************************************************************
ukol4:
;ZDE DOPLNTE VAS KOD
call ReadInt8
mov [var1], al
call ReadInt8
mov [var2], al

;vypis v binarni podobe
mov al, [var1]
call WriteBin8
call WriteNewLine

mov al, [var2]
call WriteBin8
call WriteNewLine

;soucet
mov al, [var1]
add al, [var2]
call WriteBin8
call WriteNewLine

mov al, [var1]
add al, [var2]
jno .jeMozny
jo .neniMozny
.jeMozny:
  mov esi, soucetJePlatny
  call WriteString
  jmp .konec
.neniMozny:
  mov esi, soucetNeniPlatny
  call WriteString
  jmp .konec
.konec:

;*******************************************************************************
  call WriteNewLine
  mov esi,delimiter
  call WriteString
;*******************************************************************************
;*******************************************************************************
; Ukol c. 5 (0.5 bodu)
; Algoritmicky vypiste na obrazovku prvnich 15 clenu geometricke posloupnosti.
; Prvni clen a1 a kvocient q mate uvedeny na datovem segmentu. Jednotlive cleny
; posloupnosti oddelujte mezerou.
;
; Vzorovy vystup: 5 15 45 135 405 1215 3645 10935 32805 32879 33101 33767 35765 41759 59741 
;*******************************************************************************
ukol5:
;ZDE DOPLNTE VAS KOD

mov cl, 1
mov ax, [a1]
.cyklus:
call WriteUInt16
mul word [q]
inc cl
;call WriteUInt16
call WriteNewLine
cmp cl, 15
je .konec
jmp .cyklus
.konec:

;*******************************************************************************
  call WriteNewLine
  mov esi,delimiter
  call WriteString
;*******************************************************************************
;*******************************************************************************
; Ukol c. 6 (0.5 bodu)
; Nactete od uzivatele NEZNAMENKOVE osmibitove cislo. Toto cislo vypiste
; v binarni podobe na obrazovku. Zjistete, zda ma toto cislo v binarni podobe
; na osmi bitech sudy nebo lichy pocet nul. V pripade, ze ma lichy pocet
; nul, vypiste na obrazovku retezec cisloMaLichy z datoveho segmentu.
;`V pripade, ze ma sudy pocet nul, vypiste na obrazovku retezec
; cisloMaSudy z datoveho segmentu.  
;
; Vzorovy vystup pro cislo 6:
; Zadane cislo ma v binarni podobe na 8 bitech sudy pocet nul.
; Vzorovy vystup pro cislo 7:
; Zadane cislo ma v binarni podobe na 8 bitech lichy pocet nul. 
;*******************************************************************************
ukol6:
;ZDE DOPLNTE VAS KOD
call ReadUInt8
call WriteBin8
call WriteNewLine
mov bl, al
add bl, 0

jnp .lichy
jp .sudy
.lichy:
  mov esi, cisloMaLichy
  call WriteString
  jmp .konec
.sudy:
  mov esi, cisloMaSudy
  call WriteString
  jmp .konec
.konec:  

;*******************************************************************************
  call WriteNewLine
  mov esi,delimiter
  call WriteString
;*******************************************************************************
epilogue
;*******************************************************************************
; 13/10/23/11/06
;*******************************************************************************