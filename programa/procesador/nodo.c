#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "nodo.h"


FILE * file;
int nPlot=0;
int totalParam=0;


nodo* crearNodo(char *nombre){
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup(nombre);
	nodoActual->nChild = 0;
	
	return nodoActual;
}

nodo* crearNodoTipo(char *nombre, tipoNodo tipo) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup(nombre);
	nodoActual->nChild = 0;
	nodoActual->tipo = tipo;
	
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
	
	return nodoActual;
}

nodo* crearNodoIndex(atributos array, nodo *ind) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup("[]");
	nodoActual->nChild = 2;
	nodoActual->children[0] = array.nodoPropio;
	nodoActual->children[1] = ind;
	nodoActual->tipo = NODO_IND;

	if (array.dimension == 1){
		if (array.tam == 2) {
			nodoActual->subTipo = NODO_IND_VEC2;
		} else {
			nodoActual->subTipo = NODO_IND_VEC3;
		}
	} else {
		if (array.tam == 2) {
			nodoActual->subTipo = NODO_IND_MAT2;
		} else {
			nodoActual->subTipo = NODO_IND_MAT3;
		}
	}
	return nodoActual;
}

nodo* crearNodoParentesis(nodo *expr) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup("()");
	nodoActual->nChild = 1;
	nodoActual->children[0] = expr;
	nodoActual->tipo = NODO_PAREN;
	
	return nodoActual;
}

nodo* crearNodoOpUn(char *op, nodo *expr) {
	nodo *nodoActual = crearNodo(op);
	
	nodoActual->nChild = 1;
	nodoActual->children[0] = expr;
	nodoActual->tipo = NODO_OP;
	
	return nodoActual;
}

nodo* crearNodoOpBin(nodo *expr1, char *op, nodo *expr2) {
	nodo *nodoActual = crearNodo(op);
	
	nodoActual->nChild = 2;
	nodoActual->children[0] = expr1;
	nodoActual->children[1] = expr2;
	nodoActual->tipo = NODO_OP;
	
	return nodoActual;
}

nodo* crearNodoNormal(nodo *parU, nodo *parV) {
	nodo *nodoActual, *nodoCross;
	
	nodoCross = crearNodoTipo(strdup("cross"), NODO_FUN);
	nodoCross->nChild = 2;
	nodoCross->children[0] = parU;
	nodoCross->children[1] = parV;

	nodoActual = crearNodoTipo(strdup("normalize"), NODO_FUN);
	nodoActual->nChild = 1;
	nodoActual->children[0] = nodoCross;
	
	return nodoActual;
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
	char * sent;
	
  	sent = (char *) malloc(1000);
  	sent[0]=0;
  	
    file = fopen("../shaders/vertex.s","w");
  	
    sprintf(sent,"#version 440 core\n");
    sprintf(sent,"%slayout (location = 0) in vec2 aPos;\n\n", sent);
    sprintf(sent,"%sout vData {vec3 FragPos; vec3 Normal;} vertex;\n\n", sent);
    sprintf(sent,"%suniform mat4 model;\n", sent);
    sprintf(sent,"%suniform mat4 view;\n", sent);
    sprintf(sent,"%suniform mat4 projection;\n", sent);
    sprintf(sent,"%suniform float param_t[%d];\n", sent, LIMIT_FUN);
    sprintf(sent,"%suniform int funPlot;\n\n", sent);
    
  	fputs(sent,file);
  	free(sent);	
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

nodo* addParen(nodo *n) {
	nodo *nodoParen = malloc(sizeof(nodo));

	nodoParen->tipo = NODO_PAREN;
	nodoParen->nChild = 1;
	nodoParen->lex = strdup("()");
	nodoParen->children[0] = n;

	return nodoParen;
}

nodo* addNodoArray(nodo *n, tipoNodoInd subTipo) {
	nodo *nodoArray = malloc(sizeof(nodo));

	nodoArray->tipo = NODO_FUN;
	nodoArray->nChild = 1;

	if (subTipo == NODO_IND_VEC2){
		nodoArray->lex = strdup("vec2");
	} else if (subTipo == NODO_IND_VEC3){
		nodoArray->lex = strdup("vec3");
	} else if (subTipo == NODO_IND_MAT2){
		nodoArray->lex = strdup("mat2");
	} else if (subTipo == NODO_IND_MAT2){
		nodoArray->lex = strdup("mat3");
	} else {
		printf("Error, el nodo de índice para array no tiene subtipo.\n");
		
		return NULL;
	}

	nodoArray->children[0] = n;

	return nodoArray;
}

void partialNodoSum(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = strdup(nodoFun->lex);
	nodoPar->children[0] = partialExpr(nodoFun->children[0], nVar);
	nodoPar->children[1] = partialExpr(nodoFun->children[1], nVar);
}

void partialNodoMenos(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = strdup(nodoFun->lex);
	nodoPar->children[0] = partialExpr(nodoFun->children[0], nVar);
}

void partialNodoMul(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	nodo *nodoIzq = malloc(sizeof(nodo));
	nodo *nodoDer = malloc(sizeof(nodo));
	nodo *nodoSum = malloc(sizeof(nodo));

	nodoIzq->tipo = nodoFun->tipo;
	nodoIzq->nChild = nodoFun->nChild;
	nodoIzq->lex = strdup("*");
	nodoIzq->children[0] = partialExpr(nodoFun->children[0], nVar);
	nodoIzq->children[1] = nodoFun->children[1];

	nodoDer->tipo = nodoFun->tipo;
	nodoDer->nChild = nodoFun->nChild;
	nodoDer->lex = strdup("*");
	nodoDer->children[0] = nodoFun->children[0];
	nodoDer->children[1] = partialExpr(nodoFun->children[1], nVar);

	nodoSum->tipo = nodoFun->tipo;
	nodoSum->nChild = nodoFun->nChild;
	nodoSum->lex = strdup("+");
	nodoSum->children[0] = nodoIzq;
	nodoSum->children[1] = nodoDer;

	nodoPar->tipo = NODO_PAREN;
	nodoPar->nChild = 1;
	nodoPar->lex = strdup("()");
	nodoPar->children[0] = nodoSum;

}

void partialNodoDiv(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	nodo *nodoIzq = malloc(sizeof(nodo));
	nodo *nodoDer = malloc(sizeof(nodo));
	nodo *nodoNum = malloc(sizeof(nodo));
	nodo *nodoDen = malloc(sizeof(nodo));

	nodoIzq->tipo = nodoFun->tipo;
	nodoIzq->nChild = nodoFun->nChild;
	nodoIzq->lex = strdup("/");
	nodoIzq->children[0] = partialExpr(nodoFun->children[0], nVar);
	nodoIzq->children[1] = nodoFun->children[1];

	nodoNum->tipo = nodoFun->tipo;
	nodoNum->nChild = nodoFun->nChild;
	nodoNum->lex = strdup("*");
	nodoNum->children[0] = nodoFun->children[0];
	nodoNum->children[1] = partialExpr(nodoFun->children[1], nVar);

	nodoDen->tipo = nodoFun->tipo;
	nodoDen->nChild = nodoFun->nChild;
	nodoDen->lex = strdup("*");
	nodoDen->children[0] = nodoFun->children[1];
	nodoDen->children[1] = nodoFun->children[1];

	nodoDer->tipo = nodoFun->tipo;
	nodoDer->nChild = nodoFun->nChild;
	nodoDer->lex = strdup("/");
	nodoDer->children[0] = nodoNum;
	nodoDer->children[1] = addParen(nodoDen);

	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = strdup("-");
	nodoPar->children[0] = nodoIzq;
	nodoPar->children[1] = nodoDer;
}

void partialNodoExp(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	nodo *nodoExp, *nodoLn, *nodoPotencia, *nodoPotenciaDer;


	if (nodoFun->children[1]->tipo != NODO_CTE){	
		if (strcmp(nodoFun->children[0]->lex, "E") == 0) {
			nodoExp = nodoFun->children[1];
		} else {
			nodoLn = malloc(sizeof(nodo));
			nodoLn->tipo = NODO_FUN;
			nodoLn->nChild = 1;
			nodoLn->lex = strdup("log");
			nodoLn->children[0] = nodoFun->children[0];

			nodoExp = malloc(sizeof(nodo));
			nodoExp->tipo = nodoFun->tipo;
			nodoExp->nChild = nodoFun->nChild;
			nodoExp->lex = strdup("*");
			nodoExp->children[0] = nodoFun->children[1];
			nodoExp->children[1] = nodoLn;
		}

		nodoPar->tipo = nodoFun->tipo;
		nodoPar->nChild = 2;
		nodoPar->lex = strdup("*");
		nodoPar->children[0] = nodoFun;
		nodoPar->children[1] = addParen(partialExpr(nodoExp, nVar));
	} else {
		if (strcmp(nodoFun->children[1]->lex, "0") == 0){
			nodoPar->tipo = NODO_CTE;
			nodoPar->nChild = 0;
			nodoPar->lex = strdup("0");
		} else {
			char *nExp;
			nExp = (char *) malloc(100);
			nExp[0]=0;

			nodoPotencia = malloc(sizeof(nodo));
			nodoPotencia->tipo = NODO_OP;
			nodoPotencia->nChild = 2;
			nodoPotencia->lex = strdup("^");
			nodoPotencia->children[0] = nodoFun->children[0];

			sprintf(nExp, "%f", atof(nodoFun->children[1]->lex)-1);
			nodoPotencia->children[1] = crearNodoTipo(nExp, NODO_CTE);

			nodoPotenciaDer = malloc(sizeof(nodo));
			nodoPotenciaDer->tipo = NODO_OP;
			nodoPotenciaDer->nChild = 2;
			nodoPotenciaDer->lex = strdup("*");
			nodoPotenciaDer->children[0] = crearNodoTipo(nodoFun->children[1]->lex, NODO_CTE);
			nodoPotenciaDer->children[1] = nodoPotencia;

			nodoPar->tipo = NODO_OP;
			nodoPar->nChild = 2;
			nodoPar->lex = strdup("*");
			nodoPar->children[0] = partialExpr(nodoFun->children[0], nVar);
			nodoPar->children[1] = nodoPotenciaDer;
		}
	}

	
}

void partialNodoIf(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = strdup(nodoFun->lex);
	nodoPar->children[0] = nodoFun->children[0];
	nodoPar->children[1] = partialExpr(nodoFun->children[1], nVar);
	nodoPar->children[2] = partialExpr(nodoFun->children[2], nVar);
}

void derivLog(nodo *nodoFun, nodo *nodoPar)
{
	nodo *nodoNum = malloc(sizeof(nodo));

	nodoNum->tipo = NODO_CTE;
	nodoNum->nChild = 0;
	nodoNum->lex = strdup("1");

	nodoPar->tipo = NODO_OP;
	nodoPar->nChild = 2;
	nodoPar->lex = strdup("/");
	nodoPar->children[0] = nodoNum;
	nodoPar->children[1] = nodoFun->children[0];
}

void derivSin(nodo *nodoFun, nodo *nodoPar)
{
	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = strdup("cos");
	nodoPar->children[0] = nodoFun->children[0];
}

void derivCos(nodo *nodoFun, nodo *nodoPar)
{
	nodo *nodoSin = malloc(sizeof(nodo));
	nodo *nodoSum = malloc(sizeof(nodo));

	nodoSin->tipo = nodoFun->tipo;
	nodoSin->nChild = nodoFun->nChild;
	nodoSin->lex = strdup("sin");
	nodoSin->children[0] = nodoFun->children[0];

	nodoSum->tipo = NODO_OP;
	nodoSum->nChild = 1;
	nodoSum->lex = strdup("-");
	nodoSum->children[0] = nodoSin;

	nodoPar->tipo = NODO_PAREN;
	nodoPar->nChild = 1;
	nodoPar->lex = strdup("()");
	nodoPar->children[0] = nodoSum;
}

void derivTg(nodo *nodoFun, nodo *nodoPar)
{
	nodo *nodoCos, *nodoNum, *nodoDen;

	nodoCos = malloc(sizeof(nodo));
	nodoCos->tipo = nodoFun->tipo;
	nodoCos->nChild = nodoFun->nChild;
	nodoCos->lex = strdup("cos");
	nodoCos->children[0] = nodoFun->children[0];

	nodoNum = malloc(sizeof(nodo));
	nodoNum->tipo = NODO_CTE;
	nodoDen->nChild = 0;
	nodoDen->lex = strdup("1");

	nodoDen = malloc(sizeof(nodo));
	nodoDen->tipo = NODO_OP;
	nodoDen->nChild = 2;
	nodoDen->lex = strdup("*");
	nodoDen->children[0] = nodoCos;
	nodoDen->children[1] = nodoCos;

	nodoPar->tipo = NODO_OP;
	nodoPar->nChild = 2;
	nodoPar->lex = strdup("/");
	nodoPar->children[0] = nodoNum;
	nodoPar->children[1] = nodoDen;
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
							isZero = 1;
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
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = nombreParFun;

	for (i = 0; i < nodoFun->nChild; i++) {
		nodoPar->children[i] = nodoFun->children[i];
	}

	return nodoPar;
}

void partialNodoFun(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	int i, iParFun;
	int esArray = 	strcmp(nodoFun->lex, "vec2") == 0 ||
					strcmp(nodoFun->lex, "vec3") == 0 ||
					strcmp(nodoFun->lex, "mat2") == 0 ||
					strcmp(nodoFun->lex, "mat3") == 0;

	int esPredef = 	strcmp(nodoFun->lex, "log") == 0 ||
					strcmp(nodoFun->lex, "sin") == 0 ||
					strcmp(nodoFun->lex, "cos") == 0 ||
					strcmp(nodoFun->lex, "tg") == 0;
	
	if (esArray) {
		nodoPar->tipo = nodoFun->tipo;
		nodoPar->nChild = nodoFun->nChild;
		nodoPar->lex = strdup(nodoFun->lex);

		for (i = 0; i < nodoFun->nChild; i++) {
			nodoPar->children[i] = addParen(partialExpr(nodoFun->children[i], nVar));
		}
	} else {
		if (esPredef) {
			nodo *nodoIzq = malloc(sizeof(nodo));

			if (strcmp(nodoFun->lex, "log") == 0) {
				derivLog(nodoFun, nodoIzq);
			} else if (strcmp(nodoFun->lex, "sin") == 0) {
				derivSin(nodoFun, nodoIzq);
			} else if (strcmp(nodoFun->lex, "cos") == 0) {
				derivCos(nodoFun, nodoIzq);
			} else if (strcmp(nodoFun->lex, "tg") == 0) {
				derivTg(nodoFun, nodoIzq);
			}

			nodoPar->tipo = NODO_OP;
			nodoPar->nChild = 2;
			nodoPar->lex = strdup("*");
			nodoPar->children[0] = nodoIzq;
			nodoPar->children[1] = addParen(partialExpr(nodoFun->children[0], nVar));
		} else {
			int iFun;
			nodo *nodoExprFun;

			iFun = TS_BuscarFUN(nodoFun->lex);

			if (iFun == -1) {
				printf("No existe la función: %s", nodoFun->lex);

				return;
			}

			nodo *nodoSum;
			
			nodo *nodoMul0 = malloc(sizeof(nodo));
			nodoMul0->tipo = NODO_OP;
			nodoMul0->nChild = 2;
			nodoMul0->lex = strdup("*");
			nodoMul0->children[0] = checkPartialF(nodoFun, TS[iFun + 1].lex);
			nodoMul0->children[1] = addParen(partialExpr(nodoFun->children[0], nVar));

			if (nodoFun->nChild > 1) {
				nodo *nodoMul1 = malloc(sizeof(nodo));
				nodoMul1->tipo = NODO_OP;
				nodoMul1->nChild = 2;
				nodoMul1->lex = strdup("*");
				nodoMul1->children[0] = checkPartialF(nodoFun, TS[iFun + 2].lex);
				nodoMul1->children[1] = addParen(partialExpr(nodoFun->children[1], nVar));

				nodoSum = malloc(sizeof(nodo));
				nodoSum->tipo = NODO_OP;
				nodoSum->nChild = 2;
				nodoSum->lex = strdup("+");
				nodoSum->children[0] = nodoMul0;
				nodoSum->children[1] = nodoMul1;
			} else {
				nodoSum = nodoMul0;
			}

			for (i = 2; i < nodoFun->nChild; i++) {
				nodo *nodoMul = malloc(sizeof(nodo));
				nodoMul->tipo = NODO_OP;
				nodoMul->nChild = 2;
				nodoMul->lex = strdup("*");
				nodoMul->children[0] = checkPartialF(nodoFun, TS[iFun + i + 1].lex);
				nodoMul->children[1] = addParen(partialExpr(nodoFun->children[i], nVar));

				nodo *nodoNewSum = malloc(sizeof(nodo));
				nodoNewSum->tipo = NODO_OP;
				nodoNewSum->nChild = 2;
				nodoNewSum->lex = strdup("+");
				nodoNewSum->children[0] = nodoSum;
				nodoNewSum->children[1] = nodoMul;
				nodoSum = nodoNewSum;
			}

			nodoPar->tipo = nodoSum->tipo;
			nodoPar->nChild = nodoSum->nChild;
			nodoPar->lex = nodoSum->lex;

			for (i = 0; i < nodoSum->nChild; i++) {
				nodoPar->children[i] = nodoSum->children[i];
			}
		}
	}
}


void partialNodoInd(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = strdup(nodoFun->lex);
	nodoPar->children[0] = addNodoArray(partialExpr(nodoFun->children[0], nVar), nodoFun->subTipo);
	nodoPar->children[1] = nodoFun->children[1];
	nodoPar->subTipo = nodoFun->subTipo;
}

void partialNodoParen(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = strdup(nodoFun->lex);
	nodoPar->children[0] = partialExpr(nodoFun->children[0], nVar);
}

nodo* partialExpr(nodo *nodoFun, char *nVar)
{
	nodo *nodoPar = malloc(sizeof(nodo));
	int i = 0;

	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = strdup(nodoFun->lex);

	for (i = 0; i < nodoFun->nChild; i++) {
		nodoPar->children[i] = nodoFun->children[i];
	}
	
	if (nodoFun->nChild == 0){
		if (strcmp(nVar, nodoFun->lex) == 0){
			nodoPar->lex = strdup("1");
		} else {
			nodoPar->lex = strdup("0");
		}

		nodoPar->tipo = NODO_CTE;
		nodoPar->nChild = 0;
	} else if (nodoFun->tipo == NODO_OP){
		if (nodoFun->nChild == 1) {
			if (strcmp("-", nodoFun->lex) == 0){
				partialNodoMenos(nodoFun, nodoPar, nVar);
			}
		}
		if (nodoFun->nChild == 2) {
			if (strcmp("+", nodoFun->lex) == 0 || strcmp("-", nodoFun->lex) == 0){
				partialNodoSum(nodoFun, nodoPar, nVar);
			} else if (strcmp("*", nodoFun->lex) == 0){
				partialNodoMul(nodoFun, nodoPar, nVar);
			} else if (strcmp("/", nodoFun->lex) == 0){
				partialNodoDiv(nodoFun, nodoPar, nVar);
			} else if (strcmp("^", nodoFun->lex) == 0){
				partialNodoExp(nodoFun, nodoPar, nVar);
			}
		}
	} else if (nodoFun->tipo == NODO_IF){
		partialNodoIf(nodoFun, nodoPar, nVar);
	} else if (nodoFun->tipo == NODO_FUN){
		partialNodoFun(nodoFun, nodoPar, nVar);
	} else if (nodoFun->tipo == NODO_IND){
		partialNodoInd(nodoFun, nodoPar, nVar);
	} else if (nodoFun->tipo == NODO_PAREN){
		partialNodoParen(nodoFun, nodoPar, nVar);
	}

	return addParen(nodoPar);
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

		nodo *nodoFun = crearNodoTipo(fun.lex, NODO_FUN);
		
		nodoFun->nChild = TS[indexFun].nParam;

		for (i = 0; i < TS[indexFun].nParam; i++){
			nodoFun->children[i] = crearNodoTipo(strdup(TS[indexFun + i + 1].lex), NODO_VAR);
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

	// Para el vértice
    sprintf(sent,"%sif (funPlot==%d) {\n\t\t", sent, nPlot);
    sprintf(sent,"%saPosSurf = %s(aPos.x, aPos.y", sent, fun.lex);
    nPlot++;
    
    while(i<fun.nParam){
    	sprintf(sent,"%s, param_t[%d]", sent, i-2);
    	i++;
    }

	if (fun.nParam > totalParam)
		totalParam = fun.nParam;
    
	sprintf(sent,"%s);\n\t\t", sent);

	// Para la normal
	i = 2;
    sprintf(sent,"%saNormSurf = %sNormal(aPos.x, aPos.y", sent, fun.lex);

	while(i<fun.nParam){
    	sprintf(sent,"%s, param_t[%d]", sent, i-2);
    	i++;
    }

	if (fun.nParam > totalParam)
		totalParam = fun.nParam;
	
	sprintf(sent,"%s);\n\t}", sent);
	  	
}

void escribeIniPlot(char *fun){
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
  	
    sprintf(sent,"void main() {\n\tvec3 aPosSurf, aNormSurf;\n\n\t");
    escribeIfPlot(sent, TS[indexFun]);
    
  	fputs(sent,file);
  	free(sent);
  	
}

void escribeContPlot(char *fun){
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
	char *sent, *sent_temp;
	
  	sent = (char *) malloc(1000);
  	sent_temp = (char *) malloc(1000);

  	sent[0]=0;
  	sent_temp[0]=0;
  	
    FILE *temp_file = fopen("../temp","w");
  	
    sprintf(sent,"\n\n\tvertex.FragPos = vec3(vec4(aPosSurf, 1.0));"); // model *
    sprintf(sent,"%s\n\tvertex.Normal = aNormSurf;", sent);
    sprintf(sent,"%s\n\tgl_Position = vec4(aPosSurf, 1.0);\n}", sent); // projection * view * model *

  	fputs(sent,file);
  	free(sent);

	sprintf(sent_temp,"%d\n", nPlot);
	sprintf(sent_temp,"%s%d", sent_temp, totalParam-2);

	fputs(sent_temp,temp_file);
  	free(sent_temp);
    fclose(temp_file);
}