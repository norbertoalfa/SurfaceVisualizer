#version 440 core
layout (location = 0) in vec2 aPos;

out vData {vec3 FragPos; vec3 Normal;} vertex;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float param_t[10];
uniform int funPlot;


float PI = 3.14159265;
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
vec3 g(float u, float v) {
	return 2 *  vec3( cos(v * PI) *  cos(u * 2 * PI),  cos(v * PI) *  sin(u * 2 * PI),  sin(v * PI));
}

vec3 gPu(float u, float v) {
	return 0 *  vec3( cos(v * PI) *  cos(u * 2 * PI),  cos(v * PI) *  sin(u * 2 * PI),  sin(v * PI)) + 2 *  vec3(( -  sin(v * PI) * (0 * PI + v * 0) *  cos(u * 2 * PI) +  cos(v * PI) *  -  sin(u * 2 * PI) * (1 * 2 + u * 0 * PI + u * 2 * 0)), ( -  sin(v * PI) * (0 * PI + v * 0) *  sin(u * 2 * PI) +  cos(v * PI) *  cos(u * 2 * PI) * (1 * 2 + u * 0 * PI + u * 2 * 0)), ( cos(v * PI) * (0 * PI + v * 0)));
}

vec3 gPv(float u, float v) {
	return 0 *  vec3( cos(v * PI) *  cos(u * 2 * PI),  cos(v * PI) *  sin(u * 2 * PI),  sin(v * PI)) + 2 *  vec3(( -  sin(v * PI) * (1 * PI + v * 0) *  cos(u * 2 * PI) +  cos(v * PI) *  -  sin(u * 2 * PI) * (0 * 2 + u * 0 * PI + u * 2 * 0)), ( -  sin(v * PI) * (1 * PI + v * 0) *  sin(u * 2 * PI) +  cos(v * PI) *  cos(u * 2 * PI) * (0 * 2 + u * 0 * PI + u * 2 * 0)), ( cos(v * PI) * (1 * PI + v * 0)));
}

vec3 gNormal(float u, float v) {
	return  normalize( cross( gPu(u, v),  gPv(u, v)));
}

vec3 h(float u, float v) {
	return 2 *  vec3(u, v,  cos(10 * u) +  cos(10 * v));
}

vec3 hPu(float u, float v) {
	return 0 *  vec3(u, v,  cos(10 * u) +  cos(10 * v)) + 2 *  vec3((1), (0), ( -  sin(10 * u) * (0 * u + 10 * 1) +  -  sin(10 * v) * (0 * v + 10 * 0)));
}

vec3 hPv(float u, float v) {
	return 0 *  vec3(u, v,  cos(10 * u) +  cos(10 * v)) + 2 *  vec3((0), (1), ( -  sin(10 * u) * (0 * u + 10 * 0) +  -  sin(10 * v) * (0 * v + 10 * 1)));
}

vec3 hNormal(float u, float v) {
	return  normalize( cross( hPu(u, v),  hPv(u, v)));
}

vec3 f(float u, float v) {
	return  g(u - 0.5, v - 0.5);
}

vec3 fPu(float u, float v) {
	return  gPu(u - 0.5, v - 0.5) * (1 - 0) +  gPv(u - 0.5, v - 0.5) * (0 - 0);
}

vec3 fPv(float u, float v) {
	return  gPu(u - 0.5, v - 0.5) * (0 - 0) +  gPv(u - 0.5, v - 0.5) * (1 - 0);
}

vec3 fNormal(float u, float v) {
	return  normalize( cross( fPu(u, v),  fPv(u, v)));
}

vec3 f2(float u, float v, float t0) {
	return  pow((t0 * t0), 2) *  f(u, v) + (1 - t0 * t0) *  vec3( f(u, v)[0], 0.0,  f(u, v)[1]);
}

vec3 f2Pu(float u, float v, float t0) {
	return  pow((t0 * t0), 2) * (0 *  log((t0 * t0)) + 2 * 1 / (t0 * t0) * ((0 * t0 + t0 * 0))) *  f(u, v) +  pow((t0 * t0), 2) *  fPu(u, v) * (1) +  fPv(u, v) * (0) + (0 - 0 * t0 + t0 * 0) *  vec3( f(u, v)[0], 0.0,  f(u, v)[1]) + (1 - t0 * t0) *  vec3(( vec3( fPu(u, v) * (1) +  fPv(u, v) * (0))[0]), (0), ( vec3( fPu(u, v) * (1) +  fPv(u, v) * (0))[1]));
}

vec3 f2Pv(float u, float v, float t0) {
	return  pow((t0 * t0), 2) * (0 *  log((t0 * t0)) + 2 * 1 / (t0 * t0) * ((0 * t0 + t0 * 0))) *  f(u, v) +  pow((t0 * t0), 2) *  fPu(u, v) * (0) +  fPv(u, v) * (1) + (0 - 0 * t0 + t0 * 0) *  vec3( f(u, v)[0], 0.0,  f(u, v)[1]) + (1 - t0 * t0) *  vec3(( vec3( fPu(u, v) * (0) +  fPv(u, v) * (1))[0]), (0), ( vec3( fPu(u, v) * (0) +  fPv(u, v) * (1))[1]));
}

vec3 f2Normal(float u, float v, float t0) {
	return  normalize( cross( f2Pu(u, v, t0),  f2Pv(u, v, t0)));
}

void main() {
	vec3 aPosSurf, aNormSurf;

	if (funPlot==0) {
		aPosSurf = f2(aPos.x, aPos.y, param_t[0]);
		aNormSurf = f2Normal(aPos.x, aPos.y, param_t[0]);
	}

	vertex.FragPos = vec3(model * vec4(aPosSurf, 1.0));
	vertex.Normal = -aNormSurf;
	gl_Position = projection * view * model * vec4(aPosSurf, 1.0);
}