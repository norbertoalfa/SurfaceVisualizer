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

"("							{yylval.lex=strdup(yytext); return PAR_IZQ;}
")"							{yylval.lex=strdup(yytext); return PAR_DER;}
"["							{yylval.lex=strdup(yytext); return COR_IZQ;}
"]"							{yylval.lex=strdup(yytext); return COR_DER;}
"="							{yylval.lex=strdup(yytext); return ASIGN;}
","							{yylval.lex=strdup(yytext); return COMA;}
";"							{yylval.lex=strdup(yytext); return PTOCOMA;}
":"							{yylval.lex=strdup(yytext); return DOSPTOS;}

"+"							{yylval.lex=strdup(yytext); return OP_SUMA;}
"*"							{yylval.lex=strdup(yytext); yylval.atrib=0; return OP_MULTIP;}
"/"							{yylval.lex=strdup(yytext); yylval.atrib=1; return OP_MULTIP;}
"^"							{yylval.lex=strdup(yytext); yylval.atrib=2; return OP_MULTIP;}
"and"						{yylval.lex=strdup(yytext); return OP_AND;}
"or"						{yylval.lex=strdup(yytext); return OP_OR;}
">"							{yylval.lex=strdup(yytext); yylval.atrib=0; return OP_COMP;}
"<"							{yylval.lex=strdup(yytext); yylval.atrib=1; return OP_COMP;}
"<="						{yylval.lex=strdup(yytext); yylval.atrib=2; return OP_COMP;}
">="						{yylval.lex=strdup(yytext); yylval.atrib=3; return OP_COMP;}
"=="						{yylval.lex=strdup(yytext); yylval.atrib=0; return OP_IGUAL;}
"!="						{yylval.lex=strdup(yytext); yylval.atrib=1; return OP_IGUAL;}

"!"							{yylval.lex=strdup(yytext); return OP_NEG;}
"-"							{yylval.lex=strdup(yytext); return OP_MENOS;}

"plot"						{yylval.lex=strdup(yytext); return PLOT;}

"if"						{yylval.lex=strdup(yytext); return IF;}
"then"						{yylval.lex=strdup(yytext); return THEN;}
"else"						{yylval.lex=strdup(yytext); return ELSE;}

{entero}          			{yylval.lex=strdup(yytext); return CONST_ENTERO;}
{real}            			{yylval.lex=strdup(yytext); return CONST_REAL;}
{bool}						{yylval.lex=strdup(yytext); return CONST_BOOL;}

{ident}						{yylval.lex=strdup(yytext); return IDENT;}

[ \t]						{;}

"/*"([^*]|\*+[^*/])*\*+"/"	{linea++;}
\/\/.*\n					{linea++;}
\n							{linea++;}

.							{printf("Error léxico, linea %d: %s\n", linea, yytext); errores++;}



%%
