#version 440 core
layout (location = 0) in vec2 aPos;

out vData {vec3 FragPos; vec3 Normal; float Area;} vertex;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float param_t[10];
uniform int funPlot;


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
float PI2 = 3.1415926;

float r = 0.5;

float R = 2.0;

vec3 g(float u, float v) {
	return 2 *  vec3( cos(v * PI2) *  cos(u * 2 * PI2),  cos(v * PI2) *  sin(u * 2 * PI2),  sin(v * PI2));
}

vec3 gPu(float u, float v) {
	return ( vec3(0) + 2 *  vec3(( cos(v * PI2) * (( -  sin(u * 2 * PI2)) * (2 * PI2))), ( cos(v * PI2) * ( cos(u * 2 * PI2) * (2 * PI2))), 0));
}

vec3 gPv(float u, float v) {
	return ( vec3(0) + 2 *  vec3(((( -  sin(v * PI2)) * PI2) *  cos(u * 2 * PI2)), ((( -  sin(v * PI2)) * PI2) *  sin(u * 2 * PI2)), ( cos(v * PI2) * PI2)));
}

vec3 gNormal(float u, float v) {
	return  normalize( cross( gPu(u, v),  gPv(u, v)));
}

float gArea(float u, float v) {
	return  distance( gPu(u, v),  gPv(u, v));
}

vec3 gPuPu(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(( cos(v * PI2) * (( - ( cos(u * 2 * PI2) * (2 * PI2))) * (2 * PI2))), ( cos(v * PI2) * ((( -  sin(u * 2 * PI2)) * (2 * PI2)) * (2 * PI2))), 0)));
}

vec3 gPvPv(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(((( - ( cos(v * PI2) * PI2)) * PI2) *  cos(u * 2 * PI2)), ((( - ( cos(v * PI2) * PI2)) * PI2) *  sin(u * 2 * PI2)), ((( -  sin(v * PI2)) * PI2) * PI2))));
}

vec3 gPuPv(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(((( -  sin(v * PI2)) * PI2) * (( -  sin(u * 2 * PI2)) * (2 * PI2))), ((( -  sin(v * PI2)) * PI2) * ( cos(u * 2 * PI2) * (2 * PI2))), 0)));
}

float gK(float u, float v) {
	return ( determinant( mat3( gPuPu(u, v),  gPu(u, v),  gPv(u, v))) *  determinant( mat3( gPvPv(u, v),  gPu(u, v),  gPv(u, v))) -  pow( determinant( mat3( gPuPv(u, v),  gPu(u, v),  gPv(u, v))), 2)) /  pow( pow( length( gPu(u, v)), 2) *  pow( length( gPv(u, v)), 2) -  pow( dot( gPu(u, v),  gPv(u, v)), 2), 2);
}

vec3 h(float u, float v) {
	return 2 *  vec3(u, v,  cos(10 * u) +  cos(10 * v));
}

vec3 hPu(float u, float v) {
	return ( vec3(0) + 2 *  vec3(1, 0, (( -  sin(10 * u)) * 10)));
}

vec3 hPv(float u, float v) {
	return ( vec3(0) + 2 *  vec3(0, 1, (( -  sin(10 * v)) * 10)));
}

vec3 hNormal(float u, float v) {
	return  normalize( cross( hPu(u, v),  hPv(u, v)));
}

float hArea(float u, float v) {
	return  distance( hPu(u, v),  hPv(u, v));
}

vec3 hPuPu(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(0, 0, (( - ( cos(10 * u) * 10)) * 10))));
}

vec3 hPvPv(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(0, 0, (( - ( cos(10 * v) * 10)) * 10))));
}

vec3 hPuPv(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(0, 0, 0)));
}

float hK(float u, float v) {
	return ( determinant( mat3( hPuPu(u, v),  hPu(u, v),  hPv(u, v))) *  determinant( mat3( hPvPv(u, v),  hPu(u, v),  hPv(u, v))) -  pow( determinant( mat3( hPuPv(u, v),  hPu(u, v),  hPv(u, v))), 2)) /  pow( pow( length( hPu(u, v)), 2) *  pow( length( hPv(u, v)), 2) -  pow( dot( hPu(u, v),  hPv(u, v)), 2), 2);
}

vec3 f(float u, float v) {
	return  g(u - 0.5, v - 0.5);
}

vec3 fPu(float u, float v) {
	return  gPu(u - 0.5, v - 0.5);
}

vec3 fPv(float u, float v) {
	return  gPv(u - 0.5, v - 0.5);
}

vec3 fNormal(float u, float v) {
	return  normalize( cross( fPu(u, v),  fPv(u, v)));
}

float fArea(float u, float v) {
	return  distance( fPu(u, v),  fPv(u, v));
}

vec3 fPuPu(float u, float v) {
	return  gPuPu(u - 0.5, v - 0.5);
}

vec3 gPvPu(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(((( -  sin(v * PI2)) * PI2) * (( -  sin(u * 2 * PI2)) * (2 * PI2))), ((( -  sin(v * PI2)) * PI2) * ( cos(u * 2 * PI2) * (2 * PI2))), 0)));
}

vec3 fPvPv(float u, float v) {
	return  gPvPv(u - 0.5, v - 0.5);
}

vec3 fPuPv(float u, float v) {
	return  gPuPv(u - 0.5, v - 0.5);
}

float fK(float u, float v) {
	return ( determinant( mat3( fPuPu(u, v),  fPu(u, v),  fPv(u, v))) *  determinant( mat3( fPvPv(u, v),  fPu(u, v),  fPv(u, v))) -  pow( determinant( mat3( fPuPv(u, v),  fPu(u, v),  fPv(u, v))), 2)) /  pow( pow( length( fPu(u, v)), 2) *  pow( length( fPv(u, v)), 2) -  pow( dot( fPu(u, v),  fPv(u, v)), 2), 2);
}

float compx(float u, float v, float t1, float t2) {
	return (t1 + t2 *  cos(v * 2 * PI)) *  cos(u * 2 * PI);
}

float compy(float u, float v, float t1, float t2) {
	return (t1 + t2 *  cos(v * 2 * PI)) *  sin(u * 2 * PI);
}

float compz(float u, float v, float t1, float t2) {
	return t2 *  sin(v * 2 * PI);
}

vec3 g2(float u, float v, float t0, float t1, float t2) {
	return  vec3( compx(u *  cos(t0), v, t1, t2),  compy(u, v, t1, t2),  compz(u, v, t1, t2));
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

vec3 g2Pu(float u, float v, float t0, float t1, float t2) {
	return  vec3(( compxPu(u *  cos(t0), v, t1, t2) *  cos(t0)),  compyPu(u, v, t1, t2),  compzPu(u, v, t1, t2));
}

vec3 g2Pv(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPv(u *  cos(t0), v, t1, t2),  compyPv(u, v, t1, t2),  compzPv(u, v, t1, t2));
}

vec3 g2Normal(float u, float v, float t0, float t1, float t2) {
	return  normalize( cross( g2Pu(u, v, t0, t1, t2),  g2Pv(u, v, t0, t1, t2)));
}

float g2Area(float u, float v, float t0, float t1, float t2) {
	return  distance( g2Pu(u, v, t0, t1, t2),  g2Pv(u, v, t0, t1, t2));
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

vec3 g2PuPu(float u, float v, float t0, float t1, float t2) {
	return  vec3((( compxPuPu(u *  cos(t0), v, t1, t2) *  cos(t0)) *  cos(t0)),  compyPuPu(u, v, t1, t2),  compzPuPu(u, v, t1, t2));
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

vec3 g2PvPv(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPvPv(u *  cos(t0), v, t1, t2),  compyPvPv(u, v, t1, t2),  compzPvPv(u, v, t1, t2));
}

vec3 g2PuPv(float u, float v, float t0, float t1, float t2) {
	return  vec3(( compxPuPv(u *  cos(t0), v, t1, t2) *  cos(t0)),  compyPuPv(u, v, t1, t2),  compzPuPv(u, v, t1, t2));
}

float g2K(float u, float v, float t0, float t1, float t2) {
	return ( determinant( mat3( g2PuPu(u, v, t0, t1, t2),  g2Pu(u, v, t0, t1, t2),  g2Pv(u, v, t0, t1, t2))) *  determinant( mat3( g2PvPv(u, v, t0, t1, t2),  g2Pu(u, v, t0, t1, t2),  g2Pv(u, v, t0, t1, t2))) -  pow( determinant( mat3( g2PuPv(u, v, t0, t1, t2),  g2Pu(u, v, t0, t1, t2),  g2Pv(u, v, t0, t1, t2))), 2)) /  pow( pow( length( g2Pu(u, v, t0, t1, t2)), 2) *  pow( length( g2Pv(u, v, t0, t1, t2)), 2) -  pow( dot( g2Pu(u, v, t0, t1, t2),  g2Pv(u, v, t0, t1, t2)), 2), 2);
}

vec3 f2(float u, float v) {
	return 2 *  g2(u - 0.5, v - 0.5, 0, R, r);
}

vec3 g2Pt0(float u, float v, float t0, float t1, float t2) {
	return  vec3(( compxPu(u *  cos(t0), v, t1, t2) * (u * ( -  sin(t0)))), 0, 0);
}

vec3 g2Pt1(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPt1(u *  cos(t0), v, t1, t2),  compyPt1(u, v, t1, t2),  compzPt1(u, v, t1, t2));
}

vec3 g2Pt2(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPt2(u *  cos(t0), v, t1, t2),  compyPt2(u, v, t1, t2),  compzPt2(u, v, t1, t2));
}

vec3 f2Pu(float u, float v) {
	return (2 *  g2Pu(u - 0.5, v - 0.5, 0, R, r));
}

vec3 f2Pv(float u, float v) {
	return (2 *  g2Pv(u - 0.5, v - 0.5, 0, R, r));
}

vec3 f2Normal(float u, float v) {
	return  normalize( cross( f2Pu(u, v),  f2Pv(u, v)));
}

float f2Area(float u, float v) {
	return  distance( f2Pu(u, v),  f2Pv(u, v));
}

vec3 g2PuPt0(float u, float v, float t0, float t1, float t2) {
	return  vec3((( compxPuPu(u *  cos(t0), v, t1, t2) * (u * ( -  sin(t0)))) *  cos(t0) +  compxPu(u *  cos(t0), v, t1, t2) * ( -  sin(t0))), 0, 0);
}

vec3 g2PuPt1(float u, float v, float t0, float t1, float t2) {
	return  vec3(( compxPuPt1(u *  cos(t0), v, t1, t2) *  cos(t0)),  compyPuPt1(u, v, t1, t2),  compzPuPt1(u, v, t1, t2));
}

vec3 g2PuPt2(float u, float v, float t0, float t1, float t2) {
	return  vec3(( compxPuPt2(u *  cos(t0), v, t1, t2) *  cos(t0)),  compyPuPt2(u, v, t1, t2),  compzPuPt2(u, v, t1, t2));
}

vec3 f2PuPu(float u, float v) {
	return (2 *  g2PuPu(u - 0.5, v - 0.5, 0, R, r));
}

vec3 g2PvPu(float u, float v, float t0, float t1, float t2) {
	return  vec3(( compxPvPu(u *  cos(t0), v, t1, t2) *  cos(t0)),  compyPvPu(u, v, t1, t2),  compzPvPu(u, v, t1, t2));
}

vec3 g2PvPt0(float u, float v, float t0, float t1, float t2) {
	return  vec3(( compxPvPu(u *  cos(t0), v, t1, t2) * (u * ( -  sin(t0)))), 0, 0);
}

vec3 g2PvPt1(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPvPt1(u *  cos(t0), v, t1, t2),  compyPvPt1(u, v, t1, t2),  compzPvPt1(u, v, t1, t2));
}

vec3 g2PvPt2(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPvPt2(u *  cos(t0), v, t1, t2),  compyPvPt2(u, v, t1, t2),  compzPvPt2(u, v, t1, t2));
}

vec3 f2PvPv(float u, float v) {
	return (2 *  g2PvPv(u - 0.5, v - 0.5, 0, R, r));
}

vec3 f2PuPv(float u, float v) {
	return (2 *  g2PuPv(u - 0.5, v - 0.5, 0, R, r));
}

float f2K(float u, float v) {
	return ( determinant( mat3( f2PuPu(u, v),  f2Pu(u, v),  f2Pv(u, v))) *  determinant( mat3( f2PvPv(u, v),  f2Pu(u, v),  f2Pv(u, v))) -  pow( determinant( mat3( f2PuPv(u, v),  f2Pu(u, v),  f2Pv(u, v))), 2)) /  pow( pow( length( f2Pu(u, v)), 2) *  pow( length( f2Pv(u, v)), 2) -  pow( dot( f2Pu(u, v),  f2Pv(u, v)), 2), 2);
}

vec3 fAmbas(float u, float v, float t0) {
	return t0 *  f(u, v) + (1 - t0) *  f2(u, v);
}

vec3 fAmbasPu(float u, float v, float t0) {
	return ((t0 *  fPu(u, v)) + ((1 - t0) *  f2Pu(u, v)));
}

vec3 fAmbasPv(float u, float v, float t0) {
	return ((t0 *  fPv(u, v)) + ((1 - t0) *  f2Pv(u, v)));
}

vec3 fAmbasNormal(float u, float v, float t0) {
	return  normalize( cross( fAmbasPu(u, v, t0),  fAmbasPv(u, v, t0)));
}

float fAmbasArea(float u, float v, float t0) {
	return  distance( fAmbasPu(u, v, t0),  fAmbasPv(u, v, t0));
}

vec3 fAmbasPuPu(float u, float v, float t0) {
	return ((t0 *  fPuPu(u, v)) + ((1 - t0) *  f2PuPu(u, v)));
}

vec3 f2PvPu(float u, float v) {
	return (2 *  g2PvPu(u - 0.5, v - 0.5, 0, R, r));
}

vec3 fPvPu(float u, float v) {
	return  gPvPu(u - 0.5, v - 0.5);
}

vec3 fAmbasPvPv(float u, float v, float t0) {
	return ((t0 *  fPvPv(u, v)) + ((1 - t0) *  f2PvPv(u, v)));
}

vec3 fAmbasPuPv(float u, float v, float t0) {
	return ((t0 *  fPuPv(u, v)) + ((1 - t0) *  f2PuPv(u, v)));
}

float fAmbasK(float u, float v, float t0) {
	return ( determinant( mat3( fAmbasPuPu(u, v, t0),  fAmbasPu(u, v, t0),  fAmbasPv(u, v, t0))) *  determinant( mat3( fAmbasPvPv(u, v, t0),  fAmbasPu(u, v, t0),  fAmbasPv(u, v, t0))) -  pow( determinant( mat3( fAmbasPuPv(u, v, t0),  fAmbasPu(u, v, t0),  fAmbasPv(u, v, t0))), 2)) /  pow( pow( length( fAmbasPu(u, v, t0)), 2) *  pow( length( fAmbasPv(u, v, t0)), 2) -  pow( dot( fAmbasPu(u, v, t0),  fAmbasPv(u, v, t0)), 2), 2);
}

void main() {
	vec3 aPosSurf, aNormSurf;
	float aAreaSurf;

	if (funPlot==0) {
		aPosSurf = fAmbas(aPos.x, aPos.y, param_t[0]);
		aNormSurf = fAmbasNormal(aPos.x, aPos.y, param_t[0]);
		aAreaSurf = fAmbasArea(aPos.x, aPos.y, param_t[0]);
	}

	vertex.FragPos = vec3(vec4(aPosSurf, 1.0));
	vertex.Normal = aNormSurf;
	vertex.Area = aAreaSurf;
	gl_Position = vec4(aPosSurf, 1.0);
}