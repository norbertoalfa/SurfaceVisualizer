
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
float A = 1.0;

float compx(float u, float v) {
	return 4 *  pow(A, 2) *  cos(3 * v) / (3 *  pow(u, 3));
}

float compy(float u, float v) {
	return 2 * A *  cos(2 * v) / ( pow(u, 2));
}

float compz(float u, float v) {
	return 4 *  pow(A, 2) *  sin(3 * v) / (3 *  pow(u, 3));
}

vec3 f(float u, float v) {
	return vec3( vec3( compx(u, v),  compy(u, v),  compz(u, v)));
}

float compxPu(float u, float v) {
	return ( - 4 *  pow(A, 2) *  cos(3 * v) * (3 * (3 *  pow(u, 2.000000))) / ( pow((3 *  pow(u, 3)), 2)));
}

float compxPv(float u, float v) {
	return ((4 *  pow(A, 2) * (( -  sin(3 * v)) * 3)) / (3 *  pow(u, 3)));
}

float compyPu(float u, float v) {
	return ( - 2 * A *  cos(2 * v) * (2 *  pow(u, 1.000000)) / ( pow(( pow(u, 2)), 2)));
}

float compyPv(float u, float v) {
	return ((2 * A * (( -  sin(2 * v)) * 2)) / ( pow(u, 2)));
}

float compzPu(float u, float v) {
	return ( - 4 *  pow(A, 2) *  sin(3 * v) * (3 * (3 *  pow(u, 2.000000))) / ( pow((3 *  pow(u, 3)), 2)));
}

float compzPv(float u, float v) {
	return ((4 *  pow(A, 2) * ( cos(3 * v) * 3)) / (3 *  pow(u, 3)));
}

vec3 fPu(float u, float v) {
	return vec3( vec3( compxPu(u, v),  compyPu(u, v),  compzPu(u, v)));
}

vec3 fPv(float u, float v) {
	return vec3( vec3( compxPv(u, v),  compyPv(u, v),  compzPv(u, v)));
}

vec3 fNormal(float u, float v) {
	return vec3( normalize( cross( fPu(u, v),  fPv(u, v))));
}

float fArea(float u, float v) {
	return  distance( fPu(u, v),  fPv(u, v));
}

float compxPuPu(float u, float v) {
	return ( - ((4 *  pow(A, 2) *  cos(3 * v) * (3 * (3 * (2.000000 *  pow(u, 1.000000))))) / ( pow((3 *  pow(u, 3)), 2)) - 4 *  pow(A, 2) *  cos(3 * v) * (3 * (3 *  pow(u, 2.000000))) * (2 *  pow((3 *  pow(u, 3)), 1.000000) * (3 * (3 *  pow(u, 2.000000)))) / ( pow(( pow((3 *  pow(u, 3)), 2)), 2))));
}

float compxPuPv(float u, float v) {
	return ( - (((4 *  pow(A, 2) * (( -  sin(3 * v)) * 3)) * (3 * (3 *  pow(u, 2.000000)))) / ( pow((3 *  pow(u, 3)), 2))));
}

float compyPuPu(float u, float v) {
	return ( - ((2 * A *  cos(2 * v) * (2 * (1.000000 *  pow(u, 0.000000)))) / ( pow(( pow(u, 2)), 2)) - 2 * A *  cos(2 * v) * (2 *  pow(u, 1.000000)) * (2 *  pow(( pow(u, 2)), 1.000000) * (2 *  pow(u, 1.000000))) / ( pow(( pow(( pow(u, 2)), 2)), 2))));
}

float compyPuPv(float u, float v) {
	return ( - (((2 * A * (( -  sin(2 * v)) * 2)) * (2 *  pow(u, 1.000000))) / ( pow(( pow(u, 2)), 2))));
}

float compzPuPu(float u, float v) {
	return ( - ((4 *  pow(A, 2) *  sin(3 * v) * (3 * (3 * (2.000000 *  pow(u, 1.000000))))) / ( pow((3 *  pow(u, 3)), 2)) - 4 *  pow(A, 2) *  sin(3 * v) * (3 * (3 *  pow(u, 2.000000))) * (2 *  pow((3 *  pow(u, 3)), 1.000000) * (3 * (3 *  pow(u, 2.000000)))) / ( pow(( pow((3 *  pow(u, 3)), 2)), 2))));
}

float compzPuPv(float u, float v) {
	return ( - (((4 *  pow(A, 2) * ( cos(3 * v) * 3)) * (3 * (3 *  pow(u, 2.000000)))) / ( pow((3 *  pow(u, 3)), 2))));
}

vec3 fPuPu(float u, float v) {
	return vec3( vec3( compxPuPu(u, v),  compyPuPu(u, v),  compzPuPu(u, v)));
}

float compxPvPu(float u, float v) {
	return ( - (4 *  pow(A, 2) * (( -  sin(3 * v)) * 3)) * (3 * (3 *  pow(u, 2.000000))) / ( pow((3 *  pow(u, 3)), 2)));
}

float compxPvPv(float u, float v) {
	return ((4 *  pow(A, 2) * (( - ( cos(3 * v) * 3)) * 3)) / (3 *  pow(u, 3)));
}

float compyPvPu(float u, float v) {
	return ( - (2 * A * (( -  sin(2 * v)) * 2)) * (2 *  pow(u, 1.000000)) / ( pow(( pow(u, 2)), 2)));
}

float compyPvPv(float u, float v) {
	return ((2 * A * (( - ( cos(2 * v) * 2)) * 2)) / ( pow(u, 2)));
}

float compzPvPu(float u, float v) {
	return ( - (4 *  pow(A, 2) * ( cos(3 * v) * 3)) * (3 * (3 *  pow(u, 2.000000))) / ( pow((3 *  pow(u, 3)), 2)));
}

float compzPvPv(float u, float v) {
	return ((4 *  pow(A, 2) * ((( -  sin(3 * v)) * 3) * 3)) / (3 *  pow(u, 3)));
}

vec3 fPvPv(float u, float v) {
	return vec3( vec3( compxPvPv(u, v),  compyPvPv(u, v),  compzPvPv(u, v)));
}

vec3 fPuPv(float u, float v) {
	return vec3( vec3( compxPuPv(u, v),  compyPuPv(u, v),  compzPuPv(u, v)));
}

float fK(float u, float v) {
	return ( determinant( mat3( fPuPu(u, v),  fPu(u, v),  fPv(u, v))) *  determinant( mat3( fPvPv(u, v),  fPu(u, v),  fPv(u, v))) -  pow( determinant( mat3( fPuPv(u, v),  fPu(u, v),  fPv(u, v))), 2)) /  pow( pow( length( fPu(u, v)), 2) *  pow( length( fPv(u, v)), 2) -  pow( dot( fPu(u, v),  fPv(u, v)), 2), 2);
}

vec3 g(float u, float v, float t0) {
	return vec3( f(2 * u + 0.5, 2 * PI * v));
}

vec3 gPu(float u, float v, float t0) {
	return vec3(( fPu(2 * u + 0.5, 2 * PI * v) * 2));
}

vec3 gPv(float u, float v, float t0) {
	return vec3(( fPv(2 * u + 0.5, 2 * PI * v) * (2 * PI)));
}

vec3 gNormal(float u, float v, float t0) {
	return vec3( normalize( cross( gPu(u, v, t0),  gPv(u, v, t0))));
}

float gArea(float u, float v, float t0) {
	return  distance( gPu(u, v, t0),  gPv(u, v, t0));
}

vec3 gPuPu(float u, float v, float t0) {
	return vec3((( fPuPu(2 * u + 0.5, 2 * PI * v) * 2) * 2));
}

vec3 fPvPu(float u, float v) {
	return vec3( vec3( compxPvPu(u, v),  compyPvPu(u, v),  compzPvPu(u, v)));
}

vec3 gPvPv(float u, float v, float t0) {
	return vec3((( fPvPv(2 * u + 0.5, 2 * PI * v) * (2 * PI)) * (2 * PI)));
}

vec3 gPuPv(float u, float v, float t0) {
	return vec3((( fPuPv(2 * u + 0.5, 2 * PI * v) * (2 * PI)) * 2));
}

float gK(float u, float v, float t0) {
	return ( determinant( mat3( gPuPu(u, v, t0),  gPu(u, v, t0),  gPv(u, v, t0))) *  determinant( mat3( gPvPv(u, v, t0),  gPu(u, v, t0),  gPv(u, v, t0))) -  pow( determinant( mat3( gPuPv(u, v, t0),  gPu(u, v, t0),  gPv(u, v, t0))), 2)) /  pow( pow( length( gPu(u, v, t0)), 2) *  pow( length( gPv(u, v, t0)), 2) -  pow( dot( gPu(u, v, t0),  gPv(u, v, t0)), 2), 2);
}

vec3 functionParam(vec2 p) {
	if (funPlot==0) {
		return g(p.x, p.y, param_t[0]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 normalParam(vec2 p) {
	if (funPlot==0) {
		return gNormal(p.x, p.y, param_t[0]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 tangentParam(vec2 p) {
	if (funPlot==0) {
		return gPu(p.x, p.y, param_t[0]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 cotangentParam(vec2 p) {
	if (funPlot==0) {
		return gPv(p.x, p.y, param_t[0]);
	}

	return vec3(0.0, 0.0, 0.0);
}

float areaParam(vec2 p) {
	if (funPlot==0) {
		return gArea(p.x, p.y, param_t[0]);
	}

	return 0.0;
}

float curvatureParam(vec2 p) {
	if (funPlot==0) {
		return gK(p.x, p.y, param_t[0]);
	}

	return 0.0;
}

