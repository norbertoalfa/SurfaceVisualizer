
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
float r = 0.5;

float R = 2.0;

float compx(float u, float v, float t1, float t2) {
	return (t1 + t2 *  cos(v * 2 * PI)) *  cos(u * 2 * PI);
}

float compy(float u, float v, float t1, float t2) {
	return (t1 + t2 *  cos(v * 2 * PI)) *  sin(u * 2 * PI);
}

float compz(float u, float v, float t1, float t2) {
	return t2 *  sin(v * 2 * PI);
}

vec3 g(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3( compx(u *  cos(t0), v, t1, t2),  compy(u, v, t1, t2),  compz(u, v, t1, t2)));
}

float compxPu(float u, float v, float t1, float t2) {
	return ((t1 + t2 *  cos(v * 2 * PI)) * (( -  sin(u * 2 * PI)) * (2 * PI)));
}

float compxPv(float u, float v, float t1, float t2) {
	return ((t2 * (( -  sin(v * 2 * PI)) * (2 * PI))) *  cos(u * 2 * PI));
}

float compxPt1(float u, float v, float t1, float t2) {
	return  cos(u * 2 * PI);
}

float compxPt2(float u, float v, float t1, float t2) {
	return ( cos(v * 2 * PI) *  cos(u * 2 * PI));
}

float compyPu(float u, float v, float t1, float t2) {
	return ((t1 + t2 *  cos(v * 2 * PI)) * ( cos(u * 2 * PI) * (2 * PI)));
}

float compyPv(float u, float v, float t1, float t2) {
	return ((t2 * (( -  sin(v * 2 * PI)) * (2 * PI))) *  sin(u * 2 * PI));
}

float compyPt1(float u, float v, float t1, float t2) {
	return  sin(u * 2 * PI);
}

float compyPt2(float u, float v, float t1, float t2) {
	return ( cos(v * 2 * PI) *  sin(u * 2 * PI));
}

float compzPu(float u, float v, float t1, float t2) {
	return 0;
}

float compzPv(float u, float v, float t1, float t2) {
	return (t2 * ( cos(v * 2 * PI) * (2 * PI)));
}

float compzPt1(float u, float v, float t1, float t2) {
	return 0;
}

float compzPt2(float u, float v, float t1, float t2) {
	return  sin(v * 2 * PI);
}

vec3 gPu(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3(( compxPu(u *  cos(t0), v, t1, t2) *  cos(t0)),  compyPu(u, v, t1, t2),  compzPu(u, v, t1, t2)));
}

vec3 gPv(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3( compxPv(u *  cos(t0), v, t1, t2),  compyPv(u, v, t1, t2),  compzPv(u, v, t1, t2)));
}

vec3 gNormal(float u, float v, float t0, float t1, float t2) {
	return vec3( normalize( cross( gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2))));
}

float gArea(float u, float v, float t0, float t1, float t2) {
	return  distance( gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2));
}

float compxPuPu(float u, float v, float t1, float t2) {
	return ((t1 + t2 *  cos(v * 2 * PI)) * (( - ( cos(u * 2 * PI) * (2 * PI))) * (2 * PI)));
}

float compxPuPv(float u, float v, float t1, float t2) {
	return ((t2 * (( -  sin(v * 2 * PI)) * (2 * PI))) * (( -  sin(u * 2 * PI)) * (2 * PI)));
}

float compxPuPt1(float u, float v, float t1, float t2) {
	return (( -  sin(u * 2 * PI)) * (2 * PI));
}

float compxPuPt2(float u, float v, float t1, float t2) {
	return ( cos(v * 2 * PI) * (( -  sin(u * 2 * PI)) * (2 * PI)));
}

float compyPuPu(float u, float v, float t1, float t2) {
	return ((t1 + t2 *  cos(v * 2 * PI)) * ((( -  sin(u * 2 * PI)) * (2 * PI)) * (2 * PI)));
}

float compyPuPv(float u, float v, float t1, float t2) {
	return ((t2 * (( -  sin(v * 2 * PI)) * (2 * PI))) * ( cos(u * 2 * PI) * (2 * PI)));
}

float compyPuPt1(float u, float v, float t1, float t2) {
	return ( cos(u * 2 * PI) * (2 * PI));
}

float compyPuPt2(float u, float v, float t1, float t2) {
	return ( cos(v * 2 * PI) * ( cos(u * 2 * PI) * (2 * PI)));
}

float compzPuPu(float u, float v, float t1, float t2) {
	return 0;
}

float compzPuPv(float u, float v, float t1, float t2) {
	return 0;
}

float compzPuPt1(float u, float v, float t1, float t2) {
	return 0;
}

float compzPuPt2(float u, float v, float t1, float t2) {
	return 0;
}

vec3 gPuPu(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3((( compxPuPu(u *  cos(t0), v, t1, t2) *  cos(t0)) *  cos(t0)),  compyPuPu(u, v, t1, t2),  compzPuPu(u, v, t1, t2)));
}

float compxPvPu(float u, float v, float t1, float t2) {
	return ((t2 * (( -  sin(v * 2 * PI)) * (2 * PI))) * (( -  sin(u * 2 * PI)) * (2 * PI)));
}

float compxPvPv(float u, float v, float t1, float t2) {
	return ((t2 * (( - ( cos(v * 2 * PI) * (2 * PI))) * (2 * PI))) *  cos(u * 2 * PI));
}

float compxPvPt1(float u, float v, float t1, float t2) {
	return 0;
}

float compxPvPt2(float u, float v, float t1, float t2) {
	return ((( -  sin(v * 2 * PI)) * (2 * PI)) *  cos(u * 2 * PI));
}

float compyPvPu(float u, float v, float t1, float t2) {
	return ((t2 * (( -  sin(v * 2 * PI)) * (2 * PI))) * ( cos(u * 2 * PI) * (2 * PI)));
}

float compyPvPv(float u, float v, float t1, float t2) {
	return ((t2 * (( - ( cos(v * 2 * PI) * (2 * PI))) * (2 * PI))) *  sin(u * 2 * PI));
}

float compyPvPt1(float u, float v, float t1, float t2) {
	return 0;
}

float compyPvPt2(float u, float v, float t1, float t2) {
	return ((( -  sin(v * 2 * PI)) * (2 * PI)) *  sin(u * 2 * PI));
}

float compzPvPu(float u, float v, float t1, float t2) {
	return 0;
}

float compzPvPv(float u, float v, float t1, float t2) {
	return (t2 * ((( -  sin(v * 2 * PI)) * (2 * PI)) * (2 * PI)));
}

float compzPvPt1(float u, float v, float t1, float t2) {
	return 0;
}

float compzPvPt2(float u, float v, float t1, float t2) {
	return ( cos(v * 2 * PI) * (2 * PI));
}

vec3 gPvPv(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3( compxPvPv(u *  cos(t0), v, t1, t2),  compyPvPv(u, v, t1, t2),  compzPvPv(u, v, t1, t2)));
}

vec3 gPuPv(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3(( compxPuPv(u *  cos(t0), v, t1, t2) *  cos(t0)),  compyPuPv(u, v, t1, t2),  compzPuPv(u, v, t1, t2)));
}

float gK(float u, float v, float t0, float t1, float t2) {
	return ( determinant( mat3( gPuPu(u, v, t0, t1, t2),  gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2))) *  determinant( mat3( gPvPv(u, v, t0, t1, t2),  gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2))) -  pow( determinant( mat3( gPuPv(u, v, t0, t1, t2),  gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2))), 2)) /  pow( pow( length( gPu(u, v, t0, t1, t2)), 2) *  pow( length( gPv(u, v, t0, t1, t2)), 2) -  pow( dot( gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2)), 2), 2);
}

vec3 f(float u, float v, float t0, float t1, float t2) {
	return vec3(2 *  g((u - 0.5), (v - 0.5), t0, t1 + R, t2 + r));
}

vec3 gPt0(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3(( compxPu(u *  cos(t0), v, t1, t2) * (u * ( -  sin(t0)))), 0, 0));
}

vec3 gPt1(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3( compxPt1(u *  cos(t0), v, t1, t2),  compyPt1(u, v, t1, t2),  compzPt1(u, v, t1, t2)));
}

vec3 gPt2(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3( compxPt2(u *  cos(t0), v, t1, t2),  compyPt2(u, v, t1, t2),  compzPt2(u, v, t1, t2)));
}

vec3 fPu(float u, float v, float t0, float t1, float t2) {
	return vec3((2 *  gPu((u - 0.5), (v - 0.5), t0, t1 + R, t2 + r)));
}

vec3 fPv(float u, float v, float t0, float t1, float t2) {
	return vec3((2 *  gPv((u - 0.5), (v - 0.5), t0, t1 + R, t2 + r)));
}

vec3 fNormal(float u, float v, float t0, float t1, float t2) {
	return vec3( normalize( cross( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))));
}

float fArea(float u, float v, float t0, float t1, float t2) {
	return  distance( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2));
}

vec3 gPuPt0(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3((( compxPuPu(u *  cos(t0), v, t1, t2) * (u * ( -  sin(t0)))) *  cos(t0) +  compxPu(u *  cos(t0), v, t1, t2) * ( -  sin(t0))), 0, 0));
}

vec3 gPuPt1(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3(( compxPuPt1(u *  cos(t0), v, t1, t2) *  cos(t0)),  compyPuPt1(u, v, t1, t2),  compzPuPt1(u, v, t1, t2)));
}

vec3 gPuPt2(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3(( compxPuPt2(u *  cos(t0), v, t1, t2) *  cos(t0)),  compyPuPt2(u, v, t1, t2),  compzPuPt2(u, v, t1, t2)));
}

vec3 fPuPu(float u, float v, float t0, float t1, float t2) {
	return vec3((2 *  gPuPu((u - 0.5), (v - 0.5), t0, t1 + R, t2 + r)));
}

vec3 gPvPu(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3(( compxPvPu(u *  cos(t0), v, t1, t2) *  cos(t0)),  compyPvPu(u, v, t1, t2),  compzPvPu(u, v, t1, t2)));
}

vec3 gPvPt0(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3(( compxPvPu(u *  cos(t0), v, t1, t2) * (u * ( -  sin(t0)))), 0, 0));
}

vec3 gPvPt1(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3( compxPvPt1(u *  cos(t0), v, t1, t2),  compyPvPt1(u, v, t1, t2),  compzPvPt1(u, v, t1, t2)));
}

vec3 gPvPt2(float u, float v, float t0, float t1, float t2) {
	return vec3( vec3( compxPvPt2(u *  cos(t0), v, t1, t2),  compyPvPt2(u, v, t1, t2),  compzPvPt2(u, v, t1, t2)));
}

vec3 fPvPv(float u, float v, float t0, float t1, float t2) {
	return vec3((2 *  gPvPv((u - 0.5), (v - 0.5), t0, t1 + R, t2 + r)));
}

vec3 fPuPv(float u, float v, float t0, float t1, float t2) {
	return vec3((2 *  gPuPv((u - 0.5), (v - 0.5), t0, t1 + R, t2 + r)));
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

