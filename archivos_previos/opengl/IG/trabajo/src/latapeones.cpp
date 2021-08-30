#include "latapeones.h"
#include "malla-ind.h"
#include "malla-revol.h"


using namespace std;

LataPeones::LataPeones(){
	// Declaracion de todos los elementos mediante punteros
	peonMadera = new MallaRevolPLY("../recursos/plys/peon.ply", 20);
	peonBlanco = new MallaRevolPLY("../recursos/plys/peon.ply", 20);
	peonNegro = new MallaRevolPLY("../recursos/plys/peon.ply", 20);
	
	m_madera = new Material(new TexturaXY("../recursos/imgs/text-madera.jpg"), 0.3, 0.6, 1.0, 30.0);
	m_blanco = new Material(0.2, 0.9, 0.1, 1.0);
	m_negro = new Material(0.3, 0.2, 0.8, 5.0);
	
	peonBlanco->ponerColor({1.0, 1.0, 1.0});
	peonNegro->ponerColor({0.1, 0.1, 0.1});
	
	agregar(new Lata("Lata de Coca-Cola", "../recursos/imgs/lata-coke.jpg"));
	
	agregar(MAT_Escalado(0.2, 0.2, 0.2));
	agregar(MAT_Traslacion(0.0, 1.4, 0.0));
	
	agregar(MAT_Traslacion(0.0, 0.0, 4.0));
	agregar(m_madera);
	agregar(peonMadera);
	
	agregar(MAT_Traslacion(2.5, 0.0, 0.0));
	agregar(m_blanco);
	agregar(peonBlanco);
	
	agregar(MAT_Traslacion(2.5, 0.0, 0.0));
	agregar(m_negro);
	agregar(peonNegro);
}

unsigned LataPeones::leerNumParametros() const {
	return nparam;
}

//------------------------------------------------------------------------------

VariasLatasPeones::VariasLatasPeones(){
	// Declaracion de todos los elementos mediante punteros
	ponerNombre("Varias latas Peones");
	
	peonMadera = new MallaRevolPLY("../recursos/plys/peon.ply", 20);
	peonBlanco = new MallaRevolPLY("../recursos/plys/peon.ply", 20);
	peonNegro = new MallaRevolPLY("../recursos/plys/peon.ply", 20);
	
	lataCoca = new Lata("Lata de Coca-Cola", "../recursos/imgs/lata-coke.jpg");
	lataPepsi = new Lata("Lata de Pepsi", "../recursos/imgs/lata-pepsi.jpg");
	lataUGR = new Lata("Lata de la UGR", "../recursos/imgs/window-icon.jpg");
	
	peonMadera->ponerNombre("Peon de madera");
	peonBlanco->ponerNombre("Peon blanco");
	peonNegro->ponerNombre("Peon negro");
	
	peonMadera->ponerIdentificador(16711680);
	peonBlanco->ponerIdentificador(65280);
	peonNegro->ponerIdentificador(255);
	
	lataCoca->ponerIdentificador(16776960);
	lataPepsi->ponerIdentificador(65535);
	lataUGR->ponerIdentificador(16711935);
	
	m_madera = new Material(new TexturaXY("../recursos/imgs/text-madera.jpg"), 0.3, 0.6, 1.0, 30.0);
	m_blanco = new Material(0.2, 0.9, 0.1, 1.0);
	m_negro = new Material(0.3, 0.2, 0.8, 5.0);
	
	peonBlanco->ponerColor({1.0, 1.0, 1.0});
	peonNegro->ponerColor({0.1, 0.1, 0.1});
	
	// Lata de coca-cola
	agregar(lataCoca);
	
	// Lata de pepsi
	agregar(MAT_Traslacion(1.0, 0.0, 0.0));
	agregar(lataPepsi);
	
	// Lata de la ugr
	agregar(MAT_Traslacion(1.0, 0.0, 0.0));
	agregar(lataUGR);
	
	agregar(MAT_Traslacion(-2.0, 0.0, 0.0));
	
	agregar(MAT_Escalado(0.2, 0.2, 0.2));
	agregar(MAT_Traslacion(0.0, 1.4, 0.0));
	
	// Peon 1
	agregar(MAT_Traslacion(0.0, 0.0, 4.0));
	agregar(m_madera);
	agregar(peonMadera);
	
	// Peon 2
	agregar(MAT_Traslacion(2.5, 0.0, 0.0));
	agregar(m_blanco);
	agregar(peonBlanco);
	
	// Peon 3
	agregar(MAT_Traslacion(2.5, 0.0, 0.0));
	agregar(m_negro);
	agregar(peonNegro);
		
}

unsigned VariasLatasPeones::leerNumParametros() const {
	return nparam;
}

//------------------------------------------------------------------------------

Lata::Lata(const string nombre, const string & texturaJPG){
	// Declaracion de todos los elementos mediante punteros
	ponerNombre(nombre);
	
	tuboLata = new MallaRevolPLY("../recursos/plys/lata-pcue.ply", 20);
	supLata = new MallaRevolPLY("../recursos/plys/lata-psup.ply", 20);
	infLata = new MallaRevolPLY("../recursos/plys/lata-pinf.ply", 20);
	
	m_lata = new Material(new Textura(texturaJPG), 0.3, 1.0, 1.0, 30.0);
	m_tapa = new Material(0.3, 0.4, 0.8, 5.0);
	
	supLata->ponerColor({0.5, 0.5, 0.5});
	infLata->ponerColor({0.5, 0.5, 0.5});
	
	agregar(m_tapa);
	agregar(supLata);
	agregar(infLata);
	agregar(m_lata);
	agregar(tuboLata);
	
}

unsigned Lata::leerNumParametros() const {
	return nparam;
}
