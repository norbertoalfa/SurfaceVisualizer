%{
	#include <stdlib.h>
	#include <stdio.h>
	#include <string.h>
	#include "semantico.h"
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

sentencia_declar_valor : IDENT DOSPTOS IDENT ASIGN expresion { setTipo($3); TS_InsertaIDENT($1); 
if($1.tipo != $5.tipo) { printf("(Error semántico, línea %d) Los tipos no coinciden (%d) y (%d).\n",linea,$1.tipo,$5.tipo);} }
;

sentencia_declar_fun : IDENT {setTipoDesc(); TS_InsertaFUN($1); } PAR_IZQ lista_param PAR_DER DOSPTOS IDENT { TS_ActualizarFun($7); TS_InsertaMARCA(); } ASIGN expresion {	
										if(TS[currentFun].tipo != $10.tipo) { 
											printf("(Error semántico, línea %d) Los tipos no coinciden (%d) y (%d).\n",
																								linea,TS[currentFun].tipo,$10.tipo);
										}
										TS_VaciarENTRADAS(); nParam = 0;
									 }
;

sentencia_plot : PLOT lista_ident
;

expresion : PAR_IZQ expresion PAR_DER					{ $$.tipo=$2.tipo; $$.dimension=$2.dimension; $$.tam=$2.tam; }
          | IF expresion THEN expresion ELSE expresion	{ comprobarIF($1, $2, $3, &$$); }
          | expresion COR_IZQ expresion COR_DER			{ comprobarIND($1, $2, &$$); }
          | llamada_funcion								{ $$.tipo=$1.tipo; $$.dimension=$1.dimension; $$.tam=$1.tam; }
          | OP_MENOS expresion							{ TS_OpUNARIA($1, $2, &$$); }
          | OP_NEG expresion							{ TS_OpUNARIA($1, $2, &$$); }
          | expresion OP_SUMA expresion					{ TS_OpSUMARESTA($1, $2, $3, &$$); }
          | expresion OP_MENOS expresion				{ TS_OpSUMARESTA($1, $2, $3, &$$); }
          | expresion OP_MULTIP expresion				{ TS_OpMULTIP($1, $2, $3, &$$); }
          | expresion OP_IGUAL expresion				{ TS_OpIGUAL($1, $2, $3, &$$); }
          | expresion OP_COMP expresion					{ TS_OpCOMP($1, $2, $3, &$$); }
          | expresion OP_OR expresion					{ TS_OpOR($1, $2, $3, &$$); }
          | expresion OP_AND expresion					{ TS_OpAND($1, $2, $3, &$$); }
          | IDENT										{ declaracion=0; TS_getIDENT($1, &$$); }
          | constante									{ $$.tipo=$1.tipo; $$.dimension=$1.dimension; $$.tam=$1.tam; }
          | error
;

llamada_funcion : IDENT PAR_IZQ lista_expresiones PAR_DER	{ TS_FunCall($1, &$$); nParam=0; }
;

lista_expresiones : lista_expresiones COMA expresion	{ nParam++; TS_ComprobarPARAM($-1,$3, nParam); }
           		  | expresion							{ nParam++; TS_ComprobarPARAM($-1,$1, nParam); }
;

lista_param : lista_param COMA lista_ident DOSPTOS IDENT	{ actualizaTipoDesc($5); }	// Asignar el tipo a las ultimas entradas.
            | lista_ident DOSPTOS IDENT						{ actualizaTipoDesc($3); }
;

lista_ident : lista_ident COMA IDENT	{ nParam++; setTipoDesc(); TS_InsertaIDENT($3); }	// Introducir como desconocido y llevar la cuenta.
            | IDENT						{ nParam++; setTipoDesc(); TS_InsertaIDENT($1); }
;

constante : CONST_BOOL		{ $$.tipo = BOOLEANO; $$.dimension = 0; $$.tam = 0; }
          | CONST_ENTERO	{ $$.tipo = ENTERO; $$.dimension = 0; $$.tam = 0; }
          | CONST_REAL		{ $$.tipo = REAL; $$.dimension = 0; $$.tam = 0; }
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
