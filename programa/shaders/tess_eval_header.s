#version 440
layout (triangles, equal_spacing, cw) in;

out gData {vec3 FragPos; vec3 Tangent; vec3 Cotan; vec3 Normal; float Area; float K; float Critic;} geo;

uniform float param_t[10];
uniform int funPlot;

