
bool containsZero(float a, float b, float umbral) {
    float inf, sup;
    if (a < b) {
        inf = a;
        sup = b;
    } else {
        inf = b;
        sup = a;
    }

    return  (inf < -umbral && sup > -umbral) ||
            (inf <  umbral && sup >  umbral) ||
            (inf >  -umbral && sup <  umbral);
}

float calculateMaxK(vec2 p1, vec2 p2, int nIniPts){
    float maxK = 0;
    vec2 coord;

    for (int i = 0; i <= nIniPts; i++) {
        coord = ((nIniPts - i) * p1 + i * p2) / nIniPts;

        maxK = max(maxK, abs(curvatureParam(coord)));
    }

    return maxK;
}

float bestNPtsK(vec2 p1, vec2 p2) {
    vec3 imageP1 = functionParam(p1);
    vec3 imageP2 = functionParam(p2);
    vec3 vision1 = normalize(imageP1 - viewPos);
    vec3 vision2 = normalize(imageP2 - viewPos);

    float signNormal = invertNorm? -1.0 : 1.0;

    vec3 n1 = signNormal*normalParam(p1);
    vec3 n2 = signNormal*normalParam(p2);
    float dotP1 = dot(vision1, n1);
    float dotP2 = dot(vision2, n2);
    float longitud = 2*length(imageP2 - imageP1) / (length(imageP1-viewPos) + length(imageP2-viewPos));
    float bestN = 1;
    bool hidden = dotP1 > 0.5 && dotP2 > 0.5;
    bool outVF = (dot(Front, vision1) > -0.85) && (dot(Front, vision2) > -0.85);

    if (tessEdge) {
        bool isEdge =   p1.x*p1.y*p2.x*p2.y == 0 ||
                        (p1.x-1)*(p1.y-1)*(p2.x-1)*(p2.y-1) == 0;  // Cuando es el borde de la parametrización
        
        if (!isEdge) {
            isEdge = containsZero(dotP1, dotP2, umbralEdge);
        }

        if (isEdge) {
            bestN = floor((calculateMaxK(p1, p2, ptsLimit) * longitud) / umbralLength) + 1;
        } 
    } else if (!hidden && !outVF){
        bestN = floor((calculateMaxK(p1, p2, ptsLimit) * longitud) / umbralLength) + 1;
    }

    return bestN;
}

void main(void) {
    vec2 p1, p2, p3, p_medio12,  p_medio23,  p_medio31;
    float nPts12, nPts23, nPts31, nPtsInt;

    if (tessGlobal || tessEdge) {
        p1 = vertex[0].Coord;
        p2 = vertex[1].Coord;
        p3 = vertex[2].Coord;

        p_medio12 = (p1 + p2) / 2.0;
        p_medio23 = (p2 + p3) / 2.0;
        p_medio31 = (p3 + p1) / 2.0;

        if (gl_InvocationID == 0) {
            nPts12 = bestNPtsK(p1, p2);
            nPts23 = bestNPtsK(p2, p3);
            nPts31 = bestNPtsK(p3, p1);

            nPtsInt = bestNPtsK(p1, p_medio23);
            nPtsInt = max(nPtsInt, bestNPtsK(p2, p_medio31));
            nPtsInt = max(nPtsInt, bestNPtsK(p3, p_medio12));

            gl_TessLevelInner[0] = nPtsInt;
            gl_TessLevelOuter[0] = nPts23;
            gl_TessLevelOuter[1] = nPts31;
            gl_TessLevelOuter[2] = nPts12;
        }
    } else {
        gl_TessLevelInner[0] = 1;
        gl_TessLevelOuter[0] = 1;
        gl_TessLevelOuter[1] = 1;
        gl_TessLevelOuter[2] = 1;
    }

    gl_out[gl_InvocationID].gl_Position = vec4(vertex[gl_InvocationID].Coord, 0.0, 0.0);
}
