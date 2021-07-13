#version 440
layout (triangles) in;
layout (triangle_strip, max_vertices = 90) out;

in vData {vec3 FragPos; vec3 Normal; float Area; float u; float v;} vertices[];

out fData {vec3 FragPos; vec3 Normal; float Area;} frag;

uniform mat4 model;
uniform mat4 tr_inv_model;
uniform mat4 view;
uniform mat4 projection;

uniform float param_t[10];
uniform float umbralArea;


vec3 functionParam(vec2 p) {
    return fAmbas(p.x, p.y, param_t[0]);
}

vec3 normalParam(vec2 p) {
    return fAmbasNormal(p.x, p.y, param_t[0]);
}

void genVertex(vec2 p) {
    gl_Position = projection * view * model * vec4(functionParam(p), 1.0);
    frag.FragPos = functionParam(p);
    frag.Normal = mat3(tr_inv_model) * normalParam(p);
    frag.Area = 1.0;

    EmitVertex( );
}

void genTriangle(vec2 p1, vec2 p2, vec2 p3){
    genVertex(p1);
    genVertex(p2);
    genVertex(p3);

    EndPrimitive();
}

void checkTriangle3(vec2 p1, vec2 p2, vec2 p3){
    float vol = abs(determinant(mat3(functionParam(p1), functionParam(p2), functionParam(p3))))/6.0;
    vec2 p_medio = (p1 + p2 + p3)/3.0;

    if (vol > umbralArea) {
        genTriangle(p1, p2, p_medio);
        genTriangle(p2, p3, p_medio);
        genTriangle(p3, p1, p_medio);
    } else {
        genTriangle(p1, p2, p3);
    }
}

void checkTriangle2(vec2 p1, vec2 p2, vec2 p3){
    float vol = abs(determinant(mat3(functionParam(p1), functionParam(p2), functionParam(p3))))/6.0;
    vec2 p_medio = (p1 + p2 + p3)/3.0;

    if (vol > umbralArea) {
        checkTriangle3(p1, p2, p_medio);
        checkTriangle3(p2, p3, p_medio);
        checkTriangle3(p3, p1, p_medio);
    } else {
        genTriangle(p1, p2, p3);
    }
}

void checkTriangle(vec2 p1, vec2 p2, vec2 p3){
    float vol = abs(determinant(mat3(functionParam(p1), functionParam(p2), functionParam(p3))))/6.0;
    vec2 p_medio = (p1 + p2 + p3)/3.0;

    if (vol > umbralArea) {
        checkTriangle2(p1, p2, p_medio);
        checkTriangle2(p2, p3, p_medio);
        checkTriangle2(p3, p1, p_medio);
    } else {
        genTriangle(p1, p2, p3);
    }
}

void main() {

    checkTriangle(vec2(vertices[0].u, vertices[0].v),
                    vec2(vertices[1].u, vertices[1].v),
                    vec2(vertices[2].u, vertices[2].v));

    /*for( int i=0; i<gl_in.length( ); i++ )
    {
        gl_Position = projection * view * model * gl_in[i].gl_Position;
        frag.FragPos = vertices[i].FragPos;
        frag.Normal = mat3(tr_inv_model) * vertices[i].Normal;
        frag.Area = vertices[i].Area;
        EmitVertex( );
    }

    EndPrimitive( );*/
    
}
