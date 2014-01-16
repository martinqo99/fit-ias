;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 7 - cvicny priklad c. 5
;
; Na datovem segmentu mate promenne r typu double
; Napiste kod, pomoci ktereho vypocitate objem koule s polomerem r.
; Vysledek ulozte do promenne result na datovem segmentu a vypiste
; na obrazovku.
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

  r: dq 3.0                                                      
  result: dq 0.0

  ctyrka: dq 4.0
  trojka: dq 3.0
  
[segment .code use32]

priklad5:
        
prologue

finit
fld qword [trojka] ;st0 = 3
fld qword [ctyrka] ;st0 = 4 ;st1 = 3
fdiv st1
fst st1 ;st0 = 4/3; st1 = 4/3
fldpi ;st0 = pi; st1 = 4/3
fmul st1
fld qword [r] ;st0 = 3; st1 = pi*4/3
fmul st0
fld qword [r] ;st0 = 3; st1 = 9; st2 = pi*4/3
fmul st1 ;st0 = 27; st1 = 9; st2 = pi*4/3
fmul st2 ;st0 = 27 * pi*4/3
fst qword [result]

call WriteDouble
                                                                           
epilogue                                                 
 