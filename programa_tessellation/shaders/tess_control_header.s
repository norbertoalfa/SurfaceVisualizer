#version 440
layout (vertices = 3) out;

in vData {vec3 FragPos; vec3 Normal; float Area; vec2 Coord;} vertex[];
out vData {vec3 FragPos; vec3 Normal; float Area; vec2 Coord;} control[];

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform mat4 tr_inv_model;
uniform float param_t[10];
uniform int funPlot;
uniform float umbralArea;

