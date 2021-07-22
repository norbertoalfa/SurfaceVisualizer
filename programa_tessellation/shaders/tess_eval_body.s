
void genVertex(vec2 p) {
    gl_Position = vec4(functionParam(p), 1.0);
    geo.FragPos = functionParam(p);
    geo.Normal = normalParam(p);
    geo.Area = areaParam(p);
    geo.K = curvatureParam(p);
}

void main() {
    vec4 interpolated = ( gl_TessCoord.x * gl_in[0].gl_Position +
                            gl_TessCoord.y * gl_in[1].gl_Position +
                            gl_TessCoord.z * gl_in[2].gl_Position);

    genVertex(vec2(interpolated.x, interpolated.y));
}
