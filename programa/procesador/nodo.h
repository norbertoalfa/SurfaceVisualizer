#ifndef NODO_H
#define NODO_H

#include "semantico.h"


extern FILE * file;

extern int nPlot;
extern int totalParam;

tipoNodoArray calculaSubTipo(atributos att);

tipoNodoArray calculaSubTipoLex(char *name);

// Crea el nodo correspondiente a la sentencia "if"
nodo* crearNodoIf(nodo *comp, nodo *expr1, nodo *expr2);

// Crea el nodo correspondiente al acceso mediante índices (array)
nodo* crearNodoIndex(atributos array, nodo *ind);

// Nodo correspondiente a una sentencia entre paréntesis
nodo* crearNodoParentesis(nodo *expr);

// Nodo correspondiente a una sentencia con un operador unario
nodo* crearNodoOpUn(char *op, nodo *expr);

// Nodo correspondiente a una sentencia con un operador binario
nodo* crearNodoOpBin(nodo *expr1, char *op, nodo *expr2);

// Crea un nodo con el mismo lexico que el indicado
nodo* crearNodo(char *nombre);

// Crea un nodo indicando el tipo (si es cte, variable, función, etc)
nodo* crearNodoTipo(char *nombre, tipoNodo tipo, tipoNodoArray subTipo);

//  Crea el nodo correspondiente a la normal de la superficie para una 
// parametrización dada
nodo* crearNodoNormal(nodo *parU, nodo *parV);

// Comprueba si existe la parcial de una función respecto de una variable
// y en caso de no existir la define e implementa
nodo* checkPartialF(nodo *nodoFun, char *nVar);

// Calcula la parcial de un nodo de tipo FUNCION, teniendo en cuenta las expresiones
// pasadas como parámetros a dicha función (hace la regla de la cadena).
nodo* partialNodoFun(nodo *nodoFun, char *nVar);

// Calcula la parcial de un nodo en general, llamando a la función correspondiente
// según el tipo de nodo que sea
nodo* partialExpr(nodo *nodoFun, char *nVar);

// Añade un nodo de paréntesis al nodo actual (añadir prioridad)
nodo* addParen(nodo *n);

// Añade un nodo de llamada a conversión a array, para los accesos a arrays.
nodo* addNodoArray(nodo *n, tipoNodoArray subTipo);

// Añade un hijo al nodo función, correspondiente al nuevo parámetro detectado
// (en el análisis semántico)
void actualizaNodo(nodo *nodoFun, nodo *expr);

// Genera el fichero final (vertex shader) donde se volcará la traducción
void generaFich();

// Añade las ctes predefinidas
void generaCtes();

// Añade al fichero funciones que simulan el comportamiento de la sentencia "if",
// para todos los posibles tipos de datos
void generaFuncionIf();

// Cierra el fichero del vertex shader
void closeInter();

// Escribe en el fichero el string "<tipo_dato> <nombre_var>" correspondiente a la
// entrada de la tabla
void escribeEntrada(char *sent, entradaTS e);

// Escribe en el fichero el árbol sintáctico correspondiente a una expresión
void escribeExpr(char *sent, nodo *nodoExpr);

// Escribe en el fichero final la definición e implementación de la función indicada
void escribeFun(char *fun, nodo *expr);

// Escribe la normal de la función indicada
void escribeNorm(atributos fun, atributos e1);

// Escribe la función que aporta una medida sobre el área localmente
void escribeArea(atributos fun, atributos e1);

// Escribe la declaración de la constante indicada
void escribeVal(char *id, nodo *expr);

// Escribe parte de la secuencia de "if" para controlar que parametrización se está usando
// actualmente
void escribeIfPlot(char *sent, entradaTS fun);

// Escribe la parte inicial del main del vertex shader
void escribeIniPlot(char *fun);

// Añade un "else" si es necesario, para la secuencia de "if" citada
void escribeContPlot(char *fun);

// Finaliza el main del vertex shader
void escribeFinPlot();

#endif
