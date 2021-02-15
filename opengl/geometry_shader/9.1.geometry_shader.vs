#version 330 core
layout (location = 0) in vec2 aPos;
//layout (location = 1) in vec3 aColor;

//out VS_OUT {
//    vec3 color;
//} vs_out;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float radio_a;
uniform float radio_r;

vec4 f(vec2 v) {
	//float comp_x = abs(v.x-0.5)*(v.x-0.5);
	//float comp_y = abs(v.y-0.5)*(v.y-0.5);
	float pi=3.14159;
	
	// Esfera
	//float comp_x = cos(v.y*pi)*cos(v.x*2*pi);
	//float comp_y = cos(v.y*pi)*sin(v.x*2*pi);
	//float comp_z = sin(v.y*pi);
	
	// Toro
	float comp_x = (radio_a+radio_r*cos(v.y*2*pi))*cos(v.x*2*pi);
	float comp_y = (radio_a+radio_r*cos(v.y*2*pi))*sin(v.x*2*pi);
	float comp_z = radio_r*sin(v.y*2*pi);
	
	return vec4(comp_x, comp_y, comp_z, 1.0);
	//return vec4(v.x, v.y, v.x*v.x + v.y*v.y, 1.0);
	//return v;
}

void main()
{
    //vs_out.color = aColor;
    gl_Position = projection * view * model * f(aPos - vec2(0.5, 0.5)); 
}
