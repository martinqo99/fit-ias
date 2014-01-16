;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 7 - cvicny priklad c. 4
;
; Na datovem segmentu mate promenne a,c,v typu double
; Napiste kod, pomoci ktereho vypocitate obsah lichobezniku se zakladnami
; a,c a vyskou v.
; Vysledek ulozte do promenne result na datovem segmentu a vypiste
; na obrazovku.
;******************************************************************************

%include 'rw32.inc'
  
[segment .data use32]

  a: dq 1.0
  c: dq 2.0                                                          
  v: dq 3.0

  result: dq 0.0
  dvojka: dq 2.0

[segment .code use32]

priklad4:
        
prologue

finit
fld qword [a] ;st0=2
fld qword [c] ;st0=4; st1 = 2
fadd st1 ;st0 = 6; st1 = 2
fld qword [v] ;st0 = 3; st1 = 6; st1 = 2
fmul st1
fld qword [dvojka] ;st0 = 2; st1 = 3*6; st2 = 2
fxch st1
fdiv st1
fst qword [result]

call WriteDouble

                                                                            
epilogue                                                  