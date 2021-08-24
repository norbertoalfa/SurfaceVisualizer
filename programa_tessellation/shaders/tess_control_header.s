#version 440
layout (vertices = 3) out;

in vData {vec2 Coord;} vertex[];

uniform float param_t[10];
uniform int funPlot;
uniform float tessDist;
uniform float umbralLength;
uniform float umbralEdge;
uniform float expK;
uniform float signNormal;
uniform float dotVF;

uniform vec3 lightPos;
uniform vec3 viewPos;  
uniform vec3 Front;  

uniform bool tessGlobal;
uniform bool tessEdge;
uniform bool improvePerf;
uniform bool improvePerfEsp;

uniform bool showVectors;
uniform bool showVectorsPerV;

const int samplePts = 10;
const float sampleCoct = 0.1;

const mat3 eyeMatrix = mat3(1,0,1,
                            1,1,0,
                            0,1,1);

