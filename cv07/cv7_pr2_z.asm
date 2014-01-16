;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 7 - cvicny priklad c. 2
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

priklad2:
; ZDE DOPISTE VAS KOD
finit
fld qword [b] ;st0=b
fld qword [a] ;st0=b; st1=b
fmulp ;st0 = a*b; st1 = ?;
fld qword [b] ;st0=b; st1=a*b
fld qword [c] ;st0=c; st1 = b; st2= a*b
fmulp ;st0=c*b;st1=a*b
fld qword [a] ;st0=a;st1=c*b;st2=A*b
fld qword [c] ;st0=c; st1=a; st2=c*b; st3=a*b
fmulp ;st0=c*a; st1 = c*b; st2 = a*b
faddp ;st0=c*a + c*b; st1 = a*b
faddp ;st0=c*a+c*b+a*b
fld qword [d]  ;st0=2.0; st1
fmulp ;sto = 2*(CA+CB+AB)
fst qword [result]
call WriteDouble
                                                                           
epilogue 