
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
float PI2 = 3.1415926;

vec3 g(float u, float v) {
	return 2 *  vec3( cos(v * PI2) *  cos(u * 2 * PI2),  cos(v * PI2) *  sin(u * 2 * PI2),  sin(v * PI2));
}

vec3 gPu(float u, float v) {
	return ( vec3(0) + 2 *  vec3(( cos(v * PI2) * (( -  sin(u * 2 * PI2)) * (2 * PI2))), ( cos(v * PI2) * ( cos(u * 2 * PI2) * (2 * PI2))), 0));
}

vec3 gPv(float u, float v) {
	return ( vec3(0) + 2 *  vec3(((( -  sin(v * PI2)) * PI2) *  cos(u * 2 * PI2)), ((( -  sin(v * PI2)) * PI2) *  sin(u * 2 * PI2)), ( cos(v * PI2) * PI2)));
}

vec3 gNormal(float u, float v) {
	return  normalize( cross( gPu(u, v),  gPv(u, v)));
}

float gArea(float u, float v) {
	return  distance( gPu(u, v),  gPv(u, v));
}

vec3 gPuPu(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(( cos(v * PI2) * (( - ( cos(u * 2 * PI2) * (2 * PI2))) * (2 * PI2))), ( cos(v * PI2) * ((( -  sin(u * 2 * PI2)) * (2 * PI2)) * (2 * PI2))), 0)));
}

vec3 gPvPv(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(((( - ( cos(v * PI2) * PI2)) * PI2) *  cos(u * 2 * PI2)), ((( - ( cos(v * PI2) * PI2)) * PI2) *  sin(u * 2 * PI2)), ((( -  sin(v * PI2)) * PI2) * PI2))));
}

vec3 gPuPv(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(((( -  sin(v * PI2)) * PI2) * (( -  sin(u * 2 * PI2)) * (2 * PI2))), ((( -  sin(v * PI2)) * PI2) * ( cos(u * 2 * PI2) * (2 * PI2))), 0)));
}

float gK(float u, float v) {
	return ( determinant( mat3( gPuPu(u, v),  gPu(u, v),  gPv(u, v))) *  determinant( mat3( gPvPv(u, v),  gPu(u, v),  gPv(u, v))) -  pow( determinant( mat3( gPuPv(u, v),  gPu(u, v),  gPv(u, v))), 2)) /  pow( pow( length( gPu(u, v)), 2) *  pow( length( gPv(u, v)), 2) -  pow( dot( gPu(u, v),  gPv(u, v)), 2), 2);
}

vec3 h(float u, float v) {
	return 2 *  vec3(u, v,  cos(10 * u) +  cos(10 * v));
}

vec3 hPu(float u, float v) {
	return ( vec3(0) + 2 *  vec3(1, 0, (( -  sin(10 * u)) * 10)));
}

vec3 hPv(float u, float v) {
	return ( vec3(0) + 2 *  vec3(0, 1, (( -  sin(10 * v)) * 10)));
}

vec3 hNormal(float u, float v) {
	return  normalize( cross( hPu(u, v),  hPv(u, v)));
}

float hArea(float u, float v) {
	return  distance( hPu(u, v),  hPv(u, v));
}

vec3 hPuPu(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(0, 0, (( - ( cos(10 * u) * 10)) * 10))));
}

vec3 hPvPv(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(0, 0, (( - ( cos(10 * v) * 10)) * 10))));
}

vec3 hPuPv(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(0, 0, 0)));
}

float hK(float u, float v) {
	return ( determinant( mat3( hPuPu(u, v),  hPu(u, v),  hPv(u, v))) *  determinant( mat3( hPvPv(u, v),  hPu(u, v),  hPv(u, v))) -  pow( determinant( mat3( hPuPv(u, v),  hPu(u, v),  hPv(u, v))), 2)) /  pow( pow( length( hPu(u, v)), 2) *  pow( length( hPv(u, v)), 2) -  pow( dot( hPu(u, v),  hPv(u, v)), 2), 2);
}

vec3 f(float u, float v) {
	return  g((u - 0.5) / 2, v - 0.5);
}

vec3 fPu(float u, float v) {
	return ( gPu((u - 0.5) / 2, v - 0.5) * (1 / 2));
}

vec3 fPv(float u, float v) {
	return  gPv((u - 0.5) / 2, v - 0.5);
}

vec3 fNormal(float u, float v) {
	return  normalize( cross( fPu(u, v),  fPv(u, v)));
}

float fArea(float u, float v) {
	return  distance( fPu(u, v),  fPv(u, v));
}

vec3 fPuPu(float u, float v) {
	return (( gPuPu((u - 0.5) / 2, v - 0.5) * (1 / 2)) * (1 / 2));
}

vec3 gPvPu(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(((( -  sin(v * PI2)) * PI2) * (( -  sin(u * 2 * PI2)) * (2 * PI2))), ((( -  sin(v * PI2)) * PI2) * ( cos(u * 2 * PI2) * (2 * PI2))), 0)));
}

vec3 fPvPv(float u, float v) {
	return  gPvPv((u - 0.5) / 2, v - 0.5);
}

vec3 fPuPv(float u, float v) {
	return ( gPuPv((u - 0.5) / 2, v - 0.5) * (1 / 2));
}

float fK(float u, float v) {
	return ( determinant( mat3( fPuPu(u, v),  fPu(u, v),  fPv(u, v))) *  determinant( mat3( fPvPv(u, v),  fPu(u, v),  fPv(u, v))) -  pow( determinant( mat3( fPuPv(u, v),  fPu(u, v),  fPv(u, v))), 2)) /  pow( pow( length( fPu(u, v)), 2) *  pow( length( fPv(u, v)), 2) -  pow( dot( fPu(u, v),  fPv(u, v)), 2), 2);
}

vec3 f2(float u, float v) {
	return  funcionIf(u < 0.51,  f(2 * u, v),  h(2 * u, v));
}

vec3 f2Pu(float u, float v) {
	return  funcionIf(u < 0.51, ( fPu(2 * u, v) * 2), ( hPu(2 * u, v) * 2));
}

vec3 f2Pv(float u, float v) {
	return  funcionIf(u < 0.51,  fPv(2 * u, v),  hPv(2 * u, v));
}

vec3 f2Normal(float u, float v) {
	return  normalize( cross( f2Pu(u, v),  f2Pv(u, v)));
}

float f2Area(float u, float v) {
	return  distance( f2Pu(u, v),  f2Pv(u, v));
}

vec3 f2PuPu(float u, float v) {
	return  funcionIf(u < 0.51, (( fPuPu(2 * u, v) * 2) * 2), (( hPuPu(2 * u, v) * 2) * 2));
}

vec3 hPvPu(float u, float v) {
	return ( vec3(0) + ( vec3(0) + 2 *  vec3(0, 0, 0)));
}

vec3 fPvPu(float u, float v) {
	return ( gPvPu((u - 0.5) / 2, v - 0.5) * (1 / 2));
}

vec3 f2PvPv(float u, float v) {
	return  funcionIf(u < 0.51,  fPvPv(2 * u, v),  hPvPv(2 * u, v));
}

vec3 f2PuPv(float u, float v) {
	return  funcionIf(u < 0.51, ( fPuPv(2 * u, v) * 2), ( hPuPv(2 * u, v) * 2));
}

float f2K(float u, float v) {
	return ( determinant( mat3( f2PuPu(u, v),  f2Pu(u, v),  f2Pv(u, v))) *  determinant( mat3( f2PvPv(u, v),  f2Pu(u, v),  f2Pv(u, v))) -  pow( determinant( mat3( f2PuPv(u, v),  f2Pu(u, v),  f2Pv(u, v))), 2)) /  pow( pow( length( f2Pu(u, v)), 2) *  pow( length( f2Pv(u, v)), 2) -  pow( dot( f2Pu(u, v),  f2Pv(u, v)), 2), 2);
}

vec3 functionParam(vec2 p) {
	if (funPlot==0) {
		return f(p.x, p.y);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 normalParam(vec2 p) {
	if (funPlot==0) {
		return fNormal(p.x, p.y);
	}

	return vec3(0.0, 0.0, 0.0);
}

float areaParam(vec2 p) {
	if (funPlot==0) {
		return fArea(p.x, p.y);
	}

	return 0.0;
}

