
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
float sinh(float x) {
	return ( pow(E, x) -  pow(E, ( - x))) / 2.0;
}

float cosh(float x) {
	return ( pow(E, x) +  pow(E, ( - x))) / 2.0;
}

float compx(float u, float v, float tita) {
	return  cos(tita) *  sinh(v) *  sin(u) +  sin(tita) *  cosh(v) *  cos(u);
}

float compy(float u, float v, float tita) {
	return u *  cos(tita) + v *  sin(tita);
}

float compz(float u, float v, float tita) {
	return  -  cos(tita) *  sinh(v) *  cos(u) +  sin(tita) *  cosh(v) *  sin(u);
}

vec3 f(float u, float v, float t0, float t1, float t2) {
	return  vec3( compx(u, v, t2),  compy(u, v, t2),  compz(u, v, t2));
}

float coshPx(float x) {
	return ((( pow(E, x)) + ( pow(E, ( - x)) * ( - 1))) / 2.0);
}

float sinhPx(float x) {
	return ((( pow(E, x)) - ( pow(E, ( - x)) * ( - 1))) / 2.0);
}

float compxPu(float u, float v, float tita) {
	return (( cos(tita) *  sinh(v) *  cos(u)) + ( sin(tita) *  cosh(v) * ( -  sin(u))));
}

float compxPv(float u, float v, float tita) {
	return ((( cos(tita) *  sinhPx(v)) *  sin(u)) + (( sin(tita) *  coshPx(v)) *  cos(u)));
}

float compxPtita(float u, float v, float tita) {
	return (((( -  sin(tita)) *  sinh(v)) *  sin(u)) + (( cos(tita) *  cosh(v)) *  cos(u)));
}

float compyPu(float u, float v, float tita) {
	return  cos(tita);
}

float compyPv(float u, float v, float tita) {
	return  sin(tita);
}

float compyPtita(float u, float v, float tita) {
	return ((u * ( -  sin(tita))) + (v *  cos(tita)));
}

float compzPu(float u, float v, float tita) {
	return (( - ( cos(tita) *  sinh(v) * ( -  sin(u)))) + ( sin(tita) *  cosh(v) *  cos(u)));
}

float compzPv(float u, float v, float tita) {
	return (( - (( cos(tita) *  sinhPx(v)) *  cos(u))) + (( sin(tita) *  coshPx(v)) *  sin(u)));
}

float compzPtita(float u, float v, float tita) {
	return (( - ((( -  sin(tita)) *  sinh(v)) *  cos(u))) + (( cos(tita) *  cosh(v)) *  sin(u)));
}

vec3 fPu(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPu(u, v, t2),  compyPu(u, v, t2),  compzPu(u, v, t2));
}

vec3 fPv(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPv(u, v, t2),  compyPv(u, v, t2),  compzPv(u, v, t2));
}

vec3 fNormal(float u, float v, float t0, float t1, float t2) {
	return  normalize( cross( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2)));
}

float fArea(float u, float v, float t0, float t1, float t2) {
	return  distance( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2));
}

float compxPuPu(float u, float v, float tita) {
	return (( cos(tita) *  sinh(v) * ( -  sin(u))) + ( sin(tita) *  cosh(v) * ( -  cos(u))));
}

float compxPuPv(float u, float v, float tita) {
	return ((( cos(tita) *  sinhPx(v)) *  cos(u)) + (( sin(tita) *  coshPx(v)) * ( -  sin(u))));
}

float compxPuPtita(float u, float v, float tita) {
	return (((( -  sin(tita)) *  sinh(v)) *  cos(u)) + (( cos(tita) *  cosh(v)) * ( -  sin(u))));
}

float compyPuPu(float u, float v, float tita) {
	return 0;
}

float compyPuPv(float u, float v, float tita) {
	return 0;
}

float compyPuPtita(float u, float v, float tita) {
	return ( -  sin(tita));
}

float compzPuPu(float u, float v, float tita) {
	return (( - ( cos(tita) *  sinh(v) * ( -  cos(u)))) + ( sin(tita) *  cosh(v) * ( -  sin(u))));
}

float compzPuPv(float u, float v, float tita) {
	return (( - (( cos(tita) *  sinhPx(v)) * ( -  sin(u)))) + (( sin(tita) *  coshPx(v)) *  cos(u)));
}

float compzPuPtita(float u, float v, float tita) {
	return (( - ((( -  sin(tita)) *  sinh(v)) * ( -  sin(u)))) + (( cos(tita) *  cosh(v)) *  cos(u)));
}

vec3 fPuPu(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPuPu(u, v, t2),  compyPuPu(u, v, t2),  compzPuPu(u, v, t2));
}

float coshPxPx(float x) {
	return ((( pow(E, x)) + (( pow(E, ( - x)) * ( - 1)) * ( - 1))) / 2.0);
}

float sinhPxPx(float x) {
	return ((( pow(E, x)) - (( pow(E, ( - x)) * ( - 1)) * ( - 1))) / 2.0);
}

float compxPvPu(float u, float v, float tita) {
	return ((( cos(tita) *  sinhPx(v)) *  cos(u)) + (( sin(tita) *  coshPx(v)) * ( -  sin(u))));
}

float compxPvPv(float u, float v, float tita) {
	return ((( cos(tita) *  sinhPxPx(v)) *  sin(u)) + (( sin(tita) *  coshPxPx(v)) *  cos(u)));
}

float compxPvPtita(float u, float v, float tita) {
	return (((( -  sin(tita)) *  sinhPx(v)) *  sin(u)) + (( cos(tita) *  coshPx(v)) *  cos(u)));
}

float compyPvPu(float u, float v, float tita) {
	return 0;
}

float compyPvPv(float u, float v, float tita) {
	return 0;
}

float compyPvPtita(float u, float v, float tita) {
	return  cos(tita);
}

float compzPvPu(float u, float v, float tita) {
	return (( - (( cos(tita) *  sinhPx(v)) * ( -  sin(u)))) + (( sin(tita) *  coshPx(v)) *  cos(u)));
}

float compzPvPv(float u, float v, float tita) {
	return (( - (( cos(tita) *  sinhPxPx(v)) *  cos(u))) + (( sin(tita) *  coshPxPx(v)) *  sin(u)));
}

float compzPvPtita(float u, float v, float tita) {
	return (( - ((( -  sin(tita)) *  sinhPx(v)) *  cos(u))) + (( cos(tita) *  coshPx(v)) *  sin(u)));
}

vec3 fPvPv(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPvPv(u, v, t2),  compyPvPv(u, v, t2),  compzPvPv(u, v, t2));
}

vec3 fPuPv(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPuPv(u, v, t2),  compyPuPv(u, v, t2),  compzPuPv(u, v, t2));
}

float fK(float u, float v, float t0, float t1, float t2) {
	return ( determinant( mat3( fPuPu(u, v, t0, t1, t2),  fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))) *  determinant( mat3( fPvPv(u, v, t0, t1, t2),  fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))) -  pow( determinant( mat3( fPuPv(u, v, t0, t1, t2),  fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))), 2)) /  pow( pow( length( fPu(u, v, t0, t1, t2)), 2) *  pow( length( fPv(u, v, t0, t1, t2)), 2) -  pow( dot( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2)), 2), 2);
}

vec3 g(float u, float v, float t0, float t1, float t2) {
	return  f((1 + t1) * (u - 0.5) * 2 * PI, (1 + t0) * 2 * (v - 0.5), t0, t1, t2 * PI);
}

vec3 fPt0(float u, float v, float t0, float t1, float t2) {
	return  vec3(0, 0, 0);
}

vec3 fPt1(float u, float v, float t0, float t1, float t2) {
	return  vec3(0, 0, 0);
}

vec3 fPt2(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPtita(u, v, t2),  compyPtita(u, v, t2),  compzPtita(u, v, t2));
}

vec3 gPu(float u, float v, float t0, float t1, float t2) {
	return ( fPu((1 + t1) * (u - 0.5) * 2 * PI, (1 + t0) * 2 * (v - 0.5), t0, t1, t2 * PI) * (((1 + t1) * 2) * PI));
}

vec3 gPv(float u, float v, float t0, float t1, float t2) {
	return ( fPv((1 + t1) * (u - 0.5) * 2 * PI, (1 + t0) * 2 * (v - 0.5), t0, t1, t2 * PI) * ((1 + t0) * 2));
}

vec3 gNormal(float u, float v, float t0, float t1, float t2) {
	return  normalize( cross( gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2)));
}

float gArea(float u, float v, float t0, float t1, float t2) {
	return  distance( gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2));
}

vec3 fPuPt0(float u, float v, float t0, float t1, float t2) {
	return  vec3(0, 0, 0);
}

vec3 fPuPt1(float u, float v, float t0, float t1, float t2) {
	return  vec3(0, 0, 0);
}

vec3 fPuPt2(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPuPtita(u, v, t2),  compyPuPtita(u, v, t2),  compzPuPtita(u, v, t2));
}

vec3 gPuPu(float u, float v, float t0, float t1, float t2) {
	return (( fPuPu((1 + t1) * (u - 0.5) * 2 * PI, (1 + t0) * 2 * (v - 0.5), t0, t1, t2 * PI) * (((1 + t1) * 2) * PI)) * (((1 + t1) * 2) * PI));
}

vec3 fPvPu(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPvPu(u, v, t2),  compyPvPu(u, v, t2),  compzPvPu(u, v, t2));
}

vec3 fPvPt0(float u, float v, float t0, float t1, float t2) {
	return  vec3(0, 0, 0);
}

vec3 fPvPt1(float u, float v, float t0, float t1, float t2) {
	return  vec3(0, 0, 0);
}

vec3 fPvPt2(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPvPtita(u, v, t2),  compyPvPtita(u, v, t2),  compzPvPtita(u, v, t2));
}

vec3 gPvPv(float u, float v, float t0, float t1, float t2) {
	return (( fPvPv((1 + t1) * (u - 0.5) * 2 * PI, (1 + t0) * 2 * (v - 0.5), t0, t1, t2 * PI) * ((1 + t0) * 2)) * ((1 + t0) * 2));
}

vec3 gPuPv(float u, float v, float t0, float t1, float t2) {
	return (( fPuPv((1 + t1) * (u - 0.5) * 2 * PI, (1 + t0) * 2 * (v - 0.5), t0, t1, t2 * PI) * ((1 + t0) * 2)) * (((1 + t1) * 2) * PI));
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

