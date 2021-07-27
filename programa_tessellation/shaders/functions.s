
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
float g(float u, float v, float A, float sigu, float sigv) {
	return A *  pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2)))));
}

vec3 f(float u, float v, float t0, float t1, float t2) {
	return 4 *  vec3(u,  g(u - 0.5, v - 0.5, t0, t1, t2), v);
}

float gPu(float u, float v, float A, float sigu, float sigv) {
	return (A * ( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2))))));
}

float gPv(float u, float v, float A, float sigu, float sigv) {
	return (A * ( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2))))));
}

float gPA(float u, float v, float A, float sigu, float sigv) {
	return ( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))));
}

float gPsigu(float u, float v, float A, float sigu, float sigv) {
	return (A * ( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( -  pow(u, 2) * (2 * (2 *  pow(sigu, 1.000000))) / ( pow((2 *  pow(sigu, 2)), 2))))));
}

float gPsigv(float u, float v, float A, float sigu, float sigv) {
	return (A * ( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( -  pow(v, 2) * (2 * (2 *  pow(sigv, 1.000000))) / ( pow((2 *  pow(sigv, 2)), 2))))));
}

vec3 fPu(float u, float v, float t0, float t1, float t2) {
	return ( vec3(0) + 4 *  vec3(1,  gPu(u - 0.5, v - 0.5, t0, t1, t2), 0));
}

vec3 fPv(float u, float v, float t0, float t1, float t2) {
	return ( vec3(0) + 4 *  vec3(0,  gPv(u - 0.5, v - 0.5, t0, t1, t2), 1));
}

vec3 fNormal(float u, float v, float t0, float t1, float t2) {
	return  normalize( cross( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2)));
}

float fArea(float u, float v, float t0, float t1, float t2) {
	return  distance( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2));
}

float gPuPu(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2)))) +  pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 * (1.000000 *  pow(u, 0.000000))) / (2 *  pow(sigu, 2))))));
}

float gPuPv(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2))))));
}

float gPuPA(float u, float v, float A, float sigu, float sigv) {
	return ( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2)))));
}

float gPuPsigu(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( -  pow(u, 2) * (2 * (2 *  pow(sigu, 1.000000))) / ( pow((2 *  pow(sigu, 2)), 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2)))) +  pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( - (2 *  pow(u, 1.000000)) * (2 * (2 *  pow(sigu, 1.000000))) / ( pow((2 *  pow(sigu, 2)), 2))))));
}

float gPuPsigv(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( -  pow(v, 2) * (2 * (2 *  pow(sigv, 1.000000))) / ( pow((2 *  pow(sigv, 2)), 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2))))));
}

vec3 fPuPu(float u, float v, float t0, float t1, float t2) {
	return ( vec3(0) + ( vec3(0) + 4 *  vec3(0,  gPuPu(u - 0.5, v - 0.5, t0, t1, t2), 0)));
}

float gPvPu(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2))))));
}

float gPvPv(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2)))) +  pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 * (1.000000 *  pow(v, 0.000000))) / (2 *  pow(sigv, 2))))));
}

float gPvPA(float u, float v, float A, float sigu, float sigv) {
	return ( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2)))));
}

float gPvPsigu(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( -  pow(u, 2) * (2 * (2 *  pow(sigu, 1.000000))) / ( pow((2 *  pow(sigu, 2)), 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2))))));
}

float gPvPsigv(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( -  pow(v, 2) * (2 * (2 *  pow(sigv, 1.000000))) / ( pow((2 *  pow(sigv, 2)), 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2)))) +  pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( - (2 *  pow(v, 1.000000)) * (2 * (2 *  pow(sigv, 1.000000))) / ( pow((2 *  pow(sigv, 2)), 2))))));
}

vec3 fPvPv(float u, float v, float t0, float t1, float t2) {
	return ( vec3(0) + ( vec3(0) + 4 *  vec3(0,  gPvPv(u - 0.5, v - 0.5, t0, t1, t2), 0)));
}

vec3 fPuPv(float u, float v, float t0, float t1, float t2) {
	return ( vec3(0) + ( vec3(0) + 4 *  vec3(0,  gPuPv(u - 0.5, v - 0.5, t0, t1, t2), 0)));
}

float fK(float u, float v, float t0, float t1, float t2) {
	return ( determinant( mat3( fPuPu(u, v, t0, t1, t2),  fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))) *  determinant( mat3( fPvPv(u, v, t0, t1, t2),  fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))) -  pow( determinant( mat3( fPuPv(u, v, t0, t1, t2),  fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))), 2)) /  pow( pow( length( fPu(u, v, t0, t1, t2)), 2) *  pow( length( fPv(u, v, t0, t1, t2)), 2) -  pow( dot( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2)), 2), 2);
}

vec3 functionParam(vec2 p) {
	if (funPlot==0) {
		return f(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 normalParam(vec2 p) {
	if (funPlot==0) {
		return fNormal(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 tangentParam(vec2 p) {
	if (funPlot==0) {
		return fPu(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 cotangentParam(vec2 p) {
	if (funPlot==0) {
		return fPv(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return vec3(0.0, 0.0, 0.0);
}

float areaParam(vec2 p) {
	if (funPlot==0) {
		return fArea(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return 0.0;
}

float curvatureParam(vec2 p) {
	if (funPlot==0) {
		return fK(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return 0.0;
}

