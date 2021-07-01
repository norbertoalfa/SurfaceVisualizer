#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "nodo.h"


FILE * file;
int nPlot=0;
int totalParam=0;


nodo* crearNodo(atributos e1){
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup(e1.lex);
	nodoActual->nChild = 0;
	
	return nodoActual;
}

nodo* crearNodoCte(atributos e1) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup(e1.lex);
	nodoActual->nChild = 0;
	nodoActual->tipo = NODO_CTE;
	
	return nodoActual;
}

nodo* crearNodoVar(atributos e1) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup(e1.lex);
	nodoActual->nChild = 0;
	nodoActual->tipo = NODO_VAR;
	
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

nodo* crearNodoParen(atributos e1) {
	nodo *nodoActual = malloc(sizeof(nodo));
	
	nodoActual->lex = strdup("()");
	nodoActual->nChild = 1;
	nodoActual->children[0] = e1.nodoPropio;
	nodoActual->tipo = NODO_PAREN;
	
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

nodo* crearNodoNormal(atributos parU, atributos parV) {
	atributos attNormalize, attCross;
	nodo *nodoActual, *nodoCross;
	
	attCross.lex = strdup("cross");
	nodoCross = crearNodoFun(attCross);
	nodoCross->nChild = 2;
	nodoCross->children[0] = parU.nodoPropio;
	nodoCross->children[1] = parV.nodoPropio;
	nodoCross->tipo = NODO_FUN;

	attNormalize.lex = strdup("normalize");
	nodoActual = crearNodoFun(attNormalize);
	nodoActual->nChild = 1;
	nodoActual->children[0] = nodoCross;
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
  	
    file = fopen("../shaders/vertex.s","w");
  	
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

// Añade las ctes predefinidas
void generaCtes(){
	char * sent;
	
  	sent = (char *) malloc(1000);
  	sent[0]=0;
  	
    sprintf(sent,"\nfloat PI = 3.14159265;\n");
    sprintf(sent,"%sfloat E = 2.71828182;\n\n", sent);
    
  	fputs(sent,file);
  	free(sent);	
}

// Abre un fichero para crear el código intermedio
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

void escribeFun(atributos fun, atributos e1){
	int indexFun, i;
	char * sent;
	
  	sent = (char *) malloc(1000);
  	sent[0]=0;
  	indexFun = TS_BuscarFUN(fun);

  	if (indexFun == -1) {
  		return;
  	}

	TS[indexFun].nodoExpr = e1.nodoPropio;
  	
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

nodo* addParen(nodo *n) {
	nodo *nodoParen = malloc(sizeof(nodo));

	nodoParen->tipo = NODO_PAREN;
	nodoParen->nChild = 1;
	nodoParen->lex = strdup("()");
	nodoParen->children[0] = n;

	return nodoParen;
}

void partialNodoSum(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = nodoFun->lex;
	nodoPar->children[0] = partialF(nodoFun->children[0], nVar);
	nodoPar->children[1] = partialF(nodoFun->children[1], nVar);
}

void partialNodoMul(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	nodo *nodoIzq = malloc(sizeof(nodo));
	nodo *nodoDer = malloc(sizeof(nodo));

	nodoIzq->tipo = nodoFun->tipo;
	nodoIzq->nChild = nodoFun->nChild;
	nodoIzq->lex = strdup("*");
	nodoIzq->children[0] = partialF(nodoFun->children[0], nVar);
	nodoIzq->children[1] = nodoFun->children[1];

	nodoDer->tipo = nodoFun->tipo;
	nodoDer->nChild = nodoFun->nChild;
	nodoDer->lex = strdup("*");
	nodoDer->children[0] = nodoFun->children[0];
	nodoDer->children[1] = partialF(nodoFun->children[1], nVar);

	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = strdup("+");
	nodoPar->children[0] = nodoIzq;
	nodoPar->children[1] = nodoDer;
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
	nodoIzq->children[0] = partialF(nodoFun->children[0], nVar);
	nodoIzq->children[1] = nodoFun->children[1];

	nodoNum->tipo = nodoFun->tipo;
	nodoNum->nChild = nodoFun->nChild;
	nodoNum->lex = strdup("*");
	nodoNum->children[0] = nodoFun->children[0];
	nodoNum->children[1] = partialF(nodoFun->children[1], nVar);

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
	nodo *nodoExp, *nodoLn;

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
	nodoPar->children[1] = addParen(partialF(nodoExp, nVar));
}

void partialNodoIf(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = nodoFun->lex;
	nodoPar->children[0] = partialF(nodoFun->children[0], nVar);
	nodoPar->children[1] = partialF(nodoFun->children[1], nVar);
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

	nodoSin->tipo = nodoFun->tipo;
	nodoSin->nChild = nodoFun->nChild;
	nodoSin->lex = strdup("sin");
	nodoSin->children[0] = nodoFun->children[0];

	nodoPar->tipo = NODO_OP;
	nodoPar->nChild = 1;
	nodoPar->lex = strdup("-");
	nodoPar->children[0] = nodoSin;
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

nodo* checkPartialF(nodo *nodoFun, char *nVar)
{
	int i, iParFun;
	nodo *nodoPar;

	atributos attParFun;

		printf("%s\n", nodoFun->lex);
	attParFun.lex = strdup(nodoFun->lex);
	strcat(attParFun.lex, "P");
	strcat(attParFun.lex, nVar);
	iParFun = TS_BuscarFUN(attParFun);

	if (iParFun == -1) {
		int iFun;
		atributos attFun;
		nodo *nodoExprFun;

		attFun.lex = strdup(nodoFun->lex);
		iFun = TS_BuscarFUN(attFun);

		if (iFun == -1) {
			printf("No existe la función: %s\n", attFun.lex);

			return NULL;
		}


		nodo *nodoFun = TS[iFun].nodoExpr;
		atributos attExpr;

		attParFun.tipo = TS[iFun].tipo;

		TS_InsertaFUN(attParFun);
		iParFun = TS_BuscarFUN(attParFun);

		TS[iParFun].dimension = TS[iFun].dimension;
		TS[iParFun].tam = TS[iFun].tam;
		TS[iParFun].nParam = TS[iFun].nParam;
		TS[iParFun].tipo = TS[iFun].tipo;

		for (i = 0; i <  TS[iFun].nParam; i++) {
			TS_InsertaEntrada(TS[iFun + i + 1]);
		}

		attExpr.nodoPropio = partialF(nodoFun, nVar);
		attExpr.tipo = TS[iFun].tipo;
		attExpr.dimension = TS[iFun].dimension;
		attExpr.tam = TS[iFun].tam;

		escribeFun(attParFun, attExpr);
	}

	nodoPar = malloc(sizeof(nodo));
	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = strdup(attParFun.lex);

	for (i = 0; i < nodoFun->nChild; i++) {
		nodoPar->children[i] = nodoFun->children[i];
	}

	return nodoPar;
}

void partialNodoFun(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	int i, iParFun;
	int esArray = strcmp(nodoFun->lex, "vec2") == 0 ||
					strcmp(nodoFun->lex, "vec3") == 0 ||
					strcmp(nodoFun->lex, "mat2") == 0 ||
					strcmp(nodoFun->lex, "mat3") == 0;

	int esPredef = strcmp(nodoFun->lex, "log") == 0 ||
					strcmp(nodoFun->lex, "sin") == 0 ||
					strcmp(nodoFun->lex, "cos") == 0 ||
					strcmp(nodoFun->lex, "tg") == 0;
	
	if (esArray) {
		nodoPar->tipo = nodoFun->tipo;
		nodoPar->nChild = nodoFun->nChild;
		nodoPar->lex = nodoFun->lex;

		for (i = 0; i < nodoFun->nChild; i++) {
			nodoPar->children[i] = addParen(partialF(nodoFun->children[i], nVar));
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
			nodoPar->children[1] = addParen(partialF(nodoFun->children[0], nVar));
		} else {
			int iFun;
			atributos attFun;
			nodo *nodoExprFun;

			attFun.lex = strdup(nodoFun->lex);
			iFun = TS_BuscarFUN(attFun);

			if (iFun == -1) {
				printf("No existe la función: %s", attFun.lex);

				return;
			}

			nodo *nodoSum;
			
			nodo *nodoMul0 = malloc(sizeof(nodo));
			nodoMul0->tipo = NODO_OP;
			nodoMul0->nChild = 2;
			nodoMul0->lex = strdup("*");
			nodoMul0->children[0] = checkPartialF(nodoFun, TS[iFun + 1].lex);
			nodoMul0->children[1] = addParen(partialF(nodoFun->children[0], nVar));

			if (nodoFun->nChild > 1) {
				nodo *nodoMul1 = malloc(sizeof(nodo));
				nodoMul1->tipo = NODO_OP;
				nodoMul1->nChild = 2;
				nodoMul1->lex = strdup("*");
				nodoMul1->children[0] = checkPartialF(nodoFun, TS[iFun + 2].lex);
				nodoMul1->children[1] = addParen(partialF(nodoFun->children[1], nVar));

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
				nodoMul->children[1] = addParen(partialF(nodoFun->children[i], nVar));

				nodo *nodoNewSum = malloc(sizeof(nodo));
				nodoNewSum->tipo = NODO_OP;
				nodoNewSum->nChild = 2;
				nodoNewSum->lex = strdup("+");
				nodoNewSum->children[0] = nodoSum;
				nodoNewSum->children[1] = nodoMul;
				nodoSum = nodoNewSum;
			}

			nodoPar = nodoSum;
		}
	}
}


void partialNodoInd(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = nodoFun->lex;
	nodoPar->children[0] = partialF(nodoFun->children[0], nVar);
	nodoPar->children[1] = nodoFun->children[1];
}

void partialNodoParen(nodo *nodoFun, nodo *nodoPar, char *nVar)
{
	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = nodoFun->lex;
	nodoPar->children[0] = partialF(nodoFun->children[0], nVar);
}

nodo* partialF(nodo *nodoFun, char *nVar)
{
	nodo *nodoPar = malloc(sizeof(nodo));
	int i = 0;

	nodoPar->tipo = nodoFun->tipo;
	nodoPar->nChild = nodoFun->nChild;
	nodoPar->lex = nodoFun->lex;

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

	return nodoPar;
}

void escribeNorm(atributos fun, atributos e1){
	if (e1.dimension == 1 && e1.tam == 3) {
		int indexFun, indexNorm, i;
		char *nVarU = "u";
		char *nVarV = "v";

		indexFun = TS_BuscarFUN(fun);

		if (indexFun == -1) {
			return;
		}

		atributos attFun, attParU, attParV;

		attFun.lex = strdup(fun.lex);

		nodo *nodoFun = crearNodoFun(attFun);
		
		nodoFun->nChild = TS[indexFun].nParam;

		for (i = 0; i < TS[indexFun].nParam; i++){
			atributos var;
			var.lex = TS[indexFun + i + 1].lex;
			nodoFun->children[i] = crearNodoVar(var);
		}

		nodo *nodoParU = checkPartialF(nodoFun, nVarU);
		nodo *nodoParV = checkPartialF(nodoFun, nVarV);
		nodo *nodoExpr;
		
		attParU.nodoPropio = nodoParU;
		attParV.nodoPropio = nodoParV;

		nodoExpr = crearNodoNormal(attParU, attParV);

		atributos attExpr, attNorm;

		attNorm.lex = strdup(fun.lex);
		strcat(attNorm.lex, "Normal");
		attNorm.tipo = fun.tipo;

		TS_InsertaFUN(attNorm);
		indexNorm = TS_BuscarFUN(attNorm);

		attExpr.nodoPropio = nodoExpr;
		attExpr.tipo = fun.tipo;
		attExpr.dimension = fun.dimension;
		attExpr.tam = fun.tam;

		TS[indexNorm].dimension = TS[indexFun].dimension;
		TS[indexNorm].tam = TS[indexFun].tam;
		TS[indexNorm].nParam = TS[indexFun].nParam;
		TS[indexNorm].tipo = TS[indexFun].tipo;

		for (i = 0; i <  TS[indexFun].nParam; i++) {
			TS_InsertaEntrada(TS[indexFun + i + 1]);
		}

		escribeFun(attNorm, attExpr);

		printTS();
	}
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

	if (fun.nParam > totalParam)
		totalParam = fun.nParam;
    
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
	char *sent, *sent_temp;
	
  	sent = (char *) malloc(1000);
  	sent_temp = (char *) malloc(1000);

  	sent[0]=0;
  	sent_temp[0]=0;
  	
    FILE *temp_file = fopen("../temp","w");
  	
    sprintf(sent,"\n\n\tvertex.FragPos = vec3(model * vec4(aPosSurf, 1.0));\n\t");
    sprintf(sent,"%sgl_Position = projection * view * model * vec4(aPosSurf, 1.0);\n}", sent);

  	fputs(sent,file);
  	free(sent);

	sprintf(sent_temp,"%d\n", nPlot);
	sprintf(sent_temp,"%s%d", sent_temp, totalParam-2);

	fputs(sent_temp,temp_file);
  	free(sent_temp);
    fclose(temp_file);
}