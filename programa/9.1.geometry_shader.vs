#version 440 core
layout (location = 0) in vec2 aPos;

out vData {vec3 FragPos;} vertex;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float t_0;
uniform float t_1;
uniform int funPlot;

float pi=3.14;

vec3 f(vec2 v) {
	
	// Toro
	float radio_a = 2 + t_0/2;
	float radio_r = 0.5 + t_1/4;
	float comp_x = (radio_a+radio_r*cos(v.y*2*pi))*cos(v.x*2*pi);
	float comp_y = (radio_a+radio_r*cos(v.y*2*pi))*sin(v.x*2*pi);
	float comp_z = radio_r*sin(v.y*2*pi);
	
	return vec3(comp_x, comp_y, comp_z);
	//return vec3(v.x, v.y, v.x*v.x + v.y*v.y);
	//return vec3(v.x, v.y, 0.0);
}

vec3 g(vec2 v) {
	
	// Esfera
	float comp_x = 2*cos(v.y*pi)*cos(v.x*2*pi);
	float comp_y = 2*cos(v.y*pi)*sin(v.x*2*pi);
	float comp_z = 2*sin(v.y*pi);
	
	return vec3(comp_x, comp_y, comp_z);
}

void main()
{
    vec3 aPosSurf;

    if (funPlot == 0)
		aPosSurf =  f(aPos - vec2(0.5, 0.5));
	else
		aPosSurf = g(aPos - vec2(0.5, 0.5));
		
	
    vertex.FragPos = vec3(model * vec4(aPosSurf, 1.0));
    gl_Position = projection * view * model * vec4(aPosSurf, 1.0);
}
