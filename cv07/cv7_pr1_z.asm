;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 7 - cvicny priklad c. 1
;
; Na datovem segmentu mate promenne a,b,c typu double. Napiste kod, pomoci
; ktereho vypocitate obsah sten S kvadru o rozmerech a,b,c. Vysledek ulozte do
; promenne result na datovem segmentu a vypiste na obrazovku.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%include 'rw32.inc'

[segment .data use32]

a: dq 0.3
b: dq 0.5                                                          
c: dq 0.7
d: dq 2.0 ;pomocna promenna
result: dq 0.0
 
[segment .code use32]

prologue

priklad1:
; ZDE DOPISTE VAS KOD
finit
fld qword [b] ;st0 = b
fld qword [a] ;st0 = A; st1 = b
fmul st1 ; st0 = A*B; st1 = B
fld qword [c] ;st0 = c; st1 = a*b; st2 = B
fmul st2 ;st0 = c*b; st1 = a*b; st2 = B
fld qword [a] ;st0 = a; st1 = c*b; st2 = a*b; st3 = b
fld qword [c] ;st0=c; st1 = a; st2 = c*d; st3 = a*b; st4 = b
fmul st1 ;st0=c*a; st1 = a; st2 = c*d; st3 = a*b; st4 = b
fadd st2 ;st0=c*a+c*d;..
fadd st3 ;st0=c*a+c*d+a*b;..
fld qword[d]
fmul st1

fst qword [result]
call WriteDouble                                                            


epilogue 