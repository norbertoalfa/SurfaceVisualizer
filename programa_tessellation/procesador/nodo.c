#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "nodo.h"


FILE * file;
char *sFunParam;
char *sNormalParam;
char *sAreaParam;
char *sKParam;
int nPlot=0;
int totalParam=0;

tipoNodoArray calculaSubTipo(atributos att)
{
	tipoNodoArray subTipo = NODO_NA;

	if (att.dimension == 1){
		if (att.tam == 2) {
			subTipo = NODO_VEC2;
		} else if (att.tam == 3){
			subTipo = NODO_VEC3;
		}
	} else {
		if (att.tam == 2) {
			subTipo = NODO_MAT2;
		} else if (att.tam == 3){
			subTipo = NODO_MAT3;
		}
	}

	return subTipo;
}

tipoNodoArray calculaSubTipoLex(char *name)
{
	tipoNodoArray subTipo = NODO_NA;

	if (strcmp(name, "vec2") == 0){
		subTipo = NODO_VEC2;
	}
	if (strcmp(name, "vec3") == 0){
		subTipo = NODO_VEC3;
	}
	if (strcmp(name, "mat2") == 0){
		subTipo = NODO_MAT2;
	}
	if (strcmp(name, "mat3") == 0){
		subTipo = NODO_MAT3;
	}

	return subTipo;
}

nodo* crearNodo(char *nombre){
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup(nombre);
	nodoActual->nChild = 0;
	nodoActual->subTipo = NODO_NA;
	
	return nodoActual;
}

nodo* crearNodoTipo(char *nombre, tipoNodo tipo, tipoNodoArray subTipo) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup(nombre);
	nodoActual->nChild = 0;
	nodoActual->tipo = tipo;
	nodoActual->subTipo = subTipo;
	
	return nodoActual;
}

nodo* crearNodoFun1par(char *nombre, nodo *expr) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup(nombre);
	nodoActual->nChild = 1;
	nodoActual->tipo = NODO_FUN;
	nodoActual->subTipo = NODO_NA;
	nodoActual->children[0] = expr;
	
	return nodoActual;
}

nodo* crearNodoIf(nodo *comp, nodo *e1, nodo *e2) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup("If");
	nodoActual->nChild = 3;
	nodoActual->children[0] = comp;
	nodoActual->children[1] = e1;
	nodoActual->children[2] = e2;
	nodoActual->tipo = NODO_IF;
	nodoActual->subTipo = e1->subTipo;
	
	return nodoActual;
}

nodo* crearNodoIndex(atributos array, nodo *ind) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup("[]");
	nodoActual->nChild = 2;
	nodoActual->children[0] = array.nodoPropio;
	nodoActual->children[1] = ind;
	nodoActual->tipo = NODO_IND;
	nodoActual->subTipo = calculaSubTipo(array);

	return nodoActual;
}

nodo* crearNodoParentesis(nodo *expr) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup("()");
	nodoActual->nChild = 1;
	nodoActual->children[0] = expr;
	nodoActual->tipo = NODO_PAREN;
	nodoActual->subTipo = expr->subTipo;
	
	return nodoActual;
}

nodo* crearNodoOpUn(char *op, nodo *expr) {
	nodo *nodoActual = crearNodo(op);
	
	nodoActual->nChild = 1;
	nodoActual->children[0] = expr;
	nodoActual->tipo = NODO_OP;
	nodoActual->subTipo = expr->subTipo;
	
	return nodoActual;
}

nodo* crearNodoOpBin(nodo *expr1, char *op, nodo *expr2) {
	nodo *nodoActual = crearNodo(op);
	
	nodoActual->nChild = 2;
	nodoActual->children[0] = expr1;
	nodoActual->children[1] = expr2;
	nodoActual->tipo = NODO_OP;
	nodoActual->subTipo = expr1->subTipo;
	
	return nodoActual;
}

nodo* crearNodoNormal(nodo *parU, nodo *parV)
{
	nodo *nodoActual, *nodoCross;
	
	nodoCross = crearNodoTipo(strdup("cross"), NODO_FUN, 0);
	nodoCross->nChild = 2;
	nodoCross->children[0] = parU;
	nodoCross->children[1] = parV;

	nodoActual = crearNodoTipo(strdup("normalize"), NODO_FUN, 0);
	nodoActual->nChild = 1;
	nodoActual->children[0] = nodoCross;
	
	return nodoActual;
}

nodo* crearNodoArea(nodo *parU, nodo *parV)
{
	nodo *nodoArea;
	
	nodoArea = crearNodoTipo(strdup("distance"), NODO_FUN, 0);
	nodoArea->nChild = 2;
	nodoArea->children[0] = parU;
	nodoArea->children[1] = parV;
	
	return nodoArea;
}

nodo* crearNodoK(nodo *parU, nodo *parV)
{
	nodo *nodoK, *nodoNum, *nodoDen;

	nodo *nodoNumIzq, *nodoNumIzq1, *nodoNumIzq2;
	nodo *nodoNumDer, *nodoDetUV;

	nodo *nodoDenIzq, *nodoDenIzq1, *nodoDenIzq2;
	nodo *nodoDenDer, *nodoDot;

	nodo *nodoMatIzq1 = crearNodoTipo(strdup("mat3"), NODO_FUN, NODO_MAT3);
	nodoMatIzq1->nChild = 3;
	nodoMatIzq1->children[0] = checkPartialF(parU, "u");
	nodoMatIzq1->children[1] = parU;
	nodoMatIzq1->children[2] = parV;

	nodoNumIzq1 = crearNodoFun1par("determinant", nodoMatIzq1);

	nodo *nodoMatIzq2 = crearNodoTipo(strdup("mat3"), NODO_FUN, NODO_MAT3);
	nodoMatIzq2->nChild = 3;
	nodoMatIzq2->children[0] = checkPartialF(parV, "v");
	nodoMatIzq2->children[1] = parU;
	nodoMatIzq2->children[2] = parV;

	nodoNumIzq2 = crearNodoFun1par("determinant", nodoMatIzq2);

	nodo *nodoMatUV = crearNodoTipo(strdup("mat3"), NODO_FUN, NODO_MAT3);
	nodoMatUV->nChild = 3;
	nodoMatUV->children[0] = checkPartialF(parU, "v");
	nodoMatUV->children[1] = parU;
	nodoMatUV->children[2] = parV;

	nodoDetUV = crearNodoFun1par("determinant", nodoMatUV);

	nodoNumIzq = crearNodoOpBin(nodoNumIzq1, "*", nodoNumIzq2);
	nodoNumDer = crearNodoOpBin(nodoDetUV, "^", crearNodoTipo("2", NODO_CTE, 0));
	nodoNum = crearNodoOpBin(nodoNumIzq, "-", nodoNumDer);

	nodoDenIzq1 = crearNodoOpBin(crearNodoFun1par("length", parU), "^", crearNodoTipo("2", NODO_CTE, 0));
	nodoDenIzq2 = crearNodoOpBin(crearNodoFun1par("length", parV), "^", crearNodoTipo("2", NODO_CTE, 0));
	nodoDenIzq = crearNodoOpBin(nodoDenIzq1, "*", nodoDenIzq2);

	nodoDot = crearNodoTipo(strdup("dot"), NODO_FUN, 0);
	nodoDot->nChild = 2;
	nodoDot->children[0] = parU;
	nodoDot->children[1] = parV;

	nodoDenDer = crearNodoOpBin(nodoDot, "^", crearNodoTipo("2", NODO_CTE, 0));

	nodoDen = crearNodoOpBin(crearNodoOpBin(nodoDenIzq, "-", nodoDenDer), "^", crearNodoTipo("2", NODO_CTE, 0));

	nodoK = crearNodoOpBin(crearNodoParentesis(nodoNum), "/", nodoDen);
	
	return nodoK;
}

void actualizaNodo(nodo *nodoFun, nodo *expr) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	if (nodoFun->nChild < 10) {
		nodoFun->children[nodoFun->nChild] = expr;
		nodoFun->nChild = nodoFun->nChild +1;
	} else {
		printf("Se ha sobrepasado el límite de argumentos: %s\n", nodoFun->lex);
	}
}

void generaFich(){
    file = fopen("../shaders/functions.s","w");
}

// Añade las ctes predefinidas
void generaCtes(){
	char * sent;
	
  	sent = (char *) malloc(1000);
  	sent[0]=0;
  	
    sprintf(sent,"\nfloat PI = 3.1415926;\n");
    sprintf(sent,"%sfloat E = 2.71828182;\n\n", sent);
    
  	fputs(sent,file);
  	free(sent);	
}

void generaFuncionIf(){
	char *sent, *cuerpo;
	
  	sent = (char *) malloc(1000);
  	cuerpo = (char *) malloc(1000);

  	sent[0]=0;
  	cuerpo[0]=0;
  	
    sprintf(cuerpo,"{\n");
    sprintf(cuerpo,"%s\tif (cond)\n", cuerpo);
    sprintf(cuerpo,"%s\t\t return e1;\n", cuerpo);
    sprintf(cuerpo,"%s\t else\n", cuerpo);
    sprintf(cuerpo,"%s\t\t return e2;\n", cuerpo);
    sprintf(cuerpo,"%s}\n", cuerpo);

    sprintf(sent,"\nint funcionIf(bool cond, int e1, int e2)\n");
	fputs(sent,file);
	fputs(cuerpo,file);
	free(sent);
	sent = (char *) malloc(1000);

	sprintf(sent,"\nfloat funcionIf(bool cond, float e1, float e2)\n");
	fputs(sent,file);
	fputs(cuerpo,file);
	free(sent);
	sent = (char *) malloc(1000);

	sprintf(sent,"\nbool funcionIf(bool cond, bool e1, bool e2)\n");
	fputs(sent,file);
	fputs(cuerpo,file);
	free(sent);
	sent = (char *) malloc(1000);

	sprintf(sent,"\nvec2 funcionIf(bool cond, vec2 e1, vec2 e2)\n");
	fputs(sent,file);
	fputs(cuerpo,file);
	free(sent);
	sent = (char *) malloc(1000);

	sprintf(sent,"\nvec3 funcionIf(bool cond, vec3 e1, vec3 e2)\n");
	fputs(sent,file);
	fputs(cuerpo,file);
	free(sent);
	sent = (char *) malloc(1000);

	sprintf(sent,"\nmat2 funcionIf(bool cond, mat2 e1, mat2 e2)\n");
	fputs(sent,file);
	fputs(cuerpo,file);
	free(sent);
	sent = (char *) malloc(1000);

	sprintf(sent,"\nmat3 funcionIf(bool cond, mat3 e1, mat3 e2)\n");
	fputs(sent,file);
	fputs(cuerpo,file);
	free(sent);
	free(cuerpo);
}

// Cerrar fichero
void closeInter(){
    fclose(file);
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
		if (strcmp(nodoExpr->lex, "^") == 0) {
			sprintf(sent,"%s pow(", sent);
			hayArg = 1;
		} else {
			if (nodoExpr->nChild==2) {
				escribeExpr(sent, nodoExpr->children[0]);
			}
			
			sprintf(sent,"%s %s ", sent, nodoExpr->lex);
			escribeExpr(sent, nodoExpr->children[nodoExpr->nChild-1]);
		}
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
	} else if (nodoExpr->tipo == NODO_PAREN){
		sprintf(sent,"%s(", sent);
		escribeExpr(sent, nodoExpr->children[0]);
		sprintf(sent,"%s)", sent);
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

void escribeFun(char *fun, nodo *expr){
	int indexFun, i;
	char * sent;
	
  	sent = (char *) malloc(1000);
  	sent[0]=0;
  	indexFun = TS_BuscarFUN(fun);

  	if (indexFun == -1) {
  		return;
  	}

	TS[indexFun].nodoExpr = expr;
  	
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
    escribeExpr(sent, expr);
    sprintf(sent,"%s;\n}\n\n", sent);
    
  	fputs(sent,file);
  	free(sent);
  	
}

nodo* addNodoArray(nodo *n, tipoNodoArray subTipo) {
	nodo *nodoArray = malloc(sizeof(nodo));

	nodoArray->tipo = NODO_FUN;
	nodoArray->nChild = 1;

	if (subTipo == NODO_VEC2){
		nodoArray->lex = strdup("vec2");
	} else if (subTipo == NODO_VEC3){
		nodoArray->lex = strdup("vec3");
	} else if (subTipo == NODO_MAT2){
		nodoArray->lex = strdup("mat2");
	} else if (subTipo == NODO_MAT3){
		nodoArray->lex = strdup("mat3");
	} else {
		printf("Error, el nodo de índice para array no tiene subtipo.\n");
		
		return NULL;
	}

	nodoArray->children[0] = n;
	nodoArray->subTipo = subTipo;

	return nodoArray;
}

nodo* partialNodoSum(nodo *nodoFun, char *nVar)
{
	return crearNodoOpBin(partialExpr(nodoFun->children[0], nVar), nodoFun->lex, partialExpr(nodoFun->children[1], nVar));
}

nodo* partialNodoMenos(nodo *nodoFun, char *nVar)
{
	return crearNodoOpUn("-", partialExpr(nodoFun->children[0], nVar));
}

nodo* partialNodoMul(nodo *nodoFun, char *nVar)
{
	nodo *nodoIzq, *nodoDer;

	nodoIzq = crearNodoOpBin(partialExpr(nodoFun->children[0], nVar), "*", nodoFun->children[1]);
	nodoDer = crearNodoOpBin(nodoFun->children[0], "*", partialExpr(nodoFun->children[1], nVar));
	
	return crearNodoParentesis(crearNodoOpBin(nodoIzq, "+", nodoDer));
}

nodo* partialNodoDiv(nodo *nodoFun, char *nVar)
{
	nodo *nodoIzq, *nodoDer, *nodoNum, *nodoDen;

	nodoIzq = crearNodoOpBin(partialExpr(nodoFun->children[0], nVar), "/", nodoFun->children[1]);
	nodoNum = crearNodoOpBin(nodoFun->children[0], "*", partialExpr(nodoFun->children[1], nVar));
	nodoDen = crearNodoOpBin(nodoFun->children[1], "^", crearNodoTipo("2", NODO_CTE, 0));
	nodoDer = crearNodoOpBin(nodoNum, "/", crearNodoParentesis(nodoDen));
	
	return crearNodoOpBin(nodoIzq, "-", nodoDer);
}

nodo* partialNodoExp(nodo *nodoFun, char *nVar)
{
	nodo *nodoExp, *nodoLn, *nodoPotencia, *nodoPotenciaDer, *nodoPar;

	if (nodoFun->children[1]->tipo != NODO_CTE){	
		if (strcmp(nodoFun->children[0]->lex, "E") == 0) {
			nodoExp = nodoFun->children[1];
		} else {
			nodoLn = crearNodoFun1par("log", nodoFun->children[0]);
			nodoExp = crearNodoOpBin(nodoFun->children[1], "*", nodoLn);
		}

		nodoPar = crearNodoOpBin(nodoFun, "*", crearNodoParentesis(partialExpr(nodoExp, nVar)));

	} else {
		if (strcmp(nodoFun->children[1]->lex, "0") == 0){
			nodoPar = crearNodoTipo("0", NODO_CTE, 0);
		} else {
			char *nExp;

			nExp = (char *) malloc(100);
			nExp[0] = 0;
			sprintf(nExp, "%f", atof(nodoFun->children[1]->lex)-1);

			nodoPotencia = crearNodoOpBin(nodoFun->children[0], "^", crearNodoTipo(nExp, NODO_CTE, 0));
			nodoPotenciaDer = crearNodoOpBin(crearNodoTipo(nodoFun->children[1]->lex, NODO_CTE, 0), "*", nodoPotencia);
			nodoPar = crearNodoOpBin(nodoPotenciaDer, "*", partialExpr(nodoFun->children[0], nVar));
		}
	}

	return nodoPar;
}

nodo* partialNodoIf(nodo *nodoFun, char *nVar)
{
	return crearNodoIf(nodoFun->children[0], partialExpr(nodoFun->children[1], nVar), partialExpr(nodoFun->children[2], nVar));
}

nodo* derivLog(nodo *nodoFun)
{
	return crearNodoOpBin(crearNodoTipo("1", NODO_CTE, 0), "/", crearNodoParentesis(nodoFun->children[0]));
}

nodo* derivSin(nodo *nodoFun)
{
	return crearNodoFun1par("cos", nodoFun->children[0]);
}

nodo* derivCos(nodo *nodoFun)
{
	return crearNodoParentesis(crearNodoOpUn("-", crearNodoFun1par("sin", nodoFun->children[0])));
}

nodo* derivTg(nodo *nodoFun)
{
	nodo *nodoNum, *nodoDen;

	nodoDen = crearNodoOpBin(crearNodoFun1par("cos", nodoFun->children[0]), "^", crearNodoTipo("2", NODO_CTE, 0));
	nodoNum = crearNodoTipo("1", NODO_CTE, 0);

	return crearNodoOpBin(nodoNum, "/", nodoDen);
}

nodo* derivAtan(nodo *nodoFun)
{
	nodo *nodoExp, *nodoDen;

	nodoExp = crearNodoOpBin(crearNodoParentesis(nodoFun->children[0]), "^", crearNodoTipo("2", NODO_CTE, 0));
	nodoDen = crearNodoOpBin(crearNodoTipo("1", NODO_CTE, 0), "+", nodoExp);

	return crearNodoOpBin(crearNodoTipo("1", NODO_CTE, 0), "/", crearNodoParentesis(nodoDen));
}

void replace(nodo *baseNode, nodo *nNew) {
	int ch = 0;

	baseNode->lex = strdup(nNew->lex);
	baseNode->nChild = nNew->nChild;
	baseNode->tipo = nNew->tipo;
	baseNode->subTipo = nNew->subTipo;

	for (ch = 0; ch < baseNode->nChild; ch++) {
		baseNode->children[ch] = nNew->children[ch];
	}
}

void simplifyPartial(nodo *nodoPar){
	int i = 0;
	int simplificable = 0;

	if (nodoPar->nChild > 0) {
		for (i = 0; i < nodoPar->nChild; i++) {
			simplifyPartial(nodoPar->children[i]);
		}

		for (i = 0; i < nodoPar->nChild; i++) {

			if (nodoPar->tipo == NODO_PAREN) {
				if (nodoPar->children[0]->tipo != NODO_OP) {
					replace(nodoPar, nodoPar->children[0]);
				}
			}
			
			if (nodoPar->tipo == NODO_OP) {
				int isZero = 0;

				simplificable = strcmp(nodoPar->children[i]->lex, "0") == 0 ||
								strcmp(nodoPar->children[i]->lex, "1") == 0;
				simplificable = simplificable && nodoPar->children[i]->tipo == NODO_CTE;
				
				if (simplificable) {
					// Es un operador unario
					if (nodoPar->nChild == 1){
						if (strcmp(nodoPar->lex, "-") == 0 && strcmp(nodoPar->children[i]->lex, "0") == 0) {
							isZero = 1;
						}

						if (strcmp(nodoPar->lex, "!") == 0) {
							if (strcmp(nodoPar->children[i]->lex, "0") == 0) {
								nodoPar->lex = strdup("1");
							} else {
								nodoPar->lex = strdup("0");
							}

							nodoPar->nChild = 0;
							nodoPar->tipo = NODO_CTE;
						}

					// Es un operador binario
					} else {
						int j = !i;

						if (strcmp(nodoPar->lex, "+") == 0 && strcmp(nodoPar->children[i]->lex, "0") == 0) {
							replace(nodoPar, nodoPar->children[j]);
						}

						if (strcmp(nodoPar->lex, "-") == 0) {
							if (strcmp(nodoPar->children[0]->lex, "0") == 0 && strcmp(nodoPar->children[1]->lex, "0") == 0) {
								isZero = 1;
							} else if (strcmp(nodoPar->children[1]->lex, "0") == 0) {
								replace(nodoPar, nodoPar->children[0]);
							} else if (strcmp(nodoPar->children[0]->lex, "0") == 0) {
								nodoPar->children[0] = nodoPar->children[1];
								nodoPar->nChild = 1;
							}
						}

						if (strcmp(nodoPar->lex, "*") == 0 && strcmp(nodoPar->children[i]->lex, "0") == 0) {
							if (nodoPar->children[j]->subTipo == NODO_NA) {
								isZero = 1;
							} else {
								replace(nodoPar, addNodoArray(crearNodoTipo("0", NODO_CTE, nodoPar->children[j]->subTipo), nodoPar->children[j]->subTipo));
							}
						}

						if (strcmp(nodoPar->lex, "*") == 0 && strcmp(nodoPar->children[i]->lex, "1") == 0) {
							replace(nodoPar, nodoPar->children[j]);
						}

						if (strcmp(nodoPar->lex, "/") == 0 && strcmp(nodoPar->children[0]->lex, "0") == 0) {
							isZero = 1;
						}

						if (strcmp(nodoPar->lex, "/") == 0 && strcmp(nodoPar->children[1]->lex, "1") == 0) {
							replace(nodoPar, nodoPar->children[0]);
						}
					}

					if (isZero) {
						nodoPar->lex = strdup("0");
						nodoPar->nChild = 0;
						nodoPar->tipo = NODO_CTE;
					}
				} 
			}
		}
	}
}

nodo* checkPartialF(nodo *nodoFun, char *nVar)
{
	char *nombreParFun;
	nodo *nodoPar;
	int i, iParFun;

	nombreParFun = strdup(nodoFun->lex);
	strcat(nombreParFun, "P");
	strcat(nombreParFun, nVar);

	iParFun = TS_BuscarFUNModo(nombreParFun, 0);

	if (iParFun == -1) {
		atributos attParFun;
		int iFun;

		iFun = TS_BuscarFUN(nodoFun->lex);

		if (iFun == -1) {
			printf("No existe la función: %s\n", nodoFun->lex);

			return NULL;
		}

		nodo *nodoFunExpr = TS[iFun].nodoExpr;

		attParFun.lex = nombreParFun;
		attParFun.tipo = TS[iFun].tipo;

		TS_InsertaFUN(attParFun);
		iParFun = TS_BuscarFUN(nombreParFun);

		TS[iParFun].dimension = TS[iFun].dimension;
		TS[iParFun].tam = TS[iFun].tam;
		TS[iParFun].nParam = TS[iFun].nParam;
		TS[iParFun].tipo = TS[iFun].tipo;

		for (i = 0; i <  TS[iFun].nParam; i++) {
			TS_InsertaEntrada(TS[iFun + i + 1]);
		}

		nodo *nodoParExpr = partialExpr(nodoFunExpr, nVar);
		simplifyPartial(nodoParExpr);

		escribeFun(nombreParFun, nodoParExpr);
	}

	nodoPar = malloc(sizeof(nodo));
	nodoPar->tipo = nodoFun->tipo;
	nodoPar->subTipo = nodoFun->subTipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = nombreParFun;

	for (i = 0; i < nodoFun->nChild; i++) {
		nodoPar->children[i] = nodoFun->children[i];
	}

	return nodoPar;
}

nodo* partialNodoFun(nodo *nodoFun, char *nVar)
{
	nodo *nodoPar;

	int i, iParFun;
	int esArray = 	strcmp(nodoFun->lex, "vec2") == 0 ||
					strcmp(nodoFun->lex, "vec3") == 0 ||
					strcmp(nodoFun->lex, "mat2") == 0 ||
					strcmp(nodoFun->lex, "mat3") == 0;

	int esPredef = 	strcmp(nodoFun->lex, "log") == 0 ||
					strcmp(nodoFun->lex, "sin") == 0 ||
					strcmp(nodoFun->lex, "cos") == 0 ||
					strcmp(nodoFun->lex, "tg") == 0 ||
					strcmp(nodoFun->lex, "atan") == 0;
	
	if (esArray) {
		nodoPar = malloc(sizeof(nodo));
		nodoPar->tipo = nodoFun->tipo;
		nodoPar->subTipo = nodoFun->subTipo;
		nodoPar->nChild = nodoFun->nChild;
		nodoPar->lex = strdup(nodoFun->lex);

		for (i = 0; i < nodoFun->nChild; i++) {
			nodoPar->children[i] = crearNodoParentesis(partialExpr(nodoFun->children[i], nVar));
		}

	} else {
		if (esPredef) {
			nodo *nodoIzq;

			if (strcmp(nodoFun->lex, "log") == 0) {
				nodoIzq = derivLog(nodoFun);
			} else if (strcmp(nodoFun->lex, "sin") == 0) {
				nodoIzq = derivSin(nodoFun);
			} else if (strcmp(nodoFun->lex, "cos") == 0) {
				nodoIzq = derivCos(nodoFun);
			} else if (strcmp(nodoFun->lex, "tg") == 0) {
				nodoIzq = derivTg(nodoFun);
			} else if (strcmp(nodoFun->lex, "atan") == 0) {
				nodoIzq = derivAtan(nodoFun);
			}

			nodoPar = crearNodoOpBin(nodoIzq, "*", crearNodoParentesis(partialExpr(nodoFun->children[0], nVar)));
		
		} else {
			int iFun;
			nodo *nodoExprFun;

			iFun = TS_BuscarFUN(nodoFun->lex);

			if (iFun == -1) {
				printf("No existe la función: %s", nodoFun->lex);

				return NULL;
			}

			nodo *nodoHijo1 = checkPartialF(nodoFun, TS[iFun + 1].lex);
			nodo *nodoHijo2 = crearNodoParentesis(partialExpr(nodoFun->children[0], nVar));
			nodo *nodoSum, *nodoMul;

			nodoMul = crearNodoOpBin(nodoHijo1, "*", nodoHijo2);

			if (nodoFun->nChild > 1) {
				nodoHijo1 = checkPartialF(nodoFun, TS[iFun + 2].lex);
				nodoHijo2 = crearNodoParentesis(partialExpr(nodoFun->children[1], nVar));
				nodoSum = crearNodoOpBin(nodoMul, "+", crearNodoOpBin(nodoHijo1, "*", nodoHijo2));
			} else {
				nodoSum = nodoMul;
			}

			for (i = 2; i < nodoFun->nChild; i++) {
				nodoHijo1 = checkPartialF(nodoFun, TS[iFun + i + 1].lex);
				nodoHijo2 = crearNodoParentesis(partialExpr(nodoFun->children[i], nVar));
				nodoMul = crearNodoOpBin(nodoHijo1, "*", nodoHijo2);
				nodoSum = crearNodoOpBin(nodoSum, "+", nodoMul);
			}

			nodoPar = nodoSum;
			nodoPar->subTipo = nodoFun->subTipo;
		}
	}

	return nodoPar;
}


nodo* partialNodoInd(nodo *nodoFun, char *nVar)
{
	nodo *nodoPar = malloc(sizeof(nodo));

	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = strdup(nodoFun->lex);
	nodoPar->children[0] = addNodoArray(partialExpr(nodoFun->children[0], nVar), nodoFun->subTipo);
	nodoPar->children[1] = nodoFun->children[1];
	nodoPar->subTipo = nodoFun->subTipo;
}

nodo* partialNodoParen(nodo *nodoFun, char *nVar)
{
	return crearNodoParentesis(partialExpr(nodoFun->children[0], nVar));
}

nodo* partialExpr(nodo *nodoFun, char *nVar)
{
	nodo *nodoPar;
	int i = 0;
	
	if (nodoFun->nChild == 0){
		nodoPar = crearNodoTipo("0", NODO_CTE, 0);

		if (strcmp(nVar, nodoFun->lex) == 0){
			nodoPar->lex = strdup("1");
		}

	} else if (nodoFun->tipo == NODO_OP){
		if (nodoFun->nChild == 1) {
			if (strcmp("-", nodoFun->lex) == 0){
				nodoPar = partialNodoMenos(nodoFun, nVar);
			}
		}
		if (nodoFun->nChild == 2) {
			if (strcmp("+", nodoFun->lex) == 0 || strcmp("-", nodoFun->lex) == 0){
				nodoPar = partialNodoSum(nodoFun, nVar);
			} else if (strcmp("*", nodoFun->lex) == 0){
				nodoPar = partialNodoMul(nodoFun, nVar);
			} else if (strcmp("/", nodoFun->lex) == 0){
				nodoPar = partialNodoDiv(nodoFun, nVar);
			} else if (strcmp("^", nodoFun->lex) == 0){
				nodoPar = partialNodoExp(nodoFun, nVar);
			}
		}
	} else if (nodoFun->tipo == NODO_IF){
		nodoPar = partialNodoIf(nodoFun, nVar);
	} else if (nodoFun->tipo == NODO_FUN){
		nodoPar = partialNodoFun(nodoFun, nVar);
	} else if (nodoFun->tipo == NODO_IND){
		nodoPar = partialNodoInd(nodoFun, nVar);
	} else if (nodoFun->tipo == NODO_PAREN){
		nodoPar = partialNodoParen(nodoFun, nVar);
	}

	return crearNodoParentesis(nodoPar);
}

void escribeNorm(atributos fun, atributos e1){
				
	if (e1.dimension == 1 && e1.tam == 3) {
		int indexFun, indexNorm, i;
		char *nVarU = "u";
		char *nVarV = "v";

		indexFun = TS_BuscarFUN(fun.lex);

		if (indexFun == -1) {
			return;
		}

		nodo *nodoFun = crearNodoTipo(fun.lex, NODO_FUN, 0);
		
		nodoFun->nChild = TS[indexFun].nParam;

		for (i = 0; i < TS[indexFun].nParam; i++){
			nodoFun->children[i] = crearNodoTipo(strdup(TS[indexFun + i + 1].lex), NODO_VAR, 0);
		}

		nodo *nodoParU = checkPartialF(nodoFun, nVarU);
		nodo *nodoParV = checkPartialF(nodoFun, nVarV);


		atributos attNorm;

		attNorm.lex = strdup(fun.lex);
		strcat(attNorm.lex, "Normal");
		attNorm.tipo = fun.tipo;

		TS_InsertaFUN(attNorm);
		indexNorm = TS_BuscarFUN(attNorm.lex);

		TS[indexNorm].dimension = TS[indexFun].dimension;
		TS[indexNorm].tam = TS[indexFun].tam;
		TS[indexNorm].nParam = TS[indexFun].nParam;
		TS[indexNorm].tipo = TS[indexFun].tipo;

		for (i = 0; i <  TS[indexFun].nParam; i++) {
			TS_InsertaEntrada(TS[indexFun + i + 1]);
		}

		escribeFun(attNorm.lex, crearNodoNormal(nodoParU, nodoParV));
	}		
}

void escribeArea(atributos fun, atributos e1){
				
	if (e1.dimension == 1 && e1.tam == 3) {
		int indexFun, indexArea, i;
		char *nVarU = "u";
		char *nVarV = "v";

		indexFun = TS_BuscarFUN(fun.lex);

		if (indexFun == -1) {
			return;
		}

		nodo *nodoFun = crearNodoTipo(fun.lex, NODO_FUN, 0);
		
		nodoFun->nChild = TS[indexFun].nParam;

		for (i = 0; i < TS[indexFun].nParam; i++){
			nodoFun->children[i] = crearNodoTipo(strdup(TS[indexFun + i + 1].lex), NODO_VAR, 0);
		}

		nodo *nodoParU = checkPartialF(nodoFun, nVarU);
		nodo *nodoParV = checkPartialF(nodoFun, nVarV);


		atributos attArea;

		attArea.lex = strdup(fun.lex);
		strcat(attArea.lex, "Area");
		attArea.tipo = REAL;

		TS_InsertaFUN(attArea);
		indexArea = TS_BuscarFUN(attArea.lex);

		TS[indexArea].dimension = TS[indexFun].dimension;
		TS[indexArea].tam = TS[indexFun].tam;
		TS[indexArea].nParam = TS[indexFun].nParam;
		TS[indexArea].tipo = REAL;

		for (i = 0; i <  TS[indexFun].nParam; i++) {
			TS_InsertaEntrada(TS[indexFun + i + 1]);
		}

		escribeFun(attArea.lex, crearNodoArea(nodoParU, nodoParV));
	}		
}

void escribeK(atributos fun, atributos e1){
				
	if (e1.dimension == 1 && e1.tam == 3) {
		int indexFun, indexArea, i;
		char *nVarU = "u";
		char *nVarV = "v";

		indexFun = TS_BuscarFUN(fun.lex);

		if (indexFun == -1) {
			return;
		}

		nodo *nodoFun = crearNodoTipo(fun.lex, NODO_FUN, 0);
		
		nodoFun->nChild = TS[indexFun].nParam;

		for (i = 0; i < TS[indexFun].nParam; i++){
			nodoFun->children[i] = crearNodoTipo(strdup(TS[indexFun + i + 1].lex), NODO_VAR, 0);
		}

		nodo *nodoParU = checkPartialF(nodoFun, nVarU);
		nodo *nodoParV = checkPartialF(nodoFun, nVarV);


		atributos attArea;

		attArea.lex = strdup(fun.lex);
		strcat(attArea.lex, "K");
		attArea.tipo = REAL;

		TS_InsertaFUN(attArea);
		indexArea = TS_BuscarFUN(attArea.lex);

		TS[indexArea].dimension = TS[indexFun].dimension;
		TS[indexArea].tam = TS[indexFun].tam;
		TS[indexArea].nParam = TS[indexFun].nParam;
		TS[indexArea].tipo = REAL;

		for (i = 0; i <  TS[indexFun].nParam; i++) {
			TS_InsertaEntrada(TS[indexFun + i + 1]);
		}

		escribeFun(attArea.lex, crearNodoK(nodoParU, nodoParV));
	}		
}

void escribeVal(char *id, nodo *expr){
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
	
    escribeExpr(sent, expr);
    sprintf(sent,"%s;\n\n", sent);
    
  	fputs(sent,file);
  	free(sent);
  	
}

void escribeIfPlot(char *sent, entradaTS fun){
	int i = 2;

    sprintf(sent,"%sif (funPlot==%d) {\n\t\t", sent, nPlot);
    sprintf(sent,"%sreturn %s(p.x, p.y", sent, fun.lex);
    
    while(i<fun.nParam){
    	sprintf(sent,"%s, param_t[%d]", sent, i-2);
    	i++;
    }

	if (fun.nParam > totalParam)
		totalParam = fun.nParam;
	
	sprintf(sent,"%s);\n\t}", sent);
	  	
}

void escribeIniPlot(char *fun){
	int indexFun, indexNormal, indexArea, indexK, i;
	char *sent, *normal, *area, *curvature;
	
	normal = strcat(strdup(fun), "Normal");
	area = strcat(strdup(fun), "Area");
	curvature = strcat(strdup(fun), "K");

  	sent = (char *) malloc(1000);
  	sent[0]=0;
  	
  	indexFun = TS_BuscarFUN(fun);
  	indexNormal = TS_BuscarFUN(normal);
  	indexArea = TS_BuscarFUN(area);
  	indexK = TS_BuscarFUN(curvature);

  	nPlot = 0;
  	i = 1;
  	
  	if (indexFun == -1 || indexNormal == -1 || indexArea == -1 || indexK == -1) {
  		return;
  	}
  	
    escribeIfPlot(sent, TS[indexFun]);

	sFunParam = (char *) malloc(1000);
  	sFunParam[0]=0;
	sprintf(sFunParam,"vec3 functionParam(vec2 p) {\n\t%s", sent);

	free(sent);
	sent = (char *) malloc(1000);
  	sent[0]=0;

    escribeIfPlot(sent, TS[indexNormal]);

	sNormalParam = (char *) malloc(1000);
  	sNormalParam[0]=0;
	sprintf(sNormalParam,"vec3 normalParam(vec2 p) {\n\t%s", sent);

	free(sent);
	sent = (char *) malloc(1000);
  	sent[0]=0;

    escribeIfPlot(sent, TS[indexArea]);

	sAreaParam = (char *) malloc(1000);
  	sAreaParam[0]=0;
	sprintf(sAreaParam,"float areaParam(vec2 p) {\n\t%s", sent);

	free(sent);
	sent = (char *) malloc(1000);
  	sent[0]=0;

    escribeIfPlot(sent, TS[indexK]);

	sKParam = (char *) malloc(1000);
  	sKParam[0]=0;
	sprintf(sKParam,"float curvatureParam(vec2 p) {\n\t%s", sent);
    
	nPlot++;

  	free(sent);
}

void escribeContPlot(char *fun){
	int indexFun, indexNormal, indexArea, indexK, i;
	char *sent, *normal, *area, *curvature;

	normal = strcat(strdup(fun), "Normal");
	area = strcat(strdup(fun), "Area");
	curvature = strcat(strdup(fun), "K");
	
  	sent = (char *) malloc(1000);
  	sent[0]=0;

  	indexFun = TS_BuscarFUN(fun);
  	indexNormal = TS_BuscarFUN(normal);
  	indexArea = TS_BuscarFUN(area);
  	indexK = TS_BuscarFUN(curvature);
  	
  	if (indexFun == -1 || indexNormal == -1 || indexArea == -1 || indexK == -1) {
  		return;
  	}
  	
  	i = 1;
  	
    sprintf(sFunParam,"%s else ", sFunParam);
    escribeIfPlot(sFunParam, TS[indexFun]);

    sprintf(sNormalParam,"%s else ", sNormalParam);
    escribeIfPlot(sNormalParam, TS[indexNormal]);

    sprintf(sAreaParam,"%s else ", sAreaParam);
    escribeIfPlot(sAreaParam, TS[indexArea]);

    sprintf(sKParam,"%s else ", sKParam);
    escribeIfPlot(sKParam, TS[indexK]);

	nPlot++;

  	free(sent);
}

void escribeFinPlot(){
	FILE *temp_file = fopen("../temp","w");
	char *sent;

	sent = (char *) malloc(1000);
	sent[0]=0;

	sprintf(sent,"%d\n", nPlot);
	sprintf(sent,"%s%d", sent, totalParam-2);

	fputs(sent,temp_file);
	free(sent);
	fclose(temp_file);

	sprintf(sFunParam,"%s\n\n\treturn vec3(0.0, 0.0, 0.0);\n}\n\n", sFunParam);
	sprintf(sNormalParam,"%s\n\n\treturn vec3(0.0, 0.0, 0.0);\n}\n\n", sNormalParam);
	sprintf(sAreaParam,"%s\n\n\treturn 0.0;\n}\n\n", sAreaParam);
	sprintf(sKParam,"%s\n\n\treturn 0.0;\n}\n\n", sKParam);

	fputs(sFunParam,file);
	fputs(sNormalParam,file);
	fputs(sAreaParam,file);
	fputs(sKParam,file);

	free(sFunParam);
	free(sNormalParam);
	free(sAreaParam);
	free(sKParam);
}