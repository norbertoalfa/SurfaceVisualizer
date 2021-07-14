#version 440 core
layout (location = 0) in vec2 aPos;

out vData {vec3 FragPos; vec3 Normal; float Area; vec2 Coord;} vertex;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float param_t[10];
uniform int funPlot;
