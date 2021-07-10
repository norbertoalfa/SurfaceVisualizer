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

vec3 f2(float u, float v) {
	return  funcionIf(u < 0.51,  f(2 * u, v),  h(2 * u, v));
}

vec3 f2Pu(float u, float v) {
	return  funcionIf(u < 0.51, ( fPu(2 * u, v) * 2), ( hPu(2 * u, v) * 2));
}

vec3 f2Pv(float u, float v) {
	return  funcionIf(u < 0.51,  fPv(2 * u, v),  hPv(2 * u, v));
}

vec3 f2Normal(float u, float v) {
	return  normalize( cross( f2Pu(u, v),  f2Pv(u, v)));
}

float f2Area(float u, float v) {
	return  distance( f2Pu(u, v),  f2Pv(u, v));
}

void main() {
	vec3 aPosSurf, aNormSurf;
	float aAreaSurf;

	if (funPlot==0) {
		aPosSurf = f(aPos.x, aPos.y);
		aNormSurf = fNormal(aPos.x, aPos.y);
		aAreaSurf = fArea(aPos.x, aPos.y);
	}

	vertex.FragPos = vec3(vec4(aPosSurf, 1.0));
	vertex.Normal = aNormSurf;
	vertex.Area = aAreaSurf;
	gl_Position = vec4(aPosSurf, 1.0);
}