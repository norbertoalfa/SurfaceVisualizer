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
vec3 g(float u, float v) {
	return 2 *  vec3( cos(v * PI) *  cos(u * 2 * PI),  cos(v * PI) *  sin(u * 2 * PI),  sin(v * PI));
}

vec3 h(float u, float v) {
	return 2 *  vec3(u, v,  cos(10 * u) +  cos(10 * v));
}

vec3 f(float u, float v) {
	return  g(u - 0.5, v - 0.5);
}

vec3 f2(float u, float v, float t0) {
	return (t0 * t0) *  f(u, v) + (1 - t0 * t0) *  vec3( f(u, v)[0], 0.0,  f(u, v)[1]);
}

void main() {
	vec3 aPosSurf;

	if (funPlot==0) {
		aPosSurf = f2(aPos.x, aPos.y, param_t[0]);
	} else if (funPlot==1) {
		aPosSurf = f(aPos.x, aPos.y);
	}

	vertex.FragPos = vec3(model * vec4(aPosSurf, 1.0));
	gl_Position = projection * view * model * vec4(aPosSurf, 1.0);
}