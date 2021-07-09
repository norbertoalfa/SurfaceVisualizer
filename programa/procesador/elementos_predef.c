#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "elementos_predef.h"

void addCt(char *name) {
	entradaTS cte;

	cte.entrada = VAR;
	cte.lex = strdup(name);
	cte.tipo = REAL;
	cte.nParam = 0;
	cte.dimension=0;
	cte.tam=0;
	TS_InsertaEntrada(cte);
}

void addFunc(char *name, dtipo tipo, int nParam, int dim, int tam, entradaTS params[]) {
	entradaTS func;
	int i;

	func.entrada = FUNCION;
	func.lex = strdup(name);
	func.tipo = tipo;
	func.nParam = nParam;
	func.dimension = dim;
	func.tam = tam;
	TS_InsertaEntrada(func);

	for (i = 0; i < nParam; i++) {
		TS_InsertaEntrada(params[i]);
	}
}

entradaTS createParam(char *name, dtipo tipo, int dim, int tam) {
	entradaTS param;

	param.entrada = PARA_FORM;
	param.lex = strdup(name);
	param.tipo = tipo;
	param.nParam = 0;
	param.dimension = dim;
	param.tam = tam;

	return param;
}

// Constantes predefinidas
void addPredefCts() {
	addCt("E");
	addCt("PI");
}

// Funciones predefinidas
void addPredefFunc() {	
	// cos
	entradaTS paramsCos[1];
	paramsCos[0] = createParam("x", REAL, 0, 0);
	addFunc("cos", REAL, 1, 0, 0, paramsCos);
	
	// sin
	entradaTS paramsSin[1];
	paramsSin[0] = createParam("x", REAL, 0, 0);
	addFunc("sin", REAL, 1, 0, 0, paramsSin);
	
	// tg
	entradaTS paramsTg[1];
	paramsTg[0] = createParam("x", REAL, 0, 0);
	addFunc("tg", REAL, 1, 0, 0, paramsTg);
	
	// log
	entradaTS paramsLog[1];
	paramsLog[0] = createParam("x", REAL, 0, 0);
	addFunc("log", REAL, 1, 0, 0, paramsLog);

	// norm (vec2)
	entradaTS paramsNormVec2[1];
	paramsNormVec2[0] = createParam("x", ARRAY, 1, 2);
	addFunc("normalizeVec2", ARRAY, 1, 1, 2, paramsNormVec2);
	
	// norm (vec3)
	entradaTS paramsNormVec3[1];
	paramsNormVec3[0] = createParam("x", ARRAY, 1, 3);
	addFunc("normalizeVec3", ARRAY, 1, 1, 3, paramsNormVec3);
	
	// cross
	entradaTS paramsCross[2];
	paramsCross[0] = createParam("x", ARRAY, 1, 3);
	paramsCross[1] = createParam("y", ARRAY, 1, 3);
	addFunc("cross", ARRAY, 2, 1, 3, paramsCross);
	
	// atan
	entradaTS paramsAtan[1];
	paramsAtan[0] = createParam("x", REAL, 0, 0);
	addFunc("atan", REAL, 1, 0, 0, paramsAtan);
}