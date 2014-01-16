;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 7 - cvicny priklad c. 3
;
; Na datovem segmentu mate promenne r,v typu double.
; Mame pravouhly trojuhelnik abc s pravym uhlem u vrcholu c, zname stranu c 
; a uhel alpha zadany se stupnich. Zjistete delku strany a.
; Vysledek ulozte do promenne result na datovem segmentu a vypiste
; na obrazovku.
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

  alpha: dq 30.0  
  c: dq 5.0                                                        
  result: dq 0.0
  pomocna: dq 180.0
  
[segment .code use32]

priklad3:
        
prologue

finit
fld qword [alpha]; st0 = 30
fldpi ;st0 = pi; st1 = 30
fmul st1 ;st0 = pi*30
fld qword [pomocna]; st0 = 180; st1 = pi*30
fxch st1 ;st0 = pi*30; st1 = 180
fdiv st1 ;st0 = pi*30/180
fsin ;st0 = sin(pi*30/180)
fld qword [c] ;st0 = 5; st1=sin(30*pi/180)
fmul st1
fst qword [result]

Call WriteDouble

                                                                             
epilogue                                                  