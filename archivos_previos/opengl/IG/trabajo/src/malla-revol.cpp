// *********************************************************************
// **
// ** Informática Gráfica, curso 2019-20
// ** Implementación de la clase 'MallaRevol'
// **
// *********************************************************************

#include "ig-aux.h"
#include "tuplasg.h"
#include "lector-ply.h"
#include "matrices-tr.h"
#include "malla-revol.h"

using namespace std ;

// *****************************************************************************




// Método que crea las tablas de vértices, triángulos, normales y cc.de.tt.
// a partir de un perfil y el número de copias que queremos de dicho perfil.
void MallaRevol::inicializar
(
   const std::vector<Tupla3f> & perfil,     // tabla de vértices del perfil original
   const unsigned               num_copias  // número de copias del perfil
)
{

	std::vector<Tupla3f> na, nv;
	std::vector<float> distancia, vect_t;
	Matriz4f rotacion90 = MAT_Rotacion(90,{0,0,1});
	Tupla3f v3;
	Tupla4f v4;

	// Normales de las aristas
	for (int i=0; i<perfil.size()-1; i++){
		v3 = perfil[i]-perfil[i+1];
		v4 = Tupla4f(v3[0], v3[1], 0, 1);
		v4 = rotacion90*v4;
		v3 = Tupla3f(v4[0], v4[1], 0);
		if (v3.lengthSq() != 0)
			v3 = v3.normalized();
		na.push_back(v3);
	}
	
	// Normales de los vértices
	if (na[0].lengthSq() != 0)
		na[0] = na[0].normalized();
	nv.push_back(na[0]);
	
	for (int i=0; i<perfil.size()-1; i++){
		v3 = na[i] + na[i+1];
		if (v3.lengthSq() != 0)
			v3 = v3.normalized();
		nv.push_back(v3);
	}
	
	if (na[na.size()-1].lengthSq() != 0)
		na[na.size()-1] = na[na.size()-1].normalized();
	nv.push_back(na[na.size()-1]);
	
	// Coordenadas de textura
	
	distancia.push_back(sqrt((perfil[1]-perfil[0]).lengthSq()));
	for (int i=1; i<perfil.size()-1; i++){
		distancia.push_back((sqrt((perfil[i+1]-perfil[i]).lengthSq()))+distancia[i-1]);
	}
	
	vect_t.push_back(0);
	for (int i=1; i<perfil.size(); i++){
		vect_t.push_back(distancia[i-1]/distancia[distancia.size()-1]);
	}
	
   // COMPLETAR: Práctica 2: completar: creación de la malla....
   	int m = perfil.size();
   	
   	for (int j=0; j<m; j++){
			vertices.push_back(perfil[j]);
			nor_ver.push_back(nv[j]);
			cc_tt_ver.push_back(Tupla2f(1.0, 1-vect_t[j]));
	}
	
   	for (int i=1; i<num_copias; i++){
		for (int j=0; j<m; j++){
			float a = i*(2*M_PI/(num_copias-1));
			Tupla3f p(perfil[j][0]*cos(a), perfil[j][1], perfil[j][0]*sin(a));
			vertices.push_back(p);
			v3 = nv[j];
			v3 = Tupla3f(v3[0]*cos(a), v3[1], v3[0]*sin(a));
			nor_ver.push_back(v3);
			cc_tt_ver.push_back(Tupla2f(1.0-(float)i/(num_copias-1.0), 1.0-vect_t[j]));
		}
	}

	for (int i=0; i<num_copias-1; i++){
		for (int j=0; j<m-1; j++){
			int k = i*m + j;
			Tupla3i p(k+m, k, k+m+1), q(k+m+1, k, k+1);
			triangulos.push_back(p);
			triangulos.push_back(q);
		}
	}
	
	//calcularNormales();


}

// ---------------------------------------------------------------------

Esfera::Esfera (const int num_verts_per, const unsigned nperfiles){
	vector<Tupla3f> perfil;
	float a = M_PI/num_verts_per;
	
	for (int i=num_verts_per; i>=0; i--)
		perfil.push_back(Tupla3f(sin(i*a),cos(i*a),0));
	
	inicializar(perfil, nperfiles);
}

// ---------------------------------------------------------------------

Cilindro::Cilindro (const int num_verts_per, const unsigned nperfiles){
	vector<Tupla3f> perfil;
	float u = 1.0/(num_verts_per-1);
	
	perfil.push_back(Tupla3f(0,0,0));
	
	for (int i=0; i<num_verts_per; i++)
		perfil.push_back(Tupla3f(1,i*u,0));
		
	perfil.push_back(Tupla3f(0,1,0));
	
	inicializar(perfil, nperfiles);
}

// ---------------------------------------------------------------------

Cono::Cono (const int num_verts_per, const unsigned nperfiles){
	vector<Tupla3f> perfil;
	float u = 1.0/(num_verts_per-1);
	
	perfil.push_back(Tupla3f(0,0,0));
	
	for (int i=0; i<num_verts_per; i++)
		perfil.push_back(Tupla3f(1-i*u,i*u,0));
	
	inicializar(perfil, nperfiles);
}

// -----------------------------------------------------------------------------
// constructor, a partir de un archivo PLY

MallaRevolPLY::MallaRevolPLY
(
   const std::string & nombre_arch,
   const unsigned      nperfiles
)
{
   ponerNombre( std::string("malla por revolución del perfil en '"+ nombre_arch + "'" ));
   // COMPLETAR: práctica 2: crear la malla de revolución
   // Leer los vértice del perfil desde un PLY, después llamar a 'inicializar'
   // ...........................
   vector<Tupla3f> perfil;
   LeerVerticesPLY(nombre_arch, perfil);
   inicializar(perfil, nperfiles);
}

