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

vec3 g(float u, float v, float t0) {
	return  f((u * 2 * t0), (v - 0.5) * 2 * PI);
}

vec3 gPu(float u, float v, float t0) {
	return ( fPu((u * 2 * t0), (v - 0.5) * 2 * PI) * (2 * t0));
}

vec3 gPv(float u, float v, float t0) {
	return ( fPv((u * 2 * t0), (v - 0.5) * 2 * PI) * (2 * PI));
}

vec3 gNormal(float u, float v, float t0) {
	return  normalize( cross( gPu(u, v, t0),  gPv(u, v, t0)));
}

void main() {
	vec3 aPosSurf, aNormSurf;

	if (funPlot==0) {
		aPosSurf = g(aPos.x, aPos.y, param_t[0]);
		aNormSurf = gNormal(aPos.x, aPos.y, param_t[0]);
	}

	vertex.FragPos = vec3(vec4(aPosSurf, 1.0));
	vertex.Normal = aNormSurf;
	gl_Position = vec4(aPosSurf, 1.0);
}