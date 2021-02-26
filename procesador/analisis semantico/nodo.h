#ifndef NODO_H
#define NODO_H

#include "semantico.h"

nodo* crearNodoIf(atributos comp, atributos e1, atributos e2);

nodo* crearNodoIndex(atributos e1, atributos ind);

nodo* crearNodoOpUn(atributos op, atributos e1);

nodo* crearNodoOpBin(atributos e1, atributos op, atributos e2);

nodo* crearNodo(atributos e1);

#endif
