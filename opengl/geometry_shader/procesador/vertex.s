#version 440 core
layout (location = 0) in vec2 aPos;

out vData {vec3 FragPos;} vertex;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float param_t[10];
uniform int funPlot;

double h(double w) {
	return w + E;
}

double const_new = E ^ 2 + PI;

mat3 mat_rot(double t) {
	return  mat3( vec3( cos(t),  sin(t), 0),  vec3( -  sin(t),  cos(t), 0),  vec3(0, 0, 1));
}

bool est_pos(double a) {
	return  funcionIf(a > 0, true, false);
}

double x(double u, double v) {
	return  funcionIf(v > 1,  cos(PI * u), v *  cos(PI * u));
}

double y(double u, double v) {
	return  funcionIf(v > 1,  sin(PI * u),  funcionIf(v < 1, v *  sin(PI * u),  sin(PI * u)));
}

double z(double u, double v, double t1, double t2) {
	return t1 *  h(v + t2);
}

vec3 f(double u, double v, double t1, double t2) {
	return  vec3( x(u, v),  y(u, v),  z(u, v, t1, t2) + const_new);
}

vec3 g(double u, double v, double t1) {
	return  mat_rot(t1) *  vec3( x(u, v),  y(u, v),  z(u, v, 0.1, 0.5) +  mat_rot(t1)[0][0]);
}

void main() {
	vec3 aPosSurf;

	if (funPlot==0) {
		aPosSurf = f(aPos.x, aPos.y, param_t[0], param_t[1]);
	} else if (funPlot==1) {
		aPosSurf = g(aPos.x, aPos.y, param_t[0]);
	}

	vertex.FragPos = vec3(model * vec4(aPosSurf, 1.0));
	gl_Position = projection * view * model * vec4(aPosSurf, 1.0);
}