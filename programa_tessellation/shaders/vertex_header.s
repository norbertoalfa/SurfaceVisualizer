#version 440 core
layout (location = 0) in vec2 aPos;

out vData {vec2 Coord;} vertex;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float param_t[10];
uniform int funPlot;
