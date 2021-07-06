  /*----- Sección de Declaraciones --------------*/
%{
#include <stdio.h>
#include "tabla.h"

int linea = 1;
int errores = 0;
%}
entero  [0-9]+
real	[0-9]+(\.[0-9]+)
ident	[_a-zA-Z][_a-zA-Z0-9]*
bool 	("true"|"false")
cte 	{entero}|{real}|{bool}
%%

    /*----- Sección de Reglas ----------------*/

"("							{printf("LEXEMA: %s TOKEN: PAR_IZQ\n", yytext); return PAR_IZQ;}
")"							{printf("LEXEMA: %s TOKEN: PAR_DER\n", yytext); return PAR_DER;}
"["							{printf("LEXEMA: %s TOKEN: COR_IZQ\n", yytext); return COR_IZQ;}
"]"							{printf("LEXEMA: %s TOKEN: COR_DER\n", yytext); return COR_DER;}
"="							{printf("LEXEMA: %s TOKEN: ASIGN\n", yytext); return ASIGN;}
","							{printf("LEXEMA: %s TOKEN: COMA\n", yytext); return COMA;}
";"							{printf("LEXEMA: %s TOKEN: PTOCOMA\n", yytext); return PTOCOMA;}
":"							{printf("LEXEMA: %s TOKEN: DOSPTOS\n", yytext); return DOSPTOS;}

"+"							{printf("LEXEMA: %s TOKEN: OP_BINARIO ATRIBUTO: 0\n", yytext); return OP_BINARIO;}
"*"							{printf("LEXEMA: %s TOKEN: OP_BINARIO ATRIBUTO: 1\n", yytext); return OP_BINARIO;}
"/"							{printf("LEXEMA: %s TOKEN: OP_BINARIO ATRIBUTO: 2\n", yytext); return OP_BINARIO;}
"%"							{printf("LEXEMA: %s TOKEN: OP_BINARIO ATRIBUTO: 3\n", yytext); return OP_BINARIO;}
"and"						{printf("LEXEMA: %s TOKEN: OP_BINARIO ATRIBUTO: 4\n", yytext); return OP_BINARIO;}
"or"						{printf("LEXEMA: %s TOKEN: OP_BINARIO ATRIBUTO: 5\n", yytext); return OP_BINARIO;}
">"							{printf("LEXEMA: %s TOKEN: OP_BINARIO ATRIBUTO: 6\n", yytext); return OP_BINARIO;}
"<"							{printf("LEXEMA: %s TOKEN: OP_BINARIO ATRIBUTO: 7\n", yytext); return OP_BINARIO;}
"<="						{printf("LEXEMA: %s TOKEN: OP_BINARIO ATRIBUTO: 8\n", yytext); return OP_BINARIO;}
">="						{printf("LEXEMA: %s TOKEN: OP_BINARIO ATRIBUTO: 9\n", yytext); return OP_BINARIO;}
"=="						{printf("LEXEMA: %s TOKEN: OP_BINARIO ATRIBUTO: 10\n", yytext); return OP_BINARIO;}
"!="						{printf("LEXEMA: %s TOKEN: OP_BINARIO ATRIBUTO: 11\n", yytext); return OP_BINARIO;}
"^"							{printf("LEXEMA: %s TOKEN: OP_BINARIO ATRIBUTO: 12\n", yytext); return OP_BINARIO;}

"!"							{printf("LEXEMA: %s TOKEN: OP_NEG\n", yytext); return OP_NEG;}
"-"							{printf("LEXEMA: %s TOKEN: OP_MENOS\n", yytext); return OP_MENOS;}

"plot"						{printf("LEXEMA: %s TOKEN: PLOT\n", yytext); return PLOT;}

"if"						{printf("LEXEMA: %s TOKEN: IF\n", yytext); return IF;}
"then"						{printf("LEXEMA: %s TOKEN: THEN\n", yytext); return THEN;}
"else"						{printf("LEXEMA: %s TOKEN: ELSE\n", yytext); return ELSE;}

{entero}          			{printf("LEXEMA: %s TOKEN: CONST ATRIBUTO: 0\n", yytext); return CONST;}
{real}            			{printf("LEXEMA: %s TOKEN: CONST ATRIBUTO: 1\n", yytext); return CONST;}
{bool}						{printf("LEXEMA: %s TOKEN: CONST ATRIBUTO: 2\n", yytext); return CONST;}

{ident}						{printf("LEXEMA: %s TOKEN: IDENT\n", yytext); return IDENT;}

[ \t]						{;}

"/*"([^*]|\*+[^*/])*\*+"/"	{linea++;}
\/\/.*\n					{linea++;}
\n							{linea++;}

.							{printf("---> Error, linea %d: %s\n", linea, yytext); errores++;}



%%
