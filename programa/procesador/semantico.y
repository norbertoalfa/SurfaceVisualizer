%require "3.2"
//%language "c++"

%{
	#include <stdlib.h>
	#include <stdio.h>
	#include <string.h>
	#include "semantico.h"
	#include "elementos_predef.h"
	#include "nodo.h"
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
%left OP_EXP
%right OP_NEG
%right COR_IZQ COR_DER


%start programa

%%
programa : lista_sentencias { closeInter(); }
;

lista_sentencias : lista_sentencias sentencia PTOCOMA
           		 | sentencia PTOCOMA
;

sentencia : sentencia_declar_valor
          | sentencia_declar_fun
          | sentencia_plot { escribeFinPlot(); }
          | error
;

sentencia_declar_valor : IDENT DOSPTOS IDENT ASIGN expresion { setTipo($3); TS_InsertaIDENT($1.lex); comprobarTipoCte($5); escribeVal($1.lex, $5.nodoPropio); }
;

sentencia_declar_fun : IDENT {setTipoDesc(); TS_InsertaFUN($1); } PAR_IZQ lista_param PAR_DER DOSPTOS IDENT { setTipo($7); TS_ActualizarFun(); TS_InsertaMARCA(); } ASIGN expresion {	comprobarTipoFun($1, $10); TS_VaciarENTRADAS(); nParam = 0; decParam=0; escribeFun($1.lex, $10.nodoPropio); escribeNorm($1, $10); }
;

sentencia_plot : sentencia_plot COMA IDENT	{ TS_InsertaPLOT($3.lex); escribeContPlot($3.lex); }
			   | PLOT IDENT					{ setTipoDesc(); TS_InsertaFUN($1); TS_InsertaPLOT($2.lex); escribeIniPlot($2.lex); }
;

expresion : PAR_IZQ expresion PAR_DER					{ $$.tipo=$2.tipo; $$.dimension=$2.dimension; $$.tam=$2.tam; $$.nodoPropio=crearNodoParentesis($2.nodoPropio); }
          | IF expresion THEN expresion ELSE expresion	{ comprobarIF($2, $4, $6, &$$); $$.nodoPropio=crearNodoIf($2.nodoPropio,$4.nodoPropio,$6.nodoPropio); }
          | expresion COR_IZQ expresion COR_DER			{ comprobarIND($1, $3, &$$); $$.nodoPropio=crearNodoIndex($1,$3.nodoPropio); }
          | llamada_funcion								{ $$.tipo=$1.tipo; $$.dimension=$1.dimension; $$.tam=$1.tam; $$.nodoPropio=$1.nodoPropio; }
          | OP_MENOS expresion							{ TS_OpUNARIA($1, $2, &$$); $$.nodoPropio=crearNodoOpUn($1.lex,$2.nodoPropio); }
          | OP_NEG expresion							{ TS_OpUNARIA($1, $2, &$$); $$.nodoPropio=crearNodoOpUn($1.lex,$2.nodoPropio); }
          | expresion OP_SUMA expresion					{ TS_OpSUMARESTA($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1.nodoPropio,$2.lex,$3.nodoPropio); }
          | expresion OP_MENOS expresion				{ TS_OpSUMARESTA($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1.nodoPropio,$2.lex,$3.nodoPropio); }
          | expresion OP_MULTIP expresion				{ TS_OpMULTIP($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1.nodoPropio,$2.lex,$3.nodoPropio); }
          | expresion OP_EXP expresion				{ TS_OpMULTIP($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1.nodoPropio,$2.lex,$3.nodoPropio); }
          | expresion OP_IGUAL expresion				{ TS_OpIGUAL($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1.nodoPropio,$2.lex,$3.nodoPropio); }
          | expresion OP_COMP expresion					{ TS_OpCOMP($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1.nodoPropio,$2.lex,$3.nodoPropio); }
          | expresion OP_OR expresion					{ TS_OpOR($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1.nodoPropio,$2.lex,$3.nodoPropio); }
          | expresion OP_AND expresion					{ TS_OpAND($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1.nodoPropio,$2.lex,$3.nodoPropio); }
          | IDENT										{ declaracion=0; TS_getIDENT($1, &$$); $$.nodoPropio=crearNodoTipo($1.lex, NODO_VAR, calculaSubTipo($1)); }
          | constante									{ $$.tipo=$1.tipo; $$.dimension=$1.dimension; $$.tam=$1.tam; $$.nodoPropio=crearNodoTipo($1.lex, NODO_CTE, NODO_NA); }
          | error
;

llamada_funcion : IDENT PAR_IZQ lista_expresiones PAR_DER	{ TS_FunCall($1, $3, &$$); }
;

lista_expresiones : lista_expresiones COMA expresion	{ $$.nArg=$1.nArg + 1; TS_ComprobarPARAM($-1,$3, $$.nArg); actualizaNodo($-1.nodoPropio, $3.nodoPropio); }
           		  | expresion							{ $$.nArg=1; TS_ComprobarPARAM($-1,$1, $$.nArg); $-1.nodoPropio=crearNodoTipo($-1.lex, NODO_FUN, calculaSubTipoLex($-1.lex)); actualizaNodo($-1.nodoPropio, $1.nodoPropio); }
;

lista_param : lista_param COMA lista_ident DOSPTOS IDENT	{ actualizaTipoDesc($5); }	// Asignar el tipo a las ultimas entradas.
            | lista_ident DOSPTOS IDENT						{ actualizaTipoDesc($3); }
;

lista_ident : lista_ident COMA IDENT	{ nParam++; parDesc++; setTipoDesc(); TS_InsertaPARAMF($3); }	// Introducir como desconocido y llevar la cuenta.
            | IDENT						{ decParam=1; nParam++; parDesc++; setTipoDesc(); TS_InsertaPARAMF($1); }
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
  addPredefCts();
  addPredefFunc();
  generaFich();
  generaCtes();
  generaFuncionIf();
  
  return yyparse() ;
}
