#include "grafo-escena.h"
#include "malla-ind.h"

using namespace std ;

class LataPeones : public NodoGrafoEscena
{
private:
	const unsigned nparam=0;
	MallaInd *peonMadera, *peonBlanco, *peonNegro;
	Material *m_madera, *m_blanco, *m_negro;
public:
	LataPeones();
	unsigned leerNumParametros() const ;
};

class Lata : public NodoGrafoEscena
{
private:
	const unsigned nparam=0;
	MallaInd *tuboLata, *supLata, *infLata;
	Material *m_tapa, *m_lata;
public:
	Lata(const string nombre, const string & texturaJPG);
	unsigned leerNumParametros() const ;
};

class VariasLatasPeones : public NodoGrafoEscena
{
private:
	const unsigned nparam=0;
	MallaInd *peonMadera, *peonBlanco, *peonNegro;
	Lata *lataCoca, *lataPepsi, *lataUGR;
	Material *m_madera, *m_blanco, *m_negro;
public:
	VariasLatasPeones();
	unsigned leerNumParametros() const ;
};
