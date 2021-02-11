#version 330 core
layout (points) in;
layout (triangle_strip, max_vertices = 5) out;

//in VS_OUT {
//    vec3 color;
//} gs_in[];

//out vec3 fColor;

vec4 f(vec4 v) {
	//return vec4(2*(v.x*v.x - 0.5), 2*(v.y*v.y -  0.5), 0.0, 1.0);
	return vec4(2*(v.x*v.x - 0.5), 2*(v.y*v.y -  0.5), 0.0, 1.0);
}

void build_house(vec4 position)
{    
    //fColor = gs_in[0].color; // gs_in[0] since there's only one input vertex
    gl_Position = f(position);// + vec4(-0.2, -0.2, 0.0, 0.0); // 1:bottom-left   
    EmitVertex();   
    gl_Position = f(position + vec4( 0.05, 0.0, 0.0, 0.0)); //vec4( 0.2, -0.2, 0.0, 0.0); // 2:bottom-right
    EmitVertex();
    gl_Position = f(position + vec4( 0.0, 0.05, 0.0, 0.0)); //vec4(-0.2,  0.2, 0.0, 0.0); // 3:top-left
    EmitVertex();
    //gl_Position = position + vec4( 0.2,  0.2, 0.0, 0.0); // 4:top-right
    //EmitVertex();
    //gl_Position = position + vec4( 0.0,  0.4, 0.0, 0.0); // 5:top
    //fColor = vec3(1.0, 1.0, 1.0);
    //EmitVertex();
    EndPrimitive();
}

void main() {    
    build_house(gl_in[0].gl_Position);
}