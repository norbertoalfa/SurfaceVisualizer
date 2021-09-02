
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
vec3 f(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(u, alt *  cos(Fr * (a * u + b * v) + 2 * PI * t), v));
}

vec3 fPu(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(1, (alt * (( -  sin(Fr * (a * u + b * v) + 2 * PI * t)) * (Fr * a))), 0));
}

vec3 fPv(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( -  sin(Fr * (a * u + b * v) + 2 * PI * t)) * (Fr * b))), 1));
}

vec3 fNormal(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( normalize( cross( fPu(u, v, Fr, alt, a, b, t),  fPv(u, v, Fr, alt, a, b, t))));
}

float fArea(float u, float v, float Fr, float alt, float a, float b, float t) {
	return  distance( fPu(u, v, Fr, alt, a, b, t),  fPv(u, v, Fr, alt, a, b, t));
}

vec3 fPuPu(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( - ( cos(Fr * (a * u + b * v) + 2 * PI * t) * (Fr * a))) * (Fr * a))), 0));
}

vec3 fPvPv(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( - ( cos(Fr * (a * u + b * v) + 2 * PI * t) * (Fr * b))) * (Fr * b))), 0));
}

vec3 fPuPv(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( - ( cos(Fr * (a * u + b * v) + 2 * PI * t) * (Fr * b))) * (Fr * a))), 0));
}

float fK(float u, float v, float Fr, float alt, float a, float b, float t) {
	return ( determinant( mat3( fPuPu(u, v, Fr, alt, a, b, t),  fPu(u, v, Fr, alt, a, b, t),  fPv(u, v, Fr, alt, a, b, t))) *  determinant( mat3( fPvPv(u, v, Fr, alt, a, b, t),  fPu(u, v, Fr, alt, a, b, t),  fPv(u, v, Fr, alt, a, b, t))) -  pow( determinant( mat3( fPuPv(u, v, Fr, alt, a, b, t),  fPu(u, v, Fr, alt, a, b, t),  fPv(u, v, Fr, alt, a, b, t))), 2)) /  pow( pow( length( fPu(u, v, Fr, alt, a, b, t)), 2) *  pow( length( fPv(u, v, Fr, alt, a, b, t)), 2) -  pow( dot( fPu(u, v, Fr, alt, a, b, t),  fPv(u, v, Fr, alt, a, b, t)), 2), 2);
}

vec3 g1(float u, float v, float Fr, float alt, float t0) {
	return vec3( f(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0));
}

vec3 fPFr(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( -  sin(Fr * (a * u + b * v) + 2 * PI * t)) * (a * u + b * v))), 0));
}

vec3 fPalt(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0,  cos(Fr * (a * u + b * v) + 2 * PI * t), 0));
}

vec3 fPa(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( -  sin(Fr * (a * u + b * v) + 2 * PI * t)) * (Fr * u))), 0));
}

vec3 fPb(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( -  sin(Fr * (a * u + b * v) + 2 * PI * t)) * (Fr * v))), 0));
}

vec3 fPt(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( -  sin(Fr * (a * u + b * v) + 2 * PI * t)) * (2 * PI))), 0));
}

vec3 g1Pu(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPu(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0));
}

vec3 g1Pv(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPv(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0));
}

vec3 g1Normal(float u, float v, float Fr, float alt, float t0) {
	return vec3( normalize( cross( g1Pu(u, v, Fr, alt, t0),  g1Pv(u, v, Fr, alt, t0))));
}

float g1Area(float u, float v, float Fr, float alt, float t0) {
	return  distance( g1Pu(u, v, Fr, alt, t0),  g1Pv(u, v, Fr, alt, t0));
}

vec3 fPuPFr(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( - ( cos(Fr * (a * u + b * v) + 2 * PI * t) * (a * u + b * v))) * (Fr * a) + ( -  sin(Fr * (a * u + b * v) + 2 * PI * t)) * a)), 0));
}

vec3 fPuPalt(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (( -  sin(Fr * (a * u + b * v) + 2 * PI * t)) * (Fr * a)), 0));
}

vec3 fPuPa(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( - ( cos(Fr * (a * u + b * v) + 2 * PI * t) * (Fr * u))) * (Fr * a) + ( -  sin(Fr * (a * u + b * v) + 2 * PI * t)) * Fr)), 0));
}

vec3 fPuPb(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( - ( cos(Fr * (a * u + b * v) + 2 * PI * t) * (Fr * v))) * (Fr * a))), 0));
}

vec3 fPuPt(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( - ( cos(Fr * (a * u + b * v) + 2 * PI * t) * (2 * PI))) * (Fr * a))), 0));
}

vec3 g1PuPu(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPuPu(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0));
}

vec3 fPvPu(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( - ( cos(Fr * (a * u + b * v) + 2 * PI * t) * (Fr * a))) * (Fr * b))), 0));
}

vec3 fPvPFr(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( - ( cos(Fr * (a * u + b * v) + 2 * PI * t) * (a * u + b * v))) * (Fr * b) + ( -  sin(Fr * (a * u + b * v) + 2 * PI * t)) * b)), 0));
}

vec3 fPvPalt(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (( -  sin(Fr * (a * u + b * v) + 2 * PI * t)) * (Fr * b)), 0));
}

vec3 fPvPa(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( - ( cos(Fr * (a * u + b * v) + 2 * PI * t) * (Fr * u))) * (Fr * b))), 0));
}

vec3 fPvPb(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( - ( cos(Fr * (a * u + b * v) + 2 * PI * t) * (Fr * v))) * (Fr * b) + ( -  sin(Fr * (a * u + b * v) + 2 * PI * t)) * Fr)), 0));
}

vec3 fPvPt(float u, float v, float Fr, float alt, float a, float b, float t) {
	return vec3( vec3(0, (alt * (( - ( cos(Fr * (a * u + b * v) + 2 * PI * t) * (2 * PI))) * (Fr * b))), 0));
}

vec3 g1PvPv(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPvPv(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0));
}

vec3 g1PuPv(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPuPv(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0));
}

float g1K(float u, float v, float Fr, float alt, float t0) {
	return ( determinant( mat3( g1PuPu(u, v, Fr, alt, t0),  g1Pu(u, v, Fr, alt, t0),  g1Pv(u, v, Fr, alt, t0))) *  determinant( mat3( g1PvPv(u, v, Fr, alt, t0),  g1Pu(u, v, Fr, alt, t0),  g1Pv(u, v, Fr, alt, t0))) -  pow( determinant( mat3( g1PuPv(u, v, Fr, alt, t0),  g1Pu(u, v, Fr, alt, t0),  g1Pv(u, v, Fr, alt, t0))), 2)) /  pow( pow( length( g1Pu(u, v, Fr, alt, t0)), 2) *  pow( length( g1Pv(u, v, Fr, alt, t0)), 2) -  pow( dot( g1Pu(u, v, Fr, alt, t0),  g1Pv(u, v, Fr, alt, t0)), 2), 2);
}

vec3 g2(float u, float v, float Fr, float alt, float t0) {
	return vec3( f(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0));
}

vec3 g2Pu(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPu(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0));
}

vec3 g2Pv(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPv(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0));
}

vec3 g2Normal(float u, float v, float Fr, float alt, float t0) {
	return vec3( normalize( cross( g2Pu(u, v, Fr, alt, t0),  g2Pv(u, v, Fr, alt, t0))));
}

float g2Area(float u, float v, float Fr, float alt, float t0) {
	return  distance( g2Pu(u, v, Fr, alt, t0),  g2Pv(u, v, Fr, alt, t0));
}

vec3 g2PuPu(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPuPu(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0));
}

vec3 g2PvPv(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPvPv(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0));
}

vec3 g2PuPv(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPuPv(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0));
}

float g2K(float u, float v, float Fr, float alt, float t0) {
	return ( determinant( mat3( g2PuPu(u, v, Fr, alt, t0),  g2Pu(u, v, Fr, alt, t0),  g2Pv(u, v, Fr, alt, t0))) *  determinant( mat3( g2PvPv(u, v, Fr, alt, t0),  g2Pu(u, v, Fr, alt, t0),  g2Pv(u, v, Fr, alt, t0))) -  pow( determinant( mat3( g2PuPv(u, v, Fr, alt, t0),  g2Pu(u, v, Fr, alt, t0),  g2Pv(u, v, Fr, alt, t0))), 2)) /  pow( pow( length( g2Pu(u, v, Fr, alt, t0)), 2) *  pow( length( g2Pv(u, v, Fr, alt, t0)), 2) -  pow( dot( g2Pu(u, v, Fr, alt, t0),  g2Pv(u, v, Fr, alt, t0)), 2), 2);
}

vec3 g3(float u, float v, float Fr, float alt, float t0) {
	return vec3( f(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI));
}

vec3 g3Pu(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPu(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI));
}

vec3 g3Pv(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPv(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI));
}

vec3 g3Normal(float u, float v, float Fr, float alt, float t0) {
	return vec3( normalize( cross( g3Pu(u, v, Fr, alt, t0),  g3Pv(u, v, Fr, alt, t0))));
}

float g3Area(float u, float v, float Fr, float alt, float t0) {
	return  distance( g3Pu(u, v, Fr, alt, t0),  g3Pv(u, v, Fr, alt, t0));
}

vec3 g3PuPu(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPuPu(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI));
}

vec3 g3PvPv(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPvPv(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI));
}

vec3 g3PuPv(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPuPv(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI));
}

float g3K(float u, float v, float Fr, float alt, float t0) {
	return ( determinant( mat3( g3PuPu(u, v, Fr, alt, t0),  g3Pu(u, v, Fr, alt, t0),  g3Pv(u, v, Fr, alt, t0))) *  determinant( mat3( g3PvPv(u, v, Fr, alt, t0),  g3Pu(u, v, Fr, alt, t0),  g3Pv(u, v, Fr, alt, t0))) -  pow( determinant( mat3( g3PuPv(u, v, Fr, alt, t0),  g3Pu(u, v, Fr, alt, t0),  g3Pv(u, v, Fr, alt, t0))), 2)) /  pow( pow( length( g3Pu(u, v, Fr, alt, t0)), 2) *  pow( length( g3Pv(u, v, Fr, alt, t0)), 2) -  pow( dot( g3Pu(u, v, Fr, alt, t0),  g3Pv(u, v, Fr, alt, t0)), 2), 2);
}

vec3 g4(float u, float v, float Fr, float alt, float t0) {
	return vec3( f(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI));
}

vec3 g4Pu(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPu(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI));
}

vec3 g4Pv(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPv(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI));
}

vec3 g4Normal(float u, float v, float Fr, float alt, float t0) {
	return vec3( normalize( cross( g4Pu(u, v, Fr, alt, t0),  g4Pv(u, v, Fr, alt, t0))));
}

float g4Area(float u, float v, float Fr, float alt, float t0) {
	return  distance( g4Pu(u, v, Fr, alt, t0),  g4Pv(u, v, Fr, alt, t0));
}

vec3 g4PuPu(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPuPu(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI));
}

vec3 g4PvPv(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPvPv(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI));
}

vec3 g4PuPv(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPuPv(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI));
}

float g4K(float u, float v, float Fr, float alt, float t0) {
	return ( determinant( mat3( g4PuPu(u, v, Fr, alt, t0),  g4Pu(u, v, Fr, alt, t0),  g4Pv(u, v, Fr, alt, t0))) *  determinant( mat3( g4PvPv(u, v, Fr, alt, t0),  g4Pu(u, v, Fr, alt, t0),  g4Pv(u, v, Fr, alt, t0))) -  pow( determinant( mat3( g4PuPv(u, v, Fr, alt, t0),  g4Pu(u, v, Fr, alt, t0),  g4Pv(u, v, Fr, alt, t0))), 2)) /  pow( pow( length( g4Pu(u, v, Fr, alt, t0)), 2) *  pow( length( g4Pv(u, v, Fr, alt, t0)), 2) -  pow( dot( g4Pu(u, v, Fr, alt, t0),  g4Pv(u, v, Fr, alt, t0)), 2), 2);
}

vec3 g(float u, float v, float Fr, float alt, float t0) {
	return vec3( g1(u, v, Fr, alt, t0) +  g2(u, v, Fr, alt, t0) +  g3(u, v, Fr, alt, t0) +  g4(u, v, Fr, alt, t0));
}

vec3 g4PFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPFr(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI) * 1.3));
}

vec3 g4Palt(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPalt(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI) * 0.7));
}

vec3 g4Pt0(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPt(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI));
}

vec3 g3PFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPFr(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI) * 1.1));
}

vec3 g3Palt(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPalt(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI) * 1.3));
}

vec3 g3Pt0(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPt(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI));
}

vec3 g2PFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPFr(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0) * 0.9));
}

vec3 g2Palt(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPalt(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0) * 1.1));
}

vec3 g2Pt0(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPt(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0));
}

vec3 g1PFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPFr(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0) * 0.7));
}

vec3 g1Palt(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPalt(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0) * 0.9));
}

vec3 g1Pt0(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPt(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0));
}

vec3 gPu(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1Pu(u, v, Fr, alt, t0) +  g2Pu(u, v, Fr, alt, t0)) +  g3Pu(u, v, Fr, alt, t0)) +  g4Pu(u, v, Fr, alt, t0)));
}

vec3 gPv(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1Pv(u, v, Fr, alt, t0) +  g2Pv(u, v, Fr, alt, t0)) +  g3Pv(u, v, Fr, alt, t0)) +  g4Pv(u, v, Fr, alt, t0)));
}

vec3 gNormal(float u, float v, float Fr, float alt, float t0) {
	return vec3( normalize( cross( gPu(u, v, Fr, alt, t0),  gPv(u, v, Fr, alt, t0))));
}

float gArea(float u, float v, float Fr, float alt, float t0) {
	return  distance( gPu(u, v, Fr, alt, t0),  gPv(u, v, Fr, alt, t0));
}

vec3 g4PuPFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPuPFr(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI) * 1.3));
}

vec3 g4PuPalt(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPuPalt(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI) * 0.7));
}

vec3 g4PuPt0(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPuPt(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI));
}

vec3 g3PuPFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPuPFr(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI) * 1.1));
}

vec3 g3PuPalt(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPuPalt(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI) * 1.3));
}

vec3 g3PuPt0(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPuPt(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI));
}

vec3 g2PuPFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPuPFr(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0) * 0.9));
}

vec3 g2PuPalt(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPuPalt(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0) * 1.1));
}

vec3 g2PuPt0(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPuPt(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0));
}

vec3 g1PuPFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPuPFr(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0) * 0.7));
}

vec3 g1PuPalt(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPuPalt(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0) * 0.9));
}

vec3 g1PuPt0(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPuPt(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0));
}

vec3 gPuPu(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1PuPu(u, v, Fr, alt, t0) +  g2PuPu(u, v, Fr, alt, t0)) +  g3PuPu(u, v, Fr, alt, t0)) +  g4PuPu(u, v, Fr, alt, t0)));
}

vec3 g4PvPu(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPvPu(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI));
}

vec3 g4PvPFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPvPFr(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI) * 1.3));
}

vec3 g4PvPalt(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPvPalt(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI) * 0.7));
}

vec3 g4PvPt0(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPvPt(u, v, 1.3 * Fr, 0.7 * alt, 0, 1, t0 + 0.25 * PI));
}

vec3 g3PvPu(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPvPu(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI));
}

vec3 g3PvPFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPvPFr(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI) * 1.1));
}

vec3 g3PvPalt(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPvPalt(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI) * 1.3));
}

vec3 g3PvPt0(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPvPt(u, v, 1.1 * Fr, 1.3 * alt, 0.7, 0.3, t0 + 0.25 * PI));
}

vec3 g2PvPu(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPvPu(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0));
}

vec3 g2PvPFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPvPFr(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0) * 0.9));
}

vec3 g2PvPalt(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPvPalt(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0) * 1.1));
}

vec3 g2PvPt0(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPvPt(u, v, 0.9 * Fr, 1.1 * alt, 0.3, 0.7, t0));
}

vec3 g1PvPu(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPvPu(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0));
}

vec3 g1PvPFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPvPFr(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0) * 0.7));
}

vec3 g1PvPalt(float u, float v, float Fr, float alt, float t0) {
	return vec3(( fPvPalt(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0) * 0.9));
}

vec3 g1PvPt0(float u, float v, float Fr, float alt, float t0) {
	return vec3( fPvPt(u, v, 0.7 * Fr, 0.9 * alt, 1, 0, t0));
}

vec3 gPvPv(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1PvPv(u, v, Fr, alt, t0) +  g2PvPv(u, v, Fr, alt, t0)) +  g3PvPv(u, v, Fr, alt, t0)) +  g4PvPv(u, v, Fr, alt, t0)));
}

vec3 gPuPv(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1PuPv(u, v, Fr, alt, t0) +  g2PuPv(u, v, Fr, alt, t0)) +  g3PuPv(u, v, Fr, alt, t0)) +  g4PuPv(u, v, Fr, alt, t0)));
}

float gK(float u, float v, float Fr, float alt, float t0) {
	return ( determinant( mat3( gPuPu(u, v, Fr, alt, t0),  gPu(u, v, Fr, alt, t0),  gPv(u, v, Fr, alt, t0))) *  determinant( mat3( gPvPv(u, v, Fr, alt, t0),  gPu(u, v, Fr, alt, t0),  gPv(u, v, Fr, alt, t0))) -  pow( determinant( mat3( gPuPv(u, v, Fr, alt, t0),  gPu(u, v, Fr, alt, t0),  gPv(u, v, Fr, alt, t0))), 2)) /  pow( pow( length( gPu(u, v, Fr, alt, t0)), 2) *  pow( length( gPv(u, v, Fr, alt, t0)), 2) -  pow( dot( gPu(u, v, Fr, alt, t0),  gPv(u, v, Fr, alt, t0)), 2), 2);
}

vec3 h(float u, float v, float t0) {
	return vec3( g(10 * u, 10 * v, 1.7, 0.5, 2 * t0));
}

vec3 gPFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1PFr(u, v, Fr, alt, t0) +  g2PFr(u, v, Fr, alt, t0)) +  g3PFr(u, v, Fr, alt, t0)) +  g4PFr(u, v, Fr, alt, t0)));
}

vec3 gPalt(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1Palt(u, v, Fr, alt, t0) +  g2Palt(u, v, Fr, alt, t0)) +  g3Palt(u, v, Fr, alt, t0)) +  g4Palt(u, v, Fr, alt, t0)));
}

vec3 gPt0(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1Pt0(u, v, Fr, alt, t0) +  g2Pt0(u, v, Fr, alt, t0)) +  g3Pt0(u, v, Fr, alt, t0)) +  g4Pt0(u, v, Fr, alt, t0)));
}

vec3 hPu(float u, float v, float t0) {
	return vec3(( gPu(10 * u, 10 * v, 1.7, 0.5, 2 * t0) * 10));
}

vec3 hPv(float u, float v, float t0) {
	return vec3(( gPv(10 * u, 10 * v, 1.7, 0.5, 2 * t0) * 10));
}

vec3 hNormal(float u, float v, float t0) {
	return vec3( normalize( cross( hPu(u, v, t0),  hPv(u, v, t0))));
}

float hArea(float u, float v, float t0) {
	return  distance( hPu(u, v, t0),  hPv(u, v, t0));
}

vec3 gPuPFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1PuPFr(u, v, Fr, alt, t0) +  g2PuPFr(u, v, Fr, alt, t0)) +  g3PuPFr(u, v, Fr, alt, t0)) +  g4PuPFr(u, v, Fr, alt, t0)));
}

vec3 gPuPalt(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1PuPalt(u, v, Fr, alt, t0) +  g2PuPalt(u, v, Fr, alt, t0)) +  g3PuPalt(u, v, Fr, alt, t0)) +  g4PuPalt(u, v, Fr, alt, t0)));
}

vec3 gPuPt0(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1PuPt0(u, v, Fr, alt, t0) +  g2PuPt0(u, v, Fr, alt, t0)) +  g3PuPt0(u, v, Fr, alt, t0)) +  g4PuPt0(u, v, Fr, alt, t0)));
}

vec3 hPuPu(float u, float v, float t0) {
	return vec3((( gPuPu(10 * u, 10 * v, 1.7, 0.5, 2 * t0) * 10) * 10));
}

vec3 gPvPu(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1PvPu(u, v, Fr, alt, t0) +  g2PvPu(u, v, Fr, alt, t0)) +  g3PvPu(u, v, Fr, alt, t0)) +  g4PvPu(u, v, Fr, alt, t0)));
}

vec3 gPvPFr(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1PvPFr(u, v, Fr, alt, t0) +  g2PvPFr(u, v, Fr, alt, t0)) +  g3PvPFr(u, v, Fr, alt, t0)) +  g4PvPFr(u, v, Fr, alt, t0)));
}

vec3 gPvPalt(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1PvPalt(u, v, Fr, alt, t0) +  g2PvPalt(u, v, Fr, alt, t0)) +  g3PvPalt(u, v, Fr, alt, t0)) +  g4PvPalt(u, v, Fr, alt, t0)));
}

vec3 gPvPt0(float u, float v, float Fr, float alt, float t0) {
	return vec3(((( g1PvPt0(u, v, Fr, alt, t0) +  g2PvPt0(u, v, Fr, alt, t0)) +  g3PvPt0(u, v, Fr, alt, t0)) +  g4PvPt0(u, v, Fr, alt, t0)));
}

vec3 hPvPv(float u, float v, float t0) {
	return vec3((( gPvPv(10 * u, 10 * v, 1.7, 0.5, 2 * t0) * 10) * 10));
}

vec3 hPuPv(float u, float v, float t0) {
	return vec3((( gPuPv(10 * u, 10 * v, 1.7, 0.5, 2 * t0) * 10) * 10));
}

float hK(float u, float v, float t0) {
	return ( determinant( mat3( hPuPu(u, v, t0),  hPu(u, v, t0),  hPv(u, v, t0))) *  determinant( mat3( hPvPv(u, v, t0),  hPu(u, v, t0),  hPv(u, v, t0))) -  pow( determinant( mat3( hPuPv(u, v, t0),  hPu(u, v, t0),  hPv(u, v, t0))), 2)) /  pow( pow( length( hPu(u, v, t0)), 2) *  pow( length( hPv(u, v, t0)), 2) -  pow( dot( hPu(u, v, t0),  hPv(u, v, t0)), 2), 2);
}

vec3 functionParam(vec2 p) {
	if (funPlot==0) {
		return h(p.x, p.y, param_t[0]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 normalParam(vec2 p) {
	if (funPlot==0) {
		return hNormal(p.x, p.y, param_t[0]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 tangentParam(vec2 p) {
	if (funPlot==0) {
		return hPu(p.x, p.y, param_t[0]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 cotangentParam(vec2 p) {
	if (funPlot==0) {
		return hPv(p.x, p.y, param_t[0]);
	}

	return vec3(0.0, 0.0, 0.0);
}

float areaParam(vec2 p) {
	if (funPlot==0) {
		return hArea(p.x, p.y, param_t[0]);
	}

	return 0.0;
}

float curvatureParam(vec2 p) {
	if (funPlot==0) {
		return hK(p.x, p.y, param_t[0]);
	}

	return 0.0;
}

