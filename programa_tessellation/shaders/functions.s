
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
float PI2 = 2 * PI;

float compx(float u, float v) {
	return  cos(v * PI) *  cos(u * PI2);
}

float compy(float u, float v) {
	return  cos(v * PI) *  sin(u * PI2);
}

float compz(float u, float v) {
	return  sin(v * PI);
}

float h(float u, float v, float A, float sigu, float sigv) {
	return A *  pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2)))));
}

vec3 f(float u, float v) {
	return vec3( vec3( compx(u, v),  compy(u, v),  compz(u, v)));
}

float compxPu(float u, float v) {
	return ( cos(v * PI) * (( -  sin(u * PI2)) * PI2));
}

float compxPv(float u, float v) {
	return ((( -  sin(v * PI)) * PI) *  cos(u * PI2));
}

float compyPu(float u, float v) {
	return ( cos(v * PI) * ( cos(u * PI2) * PI2));
}

float compyPv(float u, float v) {
	return ((( -  sin(v * PI)) * PI) *  sin(u * PI2));
}

float compzPu(float u, float v) {
	return 0;
}

float compzPv(float u, float v) {
	return ( cos(v * PI) * PI);
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
	return ( cos(v * PI) * (( - ( cos(u * PI2) * PI2)) * PI2));
}

float compxPuPv(float u, float v) {
	return ((( -  sin(v * PI)) * PI) * (( -  sin(u * PI2)) * PI2));
}

float compyPuPu(float u, float v) {
	return ( cos(v * PI) * ((( -  sin(u * PI2)) * PI2) * PI2));
}

float compyPuPv(float u, float v) {
	return ((( -  sin(v * PI)) * PI) * ( cos(u * PI2) * PI2));
}

float compzPuPu(float u, float v) {
	return 0;
}

float compzPuPv(float u, float v) {
	return 0;
}

vec3 fPuPu(float u, float v) {
	return vec3( vec3( compxPuPu(u, v),  compyPuPu(u, v),  compzPuPu(u, v)));
}

float compxPvPu(float u, float v) {
	return ((( -  sin(v * PI)) * PI) * (( -  sin(u * PI2)) * PI2));
}

float compxPvPv(float u, float v) {
	return ((( - ( cos(v * PI) * PI)) * PI) *  cos(u * PI2));
}

float compyPvPu(float u, float v) {
	return ((( -  sin(v * PI)) * PI) * ( cos(u * PI2) * PI2));
}

float compyPvPv(float u, float v) {
	return ((( - ( cos(v * PI) * PI)) * PI) *  sin(u * PI2));
}

float compzPvPu(float u, float v) {
	return 0;
}

float compzPvPv(float u, float v) {
	return ((( -  sin(v * PI)) * PI) * PI);
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

vec3 g(float u, float v, float t0, float t1, float t2, float t3, float t4, float t5, float t6, float t7) {
	return vec3(4 *  f(u - 0.5, v - 0.5) * (1 +  h(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  h(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7)));
}

float hPu(float u, float v, float A, float sigu, float sigv) {
	return (A * ( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2))))));
}

float hPv(float u, float v, float A, float sigu, float sigv) {
	return (A * ( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2))))));
}

float hPA(float u, float v, float A, float sigu, float sigv) {
	return ( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))));
}

float hPsigu(float u, float v, float A, float sigu, float sigv) {
	return (A * ( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( -  pow(u, 2) * (2 * (2 *  pow(sigu, 1.000000))) / ( pow((2 *  pow(sigu, 2)), 2))))));
}

float hPsigv(float u, float v, float A, float sigu, float sigv) {
	return (A * ( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( -  pow(v, 2) * (2 * (2 *  pow(sigv, 1.000000))) / ( pow((2 *  pow(sigv, 2)), 2))))));
}

vec3 gPu(float u, float v, float t0, float t1, float t2, float t3, float t4, float t5, float t6, float t7) {
	return vec3(((4 *  fPu(u - 0.5, v - 0.5)) * (1 +  h(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  h(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7)) + 4 *  f(u - 0.5, v - 0.5) * ( hPu(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  hPu(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7))));
}

vec3 gPv(float u, float v, float t0, float t1, float t2, float t3, float t4, float t5, float t6, float t7) {
	return vec3(((4 *  fPv(u - 0.5, v - 0.5)) * (1 +  h(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  h(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7)) + 4 *  f(u - 0.5, v - 0.5) * ( hPv(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  hPv(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7))));
}

vec3 gNormal(float u, float v, float t0, float t1, float t2, float t3, float t4, float t5, float t6, float t7) {
	return vec3( normalize( cross( gPu(u, v, t0, t1, t2, t3, t4, t5, t6, t7),  gPv(u, v, t0, t1, t2, t3, t4, t5, t6, t7))));
}

float gArea(float u, float v, float t0, float t1, float t2, float t3, float t4, float t5, float t6, float t7) {
	return  distance( gPu(u, v, t0, t1, t2, t3, t4, t5, t6, t7),  gPv(u, v, t0, t1, t2, t3, t4, t5, t6, t7));
}

float hPuPu(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2)))) +  pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 * (1.000000 *  pow(u, 0.000000))) / (2 *  pow(sigu, 2))))));
}

float hPuPv(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2))))));
}

float hPuPA(float u, float v, float A, float sigu, float sigv) {
	return ( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2)))));
}

float hPuPsigu(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( -  pow(u, 2) * (2 * (2 *  pow(sigu, 1.000000))) / ( pow((2 *  pow(sigu, 2)), 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2)))) +  pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( - (2 *  pow(u, 1.000000)) * (2 * (2 *  pow(sigu, 1.000000))) / ( pow((2 *  pow(sigu, 2)), 2))))));
}

float hPuPsigv(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( -  pow(v, 2) * (2 * (2 *  pow(sigv, 1.000000))) / ( pow((2 *  pow(sigv, 2)), 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2))))));
}

vec3 gPuPu(float u, float v, float t0, float t1, float t2, float t3, float t4, float t5, float t6, float t7) {
	return vec3((((4 *  fPuPu(u - 0.5, v - 0.5)) * (1 +  h(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  h(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7)) + (4 *  fPu(u - 0.5, v - 0.5)) * ( hPu(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  hPu(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7))) + ((4 *  fPu(u - 0.5, v - 0.5)) * ( hPu(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  hPu(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7)) + 4 *  f(u - 0.5, v - 0.5) * ( hPuPu(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  hPuPu(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7)))));
}

float hPvPu(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(u, 1.000000)) / (2 *  pow(sigu, 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2))))));
}

float hPvPv(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2)))) +  pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 * (1.000000 *  pow(v, 0.000000))) / (2 *  pow(sigv, 2))))));
}

float hPvPA(float u, float v, float A, float sigu, float sigv) {
	return ( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2)))));
}

float hPvPsigu(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( -  pow(u, 2) * (2 * (2 *  pow(sigu, 1.000000))) / ( pow((2 *  pow(sigu, 2)), 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2))))));
}

float hPvPsigv(float u, float v, float A, float sigu, float sigv) {
	return (A * (( pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( -  pow(v, 2) * (2 * (2 *  pow(sigv, 1.000000))) / ( pow((2 *  pow(sigv, 2)), 2))))) * ( - ((2 *  pow(v, 1.000000)) / (2 *  pow(sigv, 2)))) +  pow(E, ( - ( pow(u, 2) / (2 *  pow(sigu, 2)) +  pow(v, 2) / (2 *  pow(sigv, 2))))) * ( - ( - (2 *  pow(v, 1.000000)) * (2 * (2 *  pow(sigv, 1.000000))) / ( pow((2 *  pow(sigv, 2)), 2))))));
}

vec3 fPvPu(float u, float v) {
	return vec3( vec3( compxPvPu(u, v),  compyPvPu(u, v),  compzPvPu(u, v)));
}

vec3 gPvPv(float u, float v, float t0, float t1, float t2, float t3, float t4, float t5, float t6, float t7) {
	return vec3((((4 *  fPvPv(u - 0.5, v - 0.5)) * (1 +  h(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  h(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7)) + (4 *  fPv(u - 0.5, v - 0.5)) * ( hPv(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  hPv(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7))) + ((4 *  fPv(u - 0.5, v - 0.5)) * ( hPv(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  hPv(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7)) + 4 *  f(u - 0.5, v - 0.5) * ( hPvPv(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  hPvPv(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7)))));
}

vec3 gPuPv(float u, float v, float t0, float t1, float t2, float t3, float t4, float t5, float t6, float t7) {
	return vec3((((4 *  fPuPv(u - 0.5, v - 0.5)) * (1 +  h(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  h(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7)) + (4 *  fPu(u - 0.5, v - 0.5)) * ( hPv(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  hPv(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7))) + ((4 *  fPv(u - 0.5, v - 0.5)) * ( hPu(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  hPu(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7)) + 4 *  f(u - 0.5, v - 0.5) * ( hPuPv(u - 0.5, v - 0.5, t0, 0.1 * t1, 0.2 * t2) +  hPuPv(u - t3, v - t4, t5, 0.1 * t6, 0.2 * t7)))));
}

float gK(float u, float v, float t0, float t1, float t2, float t3, float t4, float t5, float t6, float t7) {
	return ( determinant( mat3( gPuPu(u, v, t0, t1, t2, t3, t4, t5, t6, t7),  gPu(u, v, t0, t1, t2, t3, t4, t5, t6, t7),  gPv(u, v, t0, t1, t2, t3, t4, t5, t6, t7))) *  determinant( mat3( gPvPv(u, v, t0, t1, t2, t3, t4, t5, t6, t7),  gPu(u, v, t0, t1, t2, t3, t4, t5, t6, t7),  gPv(u, v, t0, t1, t2, t3, t4, t5, t6, t7))) -  pow( determinant( mat3( gPuPv(u, v, t0, t1, t2, t3, t4, t5, t6, t7),  gPu(u, v, t0, t1, t2, t3, t4, t5, t6, t7),  gPv(u, v, t0, t1, t2, t3, t4, t5, t6, t7))), 2)) /  pow( pow( length( gPu(u, v, t0, t1, t2, t3, t4, t5, t6, t7)), 2) *  pow( length( gPv(u, v, t0, t1, t2, t3, t4, t5, t6, t7)), 2) -  pow( dot( gPu(u, v, t0, t1, t2, t3, t4, t5, t6, t7),  gPv(u, v, t0, t1, t2, t3, t4, t5, t6, t7)), 2), 2);
}

vec3 functionParam(vec2 p) {
	if (funPlot==0) {
		return g(p.x, p.y, param_t[0], param_t[1], param_t[2], param_t[3], param_t[4], param_t[5], param_t[6], param_t[7]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 normalParam(vec2 p) {
	if (funPlot==0) {
		return gNormal(p.x, p.y, param_t[0], param_t[1], param_t[2], param_t[3], param_t[4], param_t[5], param_t[6], param_t[7]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 tangentParam(vec2 p) {
	if (funPlot==0) {
		return gPu(p.x, p.y, param_t[0], param_t[1], param_t[2], param_t[3], param_t[4], param_t[5], param_t[6], param_t[7]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 cotangentParam(vec2 p) {
	if (funPlot==0) {
		return gPv(p.x, p.y, param_t[0], param_t[1], param_t[2], param_t[3], param_t[4], param_t[5], param_t[6], param_t[7]);
	}

	return vec3(0.0, 0.0, 0.0);
}

float areaParam(vec2 p) {
	if (funPlot==0) {
		return gArea(p.x, p.y, param_t[0], param_t[1], param_t[2], param_t[3], param_t[4], param_t[5], param_t[6], param_t[7]);
	}

	return 0.0;
}

float curvatureParam(vec2 p) {
	if (funPlot==0) {
		return gK(p.x, p.y, param_t[0], param_t[1], param_t[2], param_t[3], param_t[4], param_t[5], param_t[6], param_t[7]);
	}

	return 0.0;
}

