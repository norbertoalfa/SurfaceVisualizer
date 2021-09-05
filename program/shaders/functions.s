
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
float PI2 = 2 * PI;

float compx(float u, float v) {
	return 2 * u;
}

float compy(float u, float v) {
	return  - 1 +  pow(u, 2) +  pow(v, 2);
}

float compz(float u, float v) {
	return 2 * v;
}

vec3 f(float u, float v) {
	return vec3( vec3( compx(u, v),  compy(u, v),  compz(u, v)) / (1 +  pow(u, 2) +  pow(v, 2)));
}

float compxPu(float u, float v) {
	return 2;
}

float compxPv(float u, float v) {
	return 0;
}

float compyPu(float u, float v) {
	return (2 *  pow(u, 1.000000));
}

float compyPv(float u, float v) {
	return (2 *  pow(v, 1.000000));
}

float compzPu(float u, float v) {
	return 0;
}

float compzPv(float u, float v) {
	return 2;
}

vec3 fPu(float u, float v) {
	return vec3(( vec3( compxPu(u, v),  compyPu(u, v),  compzPu(u, v)) / (1 +  pow(u, 2) +  pow(v, 2)) -  vec3( compx(u, v),  compy(u, v),  compz(u, v)) * (2 *  pow(u, 1.000000)) / ( pow((1 +  pow(u, 2) +  pow(v, 2)), 2))));
}

vec3 fPv(float u, float v) {
	return vec3(( vec3( compxPv(u, v),  compyPv(u, v),  compzPv(u, v)) / (1 +  pow(u, 2) +  pow(v, 2)) -  vec3( compx(u, v),  compy(u, v),  compz(u, v)) * (2 *  pow(v, 1.000000)) / ( pow((1 +  pow(u, 2) +  pow(v, 2)), 2))));
}

vec3 fNormal(float u, float v) {
	return vec3( normalize( cross( fPu(u, v),  fPv(u, v))));
}

float fArea(float u, float v) {
	return  distance( fPu(u, v),  fPv(u, v));
}

float compxPuPu(float u, float v) {
	return 0;
}

float compxPuPv(float u, float v) {
	return 0;
}

float compyPuPu(float u, float v) {
	return (2 * (1.000000 *  pow(u, 0.000000)));
}

float compyPuPv(float u, float v) {
	return 0;
}

float compzPuPu(float u, float v) {
	return 0;
}

float compzPuPv(float u, float v) {
	return 0;
}

vec3 fPuPu(float u, float v) {
	return vec3((( vec3( compxPuPu(u, v),  compyPuPu(u, v),  compzPuPu(u, v)) / (1 +  pow(u, 2) +  pow(v, 2)) -  vec3( compxPu(u, v),  compyPu(u, v),  compzPu(u, v)) * (2 *  pow(u, 1.000000)) / ( pow((1 +  pow(u, 2) +  pow(v, 2)), 2))) - (( vec3( compxPu(u, v),  compyPu(u, v),  compzPu(u, v)) * (2 *  pow(u, 1.000000)) +  vec3( compx(u, v),  compy(u, v),  compz(u, v)) * (2 * (1.000000 *  pow(u, 0.000000)))) / ( pow((1 +  pow(u, 2) +  pow(v, 2)), 2)) -  vec3( compx(u, v),  compy(u, v),  compz(u, v)) * (2 *  pow(u, 1.000000)) * (2 *  pow((1 +  pow(u, 2) +  pow(v, 2)), 1.000000) * (2 *  pow(u, 1.000000))) / ( pow(( pow((1 +  pow(u, 2) +  pow(v, 2)), 2)), 2)))));
}

float compxPvPu(float u, float v) {
	return 0;
}

float compxPvPv(float u, float v) {
	return 0;
}

float compyPvPu(float u, float v) {
	return 0;
}

float compyPvPv(float u, float v) {
	return (2 * (1.000000 *  pow(v, 0.000000)));
}

float compzPvPu(float u, float v) {
	return 0;
}

float compzPvPv(float u, float v) {
	return 0;
}

vec3 fPvPv(float u, float v) {
	return vec3((( vec3( compxPvPv(u, v),  compyPvPv(u, v),  compzPvPv(u, v)) / (1 +  pow(u, 2) +  pow(v, 2)) -  vec3( compxPv(u, v),  compyPv(u, v),  compzPv(u, v)) * (2 *  pow(v, 1.000000)) / ( pow((1 +  pow(u, 2) +  pow(v, 2)), 2))) - (( vec3( compxPv(u, v),  compyPv(u, v),  compzPv(u, v)) * (2 *  pow(v, 1.000000)) +  vec3( compx(u, v),  compy(u, v),  compz(u, v)) * (2 * (1.000000 *  pow(v, 0.000000)))) / ( pow((1 +  pow(u, 2) +  pow(v, 2)), 2)) -  vec3( compx(u, v),  compy(u, v),  compz(u, v)) * (2 *  pow(v, 1.000000)) * (2 *  pow((1 +  pow(u, 2) +  pow(v, 2)), 1.000000) * (2 *  pow(v, 1.000000))) / ( pow(( pow((1 +  pow(u, 2) +  pow(v, 2)), 2)), 2)))));
}

vec3 fPuPv(float u, float v) {
	return vec3((( vec3( compxPuPv(u, v),  compyPuPv(u, v),  compzPuPv(u, v)) / (1 +  pow(u, 2) +  pow(v, 2)) -  vec3( compxPu(u, v),  compyPu(u, v),  compzPu(u, v)) * (2 *  pow(v, 1.000000)) / ( pow((1 +  pow(u, 2) +  pow(v, 2)), 2))) - (( vec3( compxPv(u, v),  compyPv(u, v),  compzPv(u, v)) * (2 *  pow(u, 1.000000)) +  vec3(0)) / ( pow((1 +  pow(u, 2) +  pow(v, 2)), 2)) -  vec3( compx(u, v),  compy(u, v),  compz(u, v)) * (2 *  pow(u, 1.000000)) * (2 *  pow((1 +  pow(u, 2) +  pow(v, 2)), 1.000000) * (2 *  pow(v, 1.000000))) / ( pow(( pow((1 +  pow(u, 2) +  pow(v, 2)), 2)), 2)))));
}

float fK(float u, float v) {
	return ( determinant( mat3( fPuPu(u, v),  fPu(u, v),  fPv(u, v))) *  determinant( mat3( fPvPv(u, v),  fPu(u, v),  fPv(u, v))) -  pow( determinant( mat3( fPuPv(u, v),  fPu(u, v),  fPv(u, v))), 2)) /  pow( pow( length( fPu(u, v)), 2) *  pow( length( fPv(u, v)), 2) -  pow( dot( fPu(u, v),  fPv(u, v)), 2), 2);
}

vec3 g(float u, float v, float t0) {
	return vec3( f(10 * (u - 0.5), 10 * (v - 0.5)) * t0 + (1 - t0) *  vec3(10 * (u - 0.5),  - 1, 10 * (v - 0.5)));
}

vec3 gPu(float u, float v, float t0) {
	return vec3(((( fPu(10 * (u - 0.5), 10 * (v - 0.5)) * 10) * t0) + ( vec3(0) + (1 - t0) *  vec3(10, 0, 0))));
}

vec3 gPv(float u, float v, float t0) {
	return vec3(((( fPv(10 * (u - 0.5), 10 * (v - 0.5)) * 10) * t0) + ( vec3(0) + (1 - t0) *  vec3(0, 0, 10))));
}

vec3 gNormal(float u, float v, float t0) {
	return vec3( normalize( cross( gPu(u, v, t0),  gPv(u, v, t0))));
}

float gArea(float u, float v, float t0) {
	return  distance( gPu(u, v, t0),  gPv(u, v, t0));
}

vec3 gPuPu(float u, float v, float t0) {
	return vec3((((( fPuPu(10 * (u - 0.5), 10 * (v - 0.5)) * 10) * 10) * t0) + ( vec3(0) + ( vec3(0) + (1 - t0) *  vec3(0, 0, 0)))));
}

vec3 fPvPu(float u, float v) {
	return vec3((( vec3( compxPvPu(u, v),  compyPvPu(u, v),  compzPvPu(u, v)) / (1 +  pow(u, 2) +  pow(v, 2)) -  vec3( compxPv(u, v),  compyPv(u, v),  compzPv(u, v)) * (2 *  pow(u, 1.000000)) / ( pow((1 +  pow(u, 2) +  pow(v, 2)), 2))) - (( vec3( compxPu(u, v),  compyPu(u, v),  compzPu(u, v)) * (2 *  pow(v, 1.000000)) +  vec3(0)) / ( pow((1 +  pow(u, 2) +  pow(v, 2)), 2)) -  vec3( compx(u, v),  compy(u, v),  compz(u, v)) * (2 *  pow(v, 1.000000)) * (2 *  pow((1 +  pow(u, 2) +  pow(v, 2)), 1.000000) * (2 *  pow(u, 1.000000))) / ( pow(( pow((1 +  pow(u, 2) +  pow(v, 2)), 2)), 2)))));
}

vec3 gPvPv(float u, float v, float t0) {
	return vec3((((( fPvPv(10 * (u - 0.5), 10 * (v - 0.5)) * 10) * 10) * t0) + ( vec3(0) + ( vec3(0) + (1 - t0) *  vec3(0, 0, 0)))));
}

vec3 gPuPv(float u, float v, float t0) {
	return vec3((((( fPuPv(10 * (u - 0.5), 10 * (v - 0.5)) * 10) * 10) * t0) + ( vec3(0) + ( vec3(0) + (1 - t0) *  vec3(0, 0, 0)))));
}

float gK(float u, float v, float t0) {
	return ( determinant( mat3( gPuPu(u, v, t0),  gPu(u, v, t0),  gPv(u, v, t0))) *  determinant( mat3( gPvPv(u, v, t0),  gPu(u, v, t0),  gPv(u, v, t0))) -  pow( determinant( mat3( gPuPv(u, v, t0),  gPu(u, v, t0),  gPv(u, v, t0))), 2)) /  pow( pow( length( gPu(u, v, t0)), 2) *  pow( length( gPv(u, v, t0)), 2) -  pow( dot( gPu(u, v, t0),  gPv(u, v, t0)), 2), 2);
}

vec3 esf(float u, float v) {
	return vec3( vec3( cos(v * PI) *  cos(2 * u * PI),  cos(v * PI) *  sin(2 * u * PI),  sin(v * PI)));
}

vec3 esfPu(float u, float v) {
	return vec3( vec3(( cos(v * PI) * (( -  sin(2 * u * PI)) * (2 * PI))), ( cos(v * PI) * ( cos(2 * u * PI) * (2 * PI))), 0));
}

vec3 esfPv(float u, float v) {
	return vec3( vec3(((( -  sin(v * PI)) * PI) *  cos(2 * u * PI)), ((( -  sin(v * PI)) * PI) *  sin(2 * u * PI)), ( cos(v * PI) * PI)));
}

vec3 esfNormal(float u, float v) {
	return vec3( normalize( cross( esfPu(u, v),  esfPv(u, v))));
}

float esfArea(float u, float v) {
	return  distance( esfPu(u, v),  esfPv(u, v));
}

vec3 esfPuPu(float u, float v) {
	return vec3( vec3(( cos(v * PI) * (( - ( cos(2 * u * PI) * (2 * PI))) * (2 * PI))), ( cos(v * PI) * ((( -  sin(2 * u * PI)) * (2 * PI)) * (2 * PI))), 0));
}

vec3 esfPvPv(float u, float v) {
	return vec3( vec3(((( - ( cos(v * PI) * PI)) * PI) *  cos(2 * u * PI)), ((( - ( cos(v * PI) * PI)) * PI) *  sin(2 * u * PI)), ((( -  sin(v * PI)) * PI) * PI)));
}

vec3 esfPuPv(float u, float v) {
	return vec3( vec3(((( -  sin(v * PI)) * PI) * (( -  sin(2 * u * PI)) * (2 * PI))), ((( -  sin(v * PI)) * PI) * ( cos(2 * u * PI) * (2 * PI))), 0));
}

float esfK(float u, float v) {
	return ( determinant( mat3( esfPuPu(u, v),  esfPu(u, v),  esfPv(u, v))) *  determinant( mat3( esfPvPv(u, v),  esfPu(u, v),  esfPv(u, v))) -  pow( determinant( mat3( esfPuPv(u, v),  esfPu(u, v),  esfPv(u, v))), 2)) /  pow( pow( length( esfPu(u, v)), 2) *  pow( length( esfPv(u, v)), 2) -  pow( dot( esfPu(u, v),  esfPv(u, v)), 2), 2);
}

vec3 esfDom(float u, float v) {
	return vec3( esf(u - 0.5, v - 0.5));
}

vec3 esfDomPu(float u, float v) {
	return vec3( esfPu(u - 0.5, v - 0.5));
}

vec3 esfDomPv(float u, float v) {
	return vec3( esfPv(u - 0.5, v - 0.5));
}

vec3 esfDomNormal(float u, float v) {
	return vec3( normalize( cross( esfDomPu(u, v),  esfDomPv(u, v))));
}

float esfDomArea(float u, float v) {
	return  distance( esfDomPu(u, v),  esfDomPv(u, v));
}

vec3 esfDomPuPu(float u, float v) {
	return vec3( esfPuPu(u - 0.5, v - 0.5));
}

vec3 esfPvPu(float u, float v) {
	return vec3( vec3(((( -  sin(v * PI)) * PI) * (( -  sin(2 * u * PI)) * (2 * PI))), ((( -  sin(v * PI)) * PI) * ( cos(2 * u * PI) * (2 * PI))), 0));
}

vec3 esfDomPvPv(float u, float v) {
	return vec3( esfPvPv(u - 0.5, v - 0.5));
}

vec3 esfDomPuPv(float u, float v) {
	return vec3( esfPuPv(u - 0.5, v - 0.5));
}

float esfDomK(float u, float v) {
	return ( determinant( mat3( esfDomPuPu(u, v),  esfDomPu(u, v),  esfDomPv(u, v))) *  determinant( mat3( esfDomPvPv(u, v),  esfDomPu(u, v),  esfDomPv(u, v))) -  pow( determinant( mat3( esfDomPuPv(u, v),  esfDomPu(u, v),  esfDomPv(u, v))), 2)) /  pow( pow( length( esfDomPu(u, v)), 2) *  pow( length( esfDomPv(u, v)), 2) -  pow( dot( esfDomPu(u, v),  esfDomPv(u, v)), 2), 2);
}

vec3 functionParam(vec2 p) {
	if (funPlot==0) {
		return g(p.x, p.y, param_t[0]);
	} else if (funPlot==1) {
		return esfDom(p.x, p.y);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 normalParam(vec2 p) {
	if (funPlot==0) {
		return gNormal(p.x, p.y, param_t[0]);
	} else if (funPlot==1) {
		return esfDomNormal(p.x, p.y);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 tangentParam(vec2 p) {
	if (funPlot==0) {
		return gPu(p.x, p.y, param_t[0]);
	} else if (funPlot==1) {
		return esfDomPu(p.x, p.y);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 cotangentParam(vec2 p) {
	if (funPlot==0) {
		return gPv(p.x, p.y, param_t[0]);
	} else if (funPlot==1) {
		return esfDomPv(p.x, p.y);
	}

	return vec3(0.0, 0.0, 0.0);
}

float areaParam(vec2 p) {
	if (funPlot==0) {
		return gArea(p.x, p.y, param_t[0]);
	} else if (funPlot==1) {
		return esfDomArea(p.x, p.y);
	}

	return 0.0;
}

float curvatureParam(vec2 p) {
	if (funPlot==0) {
		return gK(p.x, p.y, param_t[0]);
	} else if (funPlot==1) {
		return esfDomK(p.x, p.y);
	}

	return 0.0;
}

