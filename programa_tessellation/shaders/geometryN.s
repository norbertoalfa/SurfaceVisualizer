#version 440
layout (triangles) in;
layout (line_strip, max_vertices = 2) out;

in gData {vec3 FragPos; vec3 Normal; float Area; float K;} geo[];

out fData {vec3 FragPos; vec3 Normal; float Area; float K;} frag;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform mat4 tr_inv_model;

uniform bool invertNorm;

void main() {

    float normalSign = 1.0;

    if (invertNorm) {
        normalSign = -1.0;
    }

    for(int i = 0; i < gl_in.length(); i++) {
        gl_Position = projection * view * model * gl_in[i].gl_Position;
        frag.FragPos = geo[i].FragPos;
        frag.Normal = mat3(tr_inv_model) * geo[i].Normal;
        frag.Area = geo[i].Area;
        frag.K = geo[i].K;
        EmitVertex( );

        gl_Position = projection * view * model *(gl_in[i].gl_Position + vec4(geo[i].Normal*normalSign*0.1, 0.0));
        frag.FragPos = geo[i].FragPos;
        frag.Normal = mat3(tr_inv_model) * geo[i].Normal * normalSign;
        frag.Area = geo[i].Area;
        frag.K = geo[i].K;
        EmitVertex( );
        
        EndPrimitive( );
    }

}   
