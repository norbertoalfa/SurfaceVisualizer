
float calculateLength(vec2 p1, vec2 p2, float nIniPts){
    float longitud = 0;
    vec2 coord_o, coord_d;

    for (int i = 0; i < nIniPts; i++) {
        coord_o = ((nIniPts - i) * p1 + i * p2) / nIniPts;
        coord_d = ((nIniPts - i-1) * p1 + (i+1) * p2) / nIniPts;

        longitud += length(functionParam(coord_d) - functionParam(coord_o));
    }

    return longitud;
}

bool containsZero(float a, float b, float umbral) {
    float inf, sup;
    if (a < b) {
        inf = a;
        sup = b;
    } else {
        inf = b;
        sup = a;
    }

    return  (inf <= -umbral && sup >= -umbral) ||
            (inf <=  umbral && sup >=  umbral) ||
            (inf >=  -umbral && sup <=  umbral);
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

float maxDotLight(vec2 p1, vec2 p2, int nIniPts, float signNormal){
    vec3 image, norm, lightDir;
    vec2 coord;
    float maxDot = -1.0;

    for (int i = 0; i <= nIniPts; i++) {
        coord = ((nIniPts - i) * p1 + i * p2) / nIniPts;
        image = functionParam(coord);
        norm = signNormal*normalParam(coord);

        // Diffuse
        lightDir = normalize(lightPos - image);
        maxDot = max(maxDot, dot(norm, lightDir));

        // Specular
        maxDot = max(maxDot, dot(normalize(viewPos - image), reflect(-lightDir, norm)));
    }

    return maxDot;
}

float bestNPtsK(vec2 p1, vec2 p2) {
    vec3 imageP1, imageP2;
    vec3 vision1, vision2;
    vec3 n1, n2;

    float signNormal, dotP1, dotP2;
    float eyeDist, lengthReal, bestN = 1;
    float actualL, alphaLen, umbralReal;
    float maxK;

    bool hidden, outVF, isEdge;

    imageP1 = functionParam(p1);
    imageP2 = functionParam(p2);

    isEdge = true;
    hidden = outVF = false;

    if (improvePerf) {
        vision1 = normalize(imageP1 - viewPos);
        vision2 = normalize(imageP2 - viewPos);

        // Indicates normal's direction
        signNormal = invertNorm? -1.0 : 1.0;

        n1 = signNormal * normalParam(p1);
        n2 = signNormal * normalParam(p2);

        dotP1 = dot(vision1, n1);
        dotP2 = dot(vision2, n2);

        if (improvePerfEsp) {
            hidden = dotP1 > 0.5 && dotP2 > 0.5;
        }

        outVF = (dot(Front, vision1) > -0.8) && (dot(Front, vision2) > -0.8);

        // Calculates if it is a visual edge.
        isEdge = containsZero(dotP1, dotP2, umbralEdge);
    }

    maxK = calculateMaxK(p1, p2, samplePts);

    if (maxK > 0.001 && !outVF && !hidden) {
        eyeDist = (length(imageP1-viewPos) + length(imageP2-viewPos)) / 2;
        lengthReal = 0.1*length(imageP2 - imageP1);
        umbralReal = umbralLength * 0.1 * eyeDist;

        actualL = calculateLength(p1, p2, 1);
        alphaLen = calculateLength(p1, p2, samplePts);

        // Calculate area (length)
        bestN = floor(abs(alphaLen - actualL) / (umbralReal)) + 1.0f;

        // Geometric mean, where the lowest value has more weight
        bestN *= floor(100*(maxK * lengthReal) / umbralReal) + 1.0f;
        bestN = min(floor(pow(bestN, 0.5)) + 1.0f, ptsLimit);           // Plus 1, to exclude 0 case  
    }

    // If it's not a edge, reduce bestN
    if (!isEdge) {
        bestN = floor(0.667*bestN) + 1.0f;
    }

    return bestN;
}

void main(void) {
    vec2 p1, p2, p3, p_medio12,  p_medio23,  p_medio31;
    float nPts12, nPts23, nPts31, nPtsInt;

    if (tessGlobal && (!showVectors || showVectorsPerV)) {
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
