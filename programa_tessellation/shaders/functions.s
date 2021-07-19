
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
float compx(float u, float v) {
	return u * ((1 -  pow(u, 2) / 3 +  pow(v, 2)) / 3);
}

float compy(float u, float v) {
	return ( pow(u, 2) -  pow(v, 2)) / 3;
}

float compz(float u, float v) {
	return ( - v) * ((1 -  pow(v, 2) / 3 +  pow(u, 2)) / 3);
}

vec3 f(float u, float v) {
	return  vec3( compx(u *  cos(v), u *  sin(v)),  compy(u *  cos(v), u *  sin(v)),  compz(u *  cos(v), u *  sin(v)));
}

float compxPu(float u, float v) {
	return (((1 -  pow(u, 2) / 3 +  pow(v, 2)) / 3) + u * (( - ((2 *  pow(u, 1.000000)) / 3)) / 3));
}

float compxPv(float u, float v) {
	return (u * ((2 *  pow(v, 1.000000)) / 3));
}

float compyPu(float u, float v) {
	return ((2 *  pow(u, 1.000000)) / 3);
}

float compyPv(float u, float v) {
	return (( - (2 *  pow(v, 1.000000))) / 3);
}

float compzPu(float u, float v) {
	return (( - v) * ((2 *  pow(u, 1.000000)) / 3));
}

float compzPv(float u, float v) {
	return (( - 1) * ((1 -  pow(v, 2) / 3 +  pow(u, 2)) / 3) + ( - v) * (( - ((2 *  pow(v, 1.000000)) / 3)) / 3));
}

vec3 fPu(float u, float v) {
	return  vec3(( compxPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compxPv(u *  cos(v), u *  sin(v)) *  sin(v)), ( compyPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compyPv(u *  cos(v), u *  sin(v)) *  sin(v)), ( compzPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compzPv(u *  cos(v), u *  sin(v)) *  sin(v)));
}

vec3 fPv(float u, float v) {
	return  vec3(( compxPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compxPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))), ( compyPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compyPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))), ( compzPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compzPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))));
}

vec3 fNormal(float u, float v) {
	return  normalize( cross( fPu(u, v),  fPv(u, v)));
}

float fArea(float u, float v) {
	return  distance( fPu(u, v),  fPv(u, v));
}

float compxPvPu(float u, float v) {
	return ((2 *  pow(v, 1.000000)) / 3);
}

float compxPvPv(float u, float v) {
	return (u * ((2 * (1.000000 *  pow(v, 0.000000))) / 3));
}

float compxPuPu(float u, float v) {
	return ((( - ((2 *  pow(u, 1.000000)) / 3)) / 3) + ((( - ((2 *  pow(u, 1.000000)) / 3)) / 3) + u * (( - ((2 * (1.000000 *  pow(u, 0.000000))) / 3)) / 3)));
}

float compxPuPv(float u, float v) {
	return ((2 *  pow(v, 1.000000)) / 3);
}

float compyPvPu(float u, float v) {
	return 0;
}

float compyPvPv(float u, float v) {
	return (( - (2 * (1.000000 *  pow(v, 0.000000)))) / 3);
}

float compyPuPu(float u, float v) {
	return ((2 * (1.000000 *  pow(u, 0.000000))) / 3);
}

float compyPuPv(float u, float v) {
	return 0;
}

float compzPvPu(float u, float v) {
	return (( - 1) * ((2 *  pow(u, 1.000000)) / 3));
}

float compzPvPv(float u, float v) {
	return ((( - 1) * (( - ((2 *  pow(v, 1.000000)) / 3)) / 3)) + (( - 1) * (( - ((2 *  pow(v, 1.000000)) / 3)) / 3) + ( - v) * (( - ((2 * (1.000000 *  pow(v, 0.000000))) / 3)) / 3)));
}

float compzPuPu(float u, float v) {
	return (( - v) * ((2 * (1.000000 *  pow(u, 0.000000))) / 3));
}

float compzPuPv(float u, float v) {
	return (( - 1) * ((2 *  pow(u, 1.000000)) / 3));
}

vec3 fPuPu(float u, float v) {
	return  vec3(((( compxPuPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compxPuPv(u *  cos(v), u *  sin(v)) *  sin(v)) *  cos(v)) + (( compxPvPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compxPvPv(u *  cos(v), u *  sin(v)) *  sin(v)) *  sin(v))), ((( compyPuPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compyPuPv(u *  cos(v), u *  sin(v)) *  sin(v)) *  cos(v)) + (( compyPvPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compyPvPv(u *  cos(v), u *  sin(v)) *  sin(v)) *  sin(v))), ((( compzPuPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compzPuPv(u *  cos(v), u *  sin(v)) *  sin(v)) *  cos(v)) + (( compzPvPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compzPvPv(u *  cos(v), u *  sin(v)) *  sin(v)) *  sin(v))));
}

vec3 fPvPv(float u, float v) {
	return  vec3(((( compxPuPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compxPuPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))) * (u * ( -  sin(v))) +  compxPu(u *  cos(v), u *  sin(v)) * (u * ( -  cos(v)))) + (( compxPvPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compxPvPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))) * (u *  cos(v)) +  compxPv(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))))), ((( compyPuPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compyPuPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))) * (u * ( -  sin(v))) +  compyPu(u *  cos(v), u *  sin(v)) * (u * ( -  cos(v)))) + (( compyPvPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compyPvPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))) * (u *  cos(v)) +  compyPv(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))))), ((( compzPuPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compzPuPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))) * (u * ( -  sin(v))) +  compzPu(u *  cos(v), u *  sin(v)) * (u * ( -  cos(v)))) + (( compzPvPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compzPvPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))) * (u *  cos(v)) +  compzPv(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))))));
}

vec3 fPuPv(float u, float v) {
	return  vec3(((( compxPuPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compxPuPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))) *  cos(v) +  compxPu(u *  cos(v), u *  sin(v)) * ( -  sin(v))) + (( compxPvPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compxPvPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))) *  sin(v) +  compxPv(u *  cos(v), u *  sin(v)) *  cos(v))), ((( compyPuPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compyPuPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))) *  cos(v) +  compyPu(u *  cos(v), u *  sin(v)) * ( -  sin(v))) + (( compyPvPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compyPvPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))) *  sin(v) +  compyPv(u *  cos(v), u *  sin(v)) *  cos(v))), ((( compzPuPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compzPuPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))) *  cos(v) +  compzPu(u *  cos(v), u *  sin(v)) * ( -  sin(v))) + (( compzPvPu(u *  cos(v), u *  sin(v)) * (u * ( -  sin(v))) +  compzPvPv(u *  cos(v), u *  sin(v)) * (u *  cos(v))) *  sin(v) +  compzPv(u *  cos(v), u *  sin(v)) *  cos(v))));
}

float fK(float u, float v) {
	return ( determinant( mat3( fPuPu(u, v),  fPu(u, v),  fPv(u, v))) *  determinant( mat3( fPvPv(u, v),  fPu(u, v),  fPv(u, v))) -  pow( determinant( mat3( fPuPv(u, v),  fPu(u, v),  fPv(u, v))), 2)) /  pow( pow( length( fPu(u, v)), 2) *  pow( length( fPv(u, v)), 2) -  pow( dot( fPu(u, v),  fPv(u, v)), 2), 2);
}

vec3 g(float u, float v, float t0, float t1) {
	return (2 * t1 + 1) *  f((u * 2 * t0), (v - 0.5) * 2 * PI);
}

vec3 gPu(float u, float v, float t0, float t1) {
	return ((2 * t1 + 1) * ( fPu((u * 2 * t0), (v - 0.5) * 2 * PI) * (2 * t0)));
}

vec3 gPv(float u, float v, float t0, float t1) {
	return ((2 * t1 + 1) * ( fPv((u * 2 * t0), (v - 0.5) * 2 * PI) * (2 * PI)));
}

vec3 gNormal(float u, float v, float t0, float t1) {
	return  normalize( cross( gPu(u, v, t0, t1),  gPv(u, v, t0, t1)));
}

float gArea(float u, float v, float t0, float t1) {
	return  distance( gPu(u, v, t0, t1),  gPv(u, v, t0, t1));
}

vec3 gPuPu(float u, float v, float t0, float t1) {
	return ((2 * t1 + 1) * (( fPuPu((u * 2 * t0), (v - 0.5) * 2 * PI) * (2 * t0)) * (2 * t0)));
}

vec3 fPvPu(float u, float v) {
	return  vec3(((( compxPuPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compxPuPv(u *  cos(v), u *  sin(v)) *  sin(v)) * (u * ( -  sin(v))) +  compxPu(u *  cos(v), u *  sin(v)) * ( -  sin(v))) + (( compxPvPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compxPvPv(u *  cos(v), u *  sin(v)) *  sin(v)) * (u *  cos(v)) +  compxPv(u *  cos(v), u *  sin(v)) *  cos(v))), ((( compyPuPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compyPuPv(u *  cos(v), u *  sin(v)) *  sin(v)) * (u * ( -  sin(v))) +  compyPu(u *  cos(v), u *  sin(v)) * ( -  sin(v))) + (( compyPvPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compyPvPv(u *  cos(v), u *  sin(v)) *  sin(v)) * (u *  cos(v)) +  compyPv(u *  cos(v), u *  sin(v)) *  cos(v))), ((( compzPuPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compzPuPv(u *  cos(v), u *  sin(v)) *  sin(v)) * (u * ( -  sin(v))) +  compzPu(u *  cos(v), u *  sin(v)) * ( -  sin(v))) + (( compzPvPu(u *  cos(v), u *  sin(v)) *  cos(v) +  compzPvPv(u *  cos(v), u *  sin(v)) *  sin(v)) * (u *  cos(v)) +  compzPv(u *  cos(v), u *  sin(v)) *  cos(v))));
}

vec3 gPvPv(float u, float v, float t0, float t1) {
	return ((2 * t1 + 1) * (( fPvPv((u * 2 * t0), (v - 0.5) * 2 * PI) * (2 * PI)) * (2 * PI)));
}

vec3 gPuPv(float u, float v, float t0, float t1) {
	return ((2 * t1 + 1) * (( fPuPv((u * 2 * t0), (v - 0.5) * 2 * PI) * (2 * PI)) * (2 * t0)));
}

float gK(float u, float v, float t0, float t1) {
	return ( determinant( mat3( gPuPu(u, v, t0, t1),  gPu(u, v, t0, t1),  gPv(u, v, t0, t1))) *  determinant( mat3( gPvPv(u, v, t0, t1),  gPu(u, v, t0, t1),  gPv(u, v, t0, t1))) -  pow( determinant( mat3( gPuPv(u, v, t0, t1),  gPu(u, v, t0, t1),  gPv(u, v, t0, t1))), 2)) /  pow( pow( length( gPu(u, v, t0, t1)), 2) *  pow( length( gPv(u, v, t0, t1)), 2) -  pow( dot( gPu(u, v, t0, t1),  gPv(u, v, t0, t1)), 2), 2);
}

vec3 functionParam(vec2 p) {
	if (funPlot==0) {
		return g(p.x, p.y, param_t[0], param_t[1]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 normalParam(vec2 p) {
	if (funPlot==0) {
		return gNormal(p.x, p.y, param_t[0], param_t[1]);
	}

	return vec3(0.0, 0.0, 0.0);
}

float areaParam(vec2 p) {
	if (funPlot==0) {
		return gArea(p.x, p.y, param_t[0], param_t[1]);
	}

	return 0.0;
}

float curvatureParam(vec2 p) {
	if (funPlot==0) {
		return gK(p.x, p.y, param_t[0], param_t[1]);
	}

	return 0.0;
}

