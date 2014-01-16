;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 7 - cvicny priklad c. 7
;
; Mame pravouhly trojuhelnik abc s pravym uhlem u vrcholu c, zname stranu c 
; a uhel alpha zadany se stupnich. Stranu c a uhel alpha mate ulozenou jako typ
; double na datovem segmentu. Pomoci FPU vypocitejte delku strany b trojuhelniku.
; Vysledek ulozte do promenne result na datovem segmentu a vypiste na obrazovku.
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

alpha: dq 80.0
c: dq 1.1                                                        
result: dq 0.0
pom: dq 180.0
  
[segment .code use32]
        
prologue

; sin(alpha) = b/c
; b = c * sin(alpha)  

priklad7:
finit

fld qword [alpha]   ;st0 = alpha
fldpi               ;st0 = pi, st1 = alpha
fmulp               ;st0 = alpha*pi

fld qword [pom]     ;st0 = 180, st1 = alpha*pi
fdivp               ; st0 = (alpha*pi)/180 

fcos                ;st0 = cos((alpha*pi)/180)

fld qword [c]       ;st0 = c, st1 = cos(...)
fmulp               ;st0 = c * cos(...)

fst qword [result]

call WriteDouble


                                                                           
epilogue                                               