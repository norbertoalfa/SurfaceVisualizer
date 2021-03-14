#ifndef NODO_H
#define NODO_H

#include "semantico.h"


extern FILE * file;

extern int nPlot;
extern int totalParam;


nodo* crearNodoIf(atributos comp, atributos e1, atributos e2);

nodo* crearNodoIndex(atributos e1, atributos ind);

nodo* crearNodoParen(atributos e1);

nodo* crearNodoOpUn(atributos op, atributos e1);

nodo* crearNodoOpBin(atributos e1, atributos op, atributos e2);

nodo* crearNodo(atributos e1);

nodo* crearNodoFun(atributos e1);

void actualizaNodo(nodo *nodoFun, atributos e1);


void generaFich();

void generaCtes();

void generaFuncionIf();

void closeInter();

void escribeEntrada(char *sent, entradaTS e);

void escribeExpr(char *sent, nodo *nodoExpr);

void escribeFun(atributos fun, atributos e1);

void escribeVal(atributos id, atributos e1);

void escribeIfPlot(char *sent, entradaTS fun);

void escribeIniPlot(atributos fun);

void escribeContPlot(atributos fun);

void escribeFinPlot();

#endif
