#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "nodo.h"


FILE * file;
int nPlot=0;


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
	nodoActual->tipo = NODO_IF;
	
	return nodoActual;
}

nodo* crearNodoIndex(atributos e1, atributos ind) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup("[]");
	nodoActual->nChild = 2;
	nodoActual->children[0] = e1.nodoPropio;
	nodoActual->children[1] = ind.nodoPropio;
	nodoActual->tipo = NODO_IND;
	
	return nodoActual;
}

nodo* crearNodoOpUn(atributos op, atributos e1) {
	nodo *nodoActual = crearNodo(op);
	
	nodoActual->nChild = 1;
	nodoActual->children[0] = e1.nodoPropio;
	nodoActual->tipo = NODO_OP;
	
	return nodoActual;
}

nodo* crearNodoOpBin(atributos e1, atributos op, atributos e2) {
	nodo *nodoActual = crearNodo(op);
	
	nodoActual->nChild = 2;
	nodoActual->children[0] = e1.nodoPropio;
	nodoActual->children[1] = e2.nodoPropio;
	nodoActual->tipo = NODO_OP;
	
	return nodoActual;
}

nodo* crearNodoFun(atributos e1) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup(e1.lex);
	nodoActual->nChild = 0;
	nodoActual->tipo = NODO_FUN;
	
	return nodoActual;
}

void actualizaNodo(nodo *nodoFun, atributos e1) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoFun->children[nodoFun->nChild] = e1.nodoPropio;
	nodoFun->nChild = nodoFun->nChild +1;
}

// Abre un fichero para crear el código intermedio
void generaFich(){
	char * sent;
	
  	sent = (char *) malloc(1000);
  	sent[0]=0;
  	
    file = fopen("vertex.s","w");
  	
    sprintf(sent,"#version 440 core\n");
    sprintf(sent,"%slayout (location = 0) in vec2 aPos;\n\n", sent);
    sprintf(sent,"%sout vData {vec3 FragPos;} vertex;\n\n", sent);
    sprintf(sent,"%suniform mat4 model;\n", sent);
    sprintf(sent,"%suniform mat4 view;\n", sent);
    sprintf(sent,"%suniform mat4 projection;\n", sent);
    sprintf(sent,"%suniform float param_t[%d];\n", sent, LIMIT_FUN);
    sprintf(sent,"%suniform int funPlot;\n\n", sent);
    
  	fputs(sent,file);
  	free(sent);	
}

// Cerrar fichero
void closeInter(){
    fclose(file);
    //if(hayError)
	//remove("generated.c");

}

void escribeEntrada(char *sent, entradaTS e){
	if (e.tipo == ENTERO) {
  		sprintf(sent,"%sint", sent);
  	} else if (e.tipo == REAL) {
  		sprintf(sent,"%sfloat", sent);
  	} else if (e.tipo == BOOLEANO) {
  		sprintf(sent,"%sbool", sent);
  	} else if (e.tipo == ARRAY) {
  		if (e.dimension == 1) {
  			sprintf(sent,"%svec%d", sent, e.tam);
  		} else if (e.dimension == 2) {
  			sprintf(sent,"%smat%d", sent, e.tam);
  		}
  	}
  	sprintf(sent,"%s %s", sent, e.lex);
}

void escribeExpr(char *sent, nodo *nodoExpr){
	int hayArg, i;
	
	hayArg = 0;
	i = 0;
	
	if (nodoExpr->nChild==0){
		sprintf(sent,"%s%s", sent, nodoExpr->lex);
	} else if (nodoExpr->tipo == NODO_OP){
		if (nodoExpr->nChild==2) {
			escribeExpr(sent, nodoExpr->children[0]);
		}
		sprintf(sent,"%s %s ", sent, nodoExpr->lex);
		escribeExpr(sent, nodoExpr->children[nodoExpr->nChild-1]);
	} else if (nodoExpr->tipo == NODO_IF){
		sprintf(sent,"%s funcionIf(", sent);
		hayArg = 1;
	} else if (nodoExpr->tipo == NODO_FUN){
		sprintf(sent,"%s %s(", sent, nodoExpr->lex);
		hayArg = 1;
	} else if (nodoExpr->tipo == NODO_IND){
		escribeExpr(sent, nodoExpr->children[0]);
		sprintf(sent,"%s[", sent);
		escribeExpr(sent, nodoExpr->children[nodoExpr->nChild-1]);
		sprintf(sent,"%s]", sent);
	}
	
	if (hayArg) {
		while(i<nodoExpr->nChild-1){
			escribeExpr(sent, nodoExpr->children[i]);
			sprintf(sent,"%s, ", sent);
			i++;
		}

		escribeExpr(sent, nodoExpr->children[nodoExpr->nChild-1]);
		sprintf(sent,"%s)", sent);
	}
	
}

void escribeFun(atributos fun, atributos e1){
	int indexFun, i;
	char * sent;
	
  	sent = (char *) malloc(1000);
  	sent[0]=0;
  	indexFun = TS_BuscarFUN(fun);
  	
  	if (indexFun == -1) {
  		return;
  	}
  	
  	i = 1;
  	
  	// Añade el tipo y el identificador
  	escribeEntrada(sent, TS[indexFun]);
  	
    sprintf(sent,"%s(", sent);
    
    while(i<TS[indexFun].nParam){
    	escribeEntrada(sent, TS[indexFun+i]);
    	sprintf(sent,"%s, ", sent);
    	i++;
    }
        
	escribeEntrada(sent, TS[indexFun+TS[indexFun].nParam]);
  	fputs(sent,file);
  	free(sent);
  	
	// Escribe la expresión de forma recurrente
  	sent = (char *) malloc(10000);
  	sent[0]=0;
	
	sprintf(sent,"%s) {\n\treturn ", sent);
    escribeExpr(sent, e1.nodoPropio);
    sprintf(sent,"%s;\n}\n\n", sent);
    
  	fputs(sent,file);
  	free(sent);
  	
}

void escribeVal(atributos id, atributos e1){
	int indexVal;
	char * sent;
	
  	sent = (char *) malloc(1000);
  	sent[0]=0;
  	indexVal = TS_BuscarIDENT(id);
  	
  	if (indexVal == -1) {
  		return;
  	}
  
  	// Añade el tipo y el identificador
  	escribeEntrada(sent, TS[indexVal]);
  	
    sprintf(sent,"%s = ", sent);
	
    escribeExpr(sent, e1.nodoPropio);
    sprintf(sent,"%s;\n\n", sent);
    
  	fputs(sent,file);
  	free(sent);
  	
}

void escribeIfPlot(char *sent, entradaTS fun){
	int i = 2;

    sprintf(sent,"%sif (funPlot==%d) {\n\t\t", sent, nPlot);
    sprintf(sent,"%saPosSurf = %s(aPos.x, aPos.y", sent, fun.lex);
    nPlot++;
    
    while(i<fun.nParam){
    	sprintf(sent,"%s, param_t[%d]", sent, i-2);
    	i++;
    }
    
	sprintf(sent,"%s);\n\t}", sent);
	  	
}

void escribeIniPlot(atributos fun){
	int indexFun, i;
	char * sent;
	
  	sent = (char *) malloc(1000);
  	sent[0]=0;
  	
  	indexFun = TS_BuscarFUN(fun);
  	nPlot = 0;
  	i = 1;
  	
  	if (indexFun == -1) {
  		return;
  	}
  	
    sprintf(sent,"void main() {\n\tvec3 aPosSurf;\n\n\t");
    escribeIfPlot(sent, TS[indexFun]);
    
  	fputs(sent,file);
  	free(sent);
  	
}

void escribeContPlot(atributos fun){
	int indexFun, i;
	char * sent;
	
  	sent = (char *) malloc(1000);
  	sent[0]=0;
  	indexFun = TS_BuscarFUN(fun);
  	
  	if (indexFun == -1) {
  		return;
  	}
  	
  	i = 1;
  	
    sprintf(sent," else ");
    escribeIfPlot(sent, TS[indexFun]);
    
  	fputs(sent,file);
  	free(sent);
  	
}

void escribeFinPlot(){
	char * sent;
	
  	sent = (char *) malloc(1000);
  	sent[0]=0;
  	
    sprintf(sent,"\n\n\tvertex.FragPos = vec3(model * vec4(aPosSurf, 1.0));\n\t");
    sprintf(sent,"%sgl_Position = projection * view * model * vec4(aPosSurf, 1.0);\n}", sent);
    
  	fputs(sent,file);
  	free(sent);
  	
}

