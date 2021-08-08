#version 440
layout (vertices = 3) out;

in vData {vec2 Coord;} vertex[];

uniform float param_t[10];
uniform int funPlot;
uniform float umbralLength;
uniform float umbralEdge;
uniform float coeffK;

uniform vec3 lightPos;
uniform vec3 viewPos;  
uniform vec3 Front;  

uniform int ptsLimit;
uniform int failsLimit;

uniform bool invertNorm;
uniform bool tessGlobal;
uniform bool tessEdge;
uniform bool improvePerf;

