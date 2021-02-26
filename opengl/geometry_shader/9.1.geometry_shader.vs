#version 330 core
layout (location = 0) in vec2 aPos;
//layout (location = 1) in vec3 aColor;

//out VS_OUT {
//    vec3 color;
//} vs_out;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float t_0;
uniform float t_1;
uniform int funPlot;

float pi=3.14;

vec4 f(vec2 v) {
	
	// Esfera
	//float comp_x = 2*cos(v.y*pi)*cos(v.x*2*pi);
	//float comp_y = 2*cos(v.y*pi)*sin(v.x*2*pi);
	//float comp_z = 2*sin(v.y*pi);
	
	// Toro
	float radio_a = 2 + t_0/2;
	float radio_r = 0.5 + t_1/4;
	float comp_x = (radio_a+radio_r*cos(v.y*2*pi))*cos(v.x*2*pi);
	float comp_y = (radio_a+radio_r*cos(v.y*2*pi))*sin(v.x*2*pi);
	float comp_z = radio_r*sin(v.y*2*pi);
	
	return vec4(comp_x, comp_y, comp_z, 1.0);
	//return vec4(v.x, v.y, v.x*v.x + v.y*v.y, 1.0);
	//return vec4(v.x, v.y, 0.0, 1.0);
}

vec4 g(vec2 v) {
	
	// Esfera
	float comp_x = 2*cos(v.y*pi)*cos(v.x*2*pi);
	float comp_y = 2*cos(v.y*pi)*sin(v.x*2*pi);
	float comp_z = 2*sin(v.y*pi);
	
	return vec4(comp_x, comp_y, comp_z, 1.0);
}

void main()
{
    //vs_out.color = aColor;
    if (funPlot == 0)
		gl_Position = projection * view * model * f(aPos - vec2(0.5, 0.5));
	else
		gl_Position = projection * view * model * g(aPos - vec2(0.5, 0.5));
}
