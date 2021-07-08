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
	return (1 / ((1 + ( pow(u, 2)) + 2 * u *  cos(v)) / (1 + ( pow(u, 2)) - 2 * u *  cos(v))) * (((((((0) + ((((1) * 2 *  pow(u, 1.000000))))) + (((((0) * u + 2 * (1))) *  cos(v) + 2 * u * (( -  sin(v)) * ((0)))))))) / (1 + ( pow(u, 2)) - 2 * u *  cos(v)) - (1 + ( pow(u, 2)) + 2 * u *  cos(v)) * (((((0) + ((((1) * 2 *  pow(u, 1.000000))))) - (((((0) * u + 2 * (1))) *  cos(v) + 2 * u * (( -  sin(v)) * ((0)))))))) / ((1 + ( pow(u, 2)) - 2 * u *  cos(v)) * (1 + ( pow(u, 2)) - 2 * u *  cos(v))))));
}

float compxPv(float u, float v) {
	return (1 / ((1 + ( pow(u, 2)) + 2 * u *  cos(v)) / (1 + ( pow(u, 2)) - 2 * u *  cos(v))) * (((((((0) + ((((0) * 2 *  pow(u, 1.000000))))) + (((((0) * u + 2 * (0))) *  cos(v) + 2 * u * (( -  sin(v)) * ((1)))))))) / (1 + ( pow(u, 2)) - 2 * u *  cos(v)) - (1 + ( pow(u, 2)) + 2 * u *  cos(v)) * (((((0) + ((((0) * 2 *  pow(u, 1.000000))))) - (((((0) * u + 2 * (0))) *  cos(v) + 2 * u * (( -  sin(v)) * ((1)))))))) / ((1 + ( pow(u, 2)) - 2 * u *  cos(v)) * (1 + ( pow(u, 2)) - 2 * u *  cos(v))))));
}

float compyPu(float u, float v, float t0, float ori) {
	return ((0) + (((((0) * 2 + ori * (0))) *  atan((2 * ( pow(u, 2)) *  sin(2 * v)) / ( pow(u, 4) - 1)) + ori * 2 * (1 / (1 +  pow((2 * ( pow(u, 2)) *  sin(2 * v)) / ( pow(u, 4) - 1), 2)) * (((((((((0) * ( pow(u, 2)) + 2 * ((((1) * 2 *  pow(u, 1.000000)))))) *  sin(2 * v) + 2 * ( pow(u, 2)) * ( cos(2 * v) * ((((0) * v + 2 * (0))))))))) / ( pow(u, 4) - 1) - (2 * ( pow(u, 2)) *  sin(2 * v)) * (((((1) * 4 *  pow(u, 3.000000)) - (0)))) / (( pow(u, 4) - 1) * ( pow(u, 4) - 1))))))));
}

float compyPv(float u, float v, float t0, float ori) {
	return ((0) + (((((0) * 2 + ori * (0))) *  atan((2 * ( pow(u, 2)) *  sin(2 * v)) / ( pow(u, 4) - 1)) + ori * 2 * (1 / (1 +  pow((2 * ( pow(u, 2)) *  sin(2 * v)) / ( pow(u, 4) - 1), 2)) * (((((((((0) * ( pow(u, 2)) + 2 * ((((0) * 2 *  pow(u, 1.000000)))))) *  sin(2 * v) + 2 * ( pow(u, 2)) * ( cos(2 * v) * ((((0) * v + 2 * (1))))))))) / ( pow(u, 4) - 1) - (2 * ( pow(u, 2)) *  sin(2 * v)) * (((((0) * 4 *  pow(u, 3.000000)) - (0)))) / (( pow(u, 4) - 1) * ( pow(u, 4) - 1))))))));
}

float compyPt0(float u, float v, float t0, float ori) {
	return ((1) + (((((0) * 2 + ori * (0))) *  atan((2 * ( pow(u, 2)) *  sin(2 * v)) / ( pow(u, 4) - 1)) + ori * 2 * (1 / (1 +  pow((2 * ( pow(u, 2)) *  sin(2 * v)) / ( pow(u, 4) - 1), 2)) * (((((((((0) * ( pow(u, 2)) + 2 * ((((0) * 2 *  pow(u, 1.000000)))))) *  sin(2 * v) + 2 * ( pow(u, 2)) * ( cos(2 * v) * ((((0) * v + 2 * (0))))))))) / ( pow(u, 4) - 1) - (2 * ( pow(u, 2)) *  sin(2 * v)) * (((((0) * 4 *  pow(u, 3.000000)) - (0)))) / (( pow(u, 4) - 1) * ( pow(u, 4) - 1))))))));
}

float compyPori(float u, float v, float t0, float ori) {
	return ((0) + (((((1) * 2 + ori * (0))) *  atan((2 * ( pow(u, 2)) *  sin(2 * v)) / ( pow(u, 4) - 1)) + ori * 2 * (1 / (1 +  pow((2 * ( pow(u, 2)) *  sin(2 * v)) / ( pow(u, 4) - 1), 2)) * (((((((((0) * ( pow(u, 2)) + 2 * ((((0) * 2 *  pow(u, 1.000000)))))) *  sin(2 * v) + 2 * ( pow(u, 2)) * ( cos(2 * v) * ((((0) * v + 2 * (0))))))))) / ( pow(u, 4) - 1) - (2 * ( pow(u, 2)) *  sin(2 * v)) * (((((0) * 4 *  pow(u, 3.000000)) - (0)))) / (( pow(u, 4) - 1) * ( pow(u, 4) - 1))))))));
}

float compzPu(float u, float v) {
	return (1 / ((1 + ( pow(u, 2)) - 2 * u *  sin(v)) / (1 + ( pow(u, 2)) + 2 * u *  sin(v))) * (((((((0) + ((((1) * 2 *  pow(u, 1.000000))))) - (((((0) * u + 2 * (1))) *  sin(v) + 2 * u * ( cos(v) * ((0)))))))) / (1 + ( pow(u, 2)) + 2 * u *  sin(v)) - (1 + ( pow(u, 2)) - 2 * u *  sin(v)) * (((((0) + ((((1) * 2 *  pow(u, 1.000000))))) + (((((0) * u + 2 * (1))) *  sin(v) + 2 * u * ( cos(v) * ((0)))))))) / ((1 + ( pow(u, 2)) + 2 * u *  sin(v)) * (1 + ( pow(u, 2)) + 2 * u *  sin(v))))));
}

float compzPv(float u, float v) {
	return (1 / ((1 + ( pow(u, 2)) - 2 * u *  sin(v)) / (1 + ( pow(u, 2)) + 2 * u *  sin(v))) * (((((((0) + ((((0) * 2 *  pow(u, 1.000000))))) - (((((0) * u + 2 * (0))) *  sin(v) + 2 * u * ( cos(v) * ((1)))))))) / (1 + ( pow(u, 2)) + 2 * u *  sin(v)) - (1 + ( pow(u, 2)) - 2 * u *  sin(v)) * (((((0) + ((((0) * 2 *  pow(u, 1.000000))))) + (((((0) * u + 2 * (0))) *  sin(v) + 2 * u * ( cos(v) * ((1)))))))) / ((1 + ( pow(u, 2)) + 2 * u *  sin(v)) * (1 + ( pow(u, 2)) + 2 * u *  sin(v))))));
}

vec3 fPu(float u, float v, float t0, float ori) {
	return ( vec3((( compxPu(u, v) * ((1)) +  compxPv(u, v) * ((0)))), (( compyPu(u, v, t0, ori) * ((1)) +  compyPv(u, v, t0, ori) * ((0)) +  compyPt0(u, v, t0, ori) * ((0)) +  compyPori(u, v, t0, ori) * ((0)))), (( compzPu(u, v) * ((1)) +  compzPv(u, v) * ((0))))));
}

vec3 fPv(float u, float v, float t0, float ori) {
	return ( vec3((( compxPu(u, v) * ((0)) +  compxPv(u, v) * ((1)))), (( compyPu(u, v, t0, ori) * ((0)) +  compyPv(u, v, t0, ori) * ((1)) +  compyPt0(u, v, t0, ori) * ((0)) +  compyPori(u, v, t0, ori) * ((0)))), (( compzPu(u, v) * ((0)) +  compzPv(u, v) * ((1))))));
}

vec3 fNormal(float u, float v, float t0, float ori) {
	return  normalize( cross( fPu(u, v, t0, ori),  fPv(u, v, t0, ori)));
}

vec3 gD(float u, float v, float t0) {
	return  f(0.9999999 * u, v * 2 * PI, t0, 1);
}

vec3 fPt0(float u, float v, float t0, float ori) {
	return ( vec3((( compxPu(u, v) * ((0)) +  compxPv(u, v) * ((0)))), (( compyPu(u, v, t0, ori) * ((0)) +  compyPv(u, v, t0, ori) * ((0)) +  compyPt0(u, v, t0, ori) * ((1)) +  compyPori(u, v, t0, ori) * ((0)))), (( compzPu(u, v) * ((0)) +  compzPv(u, v) * ((0))))));
}

vec3 fPori(float u, float v, float t0, float ori) {
	return ( vec3((( compxPu(u, v) * ((0)) +  compxPv(u, v) * ((0)))), (( compyPu(u, v, t0, ori) * ((0)) +  compyPv(u, v, t0, ori) * ((0)) +  compyPt0(u, v, t0, ori) * ((0)) +  compyPori(u, v, t0, ori) * ((1)))), (( compzPu(u, v) * ((0)) +  compzPv(u, v) * ((0))))));
}

vec3 gDPu(float u, float v, float t0) {
	return ( fPu(0.9999999 * u, v * 2 * PI, t0, 1) * ((((0) * u + 0.9999999 * (1)))) +  fPv(0.9999999 * u, v * 2 * PI, t0, 1) * ((((((0) * 2 + v * (0))) * PI + v * 2 * (0)))) +  fPt0(0.9999999 * u, v * 2 * PI, t0, 1) * ((0)) +  fPori(0.9999999 * u, v * 2 * PI, t0, 1) * ((0)));
}

vec3 gDPv(float u, float v, float t0) {
	return ( fPu(0.9999999 * u, v * 2 * PI, t0, 1) * ((((0) * u + 0.9999999 * (0)))) +  fPv(0.9999999 * u, v * 2 * PI, t0, 1) * ((((((1) * 2 + v * (0))) * PI + v * 2 * (0)))) +  fPt0(0.9999999 * u, v * 2 * PI, t0, 1) * ((0)) +  fPori(0.9999999 * u, v * 2 * PI, t0, 1) * ((0)));
}

vec3 gDNormal(float u, float v, float t0) {
	return  normalize( cross( gDPu(u, v, t0),  gDPv(u, v, t0)));
}

vec3 gU(float u, float v, float t0) {
	return  f(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1);
}

vec3 gUPu(float u, float v, float t0) {
	return ( fPu(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1) * (((0) - (((0) * u + 0.9999 * (1))))) +  fPv(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1) * ((((((0) * 2 + v * (0))) * PI + v * 2 * (0)))) +  fPt0(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1) * (((((0) * PI + 2 * (0))) + (0))) +  fPori(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1) * (( - (0))));
}

vec3 gUPv(float u, float v, float t0) {
	return ( fPu(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1) * (((0) - (((0) * u + 0.9999 * (0))))) +  fPv(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1) * ((((((1) * 2 + v * (0))) * PI + v * 2 * (0)))) +  fPt0(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1) * (((((0) * PI + 2 * (0))) + (0))) +  fPori(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1) * (( - (0))));
}

vec3 gUNormal(float u, float v, float t0) {
	return  normalize( cross( gUPu(u, v, t0),  gUPv(u, v, t0)));
}

vec3 gSS(float u, float v, float t0) {
	return  funcionIf((v < 0.5),  gU(u, v * 2, t0),  gD(u, (v - 0.5) * 2, t0));
}

vec3 gUPt0(float u, float v, float t0) {
	return ( fPu(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1) * (((0) - (((0) * u + 0.9999 * (0))))) +  fPv(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1) * ((((((0) * 2 + v * (0))) * PI + v * 2 * (0)))) +  fPt0(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1) * (((((0) * PI + 2 * (0))) + (1))) +  fPori(0.99999 - 0.9999 * u, v * 2 * PI, 2 * PI + t0,  - 1) * (( - (0))));
}

vec3 gDPt0(float u, float v, float t0) {
	return ( fPu(0.9999999 * u, v * 2 * PI, t0, 1) * ((((0) * u + 0.9999999 * (0)))) +  fPv(0.9999999 * u, v * 2 * PI, t0, 1) * ((((((0) * 2 + v * (0))) * PI + v * 2 * (0)))) +  fPt0(0.9999999 * u, v * 2 * PI, t0, 1) * ((1)) +  fPori(0.9999999 * u, v * 2 * PI, t0, 1) * ((0)));
}

vec3 gSSPu(float u, float v, float t0) {
	return ( funcionIf((v < 0.5), ( gUPu(u, v * 2, t0) * ((1)) +  gUPv(u, v * 2, t0) * ((((0) * 2 + v * (0)))) +  gUPt0(u, v * 2, t0) * ((0))), ( gDPu(u, (v - 0.5) * 2, t0) * ((1)) +  gDPv(u, (v - 0.5) * 2, t0) * (((((((0) - (0)))) * 2 + (v - 0.5) * (0)))) +  gDPt0(u, (v - 0.5) * 2, t0) * ((0)))));
}

vec3 gSSPv(float u, float v, float t0) {
	return ( funcionIf((v < 0.5), ( gUPu(u, v * 2, t0) * ((0)) +  gUPv(u, v * 2, t0) * ((((1) * 2 + v * (0)))) +  gUPt0(u, v * 2, t0) * ((0))), ( gDPu(u, (v - 0.5) * 2, t0) * ((0)) +  gDPv(u, (v - 0.5) * 2, t0) * (((((((1) - (0)))) * 2 + (v - 0.5) * (0)))) +  gDPt0(u, (v - 0.5) * 2, t0) * ((0)))));
}

vec3 gSSNormal(float u, float v, float t0) {
	return  normalize( cross( gSSPu(u, v, t0),  gSSPv(u, v, t0)));
}

vec3 gSS2(float u, float v, float t0) {
	return  gSS(u, v, 4 * PI);
}

vec3 gSSPt0(float u, float v, float t0) {
	return ( funcionIf((v < 0.5), ( gUPu(u, v * 2, t0) * ((0)) +  gUPv(u, v * 2, t0) * ((((0) * 2 + v * (0)))) +  gUPt0(u, v * 2, t0) * ((1))), ( gDPu(u, (v - 0.5) * 2, t0) * ((0)) +  gDPv(u, (v - 0.5) * 2, t0) * (((((((0) - (0)))) * 2 + (v - 0.5) * (0)))) +  gDPt0(u, (v - 0.5) * 2, t0) * ((1)))));
}

vec3 gSS2Pu(float u, float v, float t0) {
	return ( gSSPu(u, v, 4 * PI) * ((1)) +  gSSPv(u, v, 4 * PI) * ((0)) +  gSSPt0(u, v, 4 * PI) * ((((0) * PI + 4 * (0)))));
}

vec3 gSS2Pv(float u, float v, float t0) {
	return ( gSSPu(u, v, 4 * PI) * ((0)) +  gSSPv(u, v, 4 * PI) * ((1)) +  gSSPt0(u, v, 4 * PI) * ((((0) * PI + 4 * (0)))));
}

vec3 gSS2Normal(float u, float v, float t0) {
	return  normalize( cross( gSS2Pu(u, v, t0),  gSS2Pv(u, v, t0)));
}

void main() {
	vec3 aPosSurf, aNormSurf;

	if (funPlot==0) {
		aPosSurf = gSS(aPos.x, aPos.y, param_t[0]);
		aNormSurf = gSSNormal(aPos.x, aPos.y, param_t[0]);
	} else if (funPlot==1) {
		aPosSurf = gSS2(aPos.x, aPos.y, param_t[0]);
		aNormSurf = gSS2Normal(aPos.x, aPos.y, param_t[0]);
	}

	vertex.FragPos = vec3(vec4(aPosSurf, 1.0));
	vertex.Normal = aNormSurf;
	gl_Position = vec4(aPosSurf, 1.0);
}