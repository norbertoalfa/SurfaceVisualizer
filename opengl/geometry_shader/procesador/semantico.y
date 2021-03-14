%require "3.2"
//%language "c++"

%{
	#include <stdlib.h>
	#include <stdio.h>
	#include <string.h>
	#include "semantico.h"
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

sentencia_declar_valor : IDENT DOSPTOS IDENT ASIGN expresion { setTipo($3); TS_InsertaIDENT($1); comprobarTipoCte($5); escribeVal($1, $5); }
;

sentencia_declar_fun : IDENT {setTipoDesc(); TS_InsertaFUN($1); } PAR_IZQ lista_param PAR_DER DOSPTOS IDENT { setTipo($7); TS_ActualizarFun(); TS_InsertaMARCA(); } ASIGN expresion {	comprobarTipoFun($1, $10); TS_VaciarENTRADAS(); nParam = 0; decParam=0; escribeFun($1, $10); }
;

sentencia_plot : sentencia_plot COMA IDENT	{ TS_InsertaPLOT($3); escribeContPlot($3); }
			   | PLOT IDENT					{ setTipoDesc(); TS_InsertaFUN($1); TS_InsertaPLOT($2); escribeIniPlot($2); }
;

expresion : PAR_IZQ expresion PAR_DER					{ $$.tipo=$2.tipo; $$.dimension=$2.dimension; $$.tam=$2.tam; $$.nodoPropio=crearNodoParen($2); }
          | IF expresion THEN expresion ELSE expresion	{ comprobarIF($2, $4, $6, &$$); $$.nodoPropio=crearNodoIf($2,$4,$6); }
          | expresion COR_IZQ expresion COR_DER			{ comprobarIND($1, $3, &$$); $$.nodoPropio=crearNodoIndex($1,$3); }
          | llamada_funcion								{ $$.tipo=$1.tipo; $$.dimension=$1.dimension; $$.tam=$1.tam; $$.nodoPropio=$1.nodoPropio; }
          | OP_MENOS expresion							{ TS_OpUNARIA($1, $2, &$$); $$.nodoPropio=crearNodoOpUn($1,$2); }
          | OP_NEG expresion							{ TS_OpUNARIA($1, $2, &$$); $$.nodoPropio=crearNodoOpUn($1,$2); }
          | expresion OP_SUMA expresion					{ TS_OpSUMARESTA($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1,$2,$3); }
          | expresion OP_MENOS expresion				{ TS_OpSUMARESTA($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1,$2,$3); }
          | expresion OP_MULTIP expresion				{ TS_OpMULTIP($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1,$2,$3); }
          | expresion OP_IGUAL expresion				{ TS_OpIGUAL($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1,$2,$3); }
          | expresion OP_COMP expresion					{ TS_OpCOMP($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1,$2,$3); }
          | expresion OP_OR expresion					{ TS_OpOR($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1,$2,$3); }
          | expresion OP_AND expresion					{ TS_OpAND($1, $2, $3, &$$); $$.nodoPropio=crearNodoOpBin($1,$2,$3); }
          | IDENT										{ declaracion=0; TS_getIDENT($1, &$$); $$.nodoPropio=crearNodo($1); }
          | constante									{ $$.tipo=$1.tipo; $$.dimension=$1.dimension; $$.tam=$1.tam; $$.nodoPropio=crearNodo($1); }
          | error
;

llamada_funcion : IDENT PAR_IZQ lista_expresiones PAR_DER	{ TS_FunCall($1, $3, &$$); }
;

lista_expresiones : lista_expresiones COMA expresion	{ $$.nArg=$1.nArg + 1; TS_ComprobarPARAM($-1,$3, $$.nArg); actualizaNodo($-1.nodoPropio, $3); }
           		  | expresion							{ $$.nArg=1; TS_ComprobarPARAM($-1,$1, $$.nArg); $-1.nodoPropio=crearNodoFun($-1); actualizaNodo($-1.nodoPropio, $1); }
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
  initializeTS();
  generaFich();
  generaCtes();
  generaFuncionIf();
  
  return yyparse() ;
}
