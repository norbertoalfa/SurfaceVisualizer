#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef enum {

	MARCA = 0,
	PROCEDIMIENTO,
	VAR,
	PARA_FORM

} tipoEntrada;


// tipos de datos
typedef enum {

	NO_ASIG = 0,
	ENTERO,
	REAL,
	CARACTER,
	BOOLEANO,
	ARRAY,
	DESCONOCIDO

} dtipo;

typedef struct {

	tipoEntrada entrada;
	char *lex;
	dtipo tipo;
	unsigned int nParam;
	unsigned int dimension;

	// Número de filas
	int filas;

	// Número de columnas
	int columnas;

} entradaTS;

typedef struct {

	int atrib;
	char *lex;
	dtipo tipo;
	unsigned int dimension;

	// Tamaño de la dimensión 1
	int filas;

	// Tamaño de la dimensión 2
	int columnas;

} atributos;

#define YYSTYPE atributos
#define MAX_IN 1000

extern long int LIMIT;

// Tabla de símbolos
extern entradaTS TS[MAX_IN];

// Línea del fichero que se está analizando
extern int linea;

extern int yylineno;

// 0: procedimientos
// 1: declaración de variables
// 2: sentencia 
extern int decVar;

// 0: no está en la cabecera de un subprograma
// 1: sí está en la cabecera de un subprograma
extern int subProg;

// 0: no se está declarando los parámetros de un procedimiento
// 1: se están declararando los parámetros de un procedimiento
extern int decParam;

// Almacena el tipo en de variable que se está declarando
extern dtipo globalType;

// Indica el tipo de dato del switch
extern dtipo switchType;

// Cuenta el número de parámetros de un procedimiento
extern int nParam;

// Índice de la tabla de símbolos del procedimiento que se está utilizando
extern int currentProc;

// Comprueba que el entero s no esté fuera del rango permitido para el array e
void comprobarSizeArray1D(atributos e, int s);

// Comprueba que los enteros s1 y s2 no estén fuera del rango permitido para el array e
void comprobarSizeArray2D(atributos e, int s1, int s2);

// Comprueba si e es o no un array.
int esArray(atributos e);

// Comprueba si e1 y e2 tienen el mismo size.
int igualSize(atributos e1, atributos e2);

// Guarda el tipo de la variable
int setTipo(atributos value);

// Devuelve la entrada de la tabla de símbolos cuyo identificador coincide con el de e. 
entradaTS getEntrada(atributos e);

// Inserta una entrada en la tabla
int TS_InsertaENTRADA(entradaTS entrada);

// Elimina una entrada de la tabla
int TS_BorrarENTRADA();

// Elimina las entradas de la tabla de símbolos hasta la marca de tope
void TS_VaciarENTRADAS();

// Busca una entrada según el identificador
int TS_BuscarIDENT(atributos e);

// Busca una entrada según el nombre
int TS_BuscarNOMBRE(atributos e);

// Añade un identificador
void TS_InsertaIDENT(atributos e);

// Añade una marca de tope
void TS_InsertaMARCA();

// Añade una entrada de subprograma
void TS_InsertaSUBPROG(atributos e);

// Añade una entrada de parametro formal
void TS_InsertaPARAMF(atributos e);

// Actualiza el número de parámetros del procedimiento
void TS_ActualizarNPARAM(atributos e);

// Devuelve el identificador
void TS_getIDENT(atributos id, atributos* res);

// Realiza la comprobación de la operación +, -
void TS_OpMENOS(atributos op, atributos o, atributos* res);

// Realiza la comprobación de la operación +, - binaria
void TS_OpSUMARESTA(atributos o1, atributos op, atributos o2, atributos* res);

// Realiza la comprobación de la operación *, /
void TS_OpMULDIV(atributos o1, atributos op, atributos o2, atributos* res);

// Realiza la comprobación de la operación &&
void TS_OpAND(atributos o1, atributos op, atributos o2, atributos* res);

// Realiza la comprobación de la operación ||
void TS_OpOR(atributos o1, atributos op, atributos o2, atributos* res);

// Realiza la comprobación de la operación ^
void TS_OpXOR(atributos o1, atributos op, atributos o2, atributos* res);

// Realiza la comprobación de la operación ==, !=
void TS_OpIGUAL(atributos o1, atributos op, atributos o2, atributos* res);

// Realiza la comprobación de la operación <, >, <=, >=, <>
void TS_OpCOMP(atributos o1,atributos o,atributos o2, atributos* res);

// Realiza la comprobación de la operación **
void TS_OpMULMAT(atributos o1,atributos o,atributos o2, atributos* res);

// Realiza la comprobación de la llamada a un procedimiento
void tsProcCall(atributos id, atributos* res);

// Realiza la comprobación de cada parámetro de un procedimiento
void TS_ComprobarPARAM(atributos funID,atributos param, int checkParam);

// Muestra una entrada de la tabla de símbolos
void printEntrada(int row);

// Muestra el tipo del dato recibido
void printTipo(dtipo tipo);

// Muestra la tabla de símbolos
void printTS();

// Muestra un atributo recibido
void printAtributo(atributos e, char *t);

