
float PI = 3.1415926;
float E = 2.71828182;


int funcionIf(bool cond, int e1, int e2)
{
	if (cond)
		 return e1;
	 else
		 return e2;
}

float funcionIf(bool cond, float e1, float e2)
{
	if (cond)
		 return e1;
	 else
		 return e2;
}

bool funcionIf(bool cond, bool e1, bool e2)
{
	if (cond)
		 return e1;
	 else
		 return e2;
}

vec2 funcionIf(bool cond, vec2 e1, vec2 e2)
{
	if (cond)
		 return e1;
	 else
		 return e2;
}

vec3 funcionIf(bool cond, vec3 e1, vec3 e2)
{
	if (cond)
		 return e1;
	 else
		 return e2;
}

mat2 funcionIf(bool cond, mat2 e1, mat2 e2)
{
	if (cond)
		 return e1;
	 else
		 return e2;
}

mat3 funcionIf(bool cond, mat3 e1, mat3 e2)
{
	if (cond)
		 return e1;
	 else
		 return e2;
}
float compz(float u, float v, float t0, float t1) {
	return 0.1 *  cos(u * u + v * v + 2 * PI * t0 + 2 * PI * t1);
}

vec3 f(float u, float v, float t0, float t1, float t2) {
	return vec3(4 *  vec3(u, t2 *  compz(4 * u, 4 * v, t0, t1) / (u * u + v * v + 1.0), v));
}

float compzPu(float u, float v, float t0, float t1) {
	return (0.1 * (( -  sin(u * u + v * v + 2 * PI * t0 + 2 * PI * t1)) * (u + u)));
}

float compzPv(float u, float v, float t0, float t1) {
	return (0.1 * (( -  sin(u * u + v * v + 2 * PI * t0 + 2 * PI * t1)) * (v + v)));
}

float compzPt0(float u, float v, float t0, float t1) {
	return (0.1 * (( -  sin(u * u + v * v + 2 * PI * t0 + 2 * PI * t1)) * (2 * PI)));
}

float compzPt1(float u, float v, float t0, float t1) {
	return (0.1 * (( -  sin(u * u + v * v + 2 * PI * t0 + 2 * PI * t1)) * (2 * PI)));
}

vec3 fPu(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + 4 *  vec3(1, ((t2 * ( compzPu(4 * u, 4 * v, t0, t1) * 4)) / (u * u + v * v + 1.0) - t2 *  compz(4 * u, 4 * v, t0, t1) * (u + u) / ( pow((u * u + v * v + 1.0), 2))), 0)));
}

vec3 fPv(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + 4 *  vec3(0, ((t2 * ( compzPv(4 * u, 4 * v, t0, t1) * 4)) / (u * u + v * v + 1.0) - t2 *  compz(4 * u, 4 * v, t0, t1) * (v + v) / ( pow((u * u + v * v + 1.0), 2))), 1)));
}

vec3 fNormal(float u, float v, float t0, float t1, float t2) {
	return vec3( normalize( cross( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))));
}

float fArea(float u, float v, float t0, float t1, float t2) {
	return  distance( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2));
}

float compzPuPu(float u, float v, float t0, float t1) {
	return (0.1 * (( - ( cos(u * u + v * v + 2 * PI * t0 + 2 * PI * t1) * (u + u))) * (u + u) + ( -  sin(u * u + v * v + 2 * PI * t0 + 2 * PI * t1)) * (1 + 1)));
}

float compzPuPv(float u, float v, float t0, float t1) {
	return (0.1 * (( - ( cos(u * u + v * v + 2 * PI * t0 + 2 * PI * t1) * (v + v))) * (u + u)));
}

float compzPuPt0(float u, float v, float t0, float t1) {
	return (0.1 * (( - ( cos(u * u + v * v + 2 * PI * t0 + 2 * PI * t1) * (2 * PI))) * (u + u)));
}

float compzPuPt1(float u, float v, float t0, float t1) {
	return (0.1 * (( - ( cos(u * u + v * v + 2 * PI * t0 + 2 * PI * t1) * (2 * PI))) * (u + u)));
}

vec3 fPuPu(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (((t2 * (( compzPuPu(4 * u, 4 * v, t0, t1) * 4) * 4)) / (u * u + v * v + 1.0) - (t2 * ( compzPu(4 * u, 4 * v, t0, t1) * 4)) * (u + u) / ( pow((u * u + v * v + 1.0), 2))) - (((t2 * ( compzPu(4 * u, 4 * v, t0, t1) * 4)) * (u + u) + t2 *  compz(4 * u, 4 * v, t0, t1) * (1 + 1)) / ( pow((u * u + v * v + 1.0), 2)) - t2 *  compz(4 * u, 4 * v, t0, t1) * (u + u) * (2 *  pow((u * u + v * v + 1.0), 1.000000) * (u + u)) / ( pow(( pow((u * u + v * v + 1.0), 2)), 2)))), 0))));
}

float compzPvPu(float u, float v, float t0, float t1) {
	return (0.1 * (( - ( cos(u * u + v * v + 2 * PI * t0 + 2 * PI * t1) * (u + u))) * (v + v)));
}

float compzPvPv(float u, float v, float t0, float t1) {
	return (0.1 * (( - ( cos(u * u + v * v + 2 * PI * t0 + 2 * PI * t1) * (v + v))) * (v + v) + ( -  sin(u * u + v * v + 2 * PI * t0 + 2 * PI * t1)) * (1 + 1)));
}

float compzPvPt0(float u, float v, float t0, float t1) {
	return (0.1 * (( - ( cos(u * u + v * v + 2 * PI * t0 + 2 * PI * t1) * (2 * PI))) * (v + v)));
}

float compzPvPt1(float u, float v, float t0, float t1) {
	return (0.1 * (( - ( cos(u * u + v * v + 2 * PI * t0 + 2 * PI * t1) * (2 * PI))) * (v + v)));
}

vec3 fPvPv(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (((t2 * (( compzPvPv(4 * u, 4 * v, t0, t1) * 4) * 4)) / (u * u + v * v + 1.0) - (t2 * ( compzPv(4 * u, 4 * v, t0, t1) * 4)) * (v + v) / ( pow((u * u + v * v + 1.0), 2))) - (((t2 * ( compzPv(4 * u, 4 * v, t0, t1) * 4)) * (v + v) + t2 *  compz(4 * u, 4 * v, t0, t1) * (1 + 1)) / ( pow((u * u + v * v + 1.0), 2)) - t2 *  compz(4 * u, 4 * v, t0, t1) * (v + v) * (2 *  pow((u * u + v * v + 1.0), 1.000000) * (v + v)) / ( pow(( pow((u * u + v * v + 1.0), 2)), 2)))), 0))));
}

vec3 fPuPv(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (((t2 * (( compzPuPv(4 * u, 4 * v, t0, t1) * 4) * 4)) / (u * u + v * v + 1.0) - (t2 * ( compzPu(4 * u, 4 * v, t0, t1) * 4)) * (v + v) / ( pow((u * u + v * v + 1.0), 2))) - (((t2 * ( compzPv(4 * u, 4 * v, t0, t1) * 4)) * (u + u)) / ( pow((u * u + v * v + 1.0), 2)) - t2 *  compz(4 * u, 4 * v, t0, t1) * (u + u) * (2 *  pow((u * u + v * v + 1.0), 1.000000) * (v + v)) / ( pow(( pow((u * u + v * v + 1.0), 2)), 2)))), 0))));
}

float fK(float u, float v, float t0, float t1, float t2) {
	return ( determinant( mat3( fPuPu(u, v, t0, t1, t2),  fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))) *  determinant( mat3( fPvPv(u, v, t0, t1, t2),  fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))) -  pow( determinant( mat3( fPuPv(u, v, t0, t1, t2),  fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2))), 2)) /  pow( pow( length( fPu(u, v, t0, t1, t2)), 2) *  pow( length( fPv(u, v, t0, t1, t2)), 2) -  pow( dot( fPu(u, v, t0, t1, t2),  fPv(u, v, t0, t1, t2)), 2), 2);
}

vec3 h(float u, float v, float t0, float t1, float t2) {
	return vec3( f(4 * (u - 0.5), 4 * (v - 0.5), t0, t1, t2));
}

vec3 fPt0(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + 4 *  vec3(0, ((t2 *  compzPt0(4 * u, 4 * v, t0, t1)) / (u * u + v * v + 1.0)), 0)));
}

vec3 fPt1(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + 4 *  vec3(0, ((t2 *  compzPt1(4 * u, 4 * v, t0, t1)) / (u * u + v * v + 1.0)), 0)));
}

vec3 fPt2(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + 4 *  vec3(0, ( compz(4 * u, 4 * v, t0, t1) / (u * u + v * v + 1.0)), 0)));
}

vec3 hPu(float u, float v, float t0, float t1, float t2) {
	return vec3(( fPu(4 * (u - 0.5), 4 * (v - 0.5), t0, t1, t2) * 4));
}

vec3 hPv(float u, float v, float t0, float t1, float t2) {
	return vec3(( fPv(4 * (u - 0.5), 4 * (v - 0.5), t0, t1, t2) * 4));
}

vec3 hNormal(float u, float v, float t0, float t1, float t2) {
	return vec3( normalize( cross( hPu(u, v, t0, t1, t2),  hPv(u, v, t0, t1, t2))));
}

float hArea(float u, float v, float t0, float t1, float t2) {
	return  distance( hPu(u, v, t0, t1, t2),  hPv(u, v, t0, t1, t2));
}

vec3 fPuPt0(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (((t2 * ( compzPuPt0(4 * u, 4 * v, t0, t1) * 4)) / (u * u + v * v + 1.0)) - (((t2 *  compzPt0(4 * u, 4 * v, t0, t1)) * (u + u)) / ( pow((u * u + v * v + 1.0), 2)))), 0))));
}

vec3 fPuPt1(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (((t2 * ( compzPuPt1(4 * u, 4 * v, t0, t1) * 4)) / (u * u + v * v + 1.0)) - (((t2 *  compzPt1(4 * u, 4 * v, t0, t1)) * (u + u)) / ( pow((u * u + v * v + 1.0), 2)))), 0))));
}

vec3 fPuPt2(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, ((( compzPu(4 * u, 4 * v, t0, t1) * 4) / (u * u + v * v + 1.0)) - (( compz(4 * u, 4 * v, t0, t1) * (u + u)) / ( pow((u * u + v * v + 1.0), 2)))), 0))));
}

vec3 hPuPu(float u, float v, float t0, float t1, float t2) {
	return vec3((( fPuPu(4 * (u - 0.5), 4 * (v - 0.5), t0, t1, t2) * 4) * 4));
}

vec3 fPvPu(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (((t2 * (( compzPvPu(4 * u, 4 * v, t0, t1) * 4) * 4)) / (u * u + v * v + 1.0) - (t2 * ( compzPv(4 * u, 4 * v, t0, t1) * 4)) * (u + u) / ( pow((u * u + v * v + 1.0), 2))) - (((t2 * ( compzPu(4 * u, 4 * v, t0, t1) * 4)) * (v + v)) / ( pow((u * u + v * v + 1.0), 2)) - t2 *  compz(4 * u, 4 * v, t0, t1) * (v + v) * (2 *  pow((u * u + v * v + 1.0), 1.000000) * (u + u)) / ( pow(( pow((u * u + v * v + 1.0), 2)), 2)))), 0))));
}

vec3 fPvPt0(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (((t2 * ( compzPvPt0(4 * u, 4 * v, t0, t1) * 4)) / (u * u + v * v + 1.0)) - (((t2 *  compzPt0(4 * u, 4 * v, t0, t1)) * (v + v)) / ( pow((u * u + v * v + 1.0), 2)))), 0))));
}

vec3 fPvPt1(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (((t2 * ( compzPvPt1(4 * u, 4 * v, t0, t1) * 4)) / (u * u + v * v + 1.0)) - (((t2 *  compzPt1(4 * u, 4 * v, t0, t1)) * (v + v)) / ( pow((u * u + v * v + 1.0), 2)))), 0))));
}

vec3 fPvPt2(float u, float v, float t0, float t1, float t2) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, ((( compzPv(4 * u, 4 * v, t0, t1) * 4) / (u * u + v * v + 1.0)) - (( compz(4 * u, 4 * v, t0, t1) * (v + v)) / ( pow((u * u + v * v + 1.0), 2)))), 0))));
}

vec3 hPvPv(float u, float v, float t0, float t1, float t2) {
	return vec3((( fPvPv(4 * (u - 0.5), 4 * (v - 0.5), t0, t1, t2) * 4) * 4));
}

vec3 hPuPv(float u, float v, float t0, float t1, float t2) {
	return vec3((( fPuPv(4 * (u - 0.5), 4 * (v - 0.5), t0, t1, t2) * 4) * 4));
}

float hK(float u, float v, float t0, float t1, float t2) {
	return ( determinant( mat3( hPuPu(u, v, t0, t1, t2),  hPu(u, v, t0, t1, t2),  hPv(u, v, t0, t1, t2))) *  determinant( mat3( hPvPv(u, v, t0, t1, t2),  hPu(u, v, t0, t1, t2),  hPv(u, v, t0, t1, t2))) -  pow( determinant( mat3( hPuPv(u, v, t0, t1, t2),  hPu(u, v, t0, t1, t2),  hPv(u, v, t0, t1, t2))), 2)) /  pow( pow( length( hPu(u, v, t0, t1, t2)), 2) *  pow( length( hPv(u, v, t0, t1, t2)), 2) -  pow( dot( hPu(u, v, t0, t1, t2),  hPv(u, v, t0, t1, t2)), 2), 2);
}

vec3 functionParam(vec2 p) {
	if (funPlot==0) {
		return h(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 normalParam(vec2 p) {
	if (funPlot==0) {
		return hNormal(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 tangentParam(vec2 p) {
	if (funPlot==0) {
		return hPu(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 cotangentParam(vec2 p) {
	if (funPlot==0) {
		return hPv(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return vec3(0.0, 0.0, 0.0);
}

float areaParam(vec2 p) {
	if (funPlot==0) {
		return hArea(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return 0.0;
}

float curvatureParam(vec2 p) {
	if (funPlot==0) {
		return hK(p.x, p.y, param_t[0], param_t[1], param_t[2]);
	}

	return 0.0;
}

