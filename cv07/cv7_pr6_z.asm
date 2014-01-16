;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 7 - cvicny priklad c. 6
;
; Na datovem segmentu mate promenne r,v typu double
; Napiste kod, pomoci ktereho vypocitate objem rotacniho kuzele o polomeru
; podstavy r a vysce v.
; Vysledek ulozte do promenne result na datovem segmentu a vypiste
; na obrazovku.
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

r: dq 7.3
v: dq 0.0001
tri: dq 3.0
                                                           
result: dq 0.0
  
[segment .code use32]
        
prologue

priklad6:
; V kuzele = (pi*r*r*v)/3
finit

fld qword [r] ;st0 = r
fld qword [r] ;st0 = r, st1 = r
fld qword [v] ;st0 = v, st1 = r, st2 = r

fmulp   ;st0 = v*r, st1 = r
fmulp   ;st0 = v*r*r

fldpi ;st0 = pi, st1 = v*r*r
fmulp ;st0 = v*r*r*pi

fld qword [tri]   ;st0 = 3.0, st1 = v*r*r*pi
fdivp             ;st0 = (v*r*r*pi)/3

fst qword [result]

call WriteDouble

                                                                           
epilogue                                                 