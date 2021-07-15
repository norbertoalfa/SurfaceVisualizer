
void genVertex(vec2 p) {
    gl_Position = projection * view * model * vec4(functionParam(p), 1.0);
    frag.FragPos = functionParam(p);
    frag.Normal = mat3(tr_inv_model) * normalParam(p);
    frag.Area = 1.0;

    //EmitVertex( );
}

void main() {

    vec4 interpolated = (gl_TessCoord.x * gl_in[0].gl_Position) +
                        (gl_TessCoord.y * gl_in[1].gl_Position) +
                        (gl_TessCoord.z * gl_in[2].gl_Position);
    
    genVertex(vec2(interpolated.x, interpolated.y));
}
