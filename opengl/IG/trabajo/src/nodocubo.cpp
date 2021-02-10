#include "nodocubo.h"
#include "malla-ind.h"
#include "malla-revol.h"


using namespace std;

NodoCubo24::NodoCubo24(){
	// Declaracion de todos los elementos mediante punteros
	ugr = new Textura("../recursos/imgs/window-icon.jpg");
	cubo = new Cubo24();
	
	agregar(new Material(ugr, 0.2, 1.0, 0.0, 0.0));
	agregar(cubo);
}

unsigned NodoCubo24::leerNumParametros() const {
	return nparam;
}

//------------------------------------------------------------------------------
