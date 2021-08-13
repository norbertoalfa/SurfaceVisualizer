
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
float h(float x, float A, float sig) {
	return A *  pow(E, ( - ( pow(x, 2) / (2 *  pow(sig, 2)))));
}

float compz(float x, float t0, float t1) {
	return 0.1 *  h(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0) *  cos(1.5 * x + 2 * PI * t0 + 2 * PI * t1);
}

vec3 f(float u, float v, float t0, float t1, float t2) {
	return vec3(4 *  vec3(u, t2 *  compz(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1), v));
}

float hPx(float x, float A, float sig) {
	return (A * ( pow(E, ( - ( pow(x, 2) / (2 *  pow(sig, 2))))) * ( - ((2 *  pow(x, 1.000000)) / (2 *  pow(sig, 2))))));
}

float hPA(float x, float A, float sig) {
	return ( pow(E, ( - ( pow(x, 2) / (2 *  pow(sig, 2))))));
}

float hPsig(float x, float A, float sig) {
	return (A * ( pow(E, ( - ( pow(x, 2) / (2 *  pow(sig, 2))))) * ( - ( -  pow(x, 2) * (2 * (2 *  pow(sig, 1.000000))) / ( pow((2 *  pow(sig, 2)), 2))))));
}

float compzPx(float x, float t0, float t1) {
	return ((0.1 *  hPx(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0)) *  cos(1.5 * x + 2 * PI * t0 + 2 * PI * t1) + 0.1 *  h(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0) * (( -  sin(1.5 * x + 2 * PI * t0 + 2 * PI * t1)) * 1.5));
}

float compzPt0(float x, float t0, float t1) {
	return ((0.1 * ( hPx(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0) * ( - 10) +  hPA(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0) * ( - 6.0 * 4 / ( pow((4 * t0 + 4.0), 2))) +  hPsig(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0))) *  cos(1.5 * x + 2 * PI * t0 + 2 * PI * t1) + 0.1 *  h(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0) * (( -  sin(1.5 * x + 2 * PI * t0 + 2 * PI * t1)) * (2 * PI)));
}

float compzPt1(float x, float t0, float t1) {
	return (0.1 *  h(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0) * (( -  sin(1.5 * x + 2 * PI * t0 + 2 * PI * t1)) * (2 * PI)));
}

vec3 fPu(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + 4 *  vec3(1, (t2 * ( compzPx(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1) * (4 * (2 *  pow(u, 1.000000))))), 0)));
}

vec3 fPv(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + 4 *  vec3(0, (t2 * ( compzPx(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1) * (4 * (2 *  pow(v, 1.000000))))), 1)));
}

vec3 fNormal(float u, float v, float t0, float t1, float t2) {
	return vec3( normalize( cross( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))));
}

float fArea(float u, float v, float t0, float t1, float t2) {
	return  distance( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2));
}

float hPxPx(float x, float A, float sig) {
	return (A * (( pow(E, ( - ( pow(x, 2) / (2 *  pow(sig, 2))))) * ( - ((2 *  pow(x, 1.000000)) / (2 *  pow(sig, 2))))) * ( - ((2 *  pow(x, 1.000000)) / (2 *  pow(sig, 2)))) +  pow(E, ( - ( pow(x, 2) / (2 *  pow(sig, 2))))) * ( - ((2 * (1.000000 *  pow(x, 0.000000))) / (2 *  pow(sig, 2))))));
}

float hPxPA(float x, float A, float sig) {
	return ( pow(E, ( - ( pow(x, 2) / (2 *  pow(sig, 2))))) * ( - ((2 *  pow(x, 1.000000)) / (2 *  pow(sig, 2)))));
}

float hPxPsig(float x, float A, float sig) {
	return (A * (( pow(E, ( - ( pow(x, 2) / (2 *  pow(sig, 2))))) * ( - ( -  pow(x, 2) * (2 * (2 *  pow(sig, 1.000000))) / ( pow((2 *  pow(sig, 2)), 2))))) * ( - ((2 *  pow(x, 1.000000)) / (2 *  pow(sig, 2)))) +  pow(E, ( - ( pow(x, 2) / (2 *  pow(sig, 2))))) * ( - ( - (2 *  pow(x, 1.000000)) * (2 * (2 *  pow(sig, 1.000000))) / ( pow((2 *  pow(sig, 2)), 2))))));
}

float compzPxPx(float x, float t0, float t1) {
	return (((0.1 *  hPxPx(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0)) *  cos(1.5 * x + 2 * PI * t0 + 2 * PI * t1) + (0.1 *  hPx(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0)) * (( -  sin(1.5 * x + 2 * PI * t0 + 2 * PI * t1)) * 1.5)) + ((0.1 *  hPx(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0)) * (( -  sin(1.5 * x + 2 * PI * t0 + 2 * PI * t1)) * 1.5) + 0.1 *  h(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0) * (( - ( cos(1.5 * x + 2 * PI * t0 + 2 * PI * t1) * 1.5)) * 1.5)));
}

float compzPxPt0(float x, float t0, float t1) {
	return (((0.1 * ( hPxPx(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0) * ( - 10) +  hPxPA(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0) * ( - 6.0 * 4 / ( pow((4 * t0 + 4.0), 2))) +  hPxPsig(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0))) *  cos(1.5 * x + 2 * PI * t0 + 2 * PI * t1) + (0.1 *  hPx(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0)) * (( -  sin(1.5 * x + 2 * PI * t0 + 2 * PI * t1)) * (2 * PI))) + ((0.1 * ( hPx(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0) * ( - 10) +  hPA(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0) * ( - 6.0 * 4 / ( pow((4 * t0 + 4.0), 2))) +  hPsig(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0))) * (( -  sin(1.5 * x + 2 * PI * t0 + 2 * PI * t1)) * 1.5) + 0.1 *  h(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0) * (( - ( cos(1.5 * x + 2 * PI * t0 + 2 * PI * t1) * (2 * PI))) * 1.5)));
}

float compzPxPt1(float x, float t0, float t1) {
	return (((0.1 *  hPx(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0)) * (( -  sin(1.5 * x + 2 * PI * t0 + 2 * PI * t1)) * (2 * PI))) + (0.1 *  h(x - 10 * t0, 6.0 / (4 * t0 + 4.0), t0 + 1.0) * (( - ( cos(1.5 * x + 2 * PI * t0 + 2 * PI * t1) * (2 * PI))) * 1.5)));
}

vec3 fPuPu(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (t2 * (( compzPxPx(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1) * (4 * (2 *  pow(u, 1.000000)))) * (4 * (2 *  pow(u, 1.000000))) +  compzPx(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1) * (4 * (2 * (1.000000 *  pow(u, 0.000000)))))), 0))));
}

vec3 fPvPv(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (t2 * (( compzPxPx(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1) * (4 * (2 *  pow(v, 1.000000)))) * (4 * (2 *  pow(v, 1.000000))) +  compzPx(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1) * (4 * (2 * (1.000000 *  pow(v, 0.000000)))))), 0))));
}

vec3 fPuPv(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (t2 * (( compzPxPx(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1) * (4 * (2 *  pow(v, 1.000000)))) * (4 * (2 *  pow(u, 1.000000))))), 0))));
}

float fK(float u, float v, float t0, float t1, float t2) {
	return ( determinant( mat3( fPuPu(u, v, t0, t1, t2),  fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))) *  determinant( mat3( fPvPv(u, v, t0, t1, t2),  fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))) -  pow( determinant( mat3( fPuPv(u, v, t0, t1, t2),  fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))), 2)) /  pow( pow( length( fPu(u, v, t0, t1, t2)), 2) *  pow( length( fPv(u, v, t0, t1, t2)), 2) -  pow( dot( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2)), 2), 2);
}

vec3 g(float u, float v, float t0, float t1, float t2) {
	return vec3( f(10 * (u - 0.5), 10 * (v - 0.5), 20 * t0, t1, t2));
}

vec3 fPt0(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + 4 *  vec3(0, (t2 *  compzPt0(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1)), 0)));
}

vec3 fPt1(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + 4 *  vec3(0, (t2 *  compzPt1(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1)), 0)));
}

vec3 fPt2(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + 4 *  vec3(0,  compz(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1), 0)));
}

vec3 gPu(float u, float v, float t0, float t1, float t2) {
	return vec3(( fPu(10 * (u - 0.5), 10 * (v - 0.5), 20 * t0, t1, t2) * 10));
}

vec3 gPv(float u, float v, float t0, float t1, float t2) {
	return vec3(( fPv(10 * (u - 0.5), 10 * (v - 0.5), 20 * t0, t1, t2) * 10));
}

vec3 gNormal(float u, float v, float t0, float t1, float t2) {
	return vec3( normalize( cross( gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2))));
}

float gArea(float u, float v, float t0, float t1, float t2) {
	return  distance( gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2));
}

vec3 fPuPt0(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (t2 * ( compzPxPt0(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1) * (4 * (2 *  pow(u, 1.000000))))), 0))));
}

vec3 fPuPt1(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (t2 * ( compzPxPt1(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1) * (4 * (2 *  pow(u, 1.000000))))), 0))));
}

vec3 fPuPt2(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, ( compzPx(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1) * (4 * (2 *  pow(u, 1.000000)))), 0))));
}

vec3 gPuPu(float u, float v, float t0, float t1, float t2) {
	return vec3((( fPuPu(10 * (u - 0.5), 10 * (v - 0.5), 20 * t0, t1, t2) * 10) * 10));
}

vec3 fPvPu(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (t2 * (( compzPxPx(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1) * (4 * (2 *  pow(u, 1.000000)))) * (4 * (2 *  pow(v, 1.000000))))), 0))));
}

vec3 fPvPt0(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (t2 * ( compzPxPt0(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1) * (4 * (2 *  pow(v, 1.000000))))), 0))));
}

vec3 fPvPt1(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (t2 * ( compzPxPt1(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1) * (4 * (2 *  pow(v, 1.000000))))), 0))));
}

vec3 fPvPt2(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, ( compzPx(4 * ( pow(u, 2) +  pow(v, 2)), t0, t1) * (4 * (2 *  pow(v, 1.000000)))), 0))));
}

vec3 gPvPv(float u, float v, float t0, float t1, float t2) {
	return vec3((( fPvPv(10 * (u - 0.5), 10 * (v - 0.5), 20 * t0, t1, t2) * 10) * 10));
}

vec3 gPuPv(float u, float v, float t0, float t1, float t2) {
	return vec3((( fPuPv(10 * (u - 0.5), 10 * (v - 0.5), 20 * t0, t1, t2) * 10) * 10));
}

float gK(float u, float v, float t0, float t1, float t2) {
	return ( determinant( mat3( gPuPu(u, v, t0, t1, t2),  gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2))) *  determinant( mat3( gPvPv(u, v, t0, t1, t2),  gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2))) -  pow( determinant( mat3( gPuPv(u, v, t0, t1, t2),  gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2))), 2)) /  pow( pow( length( gPu(u, v, t0, t1, t2)), 2) *  pow( length( gPv(u, v, t0, t1, t2)), 2) -  pow( dot( gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2)), 2), 2);
}

vec3 functionParam(vec2 p) {
	if (funPlot==0) {
		return g(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 normalParam(vec2 p) {
	if (funPlot==0) {
		return gNormal(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 tangentParam(vec2 p) {
	if (funPlot==0) {
		return gPu(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 cotangentParam(vec2 p) {
	if (funPlot==0) {
		return gPv(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return vec3(0.0, 0.0, 0.0);
}

float areaParam(vec2 p) {
	if (funPlot==0) {
		return gArea(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return 0.0;
}

float curvatureParam(vec2 p) {
	if (funPlot==0) {
		return gK(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return 0.0;
}

