#version 440
layout (triangles, equal_spacing, cw) in;

in cData {vec3 FragPos; vec3 Normal; float Area; vec2 Coord;} control[];
out gData {vec3 FragPos; vec3 Normal; float Area; vec2 Coord;} geo;


uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform mat4 tr_inv_model;
uniform float param_t[10];
uniform int funPlot;

