;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 6 - cvicny priklad c. 3
;
; Desifrovani monoalfabeticke substitucni sifry, prace se soubory pomoci
; WIN32 API.
;
;
;
;
;
;
;
; Parametry se funkcim predavaji pouze pomoci zasobniku! Je zakazano ve funkcich
; pristupovat k datovemu segmentu!
;
; Vse potrebne k programovani WinAPI v jazyce symbolickych adres najdete zde:
; https://www.fit.vutbr.cz/study/courses/IAS/private/12ias_10.pdf
; 
; Referencni manual k Windows API naleznete zde:
; http://msdn.microsoft.com/en-us/library/windows/desktop/aa364232%28v=vs.85%29.aspx
;
; Poznámka: podprogram NESMI pristupovat na retezec message primo. Offset retezce
;           predejte pomoci zasobniku!
; 
; Vzorový výstup pro øetìzec message na datovem segmentu:
;
; 37
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;*******************************************************************************
;*******************************************************************************
; IAS - Asemblery 2012/2013, 6. cviceni
;*******************************************************************************
; Varianta zadani c. 4
;*******************************************************************************

;*******************************************************************************
; ZAVAZNE POKYNY:
;
; Parametry se funkcim predavaji pouze pomoci zasobniku! Je zakazano ve funkcich
; pristupovat k datovemu segmentu!
;
; Vse potrebne k programovani WinAPI v jazyce symbolickych adres najdete zde:
; https://www.fit.vutbr.cz/study/courses/IAS/private/12ias_10.pdf
; 
; Referencni manual k Windows API naleznete zde:
; http://msdn.microsoft.com/en-us/library/windows/desktop/aa364232%28v=vs.85%29.aspx
;
; Pouzivejte pouze nasledujici funkce:
; CloseHandle, OpenFile, ReadFile, WriteFile
;
; Nevytvarejte zadne dalsi prvky na datovem segmentu!  
;*******************************************************************************
;*******************************************************************************

;*******************************************************************************
; Nacteni knihovny rw32.inc
;*******************************************************************************
%include 'rw32.inc'
%include 'cipher.inc'
;*******************************************************************************

;*******************************************************************************
; Nacteni externich funkci z dynamickych knihoven
;*******************************************************************************
extern OpenFile
import OpenFile kernel32.dll

extern ReadFile
import ReadFile kernel32.dll

extern WriteFile
import WriteFile kernel32.dll

extern CloseHandle
import CloseHandle kernel32.dll
;*******************************************************************************

;*******************************************************************************
; Direktivy preprocesoru
;*******************************************************************************
%define NULL 0x00000000 
%define OF_READ 0x00000000
%define OF_WRITE 0x00000001
%define OF_CREATE 0x00001000   
%define OF_PROMPT 0x00002000
%define HFILE_ERROR 0xFFFFFFFF
;******************************************************************************* 

;*******************************************************************************
; Kodovy segment
;*******************************************************************************  
[segment .code use32]

;*******************************************************************************
; Sifrovani zpravy pomoci monoalfabeticke substitucni sifry
; @param1 Otevreny text - zprava urcena k zasifrovani
; @param2 Tajny klic - permutace vsech pismen abecedy
; @return v EAX nic, funkce primo meni otevreny text
;*******************************************************************************  
messageEncrypt:
  push ebp
  mov ebp,esp
  
  mov ebx,[ebp+8]
.processChar:
  xor eax,eax
  mov al,[ebx]
  cmp al,0
  je .end

  push ebx
  push dword [ebp+12]  
  push eax
  call letterEncrypt
  pop ebx
  
  mov [ebx],al  
  inc ebx
  jmp .processChar
.end:

  mov esp,ebp
  pop ebp
ret 8

;*******************************************************************************
; Desifrovani zpravy pomoci monoalfabeticke substitucni sifry
; @param1 Sifrovany text - zprava urcena k desifrovani
; @param2 Tajny klic - permutace vsech pismen abecedy
; @return v EAX nic, funkce primo meni sifrovany text
;*******************************************************************************
messageDecrypt:
  push ebp
  mov ebp,esp
  
  mov ebx,[ebp+8]
.processChar:
  xor eax,eax
  mov al,[ebx]
  cmp al,0
  je .end

  push ebx
  push dword [ebp+12]  
  push eax
  call letterDecrypt
  pop ebx
  
  mov [ebx],al  
  inc ebx
  jmp .processChar
.end:

  mov esp,ebp
  pop ebp
ret 8



;*******************************************************************************
; Telo hlavniho programu
;*******************************************************************************
                  
prologue

  ;Vypsani informacniho hlaseni na obrazovku
  mov esi,message0
  call WriteString
  call WriteNewLine
  call WriteNewLine

  ;Vypsani zasifrovane zpravy secretMessage ulozene na datovem segmentu
  mov esi,secretMessage
  call WriteString
  call WriteNewLine 
  call WriteNewLine
  
  ;Desifrovani zpravy pomoci funkce messageDecrypt
  push key
  push secretMessage
  call messageDecrypt
  
  ;Vypsani informacniho hlaseni na obrazovku
  mov esi,message1
  call WriteString
  call WriteNewLine
  call WriteNewLine
  
  ;Vypsani ted jiz desifrovane zpravy secretMessage ulozene na datovem segmentu  
  mov esi,secretMessage
  call WriteString
  call WriteNewLine
  call WriteNewLine

  ;Otevreni vstupniho souboru pro cteni
  push OF_READ | OF_PROMPT
  push ofStruct
  push inputFileName
  call [OpenFile]
  cmp eax,HFILE_ERROR
  je error
  mov [inputFileHandle],eax
 
  ;Nacteni dat ze vstupniho souboru
  push dword NULL
  push bytesLoaded
  push dword 1200
  push secretFile
  push dword [inputFileHandle]
  call [ReadFile]

  ;Osetreni navratove hodnoty funkce  
  cmp eax,0
  je error
  
  ;Vypsani informacniho hlaseni na obrazovku
  mov esi,message2
  call WriteString
  call WriteNewLine
  call WriteNewLine

  ;Vypsani zasifrovaneho obsahu souboru na obrazovku  
  mov esi,secretFile
  call WriteString
  call WriteNewLine
  call WriteNewLine
  
  ;Desifrovani obsahu souboru
  push key
  push secretFile
  call messageDecrypt
  
  ;Vypsani informacniho hlaseni na obrazovku
  mov esi,message3
  call WriteString
  call WriteNewLine
  call WriteNewLine

  ;Vypsani desifrovaneho obsahu souboru na obrazovku
  mov esi,secretFile
  call WriteString
  call WriteNewLine
  call WriteNewLine
  
  ;Otevreni vystupniho souboru pro zapis
  push OF_WRITE | OF_CREATE
  push ofStruct
  push outputFileName
  call [OpenFile]
  cmp eax,HFILE_ERROR
  je error
  mov [outputFileHandle],eax
  
  ;Zapis desifrovaneho obsahu z pameti zpatky do souboru
  push NULL
  push bytesSaved
  push dword [bytesLoaded]
  push secretFile
  push dword [outputFileHandle]
  call [WriteFile]
  jmp end

  ;Vypis vyskytu pripadne chyby
error:
  mov esi,chyba
  call WriteString
  call WriteNewLine
  
end:
 
  ;Ukonceni prace se vstupnim souborem
  push inputFileHandle
  call [CloseHandle]
  
  ;Ukonceni prace s vystupnim souborem
  push inputFileHandle
  call [CloseHandle]
                                                                             
epilogue

;*******************************************************************************
; Datovy segment
;*******************************************************************************

[segment .data use32]

  message0: db "Zasifrovana zprava na datovem segmentu:",0
  message1: db "Desifrovana zprava na datovem segmentu:",0
  message2: db "Zasifrovana zprava v souboru:",0
  message3: db "Desifrovana zprava v souboru:",0
  ;tajny klic pro sifrovani a desifrovani
  key: db "SBGLQZTCHMUADINVREJOXWFKPY",0
  ;tajna zprava pro ukol c. 1
  secretMessage: db "Dsd esl msypu jpdbnahgupgc sleqj! :-L",0
  ;jmeno vstupniho souboru 
  inputFileName: db "inputFile.txt",0
  ;handle vstupniho souboru (ukazatel na vstupni soubor, jako FILE* v C)
  inputFileHandle: dd 0
  ;jmeno vystupniho souboru
  outputFileName: db "outputFile.txt",0
  ;handle vystupniho souboru (ukazatel na vystupni soubor, jako FILE* v C)
  outputFileHandle: dd 0
  ;pamet pro nacteni obsahu vstupniho souboru
  secretFile: resb 1201
  ;pocet nactenych znaku pri cteni ze souboru
  bytesLoaded: dd 0
  ;pocet ulozenych znaku pri zapisu do souboru
  bytesSaved: dd 0
  ;struktura pro otevreni souboru
  ofStruct: ISTRUC OFSTRUCT IEND
  ;zprava pro zahlaseni chyby
  chyba: db "CHYBA: Nastala chyba pri zpracovani vstupniho souboru!",0
  
;*******************************************************************************
; 12/11/04/17/53
;******************************************************************************* 