#version 440
layout (triangles) in;
layout (triangle_strip, max_vertices = 3) out;

in vData {vec3 FragPos; vec3 Normal;} vertices[];

out fData {vec3 FragPos; vec3 Normal;} frag;

uniform mat4 model;

void main() {
    vec3 a = ( gl_in[1].gl_Position - gl_in[0].gl_Position ).xyz;
    vec3 b = ( gl_in[2].gl_Position - gl_in[0].gl_Position ).xyz;
    vec3 norm = normalize( cross( b, a ) );

    for( int i=0; i<gl_in.length( ); i++ )
    {
        gl_Position = gl_in[i].gl_Position;
        frag.FragPos = vertices[i].FragPos;
        //frag.Normal = mat3(transpose(inverse(model))) * norm;
        frag.Normal = mat3(transpose(inverse(model))) * vertices[i].Normal;
        //frag.Normal = mat3(transpose(inverse(model))) * vec3(gl_Position[0], gl_Position[1], gl_Position[2]);
        EmitVertex( );
    }

    EndPrimitive( );
    
}
