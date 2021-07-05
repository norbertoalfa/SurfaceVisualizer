#version 440
layout (triangles) in;
layout (triangle_strip, max_vertices = 3) out;

in vData {vec3 FragPos; vec3 Normal;} vertices[];

out fData {vec3 FragPos; vec3 Normal;} frag;

uniform mat4 model;

void main() {

    for( int i=0; i<gl_in.length( ); i++ )
    {
        gl_Position = gl_in[i].gl_Position;
        frag.FragPos = vertices[i].FragPos;
        frag.Normal = mat3(transpose(inverse(model))) * vertices[i].Normal;
        EmitVertex( );
    }

    EndPrimitive( );
    
}
