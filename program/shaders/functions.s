
float PI = 3.1415926;
float E = 2.71828182;


int funcionIf(bool cond, int e1, int e2)
{
	if (cond)
		 return e1;
	 else
		 return e2;
}

float funcionIf(bool cond, float e1, float e2)
{
	if (cond)
		 return e1;
	 else
		 return e2;
}

bool funcionIf(bool cond, bool e1, bool e2)
{
	if (cond)
		 return e1;
	 else
		 return e2;
}

vec2 funcionIf(bool cond, vec2 e1, vec2 e2)
{
	if (cond)
		 return e1;
	 else
		 return e2;
}

vec3 funcionIf(bool cond, vec3 e1, vec3 e2)
{
	if (cond)
		 return e1;
	 else
		 return e2;
}

mat2 funcionIf(bool cond, mat2 e1, mat2 e2)
{
	if (cond)
		 return e1;
	 else
		 return e2;
}

mat3 funcionIf(bool cond, mat3 e1, mat3 e2)
{
	if (cond)
		 return e1;
	 else
		 return e2;
}
vec3 fh(float u, float v) {
	return vec3( vec3(u *  cos(v),  pow((1.0 -  pow(u, 2)), 0.5), u *  sin(v)));
}

vec3 fhPu(float u, float v) {
	return vec3( vec3( cos(v), (0.5 *  pow((1.0 -  pow(u, 2)), -0.500000) * ( - (2 *  pow(u, 1.000000)))),  sin(v)));
}

vec3 fhPv(float u, float v) {
	return vec3( vec3((u * ( -  sin(v))), 0, (u *  cos(v))));
}

vec3 fhNormal(float u, float v) {
	return vec3( normalize( cross( fhPu(u, v),  fhPv(u, v))));
}

float fhArea(float u, float v) {
	return  distance( fhPu(u, v),  fhPv(u, v));
}

vec3 fhPuPu(float u, float v) {
	return vec3( vec3(0, ((0.5 * (-0.500000 *  pow((1.0 -  pow(u, 2)), -1.500000) * ( - (2 *  pow(u, 1.000000))))) * ( - (2 *  pow(u, 1.000000))) + 0.5 *  pow((1.0 -  pow(u, 2)), -0.500000) * ( - (2 * (1.000000 *  pow(u, 0.000000))))), 0));
}

vec3 fhPvPv(float u, float v) {
	return vec3( vec3((u * ( -  cos(v))), 0, (u * ( -  sin(v)))));
}

vec3 fhPuPv(float u, float v) {
	return vec3( vec3(( -  sin(v)), 0,  cos(v)));
}

float fhK(float u, float v) {
	return ( determinant( mat3( fhPuPu(u, v),  fhPu(u, v),  fhPv(u, v))) *  determinant( mat3( fhPvPv(u, v),  fhPu(u, v),  fhPv(u, v))) -  pow( determinant( mat3( fhPuPv(u, v),  fhPu(u, v),  fhPv(u, v))), 2)) /  pow( pow( length( fhPu(u, v)), 2) *  pow( length( fhPv(u, v)), 2) -  pow( dot( fhPu(u, v),  fhPv(u, v)), 2), 2);
}

vec3 fv1(float u, float v) {
	return vec3( vec3(u *  cos(v), u *  sin(v),  pow((1.0 -  pow(u, 2)), 0.5)));
}

vec3 fv1Pu(float u, float v) {
	return vec3( vec3( cos(v),  sin(v), (0.5 *  pow((1.0 -  pow(u, 2)), -0.500000) * ( - (2 *  pow(u, 1.000000))))));
}

vec3 fv1Pv(float u, float v) {
	return vec3( vec3((u * ( -  sin(v))), (u *  cos(v)), 0));
}

vec3 fv1Normal(float u, float v) {
	return vec3( normalize( cross( fv1Pu(u, v),  fv1Pv(u, v))));
}

float fv1Area(float u, float v) {
	return  distance( fv1Pu(u, v),  fv1Pv(u, v));
}

vec3 fv1PuPu(float u, float v) {
	return vec3( vec3(0, 0, ((0.5 * (-0.500000 *  pow((1.0 -  pow(u, 2)), -1.500000) * ( - (2 *  pow(u, 1.000000))))) * ( - (2 *  pow(u, 1.000000))) + 0.5 *  pow((1.0 -  pow(u, 2)), -0.500000) * ( - (2 * (1.000000 *  pow(u, 0.000000)))))));
}

vec3 fv1PvPv(float u, float v) {
	return vec3( vec3((u * ( -  cos(v))), (u * ( -  sin(v))), 0));
}

vec3 fv1PuPv(float u, float v) {
	return vec3( vec3(( -  sin(v)),  cos(v), 0));
}

float fv1K(float u, float v) {
	return ( determinant( mat3( fv1PuPu(u, v),  fv1Pu(u, v),  fv1Pv(u, v))) *  determinant( mat3( fv1PvPv(u, v),  fv1Pu(u, v),  fv1Pv(u, v))) -  pow( determinant( mat3( fv1PuPv(u, v),  fv1Pu(u, v),  fv1Pv(u, v))), 2)) /  pow( pow( length( fv1Pu(u, v)), 2) *  pow( length( fv1Pv(u, v)), 2) -  pow( dot( fv1Pu(u, v),  fv1Pv(u, v)), 2), 2);
}

vec3 fv2(float u, float v) {
	return vec3( vec3( pow((1.0 -  pow(u, 2)), 0.5), u *  cos(v), u *  sin(v)));
}

vec3 fv2Pu(float u, float v) {
	return vec3( vec3((0.5 *  pow((1.0 -  pow(u, 2)), -0.500000) * ( - (2 *  pow(u, 1.000000)))),  cos(v),  sin(v)));
}

vec3 fv2Pv(float u, float v) {
	return vec3( vec3(0, (u * ( -  sin(v))), (u *  cos(v))));
}

vec3 fv2Normal(float u, float v) {
	return vec3( normalize( cross( fv2Pu(u, v),  fv2Pv(u, v))));
}

float fv2Area(float u, float v) {
	return  distance( fv2Pu(u, v),  fv2Pv(u, v));
}

vec3 fv2PuPu(float u, float v) {
	return vec3( vec3(((0.5 * (-0.500000 *  pow((1.0 -  pow(u, 2)), -1.500000) * ( - (2 *  pow(u, 1.000000))))) * ( - (2 *  pow(u, 1.000000))) + 0.5 *  pow((1.0 -  pow(u, 2)), -0.500000) * ( - (2 * (1.000000 *  pow(u, 0.000000))))), 0, 0));
}

vec3 fv2PvPv(float u, float v) {
	return vec3( vec3(0, (u * ( -  cos(v))), (u * ( -  sin(v)))));
}

vec3 fv2PuPv(float u, float v) {
	return vec3( vec3(0, ( -  sin(v)),  cos(v)));
}

float fv2K(float u, float v) {
	return ( determinant( mat3( fv2PuPu(u, v),  fv2Pu(u, v),  fv2Pv(u, v))) *  determinant( mat3( fv2PvPv(u, v),  fv2Pu(u, v),  fv2Pv(u, v))) -  pow( determinant( mat3( fv2PuPv(u, v),  fv2Pu(u, v),  fv2Pv(u, v))), 2)) /  pow( pow( length( fv2Pu(u, v)), 2) *  pow( length( fv2Pv(u, v)), 2) -  pow( dot( fv2Pu(u, v),  fv2Pv(u, v)), 2), 2);
}

vec3 g1(float u, float v) {
	return vec3( fh(u,  - 2 * PI * v));
}

vec3 g1Pu(float u, float v) {
	return vec3( fhPu(u,  - 2 * PI * v));
}

vec3 g1Pv(float u, float v) {
	return vec3(( fhPv(u,  - 2 * PI * v) * ( - (2 * PI))));
}

vec3 g1Normal(float u, float v) {
	return vec3( normalize( cross( g1Pu(u, v),  g1Pv(u, v))));
}

float g1Area(float u, float v) {
	return  distance( g1Pu(u, v),  g1Pv(u, v));
}

vec3 g1PuPu(float u, float v) {
	return vec3( fhPuPu(u,  - 2 * PI * v));
}

vec3 fhPvPu(float u, float v) {
	return vec3( vec3(( -  sin(v)), 0,  cos(v)));
}

vec3 g1PvPv(float u, float v) {
	return vec3((( fhPvPv(u,  - 2 * PI * v) * ( - (2 * PI))) * ( - (2 * PI))));
}

vec3 g1PuPv(float u, float v) {
	return vec3(( fhPuPv(u,  - 2 * PI * v) * ( - (2 * PI))));
}

float g1K(float u, float v) {
	return ( determinant( mat3( g1PuPu(u, v),  g1Pu(u, v),  g1Pv(u, v))) *  determinant( mat3( g1PvPv(u, v),  g1Pu(u, v),  g1Pv(u, v))) -  pow( determinant( mat3( g1PuPv(u, v),  g1Pu(u, v),  g1Pv(u, v))), 2)) /  pow( pow( length( g1Pu(u, v)), 2) *  pow( length( g1Pv(u, v)), 2) -  pow( dot( g1Pu(u, v),  g1Pv(u, v)), 2), 2);
}

vec3 g2(float u, float v) {
	return vec3( -  fh(u, 2 * PI * v));
}

vec3 g2Pu(float u, float v) {
	return vec3(( -  fhPu(u, 2 * PI * v)));
}

vec3 g2Pv(float u, float v) {
	return vec3(( - ( fhPv(u, 2 * PI * v) * (2 * PI))));
}

vec3 g2Normal(float u, float v) {
	return vec3( normalize( cross( g2Pu(u, v),  g2Pv(u, v))));
}

float g2Area(float u, float v) {
	return  distance( g2Pu(u, v),  g2Pv(u, v));
}

vec3 g2PuPu(float u, float v) {
	return vec3(( -  fhPuPu(u, 2 * PI * v)));
}

vec3 g2PvPv(float u, float v) {
	return vec3(( - (( fhPvPv(u, 2 * PI * v) * (2 * PI)) * (2 * PI))));
}

vec3 g2PuPv(float u, float v) {
	return vec3(( - ( fhPuPv(u, 2 * PI * v) * (2 * PI))));
}

float g2K(float u, float v) {
	return ( determinant( mat3( g2PuPu(u, v),  g2Pu(u, v),  g2Pv(u, v))) *  determinant( mat3( g2PvPv(u, v),  g2Pu(u, v),  g2Pv(u, v))) -  pow( determinant( mat3( g2PuPv(u, v),  g2Pu(u, v),  g2Pv(u, v))), 2)) /  pow( pow( length( g2Pu(u, v)), 2) *  pow( length( g2Pv(u, v)), 2) -  pow( dot( g2Pu(u, v),  g2Pv(u, v)), 2), 2);
}

vec3 g3(float u, float v) {
	return vec3( fv1(u, 2 * PI * v));
}

vec3 g3Pu(float u, float v) {
	return vec3( fv1Pu(u, 2 * PI * v));
}

vec3 g3Pv(float u, float v) {
	return vec3(( fv1Pv(u, 2 * PI * v) * (2 * PI)));
}

vec3 g3Normal(float u, float v) {
	return vec3( normalize( cross( g3Pu(u, v),  g3Pv(u, v))));
}

float g3Area(float u, float v) {
	return  distance( g3Pu(u, v),  g3Pv(u, v));
}

vec3 g3PuPu(float u, float v) {
	return vec3( fv1PuPu(u, 2 * PI * v));
}

vec3 fv1PvPu(float u, float v) {
	return vec3( vec3(( -  sin(v)),  cos(v), 0));
}

vec3 g3PvPv(float u, float v) {
	return vec3((( fv1PvPv(u, 2 * PI * v) * (2 * PI)) * (2 * PI)));
}

vec3 g3PuPv(float u, float v) {
	return vec3(( fv1PuPv(u, 2 * PI * v) * (2 * PI)));
}

float g3K(float u, float v) {
	return ( determinant( mat3( g3PuPu(u, v),  g3Pu(u, v),  g3Pv(u, v))) *  determinant( mat3( g3PvPv(u, v),  g3Pu(u, v),  g3Pv(u, v))) -  pow( determinant( mat3( g3PuPv(u, v),  g3Pu(u, v),  g3Pv(u, v))), 2)) /  pow( pow( length( g3Pu(u, v)), 2) *  pow( length( g3Pv(u, v)), 2) -  pow( dot( g3Pu(u, v),  g3Pv(u, v)), 2), 2);
}

vec3 g4(float u, float v) {
	return vec3( -  fv1(u,  - 2 * PI * v));
}

vec3 g4Pu(float u, float v) {
	return vec3(( -  fv1Pu(u,  - 2 * PI * v)));
}

vec3 g4Pv(float u, float v) {
	return vec3(( - ( fv1Pv(u,  - 2 * PI * v) * ( - (2 * PI)))));
}

vec3 g4Normal(float u, float v) {
	return vec3( normalize( cross( g4Pu(u, v),  g4Pv(u, v))));
}

float g4Area(float u, float v) {
	return  distance( g4Pu(u, v),  g4Pv(u, v));
}

vec3 g4PuPu(float u, float v) {
	return vec3(( -  fv1PuPu(u,  - 2 * PI * v)));
}

vec3 g4PvPv(float u, float v) {
	return vec3(( - (( fv1PvPv(u,  - 2 * PI * v) * ( - (2 * PI))) * ( - (2 * PI)))));
}

vec3 g4PuPv(float u, float v) {
	return vec3(( - ( fv1PuPv(u,  - 2 * PI * v) * ( - (2 * PI)))));
}

float g4K(float u, float v) {
	return ( determinant( mat3( g4PuPu(u, v),  g4Pu(u, v),  g4Pv(u, v))) *  determinant( mat3( g4PvPv(u, v),  g4Pu(u, v),  g4Pv(u, v))) -  pow( determinant( mat3( g4PuPv(u, v),  g4Pu(u, v),  g4Pv(u, v))), 2)) /  pow( pow( length( g4Pu(u, v)), 2) *  pow( length( g4Pv(u, v)), 2) -  pow( dot( g4Pu(u, v),  g4Pv(u, v)), 2), 2);
}

vec3 g5(float u, float v) {
	return vec3( fv2(u, 2 * PI * v));
}

vec3 g5Pu(float u, float v) {
	return vec3( fv2Pu(u, 2 * PI * v));
}

vec3 g5Pv(float u, float v) {
	return vec3(( fv2Pv(u, 2 * PI * v) * (2 * PI)));
}

vec3 g5Normal(float u, float v) {
	return vec3( normalize( cross( g5Pu(u, v),  g5Pv(u, v))));
}

float g5Area(float u, float v) {
	return  distance( g5Pu(u, v),  g5Pv(u, v));
}

vec3 g5PuPu(float u, float v) {
	return vec3( fv2PuPu(u, 2 * PI * v));
}

vec3 fv2PvPu(float u, float v) {
	return vec3( vec3(0, ( -  sin(v)),  cos(v)));
}

vec3 g5PvPv(float u, float v) {
	return vec3((( fv2PvPv(u, 2 * PI * v) * (2 * PI)) * (2 * PI)));
}

vec3 g5PuPv(float u, float v) {
	return vec3(( fv2PuPv(u, 2 * PI * v) * (2 * PI)));
}

float g5K(float u, float v) {
	return ( determinant( mat3( g5PuPu(u, v),  g5Pu(u, v),  g5Pv(u, v))) *  determinant( mat3( g5PvPv(u, v),  g5Pu(u, v),  g5Pv(u, v))) -  pow( determinant( mat3( g5PuPv(u, v),  g5Pu(u, v),  g5Pv(u, v))), 2)) /  pow( pow( length( g5Pu(u, v)), 2) *  pow( length( g5Pv(u, v)), 2) -  pow( dot( g5Pu(u, v),  g5Pv(u, v)), 2), 2);
}

vec3 g6(float u, float v) {
	return vec3( -  fv2(u,  - 2 * PI * v));
}

vec3 g6Pu(float u, float v) {
	return vec3(( -  fv2Pu(u,  - 2 * PI * v)));
}

vec3 g6Pv(float u, float v) {
	return vec3(( - ( fv2Pv(u,  - 2 * PI * v) * ( - (2 * PI)))));
}

vec3 g6Normal(float u, float v) {
	return vec3( normalize( cross( g6Pu(u, v),  g6Pv(u, v))));
}

float g6Area(float u, float v) {
	return  distance( g6Pu(u, v),  g6Pv(u, v));
}

vec3 g6PuPu(float u, float v) {
	return vec3(( -  fv2PuPu(u,  - 2 * PI * v)));
}

vec3 g6PvPv(float u, float v) {
	return vec3(( - (( fv2PvPv(u,  - 2 * PI * v) * ( - (2 * PI))) * ( - (2 * PI)))));
}

vec3 g6PuPv(float u, float v) {
	return vec3(( - ( fv2PuPv(u,  - 2 * PI * v) * ( - (2 * PI)))));
}

float g6K(float u, float v) {
	return ( determinant( mat3( g6PuPu(u, v),  g6Pu(u, v),  g6Pv(u, v))) *  determinant( mat3( g6PvPv(u, v),  g6Pu(u, v),  g6Pv(u, v))) -  pow( determinant( mat3( g6PuPv(u, v),  g6Pu(u, v),  g6Pv(u, v))), 2)) /  pow( pow( length( g6Pu(u, v)), 2) *  pow( length( g6Pv(u, v)), 2) -  pow( dot( g6Pu(u, v),  g6Pv(u, v)), 2), 2);
}

vec3 functionParam(vec2 p) {
	if (funPlot==0) {
		return g1(p.x, p.y);
	} else if (funPlot==1) {
		return g2(p.x, p.y);
	} else if (funPlot==2) {
		return g3(p.x, p.y);
	} else if (funPlot==3) {
		return g4(p.x, p.y);
	} else if (funPlot==4) {
		return g5(p.x, p.y);
	} else if (funPlot==5) {
		return g6(p.x, p.y);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 normalParam(vec2 p) {
	if (funPlot==0) {
		return g1Normal(p.x, p.y);
	} else if (funPlot==1) {
		return g2Normal(p.x, p.y);
	} else if (funPlot==2) {
		return g3Normal(p.x, p.y);
	} else if (funPlot==3) {
		return g4Normal(p.x, p.y);
	} else if (funPlot==4) {
		return g5Normal(p.x, p.y);
	} else if (funPlot==5) {
		return g6Normal(p.x, p.y);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 tangentParam(vec2 p) {
	if (funPlot==0) {
		return g1Pu(p.x, p.y);
	} else if (funPlot==1) {
		return g2Pu(p.x, p.y);
	} else if (funPlot==2) {
		return g3Pu(p.x, p.y);
	} else if (funPlot==3) {
		return g4Pu(p.x, p.y);
	} else if (funPlot==4) {
		return g5Pu(p.x, p.y);
	} else if (funPlot==5) {
		return g6Pu(p.x, p.y);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 cotangentParam(vec2 p) {
	if (funPlot==0) {
		return g1Pv(p.x, p.y);
	} else if (funPlot==1) {
		return g2Pv(p.x, p.y);
	} else if (funPlot==2) {
		return g3Pv(p.x, p.y);
	} else if (funPlot==3) {
		return g4Pv(p.x, p.y);
	} else if (funPlot==4) {
		return g5Pv(p.x, p.y);
	} else if (funPlot==5) {
		return g6Pv(p.x, p.y);
	}

	return vec3(0.0, 0.0, 0.0);
}

float areaParam(vec2 p) {
	if (funPlot==0) {
		return g1Area(p.x, p.y);
	} else if (funPlot==1) {
		return g2Area(p.x, p.y);
	} else if (funPlot==2) {
		return g3Area(p.x, p.y);
	} else if (funPlot==3) {
		return g4Area(p.x, p.y);
	} else if (funPlot==4) {
		return g5Area(p.x, p.y);
	} else if (funPlot==5) {
		return g6Area(p.x, p.y);
	}

	return 0.0;
}

float curvatureParam(vec2 p) {
	if (funPlot==0) {
		return g1K(p.x, p.y);
	} else if (funPlot==1) {
		return g2K(p.x, p.y);
	} else if (funPlot==2) {
		return g3K(p.x, p.y);
	} else if (funPlot==3) {
		return g4K(p.x, p.y);
	} else if (funPlot==4) {
		return g5K(p.x, p.y);
	} else if (funPlot==5) {
		return g6K(p.x, p.y);
	}

	return 0.0;
}

