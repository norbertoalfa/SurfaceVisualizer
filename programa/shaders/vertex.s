#version 440 core
layout (location = 0) in vec2 aPos;

out vData {vec3 FragPos;} vertex;

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
vec3 g(float x) {
	return  vec3(x - 0.5, x - 0.5, 0.1);
}

vec3 gPu(float x) {
	return  vec3((0 - 0), (0 - 0), (0));
}

vec3 gPv(float x) {
	return  vec3((0 - 0), (0 - 0), (0));
}

vec3 gNormal(float x) {
	return  normalize( cross( gPu(x),  gPv(x)));
}

vec3 f(float u, float v) {
	return 2 *  g( pow(u, 2) + v);
}

vec3 gPx(float x) {
	return  vec3((1 - 0), (1 - 0), (0));
}

vec3 fPu(float u, float v) {
	return 0 *  g( pow(u, 2) + v) + 2 *  gPx( pow(u, 2) + v) * ( pow(u, 2) * (0 *  log(u) + 2 * 1 / u * (1)) + 0);
}

vec3 fPv(float u, float v) {
	return 0 *  g( pow(u, 2) + v) + 2 *  gPx( pow(u, 2) + v) * ( pow(u, 2) * (0 *  log(u) + 2 * 1 / u * (0)) + 1);
}

vec3 fNormal(float u, float v) {
	return  normalize( cross( fPu(u, v),  fPv(u, v)));
}

void main() {
	vec3 aPosSurf;

	if (funPlot==0) {
		aPosSurf = f(aPos.x, aPos.y);
	}

	vertex.FragPos = vec3(model * vec4(aPosSurf, 1.0));
	gl_Position = projection * view * model * vec4(aPosSurf, 1.0);
}