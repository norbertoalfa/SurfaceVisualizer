
void main() {
	vec3 aPosSurf, aNormSurf;
	float aAreaSurf;

	aPosSurf = functionParam(aPos);
	aNormSurf = normalParam(aPos);
	aAreaSurf = areaParam(aPos);

	vertex.FragPos = vec3(vec4(aPosSurf, 1.0));
	vertex.Normal = aNormSurf;
	vertex.Area = aAreaSurf;
	vertex.Coord = aPos;
	gl_Position = vec4(aPosSurf, 1.0);
}