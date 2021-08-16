#version 440
layout (triangles) in;
layout (line_strip, max_vertices = 18) out;

in gData {vec3 FragPos; vec3 Tangent; vec3 Cotan; vec3 Normal; float Area; float K; float Critic;} geo[];

out fData {vec3 FragPos; vec3 Normal; float Area; float K; float Critic;} frag;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform mat4 tr_inv_model;

uniform float signNormal;

uniform bool showTangents;
uniform bool showCotangents;
uniform bool showNormals;

void genTangent(int i) {
    gl_Position = projection * view * model * gl_in[i].gl_Position;
    frag.FragPos = geo[i].FragPos;
    frag.Normal = mat3(tr_inv_model) * geo[i].Normal * signNormal;
    frag.Area = geo[i].Area;
    frag.K = geo[i].K;
    frag.Critic = geo[i].Critic;
    EmitVertex( );

    gl_Position = projection * view * model *(gl_in[i].gl_Position + vec4(geo[i].Tangent*signNormal*0.1, 0.0));
    frag.FragPos = geo[i].FragPos;
    frag.Normal = mat3(tr_inv_model) * geo[i].Normal * signNormal;
    frag.Area = geo[i].Area;
    frag.K = geo[i].K;
    frag.Critic = geo[i].Critic;
    EmitVertex( );
    
    EndPrimitive( );
}

void genCotan(int i) {
    gl_Position = projection * view * model * gl_in[i].gl_Position;
    frag.FragPos = geo[i].FragPos;
    frag.Normal = mat3(tr_inv_model) * geo[i].Normal * signNormal;
    frag.Area = geo[i].Area;
    frag.K = geo[i].K;
    frag.Critic = geo[i].Critic;
    EmitVertex( );

    gl_Position = projection * view * model *(gl_in[i].gl_Position + vec4(geo[i].Cotan*signNormal*0.1, 0.0));
    frag.FragPos = geo[i].FragPos;
    frag.Normal = mat3(tr_inv_model) * geo[i].Normal * signNormal;
    frag.Area = geo[i].Area;
    frag.K = geo[i].K;
    frag.Critic = geo[i].Critic;
    EmitVertex( );
    
    EndPrimitive( );
}

void genNormal(int i) {
    gl_Position = projection * view * model * gl_in[i].gl_Position;
    frag.FragPos = geo[i].FragPos;
    frag.Normal = mat3(tr_inv_model) * geo[i].Normal * signNormal;
    frag.Area = geo[i].Area;
    frag.K = geo[i].K;
    frag.Critic = geo[i].Critic;
    EmitVertex( );

    gl_Position = projection * view * model *(gl_in[i].gl_Position + vec4(geo[i].Normal*signNormal*0.1, 0.0));
    frag.FragPos = geo[i].FragPos;
    frag.Normal = mat3(tr_inv_model) * geo[i].Normal * signNormal;
    frag.Area = geo[i].Area;
    frag.K = geo[i].K;
    frag.Critic = geo[i].Critic;
    EmitVertex( );
    
    EndPrimitive( );
}

void main() {

    if (showTangents) {
        for(int i = 0; i < gl_in.length(); i++) {
            genTangent(i);
        }
    }

    if (showCotangents) {
        for(int i = 0; i < gl_in.length(); i++) {
            genCotan(i);
        }
    }

    if (showNormals) {
        for(int i = 0; i < gl_in.length(); i++) {
            genNormal(i);
        }
    }
}   
