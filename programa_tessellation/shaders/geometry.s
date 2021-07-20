#version 440
layout (triangles) in;
layout (triangle_strip, max_vertices = 3) out;

in gData {vec3 FragPos; vec3 Normal; float Area; float K;} geo[];

out fData {vec3 FragPos; vec3 Normal; float Area; float K;} frag;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform mat4 tr_inv_model;

uniform bool invertNorm;

bool errorVal(float x) {
    return isinf(x) || isnan(x);
}

void main() {

    vec3 normal;
    float normalSign = 1.0;
    float curvatureGlobal = 0.0;
    float curvature;

    if (invertNorm) {
        normalSign = -1.0;
    }

    if (errorVal(geo[0].K) || errorVal(geo[0].K) || errorVal(geo[0].K)) {
        if (!errorVal(geo[0].K))    curvatureGlobal = geo[0].K;
        if (!errorVal(geo[1].K))    curvatureGlobal = geo[1].K;
        if (!errorVal(geo[2].K))    curvatureGlobal = geo[2].K;
    }

    for(int i = 0; i < gl_in.length(); i++) {
        gl_Position = projection * view * model * gl_in[i].gl_Position;
        frag.FragPos = geo[i].FragPos;

        normal = geo[i].Normal;
        if (errorVal(length(normal))) {
            normal = -normalize(cross(   geo[2].FragPos - geo[0].FragPos,
                                        geo[1].FragPos - geo[0].FragPos));
        }
        frag.Normal = mat3(tr_inv_model) * normal * normalSign;

        frag.Area = geo[i].Area;

        curvature = geo[i].K;
        if (errorVal(curvature)) {
            curvature = (geo[(i + 1) % 3].K - geo[(i + 2) % 3].K) / 2.0;
        }

        if (errorVal(curvature)){
            curvature = curvatureGlobal;
        }

        frag.K = curvature;

        EmitVertex( );
    }

    EndPrimitive( );
}
