;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 7 - cvicny priklad c. 8
;
; Mame trojuhelnik abc. Zname stranu a, stranu b a uhel gamma, ktery
; strany sviraji. Napiste program, ktery vypocita delku teznice tc. Vysledek
; vypiste na obrazovku.
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

gamma: dq 40.0
a: dq 24.0
b: dq 12.5
pom: dq 180.0
dva: dq 2.0
result: dq 0.0

[segment .code use32]
        
prologue
;c^2 = a^2 + b^2 - 2*a*b*cos(gamma)

;tc = (sqrt(2a^2 + 2b^2 - c^2)/2
priklad8:

fld qword [gamma]
fldpi
fmulp

fld qword [pom]
fdivp     ;st0 = gamma v radianech

;fld qword [a]
;fld qword [a]
;fmulp         ;st0 = a*a, st1 = gamma
  ;call WriteDouble
fcos

fld qword [dva]
fld qword [a]
fld qword [b]  ;st0 = b, st1 = a, st2 = 2.0, st3 = cos gamma
fmulp
fmulp
fmulp           ;st0 = 2ab*cos(gamma)

fld qword [a]
fld qword [a]
fmulp

fld qword [b]
fld qword [b]
fmulp         ;st0 = b*b, st1 = a*a, st2 = 2ab*cos(gamma)

faddp         ;st0 = b*b + a*a, st1 = 2ab*cos(gamma)

fsub st1      ;st0 = b*b + a*a + 2ab*cos(gamma) = c*c
;fsqrt         ;st0 = c
;--------------- mam delku c

fld qword [dva]
fld qword [a]
fld qword [a] ;st0 = 2, st1 = a, st2 = a, st3 = c*c
fmulp
fmulp           ;st0 = 2a^2, st1 = c^2
call WriteDouble
call WriteNewLine 

fld qword [dva]
fld qword [b]
fld qword [b]
fmulp
fmulp           ;st0 = 2b^2, st1 = 2a^2, st2 = c^2

call WriteDouble
call WriteNewLine

faddp
call WriteDouble
call WriteNewLine
fsub st1
call WriteDouble
call WriteNewLine

fsqrt
call WriteDouble
call WriteNewLine

fld qword [dva]
fdivp

call WriteDouble
;fst qword [result]
;call WriteDouble
                                                                           
epilogue                                                  