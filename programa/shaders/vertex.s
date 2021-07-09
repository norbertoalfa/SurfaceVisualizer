#version 440 core
layout (location = 0) in vec2 aPos;

out vData {vec3 FragPos; vec3 Normal;} vertex;

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
float compx(float u, float v) {
	return  log((1 + ( pow(u, 2)) + 2 * u *  cos(v)) / (1 + ( pow(u, 2)) - 2 * u *  cos(v)));
}

float compy(float u, float v, float t0, float ori) {
	return t0 + ori * 2 *  atan((2 * ( pow(u, 2)) *  sin(2 * v)) / ( pow(u, 4) - 1));
}

float compz(float u, float v) {
	return  log((1 + ( pow(u, 2)) - 2 * u *  sin(v)) / (1 + ( pow(u, 2)) + 2 * u *  sin(v)));
}

vec3 f(float u, float v, float t0, float ori) {
	return  vec3( compx(u, v),  compy(u, v, t0, ori),  compz(u, v));
}

float compxPu(float u, float v) {
	return (1 / ((1 + ( pow(u, 2)) + 2 * u *  cos(v)) / (1 + ( pow(u, 2)) - 2 * u *  cos(v))) * (((2 *  pow(u, 1.000000)) + (2 *  cos(v))) / (1 + ( pow(u, 2)) - 2 * u *  cos(v)) - (1 + ( pow(u, 2)) + 2 * u *  cos(v)) * ((2 *  pow(u, 1.000000)) - (2 *  cos(v))) / ( pow((1 + ( pow(u, 2)) - 2 * u *  cos(v)), 2))));
}

float compxPv(float u, float v) {
	return (1 / ((1 + ( pow(u, 2)) + 2 * u *  cos(v)) / (1 + ( pow(u, 2)) - 2 * u *  cos(v))) * ((2 * u * ( -  sin(v))) / (1 + ( pow(u, 2)) - 2 * u *  cos(v)) - (1 + ( pow(u, 2)) + 2 * u *  cos(v)) * ( - (2 * u * ( -  sin(v)))) / ( pow((1 + ( pow(u, 2)) - 2 * u *  cos(v)), 2))));
}

float compyPu(float u, float v, float t0, float ori) {
	return (ori * 2 * (1 / (1 +  pow(((2 * ( pow(u, 2)) *  sin(2 * v)) / ( pow(u, 4) - 1)), 2)) * (((2 * (2 *  pow(u, 1.000000))) *  sin(2 * v)) / ( pow(u, 4) - 1) - (2 * ( pow(u, 2)) *  sin(2 * v)) * (4 *  pow(u, 3.000000)) / ( pow(( pow(u, 4) - 1), 2)))));
}

float compyPv(float u, float v, float t0, float ori) {
	return (ori * 2 * (1 / (1 +  pow(((2 * ( pow(u, 2)) *  sin(2 * v)) / ( pow(u, 4) - 1)), 2)) * ((2 * ( pow(u, 2)) * ( cos(2 * v) * 2)) / ( pow(u, 4) - 1))));
}

float compyPt0(float u, float v, float t0, float ori) {
	return 1;
}

float compyPori(float u, float v, float t0, float ori) {
	return (2 *  atan((2 * ( pow(u, 2)) *  sin(2 * v)) / ( pow(u, 4) - 1)));
}

float compzPu(float u, float v) {
	return (1 / ((1 + ( pow(u, 2)) - 2 * u *  sin(v)) / (1 + ( pow(u, 2)) + 2 * u *  sin(v))) * (((2 *  pow(u, 1.000000)) - (2 *  sin(v))) / (1 + ( pow(u, 2)) + 2 * u *  sin(v)) - (1 + ( pow(u, 2)) - 2 * u *  sin(v)) * ((2 *  pow(u, 1.000000)) + (2 *  sin(v))) / ( pow((1 + ( pow(u, 2)) + 2 * u *  sin(v)), 2))));
}

float compzPv(float u, float v) {
	return (1 / ((1 + ( pow(u, 2)) - 2 * u *  sin(v)) / (1 + ( pow(u, 2)) + 2 * u *  sin(v))) * (( - (2 * u *  cos(v))) / (1 + ( pow(u, 2)) + 2 * u *  sin(v)) - (1 + ( pow(u, 2)) - 2 * u *  sin(v)) * (2 * u *  cos(v)) / ( pow((1 + ( pow(u, 2)) + 2 * u *  sin(v)), 2))));
}

vec3 fPu(float u, float v, float t0, float ori) {
	return  vec3( compxPu(u, v),  compyPu(u, v, t0, ori),  compzPu(u, v));
}

vec3 fPv(float u, float v, float t0, float ori) {
	return  vec3( compxPv(u, v),  compyPv(u, v, t0, ori),  compzPv(u, v));
}

vec3 fNormal(float u, float v, float t0, float ori) {
	return  normalize( cross( fPu(u, v, t0, ori),  fPv(u, v, t0, ori)));
}

vec3 gD(float u, float v, float t0) {
	return  f(0.9999999 * u, v * 2 * PI, t0, 1);
}

vec3 fPt0(float u, float v, float t0, float ori) {
	return  vec3(0,  compyPt0(u, v, t0, ori), 0);
}

vec3 fPori(float u, float v, float t0, float ori) {
	return  vec3(0,  compyPori(u, v, t0, ori), 0);
}

vec3 gDPu(float u, float v, float t0) {
	return ( fPu(0.9999999 * u, v * 2 * PI, t0, 1) * 0.9999999);
}

vec3 gDPv(float u, float v, float t0) {
	return ( fPv(0.9999999 * u, v * 2 * PI, t0, 1) * (2 * PI));
}

vec3 gDNormal(float u, float v, float t0) {
	return  normalize( cross( gDPu(u, v, t0),  gDPv(u, v, t0)));
}

vec3 gU(float u, float v, float t0) {
	return  f(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1);
}

vec3 gUPu(float u, float v, float t0) {
	return ( fPu(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1) * ( - 0.9999));
}

vec3 gUPv(float u, float v, float t0) {
	return ( fPv(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1) * (2 * PI));
}

vec3 gUNormal(float u, float v, float t0) {
	return  normalize( cross( gUPu(u, v, t0),  gUPv(u, v, t0)));
}

vec3 gSS(float u, float v, float t0) {
	return  funcionIf((v < 0.5),  gU(u, v * 2, t0),  gD(u, (v - 0.5) * 2, t0));
}

vec3 gDPt0(float u, float v, float t0) {
	return  fPt0(0.9999999 * u, v * 2 * PI, t0, 1);
}

vec3 gUPt0(float u, float v, float t0) {
	return  fPt0(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1);
}

vec3 gSSPu(float u, float v, float t0) {
	return  funcionIf((v < 0.5),  gUPu(u, v * 2, t0),  gDPu(u, (v - 0.5) * 2, t0));
}

vec3 gSSPv(float u, float v, float t0) {
	return  funcionIf((v < 0.5), ( gUPv(u, v * 2, t0) * 2), ( gDPv(u, (v - 0.5) * 2, t0) * 2));
}

vec3 gSSNormal(float u, float v, float t0) {
	return  normalize( cross( gSSPu(u, v, t0),  gSSPv(u, v, t0)));
}

vec3 gSS2(float u, float v, float t0) {
	return  gSS(u, v, 4 * PI);
}

vec3 gSSPt0(float u, float v, float t0) {
	return  funcionIf((v < 0.5),  gUPt0(u, v * 2, t0),  gDPt0(u, (v - 0.5) * 2, t0));
}

vec3 gSS2Pu(float u, float v, float t0) {
	return  gSSPu(u, v, 4 * PI);
}

vec3 gSS2Pv(float u, float v, float t0) {
	return  gSSPv(u, v, 4 * PI);
}

vec3 gSS2Normal(float u, float v, float t0) {
	return  normalize( cross( gSS2Pu(u, v, t0),  gSS2Pv(u, v, t0)));
}

void main() {
	vec3 aPosSurf, aNormSurf;

	if (funPlot==0) {
		aPosSurf = gD(aPos.x, aPos.y, param_t[0]);
		aNormSurf = gDNormal(aPos.x, aPos.y, param_t[0]);
	}

	vertex.FragPos = vec3(vec4(aPosSurf, 1.0));
	vertex.Normal = aNormSurf;
	gl_Position = vec4(aPosSurf, 1.0);
}