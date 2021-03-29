#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "semantico.h"

entradaTS TS[MAX_IN];
long int LIMIT = 0;
int declaracion = 0;
int decParam = 0;
int inFun = 0;
dtipo globalType = DESCONOCIDO;
int globalDim = 0;
int globalTam = 0;
int nParam = 0;
int nArg = 0;
int parDesc = 0;
int currentFun = -1;

// Devuelve si el atributo es array o no
int esArray(atributos e){
    return (e.dimension!=0);
}

// Devuelve si los dos posibles arrays que recibe tienen el mismo tamaño
int igualSize(atributos e1, atributos e2){
    return (e1.dimension == e2.dimension && e1.tam == e2.tam);
}

void comprobarSizeArray(atributos e, int s, int t){//=0) {
	int j = TS_BuscarIDENT(e);
	int tam = TS[j].tam;
	
	if (j==-1) {
		printf("(Error semántico, línea %d) Identificador no encontrado\n", linea);
	} else {
	
		if (s < 0 || t < 0) {
			printf("(Error semántico, línea %d) Índice no permitido\n", linea);
		} else if (s >= tam || t >= tam) {
			printf("(Error semántico, línea %d) Índice no permitido\n", linea);
		}
	}
}

// Guarda el tipo de la variable
int setTipo(atributos tipo) {
	globalType = DESCONOCIDO;
	globalDim = 0;
	globalTam = 0;
	
	if (strcmp(tipo.lex, "real") == 0) {
		globalType = REAL;
	} else if (strcmp(tipo.lex, "entero") == 0) {
		globalType = ENTERO;
	} else if (strcmp(tipo.lex, "bool") == 0) {
		globalType = BOOLEANO;
	} else if (strcmp(tipo.lex, "vec2") == 0) {
		globalType = ARRAY;
		globalDim = 1;
		globalTam = 2;
	} else if (strcmp(tipo.lex, "vec3") == 0) {
		globalType = ARRAY;
		globalDim = 1;
		globalTam = 3;
	} else if (strcmp(tipo.lex, "mat2") == 0) {
		globalType = ARRAY;
		globalDim = 2;
		globalTam = 2;
	} else if (strcmp(tipo.lex, "mat3") == 0) {
		globalType = ARRAY;
		globalDim = 2;
		globalTam = 3;
	}
	
	return 1;	
}

int setTipoDesc(){
	globalType = DESCONOCIDO;
	globalDim = 0;
	globalTam = 0;
	
	return 1;
}

// Añade un id
void actualizaTipoDesc(atributos tipo){
	globalType = DESCONOCIDO;
	globalDim = 0;
	globalTam = 0;
	
	if (strcmp(tipo.lex, "real") == 0) {
		globalType = REAL;
	} else if (strcmp(tipo.lex, "entero") == 0) {
		globalType = ENTERO;
	} else if (strcmp(tipo.lex, "bool") == 0) {
		globalType = BOOLEANO;
	} else if (strcmp(tipo.lex, "vec2") == 0) {
		globalType = ARRAY;
		globalDim = 1;
		globalTam = 2;
	} else if (strcmp(tipo.lex, "vec3") == 0) {
		globalType = ARRAY;
		globalDim = 1;
		globalTam = 3;
	} else if (strcmp(tipo.lex, "mat2") == 0) {
		globalType = ARRAY;
		globalDim = 2;
		globalTam = 2;
	} else if (strcmp(tipo.lex, "mat3") == 0) {
		globalType = ARRAY;
		globalDim = 2;
		globalTam = 3;
	}
	
	
	int j = LIMIT-parDesc;
	
	//assert(j<LIMIT);

	// Se obtiene la posición de la mark del bloque
	while((TS[j].tipo == DESCONOCIDO) && (j < LIMIT)){
		TS[j].tipo = globalType;
		TS[j].dimension = globalDim;
		TS[j].tam = globalTam;
		j++;
	}
	
	parDesc = 0;
	
}

// Inserta una entrada en la tabla de símbolos
int TS_InsertaEntrada(entradaTS entrada){

    // Si se tienen más entradas de las que puede alojar la tabla de símbolos
    // dará un error, si no, se inserta
	if(LIMIT < MAX_IN) {
		
		TS[LIMIT].entrada=entrada.entrada;
		TS[LIMIT].lex=entrada.lex;
		TS[LIMIT].tipo=entrada.tipo;
		TS[LIMIT].nParam=entrada.nParam;
		TS[LIMIT].dimension=entrada.dimension;
		TS[LIMIT].tam=entrada.tam;

        // Se aumenta el contador de entradas
		LIMIT++;

		return 1;

	} else {

		printf("(Error semántico, línea %d) Desbordamiento de la pila.\n", linea);

		return 0;

	}

}

// Elimina una entrada de la tabla de símbolos
int TS_BorrarENTRADA(){

    // Si la tabla de símbolos tiene alguna entrada puede eliminar la última
    if(LIMIT > 0){

		LIMIT--;
		return 1;

	}else{

		printf("(Error semántico, línea %d) Tabla de símbolos vacía.\n", linea);
		return 0;

	}

}

// Elimina las entradas de la tabla de símbolos hasta la mark de tope
void TS_VaciarENTRADAS(){

  // Quitar todo lo del bloque
  while(TS[LIMIT-1].entrada != MARCA && LIMIT > 0){
		LIMIT--;
	}
  // Quitar la marca si es que la hubiese
	if (TS[LIMIT-1].entrada == MARCA && LIMIT > 0) {
		LIMIT--;
	}

}

// Busca una entrada según el id
int TS_BuscarIDENT(atributos e){

    int i = LIMIT - 1;
	int found = 0;
	
	while (i >= 0 && !found) {
		if (TS[i].entrada == VAR && strcmp(e.lex, TS[i].lex) == 0) {
			found = 1;
		} else{
			i--;
		}
	}

	if(!found) {
		printf("Error semántico(%d): Identificador no declarado: %s\n", linea, e.lex);
		return -1;
	} else {
		return i;
	}

}

// Devuelve la entrada
entradaTS getEntrada(atributos e) {
	int j = TS_BuscarIDENT(e);
	
	return TS[j];
}

// Busca una entrada según el nombre
int TS_BuscarFUN(atributos e){

    int i = LIMIT - 1;
	int found = 0;


	while (i > 0 && !found) {
		if (TS[i].entrada == FUNCION && strcmp(e.lex, TS[i].lex) == 0) {
			found = 1;
		} else{
			i--;
		}
	}

	if(!found) {
		printf("(Error semántico, línea %d) Función no declarada: %s\n", linea, e.lex);
		return -1;
	} else {
		return i;
	}

}

// Añade un id
void TS_InsertaIDENT(atributos e){

    // Para añadir un id a la pila no se puede haber llegado al tope,
    // el id no puede existir y se deben estar declarando variables
	int j = LIMIT-1;
	int found = 0;

	if(j >= 0){ //&& declaracion == 1){
		// Se obtiene la posición de la mark del bloque
		while((j >= 0) && !found){

			if(strcmp(TS[j].lex, e.lex) != 0){

				j--;

			} else{

				found = 1;
				printf("(Error semántico, línea %d) El identificador ya existe: %s\n", linea, e.lex);

	 		}

		}

		// Si no se ha encontrado significa que no existe, por lo que se añade
        // a la pila
		if(!found) {
			entradaTS newIn;
			newIn.entrada = VAR;
			newIn.lex = e.lex;
			newIn.tipo = globalType;
			newIn.nParam = 0;
			newIn.dimension=globalDim;
			newIn.tam=globalTam;
			TS_InsertaEntrada(newIn);

		}

	}

}

// Añade una mark de tope
void TS_InsertaMARCA(){
    entradaTS inInitScope;

	inInitScope.entrada = MARCA;
	inInitScope.lex = "{";
	inInitScope.tipo = DESCONOCIDO;
	inInitScope.nParam = 0;
	inInitScope.dimension = 0;
	inInitScope.tam = 0;
	
	TS_InsertaEntrada(inInitScope);

    // Se añaden a la tabla de símbolos los parámetros de la función como las
    // variables locales de ese bloque
	//if(inFun == 1){

	int j = LIMIT - 2, mark = 0, funct = 0;

	while(j > 0 && TS[j].entrada == PARA_FORM){

		if(TS[j].entrada == PARA_FORM) {

			entradaTS newIn;
			newIn.entrada = VAR;
			newIn.lex = TS[j].lex;
			newIn.tipo = TS[j].tipo;
			newIn.nParam = TS[j].nParam;
			newIn.dimension = TS[j].dimension;
			newIn.tam = TS[j].tam;
			TS_InsertaEntrada(newIn);

		}

		j--;

	}

	//}

}

// Añade una entrada de una función
void TS_InsertaFUN(atributos e){
	
	int j = LIMIT-1;
	int found = 0;

	// Se obtiene la posición de la mark del bloque
	while((j >= 0) && !found){

		if((strcmp(TS[j].lex, e.lex) != 0) || (TS[j].entrada == PARA_FORM)){

			j--;

		} else{

			found = 1;
			printf("(Error semántico, línea %d) El identificador ya existe: %s\n", linea, e.lex);

 		}

	}
	
  	entradaTS inFun;
	inFun.entrada = FUNCION;
	inFun.lex = e.lex;
	inFun.nParam = 0;
	inFun.dimension = 0;
	inFun.tam = 0;
	inFun.tipo = e.tipo;

	currentFun = LIMIT;
	TS_InsertaEntrada(inFun);

}

// Añade una entrada de param formal
void TS_InsertaPARAMF(atributos e){

    int j = LIMIT - 1, found = 0;

	while((j != currentFun)  && (!found) ){

		if(strcmp(TS[j].lex, e.lex) != 0) {

			j--;

		} else{

			found = 1;
			printf("Error semántico(%d): El parámetro ya existe: %s\n", linea, e.lex);

        }

	}
	
	while((j >= 0) && !found){

		if(strcmp(TS[j].lex, e.lex) != 0 || TS[j].entrada == PARA_FORM){

			j--;

		} else {

			found = 1;
			printf("(Error semántico, línea %d) El identificador ya existe: %s\n", linea, e.lex);

 		}

	}

	if(!found) {

		entradaTS newIn;
		newIn.entrada = PARA_FORM;
		newIn.lex = e.lex;
		newIn.tipo = globalType;
		newIn.nParam = 0;
		newIn.dimension=globalDim;
		newIn.tam=globalTam;
		TS_InsertaEntrada(newIn);

	}

}


void TS_InsertaPLOT(atributos id){

    int j = LIMIT - 1, found = 0;
    int index;
    int validParam = 1;

	while((j != currentFun)  && (!found) ){

		if(strcmp(TS[j].lex, id.lex) != 0) {

			j--;

		} else{

			found = 1;
			printf("Error semántico(%d): El parámetro ya existe: %s\n", linea, id.lex);

        }

	}
	
	index = TS_BuscarFUN(id);
	j = index + TS[index].nParam;
	
	while (j!=index && validParam) {
		if (TS[j].tipo != REAL) {
			validParam = 0;
		} else {
			j--;
		}
	}
	
	if(index!=-1) {
		if (TS[index].nParam<2) {
		    printf("\n(Error semántico, línea %d) El número de parámetros de la función a dibujar %s debe ser al menos 2.\n", linea, id.lex);
		} else if (!validParam) {
		    printf("\n(Error semántico, línea %d) Todos los parámetros de la función %s deben ser de tipo real.\n", linea, id.lex);
		} else {

			entradaTS newIn;
			newIn.entrada = PARA_FORM;
			newIn.lex = TS[index].lex;
			newIn.tipo = TS[index].tipo;
			newIn.nParam = TS[index].nParam;
			newIn.dimension=TS[index].dimension;
			newIn.tam=TS[index].tam;
			TS_InsertaEntrada(newIn);

		}
	}

}

// Actualiza el número de parámetros de la función
void TS_ActualizarFun(){

    TS[currentFun].tipo = globalType;
    TS[currentFun].nParam = nParam;
	TS[currentFun].dimension=globalDim;
	TS[currentFun].tam=globalTam;

}

// Devuelve el identificar
void TS_getIDENT(atributos id, atributos* res){

    int index = TS_BuscarIDENT(id);
	
	if(index==-1) {
        if(TS[index].entrada != FUNCION)
		      printf("\n(Error semántico, línea %d) Identificador no encontrado %s.\n", linea, id.lex);
	} else {

		res->lex = strdup(TS[index].lex);
		res->tipo = TS[index].tipo;
		res->dimension = TS[index].dimension;
		res->tam = TS[index].tam;

	}

}

// Realiza la comprobación de la operación +, - y !
void comprobarTipoCte(atributos idTipo){
	if(TS[LIMIT-1].tipo != idTipo.tipo) {
		if (!(TS[LIMIT-1].tipo == REAL && idTipo.tipo == ENTERO)) {
			printf("(Error semántico, línea %d) Los tipos no coinciden (%d) y (%d).\n",linea,TS[LIMIT-1].tipo,idTipo.tipo);
		}
	}

}

// Realiza la comprobación de la operación +, - y !
void comprobarTipoFun(atributos idFun, atributos idTipo){
	int index = TS_BuscarFUN(idFun);
	
	if(TS[index].tipo != idTipo.tipo) {
		if (!(TS[index].tipo == REAL && idTipo.tipo == ENTERO)) {
			printf("(Error semántico, línea %d) Los tipos no coinciden (%d) y (%d).\n",linea,TS[index].tipo,idTipo.tipo);
		}
	}

}

// Realiza la comprobación de la operación +, - y !
void comprobarIF(atributos comp, atributos e1, atributos e2, atributos* res){
	dtipo tipoActual;
	
	if (comp.tipo != BOOLEANO) {
		printf("(Error semántico, línea %d) Se esperaba una expresión booleana para la comprobación.\n", linea);
		return;
	}
	
	if (e1.tipo != e2.tipo) {
	
		if ((e1.tipo == REAL && e2.tipo == ENTERO) || (e2.tipo == REAL && e1.tipo == ENTERO)) {
			tipoActual = REAL;
		} else {
			printf("(Error semántico, línea %d) Se esperaban expresiones del mismo tipo.\n", linea);
			return;
		}
		
	} else {
	
		tipoActual = e1.tipo;
		
	}
		
	res->tipo = tipoActual;
	res->dimension = e1.dimension;
	res->tam = e1.tam;

}

// Realiza la comprobación de la operación +, - y !
void comprobarIND(atributos e1, atributos e2, atributos* res){
	dtipo tipoActual;
	
	if (!esArray(e1)) {
		printf("(Error semántico, línea %d) Se esperaba un array.\n", linea);
		return;
	}
	
	if (e2.tipo != ENTERO) {
		printf("(Error semántico, línea %d) Se esperaba un entero para el índice.\n", linea);
		return;
	}
	
	res->dimension = e1.dimension-1;
	
	if (res->dimension > 0) {
		res->tipo = ARRAY;
		res->tam = e1.tam;
	} else {
		res->tipo = REAL;
		res->tam = 0;
	}

}

// Realiza la comprobación de la operación +, - y !
void TS_OpUNARIA(atributos op, atributos o, atributos* res){
	if (strcmp(op.lex, "!") != 0) {
		if (o.tipo != REAL && o.tipo != ENTERO && o.tipo != ARRAY) {
			printf("(Error semántico, línea %d) Se esperaba una expresión entera, real o array.\n", linea);
			return;
		}
		
		res->tipo = o.tipo;
		res->dimension = o.dimension;
		res->tam = o.tam;
		
	} else {
		
		if (o.tipo != BOOLEANO || esArray(o)) {
			printf("(Error semántico, línea %d) Se esperaba una expresión booleana.\n", linea);
			return;
		}
		
		res->tipo = BOOLEANO;
		res->dimension = 0;
		res->tam = 0;
	
	}

}

// Realiza la comprobación de la operación +, - binaria
void TS_OpSUMARESTA(atributos o1, atributos op, atributos o2, atributos* res){
	
	dtipo tipoActual = REAL;

	if ((o1.tipo != ENTERO && o1.tipo != REAL && o1.tipo != ARRAY) || (o2.tipo != ENTERO && o2.tipo != REAL && o1.tipo != ARRAY)) {
		printf("(Error semántico, línea %d) Tipo inválido en la operación.\n", linea);
		return;
	} else if (o1.tipo == ENTERO && o2.tipo == ENTERO) {
		tipoActual = ENTERO;
	}

	if (esArray(o1) && esArray(o2)){

		if(igualSize(o1,o2)){

			res->tipo = o1.tipo;
			res->dimension = o1.dimension;
			res->tam = o1.tam;

		} else {

            printf("(Error semántico, línea %d) Los arrays tienen que tener el mismo tamaño y dimensión.\n", linea);
			return;

		}

	} else if (!esArray(o1) && !esArray(o2)){

		res->tipo = tipoActual;
		res->dimension = o2.dimension;
		res->tam = o2.tam;

	}else {
	
		printf("(Error semántico, línea %d) No se permite ésta operación entre array y escalar.\n", linea);
		return;
		
	}


}

// Realiza la comprobación de la operación *, /
void TS_OpMULTIP(atributos o1, atributos op, atributos o2, atributos* res){

    if (o1.tipo != ENTERO && o1.tipo != REAL && o1.tipo != ARRAY) {
		printf("(Error semántico, línea %d) Tipo inválido para la operación o1: %d.\n", linea, o1.tipo);
		return;
	}
	
	if (o2.tipo != ENTERO && o2.tipo != REAL && o2.tipo != ARRAY) {
		printf("(Error semántico, línea %d) Tipo inválido para la operación o2: %d.\n", linea, o2.tipo);
		return;
	}

	if (esArray(o1) && esArray(o2)){

		if(igualSize(o1,o2)){

			res->tipo = o1.tipo;
			res->dimension = o1.dimension;
			res->tam = o1.tam;

		} else if ((o1.dimension==2) && (o2.dimension==1) && (o1.tam == o2.tam)) {
			res->tipo = o2.tipo;
			res->dimension = o2.dimension;
			res->tam = o2.tam;
		
		} else {

            printf("(Error semántico, línea %d) Los arrays deben de tener el mismo tamaño y dimensión.\n", linea);
			return;

		}
	} else if (esArray(o1) && !esArray(o2)){
		
		res->tipo = o1.tipo;
		res->dimension = o1.dimension;
		res->tam = o1.tam;
		
	} else if (!esArray(o1) && esArray(o2)){
	
		res->tipo = o2.tipo;
		res->dimension = o2.dimension;
		res->tam = o2.tam;

	} else if (!esArray(o1) && !esArray(o2)) {
	
		if (o1.tipo == ENTERO && o2.tipo == ENTERO){
		
			res->tipo = ENTERO;
			
		} else {
		
			res->tipo = REAL;
			
		}
		
		res->dimension = o1.dimension;
		res->tam = o1.tam;

	}

}

// Realiza la comprobación de la operación &&
void TS_OpAND(atributos o1, atributos op, atributos o2, atributos* res){

    if (o1.tipo != o2.tipo) {
		printf("(Error semántico, línea %d) Las expresiones tienen que ser del mismo tipo básico.\n", linea);
		return;
	}
	if (o1.tipo != BOOLEANO || esArray(o1) || esArray(o2)) {
		printf("(Error semántico, línea %d) Se esperaba de tipo BOOLEANO.\n", linea);
		return;
	}

	res->tipo = BOOLEANO;
	res->dimension = 0;
	res->tam = 0;

}

// Realiza la comprobación de la operación ||
void TS_OpOR(atributos o1, atributos op, atributos o2, atributos* res){

    if (o1.tipo != o2.tipo) {
		printf("(Error semántico, línea %d): Las expresiones tienen que ser del mismo tipo básico.\n", linea);
		return;
	}
	if (o1.tipo != BOOLEANO || esArray(o1) || esArray(o2)) {
		printf("(Error semántico, línea %d) Se esperaba de tipo BOOLEANO.\n", linea);
		return;
	}

	res->tipo = BOOLEANO;
	res->dimension = 0;
	res->tam = 0;

}

// Realiza la comprobación de la operación ==, !=
void TS_OpIGUAL(atributos o1, atributos op, atributos o2, atributos* res){
	
	if ((o1.tipo != ENTERO && o1.tipo != REAL) || (o2.tipo != ENTERO && o2.tipo != REAL) || esArray(o1) || esArray(o2)) {
		printf("(Error semántico, línea %d) Se esperaba de tipo ENTERO o REAL.\n", linea);
		return;
	}

	res->tipo = BOOLEANO;
	res->dimension = 0;
	res->tam = 0;

}

// Realiza la comprobación de la operación <, >, <=, >=, <>
void TS_OpCOMP(atributos o1,atributos o ,atributos o2, atributos* res){

	if ((o1.tipo != ENTERO && o1.tipo != REAL) || (o2.tipo != ENTERO && o2.tipo != REAL) || esArray(o1) || esArray(o2)) {
		printf("(Error semántico, línea %d) Se esperaba de tipo ENTERO o REAL.\n", linea);
		return;
	}

	res->tipo = BOOLEANO;
	res->dimension = 0;
	res->tam = 0;

}

// Realiza la comprobación de la llamada a una función
void TS_FunCall(atributos id, atributos argFun, atributos* res){

    int index;
    
	currentFun = -1;
	res->tipo = ARRAY;
	res->lex = strdup(id.lex);
	
    if (strcmp(id.lex, "vec2") == 0) {
		res->dimension = 1;
		res->tam = 2;
    } else if (strcmp(id.lex, "vec3") == 0) {
		res->dimension = 1;
		res->tam = 3;
    } else if (strcmp(id.lex, "mat2") == 0) {
		res->dimension = 2;
		res->tam = 2;
    } else if (strcmp(id.lex, "mat3") == 0) {
		res->dimension = 2;
		res->tam = 3;
    } else {
		index = TS_BuscarFUN(id);

		if(index==-1) {

			currentFun = -1;
			printf("(Error semántico, línea %d) Función: Identificador no encontrado %s.\n", linea, id.lex);

		} else {

			if (argFun.nArg != TS[index].nParam) {
				printf("(Error semántico, línea %d) Número de parámetros no válido: %d != %d.\n", linea, argFun.nArg, TS[index].nParam);
			} else {
				currentFun = index;
				res->lex = strdup(TS[index].lex);
				res->tipo = TS[index].tipo;
				res->dimension = TS[index].dimension;
				res->tam = TS[index].tam;

			}

		}
	}

}

// Realiza la comprobación de cada parámetro de una función
void TS_ComprobarPARAM(atributos funID ,atributos param, int checkParam){

	int f;
	int posParam;
	int error;
	
	if ((strcmp(funID.lex, "vec2") == 0) || (strcmp(funID.lex, "vec3") == 0) || (strcmp(funID.lex, "mat2") == 0) || (strcmp(funID.lex, "mat3") == 0)) {
    	return;
    }
	
	f = TS_BuscarFUN(funID);
	posParam = (f ) + (checkParam);
	error = checkParam;
	
	if (param.tipo != TS[posParam].tipo) {
		if (!(TS[posParam].tipo == REAL && param.tipo == ENTERO)) {
			printf("(Error semántico, línea %d) Tipo de parámetro (%d) no válido.\n", linea, error);
			return;
		}
	}

	if (param.dimension != TS[posParam].dimension || param.tam != TS[posParam].tam) {
		printf("(Error semántico, línea %d) Tamaño del parámetro (%d) no válido.\n", linea, error);
		return;
	}

}

void initializeTS() {
	//// Constantes predefinidas
	// E
	entradaTS numE;
	numE.entrada = VAR;
	numE.lex = strdup("E");
	numE.tipo = REAL;
	numE.nParam = 0;
	numE.dimension=0;
	numE.tam=0;
	TS_InsertaEntrada(numE);
	
	// PI
	entradaTS numPI;
	numPI.entrada = VAR;
	numPI.lex = strdup("PI");
	numPI.tipo = REAL;
	numPI.nParam = 0;
	numPI.dimension=0;
	numPI.tam=0;
	TS_InsertaEntrada(numPI);
	
	// Funciones predefinidas
	// cos
	entradaTS funCos;
	funCos.entrada = FUNCION;
	funCos.lex = strdup("cos");
	funCos.tipo = REAL;
	funCos.nParam = 1;
	funCos.dimension=0;
	funCos.tam=0;
	TS_InsertaEntrada(funCos);
	
	entradaTS paramCos;
	paramCos.entrada = PARA_FORM;
	paramCos.lex = strdup("x");
	paramCos.tipo = REAL;
	paramCos.nParam = 0;
	paramCos.dimension=0;
	paramCos.tam=0;
	TS_InsertaEntrada(paramCos);
	
	// sin
	entradaTS funSin;
	funSin.entrada = FUNCION;
	funSin.lex = strdup("sin");
	funSin.tipo = REAL;
	funSin.nParam = 1;
	funSin.dimension=0;
	funSin.tam=0;
	TS_InsertaEntrada(funSin);
	
	entradaTS paramSin;
	paramSin.entrada = PARA_FORM;
	paramSin.lex = strdup("x");
	paramSin.tipo = REAL;
	paramSin.nParam = 0;
	paramSin.dimension=0;
	paramSin.tam=0;
	TS_InsertaEntrada(paramSin);
	
	// log
	entradaTS funLog;
	funLog.entrada = FUNCION;
	funLog.lex = strdup("log");
	funLog.tipo = REAL;
	funLog.nParam = 1;
	funLog.dimension=0;
	funLog.tam=0;
	TS_InsertaEntrada(funLog);
	
	entradaTS paramLog;
	paramLog.entrada = PARA_FORM;
	paramLog.lex = strdup("x");
	paramLog.tipo = REAL;
	paramLog.nParam = 0;
	paramLog.dimension=0;
	paramLog.tam=0;
	TS_InsertaEntrada(paramLog);
}


//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Visualización
//

// Muestra una entrada de la tabla de símbolos
void printEntrada(int row){

    entradaTS e = TS[row];
	printf("\n\nTipo Entrada: %d\nLexema: %s\nTipo Dato: %d\nNum Parametros: %d\nDimensiones[i][j]: %d[%d][%d]\n",
		e.entrada, e.lex, e.tipo, e.nParam, e.dimension, e.tam, e.tam);

}

void printTipo(dtipo tipo) {
	char *t;
	if(tipo == 0) { t = "NO_ASIG"; }
	if(tipo == 1) { t = "ENTERO"; }
	if(tipo == 2) { t = "REAL"; }
	if(tipo == 3) { t = "BOOLEANO"; }
	if(tipo == 4) { t = "ARRAY"; }
	if(tipo == 5) { t = "DESCONOCIDO"; }

	printf("%s", t);

}


// Muestra la tabla de símbolos
void printTS(){

    int j = 0;
	char *t, *e;

	fprintf(stderr, "--------------------------------\n");
	while(j <= LIMIT-1) {
		if(TS[j].entrada == 0) { e = "MARCA"; }
		if(TS[j].entrada == 1) { e = "FUNCION"; }
		if(TS[j].entrada == 2) { e = "VAR"; }
		if(TS[j].entrada == 3) { e = "PARA_FORM"; }

		if(TS[j].tipo == 0) { t = "NO_ASIG"; }
		if(TS[j].tipo == 1) { t = "ENTERO"; }
		if(TS[j].tipo == 2) { t = "REAL"; }
		if(TS[j].tipo == 3) { t = "BOOLEANO"; }
		if(TS[j].tipo == 4) { t = "ARRAY"; }
		if(TS[j].tipo == 5) { t = "DESCONOCIDO"; }
		fprintf(stderr, "\n----ELEMENTO %d-----------------\n", j);
		fprintf(stderr, "-Entrada: %-12s", e);
		fprintf(stderr, "-Lexema: %-12s", TS[j].lex);
		fprintf(stderr, "-tipo: %-10s", t);
		fprintf(stderr, "-nParam: %-4d", TS[j].nParam);
		fprintf(stderr, "-dimension: %-4d", TS[j].dimension);
		fprintf(stderr, "-tam: %-4d", TS[j].tam);
		j++;
	}
	fprintf(stderr, "\n--------------------------------\n");

}

// Muestra un atributo recibido
void printAtributo(atributos e, char *msg){

    char *t;

	if(e.tipo == 0) { t = "NO_ASIG"; }
	if(e.tipo == 1) { t = "ENTERO"; }
	if(e.tipo == 2) { t = "REAL"; }
	if(e.tipo == 3) { t = "BOOLEANO"; }
	if(e.tipo == 4) { t = "ARRAY"; }
	if(e.tipo == 5) { t = "DESCONOCIDO"; }
	printf("------%s-------------------------\n", msg);
	printf("-Atributos: %-4d", e.atrib);
	printf("-Lexema: %-12s", e.lex);
	printf("-tipo: %-10s", t);
	printf("-dimension: %-4d", e.dimension);
	printf("-tam: %-4d", e.tam);
	printf("-------------------------------\n");

}

