#include "grafo-escena.h"
#include "malla-ind.h"

using namespace std ;

class Torreta;
class Rueda;
class RuedaPala;
class RuedaPala_Inv;

class C : public NodoGrafoEscena
{
private:
	const unsigned nparam=5;
	const int l = 20;
	float rotacion = 0;
	float desplazamiento = 0;
	float sec_anterior = 0;
	bool tren_bajado = true;
	Torreta *torreta;
	Material *m_oxidado, *m_cuerpo, *m_goma;
	vector<Rueda *> ruedas_t, ruedas_d;
	vector<RuedaPala *> ruedasPala;
	vector<RuedaPala_Inv *> ruedasPala_inv;
public:
	C();
	unsigned leerNumParametros() const ;
	void actualizarEstadoParametro( const unsigned iParam, const float t_sec );
};

class Rueda : public NodoGrafoEscena
{
public:
	Matriz4f * rotacion = nullptr;
	Matriz4f * direccion = nullptr;
	Rueda(int l);
};

class RuedaPala : public NodoGrafoEscena
{
public:
	Matriz4f * rotacion = nullptr;
	Matriz4f * elevacion = nullptr;
	RuedaPala(int l);
};

class RuedaPala_Inv : public NodoGrafoEscena
{
public:
	Matriz4f * rotacion = nullptr;
	Matriz4f * elevacion = nullptr;
	RuedaPala_Inv(int l);
};

class Pala : public NodoGrafoEscena
{
public:
	Pala();
};

class Pala_Inv : public NodoGrafoEscena
{
public:
	Pala_Inv();
};

class Eje : public NodoGrafoEscena
{
public:
	Eje(int l);
};

class Torreta : public NodoGrafoEscena
{
public:
	Matriz4f * giro = nullptr;
	Matriz4f * elevacion = nullptr;
	Material *m_cuerpo, *m_cannon;
	Torreta();
};

class Cannon : public NodoGrafoEscena
{
public:
	Cannon(int l);
};

class Cuerpo : public MallaInd
{
public:
	Cuerpo();
};

class CuerpoTorreta : public MallaInd
{
public:
	CuerpoTorreta();
};
