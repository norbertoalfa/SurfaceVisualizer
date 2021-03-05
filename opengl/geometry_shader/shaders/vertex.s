#version 440 core
layout (location = 0) in vec2 aPos;

out vData {vec3 FragPos;} vertex;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float param_t[10];
uniform int funPlot;

float pi = 3.14159;

vec3 g(float u, float v) {
	return 2 *  vec3( cos(v * pi) *  cos(u * 2 * pi),  cos(v * pi) *  sin(u * 2 * pi),  sin(v * pi));
}

vec3 f(float u, float v) {
	return  g(u - 0.5, v - 0.5);
}

void main() {
	vec3 aPosSurf;

	if (funPlot==0) {
		aPosSurf = f(aPos.x, aPos.y);
	}

	vertex.FragPos = vec3(model * vec4(aPosSurf, 1.0));
	gl_Position = projection * view * model * vec4(aPosSurf, 1.0);
}