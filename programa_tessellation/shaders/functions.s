
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
float g(float u, float v) {
	return u * v;
}

float gPu(float u, float v) {
	return v;
}

float gPuPv(float u, float v) {
	return 1;
}

vec3 f(float u, float x, float v) {
	return vec3(40 *  vec3( cos(u),  sin(x), 0) *  gPuPv(u, x));
}

float gPuPvPu(float u, float v) {
	return 0;
}

float gPuPvPv(float u, float v) {
	return 0;
}

vec3 fPu(float u, float x, float v) {
	return vec3((( vec3(0) + 40 *  vec3(( -  sin(u)), 0, 0)) *  gPuPv(u, x) + 40 *  vec3( cos(u),  sin(x), 0) *  gPuPvPu(u, x)));
}

vec3 fPv(float u, float x, float v) {
	return vec3((( vec3(0) + 40 *  vec3(0, 0, 0)) *  gPuPv(u, x)));
}

vec3 fNormal(float u, float x, float v) {
	return vec3( normalize( cross( fPu(u, x, v),  fPv(u, x, v))));
}

float fArea(float u, float x, float v) {
	return  distance( fPu(u, x, v),  fPv(u, x, v));
}

float gPuPvPuPu(float u, float v) {
	return 0;
}

float gPuPvPuPv(float u, float v) {
	return 0;
}

vec3 fPuPu(float u, float x, float v) {
	return vec3(((( vec3(0) + ( vec3(0) + 40 *  vec3(( -  cos(u)), 0, 0))) *  gPuPv(u, x) + ( vec3(0) + 40 *  vec3(( -  sin(u)), 0, 0)) *  gPuPvPu(u, x)) + (( vec3(0) + 40 *  vec3(( -  sin(u)), 0, 0)) *  gPuPvPu(u, x) + 40 *  vec3( cos(u),  sin(x), 0) *  gPuPvPuPu(u, x))));
}

vec3 fPvPv(float u, float x, float v) {
	return vec3((( vec3(0) + ( vec3(0) + 40 *  vec3(0, 0, 0))) *  gPuPv(u, x)));
}

vec3 fPuPv(float u, float x, float v) {
	return vec3(((( vec3(0) + ( vec3(0) + 40 *  vec3(0, 0, 0))) *  gPuPv(u, x)) + (( vec3(0) + 40 *  vec3(0, 0, 0)) *  gPuPvPu(u, x))));
}

float fK(float u, float x, float v) {
	return ( determinant( mat3( fPuPu(u, x, v),  fPu(u, x, v),  fPv(u, x, v))) *  determinant( mat3( fPvPv(u, x, v),  fPu(u, x, v),  fPv(u, x, v))) -  pow( determinant( mat3( fPuPv(u, x, v),  fPu(u, x, v),  fPv(u, x, v))), 2)) /  pow( pow( length( fPu(u, x, v)), 2) *  pow( length( fPv(u, x, v)), 2) -  pow( dot( fPu(u, x, v),  fPv(u, x, v)), 2), 2);
}

vec3 functionParam(vec2 p) {
	if (funPlot==0) {
		return f(p.x, p.y, param_t[0]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 normalParam(vec2 p) {
	if (funPlot==0) {
		return fNormal(p.x, p.y, param_t[0]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 tangentParam(vec2 p) {
	if (funPlot==0) {
		return fPu(p.x, p.y, param_t[0]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 cotangentParam(vec2 p) {
	if (funPlot==0) {
		return fPv(p.x, p.y, param_t[0]);
	}

	return vec3(0.0, 0.0, 0.0);
}

float areaParam(vec2 p) {
	if (funPlot==0) {
		return fArea(p.x, p.y, param_t[0]);
	}

	return 0.0;
}

float curvatureParam(vec2 p) {
	if (funPlot==0) {
		return fK(p.x, p.y, param_t[0]);
	}

	return 0.0;
}

