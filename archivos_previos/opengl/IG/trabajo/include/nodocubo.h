#include "grafo-escena.h"
#include "malla-ind.h"

using namespace std ;

class NodoCubo24 : public NodoGrafoEscena
{
private:
	const unsigned nparam=0;
	MallaInd *cubo;
	Textura *ugr;
public:
	NodoCubo24();
	unsigned leerNumParametros() const ;
};
