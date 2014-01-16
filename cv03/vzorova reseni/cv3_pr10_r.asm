;*******************************************************************************
; IAS - Asemblery
;
; Cviceni c. 3 - cvicny priklad c. 10
;
; Prepiste nize uvedenou konstrukci v jazyce C do jazyka symbolickych adres.
;
; printf("%s", message0);
; int c = getc(stdin);
; switch(c)
; {
;    case 'A':
;      printf("%s", message1);
;      break;
;    case 'B':
;      printf("%s", message2);
;      break;
;    case 'C':
;      printf("%s", message3);
;      break;
;    default:
;      printf("%s", message4);
; }
;
;*******************************************************************************

%include 'rw32.inc'

[segment .data use32]

string message0,"Zadejte 'A','B' nebo 'C'.",EOL
string message1,"Alfa",EOL
string message2,"Beta",EOL
string message3,"Gama",EOL
string message4,"Nezadal jste ani 'A', ani 'B', ani 'C'", EOL
  
[segment .code use32]

prologue
  
; ZDE DOPLNTE VAS KOD

priklad10:
  mov esi, message0
  call WriteString
  call ReadChar

.switch:
  cmp al,'A'
  jz .a
  cmp al,'B'
  jz .b
  cmp al,'C'
  jz .c
  jmp .default
.a:
  mov esi,message1
  call WriteString
  jmp .end
.b:
  mov esi,message2
  call WriteString
  jmp .end
.c:
  mov esi,message3
  call WriteString
  jmp .end
.default:
  mov esi,message4
  call WriteString
.end:
epilogue