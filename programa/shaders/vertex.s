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
	return (0 + 0 *  cos(v * 2 * PI) + t2 *  -  sin(v * 2 * PI) * (0 * 2 + v * 0 * PI + v * 2 * 0)) *  cos(u * 2 * PI) + (t1 + t2 *  cos(v * 2 * PI)) *  -  sin(u * 2 * PI) * (1 * 2 + u * 0 * PI + u * 2 * 0);
}

float compxPv(float u, float v, float t1, float t2) {
	return (0 + 0 *  cos(v * 2 * PI) + t2 *  -  sin(v * 2 * PI) * (1 * 2 + v * 0 * PI + v * 2 * 0)) *  cos(u * 2 * PI) + (t1 + t2 *  cos(v * 2 * PI)) *  -  sin(u * 2 * PI) * (0 * 2 + u * 0 * PI + u * 2 * 0);
}

float compxPt1(float u, float v, float t1, float t2) {
	return (1 + 0 *  cos(v * 2 * PI) + t2 *  -  sin(v * 2 * PI) * (0 * 2 + v * 0 * PI + v * 2 * 0)) *  cos(u * 2 * PI) + (t1 + t2 *  cos(v * 2 * PI)) *  -  sin(u * 2 * PI) * (0 * 2 + u * 0 * PI + u * 2 * 0);
}

float compxPt2(float u, float v, float t1, float t2) {
	return (0 + 1 *  cos(v * 2 * PI) + t2 *  -  sin(v * 2 * PI) * (0 * 2 + v * 0 * PI + v * 2 * 0)) *  cos(u * 2 * PI) + (t1 + t2 *  cos(v * 2 * PI)) *  -  sin(u * 2 * PI) * (0 * 2 + u * 0 * PI + u * 2 * 0);
}

float compyPu(float u, float v, float t1, float t2) {
	return (0 + 0 *  cos(v * 2 * PI) + t2 *  -  sin(v * 2 * PI) * (0 * 2 + v * 0 * PI + v * 2 * 0)) *  sin(u * 2 * PI) + (t1 + t2 *  cos(v * 2 * PI)) *  cos(u * 2 * PI) * (1 * 2 + u * 0 * PI + u * 2 * 0);
}

float compyPv(float u, float v, float t1, float t2) {
	return (0 + 0 *  cos(v * 2 * PI) + t2 *  -  sin(v * 2 * PI) * (1 * 2 + v * 0 * PI + v * 2 * 0)) *  sin(u * 2 * PI) + (t1 + t2 *  cos(v * 2 * PI)) *  cos(u * 2 * PI) * (0 * 2 + u * 0 * PI + u * 2 * 0);
}

float compyPt1(float u, float v, float t1, float t2) {
	return (1 + 0 *  cos(v * 2 * PI) + t2 *  -  sin(v * 2 * PI) * (0 * 2 + v * 0 * PI + v * 2 * 0)) *  sin(u * 2 * PI) + (t1 + t2 *  cos(v * 2 * PI)) *  cos(u * 2 * PI) * (0 * 2 + u * 0 * PI + u * 2 * 0);
}

float compyPt2(float u, float v, float t1, float t2) {
	return (0 + 1 *  cos(v * 2 * PI) + t2 *  -  sin(v * 2 * PI) * (0 * 2 + v * 0 * PI + v * 2 * 0)) *  sin(u * 2 * PI) + (t1 + t2 *  cos(v * 2 * PI)) *  cos(u * 2 * PI) * (0 * 2 + u * 0 * PI + u * 2 * 0);
}

float compzPu(float u, float v, float t1, float t2) {
	return 0 *  sin(v * 2 * PI) + t2 *  cos(v * 2 * PI) * (0 * 2 + v * 0 * PI + v * 2 * 0);
}

float compzPv(float u, float v, float t1, float t2) {
	return 0 *  sin(v * 2 * PI) + t2 *  cos(v * 2 * PI) * (1 * 2 + v * 0 * PI + v * 2 * 0);
}

float compzPt1(float u, float v, float t1, float t2) {
	return 0 *  sin(v * 2 * PI) + t2 *  cos(v * 2 * PI) * (0 * 2 + v * 0 * PI + v * 2 * 0);
}

float compzPt2(float u, float v, float t1, float t2) {
	return 1 *  sin(v * 2 * PI) + t2 *  cos(v * 2 * PI) * (0 * 2 + v * 0 * PI + v * 2 * 0);
}

vec3 gPu(float u, float v, float t0, float t1, float t2) {
	return  vec3(( compxPu(u *  cos(t0), v, t1, t2) * (1 *  cos(t0) + u *  -  sin(t0) * (0)) +  compxPv(u *  cos(t0), v, t1, t2) * (0) +  compxPt1(u *  cos(t0), v, t1, t2) * (0) +  compxPt2(u *  cos(t0), v, t1, t2) * (0)), ( compyPu(u, v, t1, t2) * (1) +  compyPv(u, v, t1, t2) * (0) +  compyPt1(u, v, t1, t2) * (0) +  compyPt2(u, v, t1, t2) * (0)), ( compzPu(u, v, t1, t2) * (1) +  compzPv(u, v, t1, t2) * (0) +  compzPt1(u, v, t1, t2) * (0) +  compzPt2(u, v, t1, t2) * (0)));
}

vec3 gPv(float u, float v, float t0, float t1, float t2) {
	return  vec3(( compxPu(u *  cos(t0), v, t1, t2) * (0 *  cos(t0) + u *  -  sin(t0) * (0)) +  compxPv(u *  cos(t0), v, t1, t2) * (1) +  compxPt1(u *  cos(t0), v, t1, t2) * (0) +  compxPt2(u *  cos(t0), v, t1, t2) * (0)), ( compyPu(u, v, t1, t2) * (0) +  compyPv(u, v, t1, t2) * (1) +  compyPt1(u, v, t1, t2) * (0) +  compyPt2(u, v, t1, t2) * (0)), ( compzPu(u, v, t1, t2) * (0) +  compzPv(u, v, t1, t2) * (1) +  compzPt1(u, v, t1, t2) * (0) +  compzPt2(u, v, t1, t2) * (0)));
}

vec3 gNormal(float u, float v, float t0, float t1, float t2) {
	return  normalize( cross( gPu(u, v, t0, t1, t2),  gPv(u, v, t0, t1, t2)));
}

vec3 f(float u, float v, float t0, float t1, float t2) {
	return 2 *  g(u - 0.5, v - 0.5, t0, t1 + R, t2 + r);
}

vec3 gPt0(float u, float v, float t0, float t1, float t2) {
	return  vec3(( compxPu(u *  cos(t0), v, t1, t2) * (0 *  cos(t0) + u *  -  sin(t0) * (1)) +  compxPv(u *  cos(t0), v, t1, t2) * (0) +  compxPt1(u *  cos(t0), v, t1, t2) * (0) +  compxPt2(u *  cos(t0), v, t1, t2) * (0)), ( compyPu(u, v, t1, t2) * (0) +  compyPv(u, v, t1, t2) * (0) +  compyPt1(u, v, t1, t2) * (0) +  compyPt2(u, v, t1, t2) * (0)), ( compzPu(u, v, t1, t2) * (0) +  compzPv(u, v, t1, t2) * (0) +  compzPt1(u, v, t1, t2) * (0) +  compzPt2(u, v, t1, t2) * (0)));
}

vec3 gPt1(float u, float v, float t0, float t1, float t2) {
	return  vec3(( compxPu(u *  cos(t0), v, t1, t2) * (0 *  cos(t0) + u *  -  sin(t0) * (0)) +  compxPv(u *  cos(t0), v, t1, t2) * (0) +  compxPt1(u *  cos(t0), v, t1, t2) * (1) +  compxPt2(u *  cos(t0), v, t1, t2) * (0)), ( compyPu(u, v, t1, t2) * (0) +  compyPv(u, v, t1, t2) * (0) +  compyPt1(u, v, t1, t2) * (1) +  compyPt2(u, v, t1, t2) * (0)), ( compzPu(u, v, t1, t2) * (0) +  compzPv(u, v, t1, t2) * (0) +  compzPt1(u, v, t1, t2) * (1) +  compzPt2(u, v, t1, t2) * (0)));
}

vec3 gPt2(float u, float v, float t0, float t1, float t2) {
	return  vec3(( compxPu(u *  cos(t0), v, t1, t2) * (0 *  cos(t0) + u *  -  sin(t0) * (0)) +  compxPv(u *  cos(t0), v, t1, t2) * (0) +  compxPt1(u *  cos(t0), v, t1, t2) * (0) +  compxPt2(u *  cos(t0), v, t1, t2) * (1)), ( compyPu(u, v, t1, t2) * (0) +  compyPv(u, v, t1, t2) * (0) +  compyPt1(u, v, t1, t2) * (0) +  compyPt2(u, v, t1, t2) * (1)), ( compzPu(u, v, t1, t2) * (0) +  compzPv(u, v, t1, t2) * (0) +  compzPt1(u, v, t1, t2) * (0) +  compzPt2(u, v, t1, t2) * (1)));
}

vec3 fPu(float u, float v, float t0, float t1, float t2) {
	return 0 *  g(u - 0.5, v - 0.5, t0, t1 + R, t2 + r) + 2 *  gPu(u - 0.5, v - 0.5, t0, t1 + R, t2 + r) * (1 - 0) +  gPv(u - 0.5, v - 0.5, t0, t1 + R, t2 + r) * (0 - 0) +  gPt0(u - 0.5, v - 0.5, t0, t1 + R, t2 + r) * (0) +  gPt1(u - 0.5, v - 0.5, t0, t1 + R, t2 + r) * (0 + 0) +  gPt2(u - 0.5, v - 0.5, t0, t1 + R, t2 + r) * (0 + 0);
}

vec3 fPv(float u, float v, float t0, float t1, float t2) {
	return 0 *  g(u - 0.5, v - 0.5, t0, t1 + R, t2 + r) + 2 *  gPu(u - 0.5, v - 0.5, t0, t1 + R, t2 + r) * (0 - 0) +  gPv(u - 0.5, v - 0.5, t0, t1 + R, t2 + r) * (1 - 0) +  gPt0(u - 0.5, v - 0.5, t0, t1 + R, t2 + r) * (0) +  gPt1(u - 0.5, v - 0.5, t0, t1 + R, t2 + r) * (0 + 0) +  gPt2(u - 0.5, v - 0.5, t0, t1 + R, t2 + r) * (0 + 0);
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