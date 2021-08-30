%{
	#include <stdlib.h>
	#include <stdio.h>
	#include <string.h>
	#define YYDEBUG 0

	int yylex();  // Para evitar warning al compilar
	void yyerror(const char * msg);

%}

%define parse.error verbose

//Tokens

%token PAR_IZQ PAR_DER
%token ASIGN
%token COMA
%token PTOCOMA
%token DOSPTOS

%token IF
%right THEN ELSE

%token PLOT
%token IDENT

%token CONST_ENTERO CONST_BOOL CONST_REAL

%left OP_OR
%left OP_AND
%left OP_IGUAL
%left OP_COMP
%left OP_SUMA OP_MENOS
%left OP_MULTIP
%right OP_NEG
%right COR_IZQ COR_DER


%start programa

%%
programa : lista_sentencias
;

lista_sentencias : lista_sentencias sentencia PTOCOMA
           		 | sentencia PTOCOMA
;

sentencia : sentencia_declar_valor
          | sentencia_declar_fun
          | sentencia_plot
          | error
;

sentencia_declar_valor : IDENT DOSPTOS IDENT ASIGN expresion
;

sentencia_declar_fun : IDENT PAR_IZQ lista_param PAR_DER DOSPTOS IDENT ASIGN expresion
;

sentencia_plot : PLOT lista_ident
;

expresion : PAR_IZQ expresion PAR_DER
          | IF expresion THEN expresion ELSE expresion
          | IDENT PAR_IZQ lista_expresiones PAR_DER
          | expresion COR_IZQ expresion COR_DER
          | OP_MENOS expresion
          | OP_NEG expresion
          | expresion OP_SUMA expresion
          | expresion OP_MENOS expresion
          | expresion OP_MULTIP expresion
          | expresion OP_IGUAL expresion
          | expresion OP_COMP expresion
          | expresion OP_OR expresion
          | expresion OP_AND expresion
          | IDENT
          | constante
          | error
;

lista_expresiones : lista_expresiones COMA expresion
           		  | expresion
;

lista_param : lista_param COMA lista_ident DOSPTOS IDENT
            | lista_ident DOSPTOS IDENT
;

lista_ident : lista_ident COMA IDENT
            | IDENT
;

constante : CONST_BOOL
          | CONST_ENTERO
          | CONST_REAL
;
%%

#include "lex.yy.c"
//#include "error.y"

void yyerror(const char* s) {
	printf("\n(Línea %d) %s\n", linea, s);
}

int main( int argc, char *argv[] ) {
  //yyin = abrir_entrada(argc,argv) ;
  return yyparse() ;
}
