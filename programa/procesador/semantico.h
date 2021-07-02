#ifndef SEMANTICO_H
#define SEMANTICO_H

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#ifndef LIMIT_FUN
#define LIMIT_FUN 10
#endif

typedef enum {

	MARCA = 0,
	FUNCION,
	VAR,
	PARA_FORM

} tipoEntrada;


// tipos de datos
typedef enum {

	NO_ASIG = 0,
	ENTERO,
	REAL,
	BOOLEANO,
	ARRAY,
	DESCONOCIDO

} dtipo;

// tipos de datos
typedef enum {

	NODO_CTE = 0,
	NODO_VAR,
	NODO_OP,
	NODO_FUN,
	NODO_IND,
	NODO_PAREN,
	NODO_IF

} tipoNodo;

// tipos de datos para un acceso por índice
typedef enum {

	NODO_IND_VEC2 = 0,
	NODO_IND_VEC3,
	NODO_IND_MAT2,
	NODO_IND_MAT3

} tipoNodoInd;


struct nodo{

	char *lex;
	struct nodo *children[10];
	int nChild;
	tipoNodo tipo;
	tipoNodoInd subTipo;

};

typedef struct nodo nodo;

typedef struct {

	tipoEntrada entrada;
	char *lex;
	dtipo tipo;
	unsigned int nParam;
	unsigned int dimension;
	int tam;
	nodo *nodoExpr;

} entradaTS;

typedef struct {

	int atrib;
	char *lex;
	dtipo tipo;
	unsigned int dimension;
	int tam;
	int nArg;
	nodo *nodoPropio;

} atributos;

#define YYSTYPE atributos
#define MAX_IN 1000

extern long int LIMIT;

// Tabla de símbolos
entradaTS TS[MAX_IN];

// Línea del fichero que se está analizando
extern int linea;

extern int yylineno;

extern int inFun;

// 0: funciones
// 1: declaración de constantes
// 2: sentencia 
extern int declaracion;

// 0: no se está declarando los parámetros de una función
// 1: se están declararando los parámetros de una función
extern int decParam;

// Almacena el tipo de variable que se está declarando
extern dtipo globalType;


extern int globalDim;


extern int globalTam;

// Cuenta el número de parámetros de la función
extern int nParam;


extern int nArg;


extern int parDesc;

// Índice de la tabla de símbolos de la función que se está utilizando
extern int currentFun;


void initializeTS();

// Comprueba que el entero s no esté fuera del rango permitido para el array e
void comprobarSizeArray(atributos e, int s, int t);

// Comprueba si e es o no un array.
int esArray(atributos e);

// Comprueba si e1 y e2 tienen el mismo size.
int igualSize(atributos e1, atributos e2);

// Guarda el tipo de la variable
int setTipo(atributos tipo);


int setTipoDesc();


void actualizaTipoDesc(atributos tipo);

// Devuelve la entrada de la tabla de símbolos cuyo identificador coincide con el de e. 
entradaTS getEntrada(char *nombre);

// Inserta una entrada en la tabla
int TS_InsertaEntrada(entradaTS entrada);

// Elimina una entrada de la tabla

int TS_BorrarENTRADA();

// Elimina las entradas de la tabla de símbolos hasta la marca de tope
void TS_VaciarENTRADAS();

// Busca una entrada según el identificador
int TS_BuscarIDENT(char *nombre);

// Busca una entrada de una función
int TS_BuscarFUN(char *nombre);

// Busca una entrada de una función
int TS_BuscarFUNModo(char *nombre, int modoAnalisis);

// Añade un identificador
void TS_InsertaIDENT(char *nombre);

// Añade una marca de tope
void TS_InsertaMARCA();


void TS_InsertaFUN(atributos e);

// Añade una entrada de parametro formal
void TS_InsertaPARAMF(atributos e);


void TS_InsertaPLOT(char *id);

// Actualiza el número de parámetros de la función y el tipo
void TS_ActualizarFun();

// Devuelve el identificador
void TS_getIDENT(atributos id, atributos* res);


void comprobarTipoCte(atributos idTipo);


void comprobarTipoFun(atributos idFun, atributos idTipo);


void comprobarIF(atributos comp, atributos e1, atributos e2, atributos* res);


void comprobarIND(atributos e1, atributos e2, atributos* res);

// Realiza la comprobación de la operación +, - y !
void TS_OpUNARIA(atributos op, atributos o, atributos* res);

// Realiza la comprobación de la operación +, - binaria
void TS_OpSUMARESTA(atributos o1, atributos op, atributos o2, atributos* res);

// Realiza la comprobación de la operación *, /
void TS_OpMULTIP(atributos o1, atributos op, atributos o2, atributos* res);

// Realiza la comprobación de la operación &&
void TS_OpAND(atributos o1, atributos op, atributos o2, atributos* res);

// Realiza la comprobación de la operación ||
void TS_OpOR(atributos o1, atributos op, atributos o2, atributos* res);

// Realiza la comprobación de la operación ==, !=
void TS_OpIGUAL(atributos o1, atributos op, atributos o2, atributos* res);

// Realiza la comprobación de la operación <, >, <=, >=, <>
void TS_OpCOMP(atributos o1,atributos o,atributos o2, atributos* res);

// Realiza la comprobación de la llamada a una función
void TS_FunCall(atributos id, atributos argFun, atributos* res);

// Realiza la comprobación de cada parámetro de una función
void TS_ComprobarPARAM(atributos funID,atributos param, int checkParam);

// Muestra una entrada de la tabla de símbolos
void printEntrada(int row);

// Muestra el tipo del dato recibido
void printTipo(dtipo tipo);

// Muestra la tabla de símbolos
void printTS();

// Muestra un atributo recibido
void printAtributo(atributos e, char *t);

#endif
