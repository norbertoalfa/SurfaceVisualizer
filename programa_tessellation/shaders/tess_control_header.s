#version 440
layout (vertices = 3) out;

in vData {vec2 Coord;} vertex[];

uniform float param_t[10];
uniform int funPlot;
uniform float umbralLength;

uniform int ptsLimit;
uniform int failsLimit;

