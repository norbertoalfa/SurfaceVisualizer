  /*----- Sección de Declaraciones --------------*/
%{
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "y.tab.h"

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

"("							{return PAR_IZQ;}
")"							{return PAR_DER;}
"["							{return COR_IZQ;}
"]"							{return COR_DER;}
"="							{return ASIGN;}
","							{return COMA;}
";"							{return PTOCOMA;}
":"							{return DOSPTOS;}

"+"							{return OP_SUMA;}
"*"							{return OP_MULTIP;}
"/"							{return OP_MULTIP;}
"%"							{return OP_MULTIP;}
"^"							{return OP_MULTIP;}
"and"						{return OP_AND;}
"or"						{return OP_OR;}
">"							{return OP_COMP;}
"<"							{return OP_COMP;}
"<="						{return OP_COMP;}
">="						{return OP_COMP;}
"=="						{return OP_IGUAL;}
"!="						{return OP_IGUAL;}

"!"							{return OP_NEG;}
"-"							{return OP_MENOS;}

"plot"						{return PLOT;}

"if"						{return IF;}
"then"						{return THEN;}
"else"						{return ELSE;}

{entero}          			{return CONST_ENTERO;}
{real}            			{return CONST_REAL;}
{bool}						{return CONST_BOOL;}

{ident}						{return IDENT;}

[ \t]						{;}

"/*"([^*]|\*+[^*/])*\*+"/"	{linea++;}
\/\/.*\n					{linea++;}
\n							{linea++;}

.							{printf("Error léxico, linea %d: %s\n", linea, yytext); errores++;}



%%
