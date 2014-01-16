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
string message1,"Aaaa",EOL
string message2,"Bbbb",EOL
string message3,"Cccc",EOL
string message4,"Nezadal jste ani 'A', ani 'B', ani 'C'", EOL
  
[segment .code use32]

prologue
  
; ZDE DOPLNTE VAS KOD
mov esi, message0
call WriteString
call ReadChar

cmp al, 'A'
je .a
cmp al, 'B'
je .b
cmp al, 'C'
je .c
jmp .default

.a:
  mov esi, message1
  call WriteString
  jmp .end

.b:
  mov esi, message2
  call WriteString
  jmp .end
 
.c:
  mov esi, message3
  call WriteString
  jmp .end

.default:
  mov esi, message4
  call WriteString
  jmp .end

.end:      

epilogue