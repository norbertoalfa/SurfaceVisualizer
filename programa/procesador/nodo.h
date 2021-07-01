#ifndef NODO_H
#define NODO_H

#include "semantico.h"


extern FILE * file;

extern int nPlot;
extern int totalParam;

nodo* crearNodoIf(nodo *comp, nodo *expr1, nodo *expr2);

nodo* crearNodoIndex(nodo *expr, nodo *ind);

nodo* crearNodoParentesis(nodo *expr);

nodo* crearNodoOpUn(char *op, nodo *expr);

nodo* crearNodoOpBin(nodo *expr1, char *op, nodo *expr2);

nodo* crearNodo(char *nombre);

nodo* crearNodoTipo(char *nombre, tipoNodo tipo);

nodo* crearNodoNormal(nodo *parU, nodo *parV);

nodo* partialF(nodo *nodoFun, char *nVar);

void actualizaNodo(nodo *nodoFun, nodo *expr);

void generaFich();

void generaCtes();

void generaFuncionIf();

void closeInter();

void escribeEntrada(char *sent, entradaTS e);

void escribeExpr(char *sent, nodo *nodoExpr);

void escribeFun(char *fun, nodo *expr);

void escribeNorm(atributos fun, atributos e1);

void escribeVal(char *id, nodo *expr);

void escribeIfPlot(char *sent, entradaTS fun);

void escribeIniPlot(char *fun);

void escribeContPlot(char *fun);

void escribeFinPlot();

#endif
