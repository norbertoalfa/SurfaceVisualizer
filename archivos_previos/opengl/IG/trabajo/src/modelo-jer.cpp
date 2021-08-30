#include "modelo-jer.h"
#include "malla-ind.h"
#include "malla-revol.h"


using namespace std;

C::C(){
	// Declaracion de todos los elementos mediante punteros
	torreta = new Torreta();
	
	ruedas_t.push_back(new Rueda(l));
	ruedas_t.push_back(new Rueda(l));
	ruedas_d.push_back(new Rueda(l));
	ruedas_d.push_back(new Rueda(l));
	
	ruedasPala.push_back(new RuedaPala(l));
	ruedasPala.push_back(new RuedaPala(l));
	ruedasPala_inv.push_back(new RuedaPala_Inv(l));
	ruedasPala_inv.push_back(new RuedaPala_Inv(l));
	
	ruedas_t[0]->ponerIdentificador(255);
	ruedas_t[1]->ponerIdentificador(3550);
	ruedas_d[0]->ponerIdentificador(455);
	ruedas_d[1]->ponerIdentificador(5550);
	
	ruedasPala[0]->ponerIdentificador(655);
	ruedasPala[1]->ponerIdentificador(755);
	ruedasPala_inv[0]->ponerIdentificador(855);
	ruedasPala_inv[1]->ponerIdentificador(955);
	
	ponerNombre("Modelo jerarquico");
	
	ruedas_t[0]->ponerNombre("Rueda tras 0");
	ruedas_t[1]->ponerNombre("Rueda tras 1");
	ruedas_d[0]->ponerNombre("Rueda del 0");
	ruedas_d[1]->ponerNombre("Rueda del 1");
	
	ruedasPala[0]->ponerNombre("RuedaPala 0");
	ruedasPala[1]->ponerNombre("RuedaPala 1");
	ruedasPala_inv[0]->ponerNombre("RuedaPala_Inv 0");
	ruedasPala_inv[1]->ponerNombre("RuedaPala_Inv 1");
	
	m_oxidado = new Material(new Textura("../trabajo/imgs/gear.jpg"), 0.3, 1.0, 1.0, 30.0);
	m_cuerpo = new Material(new TexturaXY("../trabajo/imgs/body-mod.jpg"), 0.3, 1.0, 1.0, 30.0);
	m_goma = new Material(0.3, 0.2, 0.8, 5.0);
	
	ruedas_t[0]->ponerColor({0.1, 0.1, 0.1});
	ruedas_t[1]->ponerColor({0.1, 0.1, 0.1});
	ruedas_d[0]->ponerColor({0.1, 0.1, 0.1});
	ruedas_d[1]->ponerColor({0.1, 0.1, 0.1});
	
	// Entradas del nodo raíz
	agregar(m_cuerpo);
	agregar(new Cuerpo());	
	agregar(MAT_Traslacion(0,1.25,0));
	
	agregar(torreta);	
	agregar(MAT_Traslacion(0,-1.25,3));
	
	agregar(new Eje(20));	// Eje delantero
	agregar(MAT_Traslacion(0,0,-6));
	agregar(new Eje(20));	// Eje trasero
	agregar(MAT_Traslacion(1.5,0,0));
	
	agregar(m_goma);
	agregar(ruedas_t[0]);				// Rueda Trasera Izquierda
	agregar(MAT_Traslacion(-3,0,0));
	agregar(ruedas_t[1]);				// Rueda Trasera Derecha
	agregar(MAT_Traslacion(0,0,4));
	agregar(m_oxidado);
	agregar(ruedasPala[0]);			// RuedaPala Trasera Derecha
	agregar(MAT_Traslacion(3,0,-2));
	agregar(ruedasPala[1]);			// RuedaPala Trasera Izquierda
	agregar(MAT_Traslacion(-3,0,0));
	
	agregar(m_oxidado);
	agregar(ruedasPala_inv[0]);			// RuedaPala (inv) Trasera Derecha
	agregar(MAT_Traslacion(3,0,2));
	agregar(ruedasPala_inv[1]);			// RuedaPala (inv) Delantera Izquierda
	agregar(MAT_Traslacion(0,0,2));
	agregar(m_goma);
	agregar(ruedas_d[0]);				// Rueda (inv) Delantera Izquierda
	agregar(MAT_Traslacion(-3,0,0));
	agregar(ruedas_d[1]);				// Rueda (inv) Delantera Derecha

}

unsigned C::leerNumParametros() const {
	return nparam;
}

void C::actualizarEstadoParametro( const unsigned iParam, const float t_sec ) {
	assert(iParam<leerNumParametros() && iParam>=0);
	float n = 0.05;
	
	Matriz4f tras;
	Matriz4f rot = MAT_Rotacion(60*t_sec, {1, 0, 0});
	Matriz4f rot_pala;
	Matriz4f dir_t = MAT_Rotacion(15*sin(2*M_PI*n*t_sec), {0, 1, 0}), dir_d;
	
	dir_d = MAT_Inversa(dir_t);
	
	switch (iParam){
		case 0: // Rotacion de las 8 ruedas
			// Si las ruedas están bajadas (por debajo de 0.15 de altura) giran
			if (tren_bajado){
				// El giro de estas ruedas es mayor cuanto más bajas se encuentren
				if (t_sec - sec_anterior > 0)
					rotacion += 2*(1-desplazamiento/0.15);
				else
					rotacion -= 2*(1-desplazamiento/0.15);
					
				rot_pala = MAT_Rotacion(rotacion, {1, 0, 0});
				*(ruedasPala[0]->rotacion) = rot_pala;
				*(ruedasPala[1]->rotacion) = rot_pala;
				*(ruedasPala_inv[0]->rotacion) = rot_pala;
				*(ruedasPala_inv[1]->rotacion) = rot_pala;
				
				sec_anterior = t_sec;
			}
			
			*(ruedas_t[0]->rotacion) = rot;
			*(ruedas_t[1]->rotacion) = rot;
			*(ruedas_d[0]->rotacion) = rot;
			*(ruedas_d[1]->rotacion) = rot;
			break;
		case 1: // Giro de las 4 ruedas con dirección
			*(ruedas_t[0]->direccion) = dir_t;
			*(ruedas_t[1]->direccion) = dir_t;
			*(ruedas_d[0]->direccion) = dir_d;
			*(ruedas_d[1]->direccion) = dir_d;
			break;
		case 2: // Elevación de las 4 ruedas dentadas
			desplazamiento = 0.15+0.15*sin(2*M_PI*(n*t_sec+3.0/4.0));
			tras = MAT_Traslacion(0, desplazamiento, 0);
			
			if (desplazamiento < 0.15)
				tren_bajado = true;
			else
				tren_bajado = false;
			
			*(ruedasPala[0]->elevacion) = tras;
			*(ruedasPala[1]->elevacion) = tras;
			*(ruedasPala_inv[0]->elevacion) = tras;
			*(ruedasPala_inv[1]->elevacion) = tras;
			break;
		case 3: // Rotación de la torreta
			*(torreta->giro) = MAT_Rotacion(10*t_sec, {0, 1, 0});
			break;
		case 4: // Elevación del cañón
			*(torreta->elevacion) = MAT_Rotacion(7*sin(2*M_PI*n*t_sec), {1, 0, 0});
			break;
		default: assert(false); break;
	}
	
}

//------------------------------------------------------------------------------

Rueda::Rueda(int l){
	direccion = leerPtrMatriz(agregar( MAT_Rotacion(0, {0, 1, 0})));
	rotacion = leerPtrMatriz(agregar( MAT_Rotacion(0, {1, 0, 0})));
	
	agregar(MAT_Rotacion(90,{0,0,1})*MAT_Escalado(1,0.5,1)*MAT_Traslacion(0,-0.5,0));
	agregar(new Cilindro(l,l));
	
	ponerColor( Tupla3f(0.2,0.2,0.2));	
}

//------------------------------------------------------------------------------

RuedaPala::RuedaPala(int l){
	float n = 0.05;
	elevacion = leerPtrMatriz(agregar( MAT_Traslacion(0, 0, 0)));
	rotacion = leerPtrMatriz(agregar( MAT_Rotacion(0, {1, 0, 0})));
	
	agregar(MAT_Rotacion(90,{0,0,1})*MAT_Escalado(0.9,0.5,0.9)*MAT_Traslacion(0,-0.5,0));
	agregar(new Cilindro(l,l));
	agregar(new Pala());
	
	Matriz4f rotacion = MAT_Rotacion(360/l, {0, 1, 0});
	
	for (int i=1; i<l; i++){
		agregar(rotacion);
		agregar(new Pala());
	}
	
	ponerColor( Tupla3f(0.3,0.4,0.5));	
}

//------------------------------------------------------------------------------

RuedaPala_Inv::RuedaPala_Inv(int l){
	float n = 0.05;
	elevacion = leerPtrMatriz(agregar( MAT_Traslacion(0, 0, 0)));
	rotacion = leerPtrMatriz(agregar( MAT_Rotacion(0, {1, 0, 0})));
	
	agregar(MAT_Rotacion(90,{0,0,1})*MAT_Escalado(0.9,0.5,0.9)*MAT_Traslacion(0,-0.5,0));
	agregar(new Cilindro(l,l));
	agregar(new Pala_Inv());
	
	Matriz4f rotacion = MAT_Rotacion(360/l, {0, 1, 0});
	
	for (int i=1; i<l; i++){
		agregar(rotacion);
		agregar(new Pala_Inv());
	}
	
	ponerColor( Tupla3f(0.3,0.4,0.5));	
}

//------------------------------------------------------------------------------

Pala::Pala(){
	Matriz4f init = MAT_Rotacion(15, {1, 0, 0})*MAT_Traslacion(1, 0.5, 0)*MAT_Escalado(0.05, 0.5, 0.05);
	
	agregar(init);
	agregar(new Cubo());
	
	ponerColor( Tupla3f(0.1,0.3,0.4));	
}

//------------------------------------------------------------------------------

Pala_Inv::Pala_Inv(){
	Matriz4f init = MAT_Rotacion(-15, {1, 0, 0})*MAT_Traslacion(1, 0.5, 0)*MAT_Escalado(0.05, 0.5, 0.05);
	
	agregar(init);
	agregar(new Cubo());
	
	ponerColor( Tupla3f(0.1,0.3,0.4));	
}

//------------------------------------------------------------------------------

Eje::Eje(int l){
	agregar(MAT_Rotacion(90,{0,0,1})*MAT_Escalado(0.13,2.8,0.13)*MAT_Traslacion(0,-0.5,0));
	agregar(new Cilindro(l,l));
	
	ponerColor( Tupla3f(0.3,0.5,0.7));		
}

//------------------------------------------------------------------------------

Torreta::Torreta(){
	m_cuerpo = new Material(new TexturaXY("../trabajo/imgs/body-mod.jpg"), 0.3, 1.0, 1.0, 30.0);
	m_cannon = new Material(new TexturaXY("../trabajo/imgs/cannon-mod.jpg"), 0.3, 1.0, 1.0, 30.0);
	
	giro = leerPtrMatriz(agregar( MAT_Rotacion(0, {0, 1, 0})));
	agregar(m_cuerpo);
	agregar(new CuerpoTorreta());
	
	elevacion = leerPtrMatriz(agregar( MAT_Rotacion(0, {1, 0, 0})));
	agregar(MAT_Traslacion(0,0.3,3.5));
	
	agregar(m_cannon);
	agregar(new Cannon(20));	
	agregar(MAT_Traslacion(0,-0.3,-3.5));
}

//------------------------------------------------------------------------------

Cannon::Cannon(int l){
	agregar(MAT_Rotacion(90,{0,1,0})*MAT_Rotacion(90,{0,0,1})*MAT_Escalado(0.13,7,0.13)*MAT_Traslacion(0,-0.5,0));
	agregar(new Cilindro(l,l));
	
	ponerColor( Tupla3f(0.3,0.5,0.7));		
}

//------------------------------------------------------------------------------

Cuerpo::Cuerpo(){
	vertices =
      {  { -0.5, 0, -3.5 }, // 0
         { 0.5, 0, -3.5 }, 	// 1
         { 1.25, 0, -1.5 }, // 2
         { 1.25, 0, 1.5 }, 	// 3
         { 0.5, 0, 3.5 }, 	// 4
         { -0.5, 0, 3.5 }, 	// 5
         { -1.25, 0, 1.5 }, // 6
         { -1.25, 0, -1.5 },// 7
         //--------------------
         { -0.5, 0.5, -3.5 },	// 8
         { 0.5, 0.5, -3.5 },	// 9
         { 1.25, 1.25, -1.5 }, 	// 10
         { 1.25, 1.25, 1.5 }, 	// 11
         { 0.5, 0.5, 3.5 }, 	// 12
         { -0.5, 0.5, 3.5 }, 	// 13
         { -1.25, 1.25, 1.5 }, 	// 14
         { -1.25, 1.25, -1.5 }, // 15
      } ;
      
    triangulos =
      { {0,1,2},	// Inferior
      	{0,2,7},
      	{2,3,6},
      	{2,6,7},
      	{3,4,5},
      	{3,5,6},
      	
      	{9,8,10},	// Superior
      	{10,8,15},
      	{11,10,14},
      	{14,10,15},
      	{12,11,13},
      	{13,11,14},
      	
      	{0,8,1},	// Laterales
      	{8,9,1},
      	{1,9,2},
      	{9,10,2},
      	{2,10,3},
      	{10,11,3},
      	{3,11,4},
      	{11,12,4},
      	{4,12,5},
      	{12,13,5},
      	{5,13,6},
      	{13,14,6},
      	{6,14,7},
      	{14,15,7},
      	{7,15,0},
      	{0,15,8}
      } ;
      
  	calcularNormales();
  	
	ponerColor( Tupla3f(0.3,0.5,0.7));	
}

//------------------------------------------------------------------------------

CuerpoTorreta::CuerpoTorreta(){
	vertices =
      {  { -1.25, 0, -2.5 },// 0
         { 1.25, 0, -2.5 },	// 1
         { 1.25, 0, 0.25 }, // 2
         { 0.75, 0, 1.5 }, 	// 3
         { -0.75, 0, 1.5 }, // 4
         { -1.25, 0, 0.25 },// 5
         //--------------------
         { -1, 0.65, -2.5 }, 		// 6
         { 1, 0.65, -2.5 }, 		// 7
         { 1.12, 0.65, -0.25 }, 	// 8
         { 0.75, 0.65, 1.25 }, 		// 9
         { -0.75, 0.65, 1.25 }, 	// 10
         { -1.12, 0.65, -0.25 },	// 11
      } ;
      
    triangulos =
      { {0,1,2},	// Inferior
      	{0,2,5},
      	{2,3,4},
      	{2,4,5},
      	
      	{6,8,7},	// Superior
      	{6,11,8},
      	{8,10,9},
      	{8,11,10},
      	
      	{0,6,1},	// Laterales
      	{6,7,1},
      	{1,7,2},
      	{7,8,2},
      	{2,8,3},
      	{8,9,3},
      	{3,9,4},
      	{9,10,4},
      	{4,11,5},
      	{10,11,4},
      	{5,11,6},
      	{5,6,0},
      } ;
      
  	calcularNormales();
      
	ponerColor( Tupla3f(0.4,0.6,0.8));	
}
