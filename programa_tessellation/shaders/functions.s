
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
float compx(float u, float v, float r) {
	return (r +  cos(u / 2) *  sin(v) -  sin(u / 2) *  sin(2 * v)) *  cos(u);
}

float compy(float u, float v) {
	return  sin(u / 2) *  sin(v) +  cos(u / 2) *  sin(2 * v);
}

float compz(float u, float v, float r) {
	return (r +  cos(u / 2) *  sin(v) -  sin(u / 2) *  sin(2 * v)) *  sin(u);
}

vec3 f(float u, float v, float r) {
	return vec3( vec3( compx(u, v, r),  compy(u, v),  compz(u, v, r)));
}

float compxPu(float u, float v, float r) {
	return ((((( -  sin(u / 2)) * (1 / 2)) *  sin(v)) - (( cos(u / 2) * (1 / 2)) *  sin(2 * v))) *  cos(u) + (r +  cos(u / 2) *  sin(v) -  sin(u / 2) *  sin(2 * v)) * ( -  sin(u)));
}

float compxPv(float u, float v, float r) {
	return ((( cos(u / 2) *  cos(v)) - ( sin(u / 2) * ( cos(2 * v) * 2))) *  cos(u));
}

float compxPr(float u, float v, float r) {
	return  cos(u);
}

float compyPu(float u, float v) {
	return ((( cos(u / 2) * (1 / 2)) *  sin(v)) + ((( -  sin(u / 2)) * (1 / 2)) *  sin(2 * v)));
}

float compyPv(float u, float v) {
	return (( sin(u / 2) *  cos(v)) + ( cos(u / 2) * ( cos(2 * v) * 2)));
}

float compzPu(float u, float v, float r) {
	return ((((( -  sin(u / 2)) * (1 / 2)) *  sin(v)) - (( cos(u / 2) * (1 / 2)) *  sin(2 * v))) *  sin(u) + (r +  cos(u / 2) *  sin(v) -  sin(u / 2) *  sin(2 * v)) *  cos(u));
}

float compzPv(float u, float v, float r) {
	return ((( cos(u / 2) *  cos(v)) - ( sin(u / 2) * ( cos(2 * v) * 2))) *  sin(u));
}

float compzPr(float u, float v, float r) {
	return  sin(u);
}

vec3 fPu(float u, float v, float r) {
	return vec3( vec3( compxPu(u, v, r),  compyPu(u, v),  compzPu(u, v, r)));
}

vec3 fPv(float u, float v, float r) {
	return vec3( vec3( compxPv(u, v, r),  compyPv(u, v),  compzPv(u, v, r)));
}

vec3 fNormal(float u, float v, float r) {
	return vec3( normalize( cross( fPu(u, v, r),  fPv(u, v, r))));
}

float fArea(float u, float v, float r) {
	return  distance( fPu(u, v, r),  fPv(u, v, r));
}

float compxPuPu(float u, float v, float r) {
	return (((((( - ( cos(u / 2) * (1 / 2))) * (1 / 2)) *  sin(v)) - (((( -  sin(u / 2)) * (1 / 2)) * (1 / 2)) *  sin(2 * v))) *  cos(u) + (((( -  sin(u / 2)) * (1 / 2)) *  sin(v)) - (( cos(u / 2) * (1 / 2)) *  sin(2 * v))) * ( -  sin(u))) + ((((( -  sin(u / 2)) * (1 / 2)) *  sin(v)) - (( cos(u / 2) * (1 / 2)) *  sin(2 * v))) * ( -  sin(u)) + (r +  cos(u / 2) *  sin(v) -  sin(u / 2) *  sin(2 * v)) * ( -  cos(u))));
}

float compxPuPv(float u, float v, float r) {
	return (((((( -  sin(u / 2)) * (1 / 2)) *  cos(v)) - (( cos(u / 2) * (1 / 2)) * ( cos(2 * v) * 2))) *  cos(u)) + ((( cos(u / 2) *  cos(v)) - ( sin(u / 2) * ( cos(2 * v) * 2))) * ( -  sin(u))));
}

float compxPuPr(float u, float v, float r) {
	return ( -  sin(u));
}

float compyPuPu(float u, float v) {
	return ((((( -  sin(u / 2)) * (1 / 2)) * (1 / 2)) *  sin(v)) + ((( - ( cos(u / 2) * (1 / 2))) * (1 / 2)) *  sin(2 * v)));
}

float compyPuPv(float u, float v) {
	return ((( cos(u / 2) * (1 / 2)) *  cos(v)) + ((( -  sin(u / 2)) * (1 / 2)) * ( cos(2 * v) * 2)));
}

float compzPuPu(float u, float v, float r) {
	return (((((( - ( cos(u / 2) * (1 / 2))) * (1 / 2)) *  sin(v)) - (((( -  sin(u / 2)) * (1 / 2)) * (1 / 2)) *  sin(2 * v))) *  sin(u) + (((( -  sin(u / 2)) * (1 / 2)) *  sin(v)) - (( cos(u / 2) * (1 / 2)) *  sin(2 * v))) *  cos(u)) + ((((( -  sin(u / 2)) * (1 / 2)) *  sin(v)) - (( cos(u / 2) * (1 / 2)) *  sin(2 * v))) *  cos(u) + (r +  cos(u / 2) *  sin(v) -  sin(u / 2) *  sin(2 * v)) * ( -  sin(u))));
}

float compzPuPv(float u, float v, float r) {
	return (((((( -  sin(u / 2)) * (1 / 2)) *  cos(v)) - (( cos(u / 2) * (1 / 2)) * ( cos(2 * v) * 2))) *  sin(u)) + ((( cos(u / 2) *  cos(v)) - ( sin(u / 2) * ( cos(2 * v) * 2))) *  cos(u)));
}

float compzPuPr(float u, float v, float r) {
	return  cos(u);
}

vec3 fPuPu(float u, float v, float r) {
	return vec3( vec3( compxPuPu(u, v, r),  compyPuPu(u, v),  compzPuPu(u, v, r)));
}

float compxPvPu(float u, float v, float r) {
	return ((((( -  sin(u / 2)) * (1 / 2)) *  cos(v)) - (( cos(u / 2) * (1 / 2)) * ( cos(2 * v) * 2))) *  cos(u) + (( cos(u / 2) *  cos(v)) - ( sin(u / 2) * ( cos(2 * v) * 2))) * ( -  sin(u)));
}

float compxPvPv(float u, float v, float r) {
	return ((( cos(u / 2) * ( -  sin(v))) - ( sin(u / 2) * ((( -  sin(2 * v)) * 2) * 2))) *  cos(u));
}

float compxPvPr(float u, float v, float r) {
	return 0;
}

float compyPvPu(float u, float v) {
	return ((( cos(u / 2) * (1 / 2)) *  cos(v)) + ((( -  sin(u / 2)) * (1 / 2)) * ( cos(2 * v) * 2)));
}

float compyPvPv(float u, float v) {
	return (( sin(u / 2) * ( -  sin(v))) + ( cos(u / 2) * ((( -  sin(2 * v)) * 2) * 2)));
}

float compzPvPu(float u, float v, float r) {
	return ((((( -  sin(u / 2)) * (1 / 2)) *  cos(v)) - (( cos(u / 2) * (1 / 2)) * ( cos(2 * v) * 2))) *  sin(u) + (( cos(u / 2) *  cos(v)) - ( sin(u / 2) * ( cos(2 * v) * 2))) *  cos(u));
}

float compzPvPv(float u, float v, float r) {
	return ((( cos(u / 2) * ( -  sin(v))) - ( sin(u / 2) * ((( -  sin(2 * v)) * 2) * 2))) *  sin(u));
}

float compzPvPr(float u, float v, float r) {
	return 0;
}

vec3 fPvPv(float u, float v, float r) {
	return vec3( vec3( compxPvPv(u, v, r),  compyPvPv(u, v),  compzPvPv(u, v, r)));
}

vec3 fPuPv(float u, float v, float r) {
	return vec3( vec3( compxPuPv(u, v, r),  compyPuPv(u, v),  compzPuPv(u, v, r)));
}

float fK(float u, float v, float r) {
	return ( determinant( mat3( fPuPu(u, v, r),  fPu(u, v, r),  fPv(u, v, r))) *  determinant( mat3( fPvPv(u, v, r),  fPu(u, v, r),  fPv(u, v, r))) -  pow( determinant( mat3( fPuPv(u, v, r),  fPu(u, v, r),  fPv(u, v, r))), 2)) /  pow( pow( length( fPu(u, v, r)), 2) *  pow( length( fPv(u, v, r)), 2) -  pow( dot( fPu(u, v, r),  fPv(u, v, r)), 2), 2);
}

vec3 g(float u, float v, float t0, float t1, float t2) {
	return vec3( f(2 * t2 * PI * u, 2 * t1 * PI * (v - 0.5), 4.0 * t0 + 1.5));
}

vec3 fPr(float u, float v, float r) {
	return vec3( vec3( compxPr(u, v, r), 0,  compzPr(u, v, r)));
}

vec3 gPu(float u, float v, float t0, float t1, float t2) {
	return vec3(( fPu(2 * t2 * PI * u, 2 * t1 * PI * (v - 0.5), 4.0 * t0 + 1.5) * (2 * t2 * PI)));
}

vec3 gPv(float u, float v, float t0, float t1, float t2) {
	return vec3(( fPv(2 * t2 * PI * u, 2 * t1 * PI * (v - 0.5), 4.0 * t0 + 1.5) * (2 * t1 * PI)));
}

vec3 gNormal(float u, float v, float t0, float t1, float t2) {
	return vec3( normalize( cross( gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2))));
}

float gArea(float u, float v, float t0, float t1, float t2) {
	return  distance( gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2));
}

vec3 fPuPr(float u, float v, float r) {
	return vec3( vec3( compxPuPr(u, v, r), 0,  compzPuPr(u, v, r)));
}

vec3 gPuPu(float u, float v, float t0, float t1, float t2) {
	return vec3((( fPuPu(2 * t2 * PI * u, 2 * t1 * PI * (v - 0.5), 4.0 * t0 + 1.5) * (2 * t2 * PI)) * (2 * t2 * PI)));
}

vec3 fPvPu(float u, float v, float r) {
	return vec3( vec3( compxPvPu(u, v, r),  compyPvPu(u, v),  compzPvPu(u, v, r)));
}

vec3 fPvPr(float u, float v, float r) {
	return vec3( vec3( compxPvPr(u, v, r), 0,  compzPvPr(u, v, r)));
}

vec3 gPvPv(float u, float v, float t0, float t1, float t2) {
	return vec3((( fPvPv(2 * t2 * PI * u, 2 * t1 * PI * (v - 0.5), 4.0 * t0 + 1.5) * (2 * t1 * PI)) * (2 * t1 * PI)));
}

vec3 gPuPv(float u, float v, float t0, float t1, float t2) {
	return vec3((( fPuPv(2 * t2 * PI * u, 2 * t1 * PI * (v - 0.5), 4.0 * t0 + 1.5) * (2 * t1 * PI)) * (2 * t2 * PI)));
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

