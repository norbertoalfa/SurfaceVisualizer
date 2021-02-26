#include <string.h>
#include "nodo.h"


nodo* crearNodo(atributos e1){
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup(e1.lex);
	nodoActual->nChild = 0;
	
	return nodoActual;
}

nodo* crearNodoIf(atributos comp, atributos e1, atributos e2) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup("If");
	nodoActual->nChild = 3;
	nodoActual->children[0] = comp.nodoPropio;
	nodoActual->children[1] = e1.nodoPropio;
	nodoActual->children[2] = e2.nodoPropio;
	
	return nodoActual;
}

nodo* crearNodoIndex(atributos e1, atributos ind) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup("[]");
	nodoActual->nChild = 2;
	nodoActual->children[0] = e1.nodoPropio;
	nodoActual->children[1] = ind.nodoPropio;
	
	return nodoActual;
}

nodo* crearNodoOpUn(atributos op, atributos e1) {
	nodo *nodoActual = crearNodo(op);
	
	nodoActual->nChild = 1;
	nodoActual->children[0] = e1.nodoPropio;
	
	return nodoActual;
}

nodo* crearNodoOpBin(atributos e1, atributos op, atributos e2) {
	nodo *nodoActual = crearNodo(op);
	
	nodoActual->nChild = 2;
	nodoActual->children[0] = e1.nodoPropio;
	nodoActual->children[1] = e2.nodoPropio;
	
	return nodoActual;
}

