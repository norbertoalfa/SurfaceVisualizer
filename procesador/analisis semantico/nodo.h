#ifndef NODO_H
#define NODO_H

#include "semantico.h"


extern FILE * file;


nodo* crearNodoIf(atributos comp, atributos e1, atributos e2);

nodo* crearNodoIndex(atributos e1, atributos ind);

nodo* crearNodoOpUn(atributos op, atributos e1);

nodo* crearNodoOpBin(atributos e1, atributos op, atributos e2);

nodo* crearNodo(atributos e1);

nodo* crearNodoFun(atributos e1);

void actualizaNodo(nodo *nodoFun, atributos e1);


void generaFich();

void closeInter();

void escribeEntrada(char *sent, entradaTS e);

void escribeExpr(char *sent, nodo *nodoExpr);

void escribeFun(atributos fun, atributos e1);


#endif
