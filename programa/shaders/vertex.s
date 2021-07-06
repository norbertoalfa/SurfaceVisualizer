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
	return  vec3( compx(u *  cos(t0), v, t1, t2),  compy(u, v, t1, t2),  compz(u, v, t1, t2));
}

float compxPu(float u, float v, float t1, float t2) {
	return (0 *  cos(v * 2 * PI)) *  cos(u * 2 * PI) + (t1 + t2 *  cos(v * 2 * PI)) *  -  sin(u * 2 * PI) * (2 * PI);
}

float compxPv(float u, float v, float t1, float t2) {
	return (0 *  cos(v * 2 * PI) + t2 *  -  sin(v * 2 * PI) * (2 * PI)) *  cos(u * 2 * PI);
}

float compxPt1(float u, float v, float t1, float t2) {
	return  cos(u * 2 * PI);
}

float compxPt2(float u, float v, float t1, float t2) {
	return (1 *  cos(v * 2 * PI)) *  cos(u * 2 * PI);
}

float compyPu(float u, float v, float t1, float t2) {
	return (0 *  cos(v * 2 * PI)) *  sin(u * 2 * PI) + (t1 + t2 *  cos(v * 2 * PI)) *  cos(u * 2 * PI) * (2 * PI);
}

float compyPv(float u, float v, float t1, float t2) {
	return (0 *  cos(v * 2 * PI) + t2 *  -  sin(v * 2 * PI) * (2 * PI)) *  sin(u * 2 * PI);
}

float compyPt1(float u, float v, float t1, float t2) {
	return  sin(u * 2 * PI);
}

float compyPt2(float u, float v, float t1, float t2) {
	return (1 *  cos(v * 2 * PI)) *  sin(u * 2 * PI);
}

float compzPu(float u, float v, float t1, float t2) {
	return 0;
}

float compzPv(float u, float v, float t1, float t2) {
	return t2 *  cos(v * 2 * PI) * (2 * PI);
}

float compzPt1(float u, float v, float t1, float t2) {
	return 0;
}

float compzPt2(float u, float v, float t1, float t2) {
	return  sin(v * 2 * PI);
}

vec3 gPu(float u, float v, float t0, float t1, float t2) {
	return  vec3(( compxPu(u *  cos(t0), v, t1, t2) *  cos(t0)),  compyPu(u, v, t1, t2),  compzPu(u, v, t1, t2));
}

vec3 gPv(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPv(u *  cos(t0), v, t1, t2),  compyPv(u, v, t1, t2),  compzPv(u, v, t1, t2));
}

vec3 gNormal(float u, float v, float t0, float t1, float t2) {
	return  normalize( cross( gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2)));
}

vec3 f(float u, float v, float t0, float t1, float t2) {
	return 2 *  g(u - 0.5, v - 0.5, t0, t1 + R, t2 + r);
}

vec3 gPt0(float u, float v, float t0, float t1, float t2) {
	return  vec3(( compxPu(u *  cos(t0), v, t1, t2) * (u *  -  sin(t0))), 0, 0);
}

vec3 gPt1(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPt1(u *  cos(t0), v, t1, t2),  compyPt1(u, v, t1, t2),  compzPt1(u, v, t1, t2));
}

vec3 gPt2(float u, float v, float t0, float t1, float t2) {
	return  vec3( compxPt2(u *  cos(t0), v, t1, t2),  compyPt2(u, v, t1, t2),  compzPt2(u, v, t1, t2));
}

vec3 fPu(float u, float v, float t0, float t1, float t2) {
	return 2 *  gPu(u - 0.5, v - 0.5, t0, t1 + R, t2 + r);
}

vec3 fPv(float u, float v, float t0, float t1, float t2) {
	return 2 *  gPv(u - 0.5, v - 0.5, t0, t1 + R, t2 + r);
}

vec3 fNormal(float u, float v, float t0, float t1, float t2) {
	return  normalize( cross( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2)));
}

void main() {
	vec3 aPosSurf, aNormSurf;

	if (funPlot==0) {
		aPosSurf = f(aPos.x, aPos.y, param_t[0], param_t[1], param_t[2]);
		aNormSurf = fNormal(aPos.x, aPos.y, param_t[0], param_t[1], param_t[2]);
	}

	vertex.FragPos = vec3(vec4(aPosSurf, 1.0));
	vertex.Normal = aNormSurf;
	gl_Position = vec4(aPosSurf, 1.0);
}