
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
float compzWaves(float u, float v, float t0) {
	return 0.1 *  cos(u * u + v * v - 2 * PI * t0);
}

vec3 f(float u, float v, float t0, float t1) {
	return vec3(4 *  vec3(u, t1 *  compzWaves(4 * u, 4 * v, t0) / (u * u + v * v + 1.0), v));
}

float compzWavesPu(float u, float v, float t0) {
	return (0.1 * (( -  sin(u * u + v * v - 2 * PI * t0)) * (u + u)));
}

float compzWavesPv(float u, float v, float t0) {
	return (0.1 * (( -  sin(u * u + v * v - 2 * PI * t0)) * (v + v)));
}

float compzWavesPt0(float u, float v, float t0) {
	return (0.1 * (( -  sin(u * u + v * v - 2 * PI * t0)) * ( - (2 * PI))));
}

vec3 fPu(float u, float v, float t0, float t1) {
	return vec3(( vec3(0) + 4 *  vec3(1, ((t1 * ( compzWavesPu(4 * u, 4 * v, t0) * 4)) / (u * u + v * v + 1.0) - t1 *  compzWaves(4 * u, 4 * v, t0) * (u + u) / ( pow((u * u + v * v + 1.0), 2))), 0)));
}

vec3 fPv(float u, float v, float t0, float t1) {
	return vec3(( vec3(0) + 4 *  vec3(0, ((t1 * ( compzWavesPv(4 * u, 4 * v, t0) * 4)) / (u * u + v * v + 1.0) - t1 *  compzWaves(4 * u, 4 * v, t0) * (v + v) / ( pow((u * u + v * v + 1.0), 2))), 1)));
}

vec3 fNormal(float u, float v, float t0, float t1) {
	return vec3( normalize( cross( fPu(u, v, t0, t1),  fPv(u, v, t0, t1))));
}

float fArea(float u, float v, float t0, float t1) {
	return  distance( fPu(u, v, t0, t1),  fPv(u, v, t0, t1));
}

float compzWavesPuPu(float u, float v, float t0) {
	return (0.1 * (( - ( cos(u * u + v * v - 2 * PI * t0) * (u + u))) * (u + u) + ( -  sin(u * u + v * v - 2 * PI * t0)) * (1 + 1)));
}

float compzWavesPuPv(float u, float v, float t0) {
	return (0.1 * (( - ( cos(u * u + v * v - 2 * PI * t0) * (v + v))) * (u + u)));
}

float compzWavesPuPt0(float u, float v, float t0) {
	return (0.1 * (( - ( cos(u * u + v * v - 2 * PI * t0) * ( - (2 * PI)))) * (u + u)));
}

vec3 fPuPu(float u, float v, float t0, float t1) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (((t1 * (( compzWavesPuPu(4 * u, 4 * v, t0) * 4) * 4)) / (u * u + v * v + 1.0) - (t1 * ( compzWavesPu(4 * u, 4 * v, t0) * 4)) * (u + u) / ( pow((u * u + v * v + 1.0), 2))) - (((t1 * ( compzWavesPu(4 * u, 4 * v, t0) * 4)) * (u + u) + t1 *  compzWaves(4 * u, 4 * v, t0) * (1 + 1)) / ( pow((u * u + v * v + 1.0), 2)) - t1 *  compzWaves(4 * u, 4 * v, t0) * (u + u) * (2 *  pow((u * u + v * v + 1.0), 1.000000) * (u + u)) / ( pow(( pow((u * u + v * v + 1.0), 2)), 2)))), 0))));
}

float compzWavesPvPu(float u, float v, float t0) {
	return (0.1 * (( - ( cos(u * u + v * v - 2 * PI * t0) * (u + u))) * (v + v)));
}

float compzWavesPvPv(float u, float v, float t0) {
	return (0.1 * (( - ( cos(u * u + v * v - 2 * PI * t0) * (v + v))) * (v + v) + ( -  sin(u * u + v * v - 2 * PI * t0)) * (1 + 1)));
}

float compzWavesPvPt0(float u, float v, float t0) {
	return (0.1 * (( - ( cos(u * u + v * v - 2 * PI * t0) * ( - (2 * PI)))) * (v + v)));
}

vec3 fPvPv(float u, float v, float t0, float t1) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (((t1 * (( compzWavesPvPv(4 * u, 4 * v, t0) * 4) * 4)) / (u * u + v * v + 1.0) - (t1 * ( compzWavesPv(4 * u, 4 * v, t0) * 4)) * (v + v) / ( pow((u * u + v * v + 1.0), 2))) - (((t1 * ( compzWavesPv(4 * u, 4 * v, t0) * 4)) * (v + v) + t1 *  compzWaves(4 * u, 4 * v, t0) * (1 + 1)) / ( pow((u * u + v * v + 1.0), 2)) - t1 *  compzWaves(4 * u, 4 * v, t0) * (v + v) * (2 *  pow((u * u + v * v + 1.0), 1.000000) * (v + v)) / ( pow(( pow((u * u + v * v + 1.0), 2)), 2)))), 0))));
}

vec3 fPuPv(float u, float v, float t0, float t1) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (((t1 * (( compzWavesPuPv(4 * u, 4 * v, t0) * 4) * 4)) / (u * u + v * v + 1.0) - (t1 * ( compzWavesPu(4 * u, 4 * v, t0) * 4)) * (v + v) / ( pow((u * u + v * v + 1.0), 2))) - (((t1 * ( compzWavesPv(4 * u, 4 * v, t0) * 4)) * (u + u)) / ( pow((u * u + v * v + 1.0), 2)) - t1 *  compzWaves(4 * u, 4 * v, t0) * (u + u) * (2 *  pow((u * u + v * v + 1.0), 1.000000) * (v + v)) / ( pow(( pow((u * u + v * v + 1.0), 2)), 2)))), 0))));
}

float fK(float u, float v, float t0, float t1) {
	return ( determinant( mat3( fPuPu(u, v, t0, t1),  fPu(u, v, t0, t1),  fPv(u, v, t0, t1))) *  determinant( mat3( fPvPv(u, v, t0, t1),  fPu(u, v, t0, t1),  fPv(u, v, t0, t1))) -  pow( determinant( mat3( fPuPv(u, v, t0, t1),  fPu(u, v, t0, t1),  fPv(u, v, t0, t1))), 2)) /  pow( pow( length( fPu(u, v, t0, t1)), 2) *  pow( length( fPv(u, v, t0, t1)), 2) -  pow( dot( fPu(u, v, t0, t1),  fPv(u, v, t0, t1)), 2), 2);
}

vec3 h(float u, float v, float t0, float t1) {
	return vec3( f(4 * (u - 0.5), 4 * (v - 0.5), t0, t1));
}

vec3 fPt0(float u, float v, float t0, float t1) {
	return vec3(( vec3(0) + 4 *  vec3(0, ((t1 *  compzWavesPt0(4 * u, 4 * v, t0)) / (u * u + v * v + 1.0)), 0)));
}

vec3 fPt1(float u, float v, float t0, float t1) {
	return vec3(( vec3(0) + 4 *  vec3(0, ( compzWaves(4 * u, 4 * v, t0) / (u * u + v * v + 1.0)), 0)));
}

vec3 hPu(float u, float v, float t0, float t1) {
	return vec3(( fPu(4 * (u - 0.5), 4 * (v - 0.5), t0, t1) * 4));
}

vec3 hPv(float u, float v, float t0, float t1) {
	return vec3(( fPv(4 * (u - 0.5), 4 * (v - 0.5), t0, t1) * 4));
}

vec3 hNormal(float u, float v, float t0, float t1) {
	return vec3( normalize( cross( hPu(u, v, t0, t1),  hPv(u, v, t0, t1))));
}

float hArea(float u, float v, float t0, float t1) {
	return  distance( hPu(u, v, t0, t1),  hPv(u, v, t0, t1));
}

vec3 fPuPt0(float u, float v, float t0, float t1) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (((t1 * ( compzWavesPuPt0(4 * u, 4 * v, t0) * 4)) / (u * u + v * v + 1.0)) - (((t1 *  compzWavesPt0(4 * u, 4 * v, t0)) * (u + u)) / ( pow((u * u + v * v + 1.0), 2)))), 0))));
}

vec3 fPuPt1(float u, float v, float t0, float t1) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, ((( compzWavesPu(4 * u, 4 * v, t0) * 4) / (u * u + v * v + 1.0)) - (( compzWaves(4 * u, 4 * v, t0) * (u + u)) / ( pow((u * u + v * v + 1.0), 2)))), 0))));
}

vec3 hPuPu(float u, float v, float t0, float t1) {
	return vec3((( fPuPu(4 * (u - 0.5), 4 * (v - 0.5), t0, t1) * 4) * 4));
}

vec3 fPvPu(float u, float v, float t0, float t1) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (((t1 * (( compzWavesPvPu(4 * u, 4 * v, t0) * 4) * 4)) / (u * u + v * v + 1.0) - (t1 * ( compzWavesPv(4 * u, 4 * v, t0) * 4)) * (u + u) / ( pow((u * u + v * v + 1.0), 2))) - (((t1 * ( compzWavesPu(4 * u, 4 * v, t0) * 4)) * (v + v)) / ( pow((u * u + v * v + 1.0), 2)) - t1 *  compzWaves(4 * u, 4 * v, t0) * (v + v) * (2 *  pow((u * u + v * v + 1.0), 1.000000) * (u + u)) / ( pow(( pow((u * u + v * v + 1.0), 2)), 2)))), 0))));
}

vec3 fPvPt0(float u, float v, float t0, float t1) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, (((t1 * ( compzWavesPvPt0(4 * u, 4 * v, t0) * 4)) / (u * u + v * v + 1.0)) - (((t1 *  compzWavesPt0(4 * u, 4 * v, t0)) * (v + v)) / ( pow((u * u + v * v + 1.0), 2)))), 0))));
}

vec3 fPvPt1(float u, float v, float t0, float t1) {
	return vec3(( vec3(0) + ( vec3(0) + 4 *  vec3(0, ((( compzWavesPv(4 * u, 4 * v, t0) * 4) / (u * u + v * v + 1.0)) - (( compzWaves(4 * u, 4 * v, t0) * (v + v)) / ( pow((u * u + v * v + 1.0), 2)))), 0))));
}

vec3 hPvPv(float u, float v, float t0, float t1) {
	return vec3((( fPvPv(4 * (u - 0.5), 4 * (v - 0.5), t0, t1) * 4) * 4));
}

vec3 hPuPv(float u, float v, float t0, float t1) {
	return vec3((( fPuPv(4 * (u - 0.5), 4 * (v - 0.5), t0, t1) * 4) * 4));
}

float hK(float u, float v, float t0, float t1) {
	return ( determinant( mat3( hPuPu(u, v, t0, t1),  hPu(u, v, t0, t1),  hPv(u, v, t0, t1))) *  determinant( mat3( hPvPv(u, v, t0, t1),  hPu(u, v, t0, t1),  hPv(u, v, t0, t1))) -  pow( determinant( mat3( hPuPv(u, v, t0, t1),  hPu(u, v, t0, t1),  hPv(u, v, t0, t1))), 2)) /  pow( pow( length( hPu(u, v, t0, t1)), 2) *  pow( length( hPv(u, v, t0, t1)), 2) -  pow( dot( hPu(u, v, t0, t1),  hPv(u, v, t0, t1)), 2), 2);
}

float r = 0.75;

float compx(float u, float v) {
	return r *  cos(v * PI) *  cos(u * 2 * PI);
}

float compy(float u, float v) {
	return r *  cos(v * PI) *  sin(u * 2 * PI);
}

float compz(float u, float v) {
	return r *  sin(v * PI);
}

vec3 esfera(float u, float v, float t0, float t1) {
	return vec3( vec3( compx(u, v),  compy(u, v) + 4 * t1 *  compzWaves(0, 0, t0),  compz(u, v)));
}

float compxPu(float u, float v) {
	return (r *  cos(v * PI) * (( -  sin(u * 2 * PI)) * (2 * PI)));
}

float compxPv(float u, float v) {
	return ((r * (( -  sin(v * PI)) * PI)) *  cos(u * 2 * PI));
}

float compyPu(float u, float v) {
	return (r *  cos(v * PI) * ( cos(u * 2 * PI) * (2 * PI)));
}

float compyPv(float u, float v) {
	return ((r * (( -  sin(v * PI)) * PI)) *  sin(u * 2 * PI));
}

float compzPu(float u, float v) {
	return 0;
}

float compzPv(float u, float v) {
	return (r * ( cos(v * PI) * PI));
}

vec3 esferaPu(float u, float v, float t0, float t1) {
	return vec3( vec3( compxPu(u, v),  compyPu(u, v),  compzPu(u, v)));
}

vec3 esferaPv(float u, float v, float t0, float t1) {
	return vec3( vec3( compxPv(u, v),  compyPv(u, v),  compzPv(u, v)));
}

vec3 esferaNormal(float u, float v, float t0, float t1) {
	return vec3( normalize( cross( esferaPu(u, v, t0, t1),  esferaPv(u, v, t0, t1))));
}

float esferaArea(float u, float v, float t0, float t1) {
	return  distance( esferaPu(u, v, t0, t1),  esferaPv(u, v, t0, t1));
}

float compxPuPu(float u, float v) {
	return (r *  cos(v * PI) * (( - ( cos(u * 2 * PI) * (2 * PI))) * (2 * PI)));
}

float compxPuPv(float u, float v) {
	return ((r * (( -  sin(v * PI)) * PI)) * (( -  sin(u * 2 * PI)) * (2 * PI)));
}

float compyPuPu(float u, float v) {
	return (r *  cos(v * PI) * ((( -  sin(u * 2 * PI)) * (2 * PI)) * (2 * PI)));
}

float compyPuPv(float u, float v) {
	return ((r * (( -  sin(v * PI)) * PI)) * ( cos(u * 2 * PI) * (2 * PI)));
}

float compzPuPu(float u, float v) {
	return 0;
}

float compzPuPv(float u, float v) {
	return 0;
}

vec3 esferaPuPu(float u, float v, float t0, float t1) {
	return vec3( vec3( compxPuPu(u, v),  compyPuPu(u, v),  compzPuPu(u, v)));
}

float compxPvPu(float u, float v) {
	return ((r * (( -  sin(v * PI)) * PI)) * (( -  sin(u * 2 * PI)) * (2 * PI)));
}

float compxPvPv(float u, float v) {
	return ((r * (( - ( cos(v * PI) * PI)) * PI)) *  cos(u * 2 * PI));
}

float compyPvPu(float u, float v) {
	return ((r * (( -  sin(v * PI)) * PI)) * ( cos(u * 2 * PI) * (2 * PI)));
}

float compyPvPv(float u, float v) {
	return ((r * (( - ( cos(v * PI) * PI)) * PI)) *  sin(u * 2 * PI));
}

float compzPvPu(float u, float v) {
	return 0;
}

float compzPvPv(float u, float v) {
	return (r * ((( -  sin(v * PI)) * PI) * PI));
}

vec3 esferaPvPv(float u, float v, float t0, float t1) {
	return vec3( vec3( compxPvPv(u, v),  compyPvPv(u, v),  compzPvPv(u, v)));
}

vec3 esferaPuPv(float u, float v, float t0, float t1) {
	return vec3( vec3( compxPuPv(u, v),  compyPuPv(u, v),  compzPuPv(u, v)));
}

float esferaK(float u, float v, float t0, float t1) {
	return ( determinant( mat3( esferaPuPu(u, v, t0, t1),  esferaPu(u, v, t0, t1),  esferaPv(u, v, t0, t1))) *  determinant( mat3( esferaPvPv(u, v, t0, t1),  esferaPu(u, v, t0, t1),  esferaPv(u, v, t0, t1))) -  pow( determinant( mat3( esferaPuPv(u, v, t0, t1),  esferaPu(u, v, t0, t1),  esferaPv(u, v, t0, t1))), 2)) /  pow( pow( length( esferaPu(u, v, t0, t1)), 2) *  pow( length( esferaPv(u, v, t0, t1)), 2) -  pow( dot( esferaPu(u, v, t0, t1),  esferaPv(u, v, t0, t1)), 2), 2);
}

vec3 g(float u, float v, float t0, float t1) {
	return vec3( esfera(u - 0.5,  - (v - 0.5), t0, t1));
}

vec3 esferaPt0(float u, float v, float t0, float t1) {
	return vec3( vec3(0, (4 * t1 *  compzWavesPt0(0, 0, t0)), 0));
}

vec3 esferaPt1(float u, float v, float t0, float t1) {
	return vec3( vec3(0, (4 *  compzWaves(0, 0, t0)), 0));
}

vec3 gPu(float u, float v, float t0, float t1) {
	return vec3( esferaPu(u - 0.5,  - (v - 0.5), t0, t1));
}

vec3 gPv(float u, float v, float t0, float t1) {
	return vec3(( esferaPv(u - 0.5,  - (v - 0.5), t0, t1) * ( - 1)));
}

vec3 gNormal(float u, float v, float t0, float t1) {
	return vec3( normalize( cross( gPu(u, v, t0, t1),  gPv(u, v, t0, t1))));
}

float gArea(float u, float v, float t0, float t1) {
	return  distance( gPu(u, v, t0, t1),  gPv(u, v, t0, t1));
}

vec3 esferaPuPt0(float u, float v, float t0, float t1) {
	return vec3( vec3(0, 0, 0));
}

vec3 esferaPuPt1(float u, float v, float t0, float t1) {
	return vec3( vec3(0, 0, 0));
}

vec3 gPuPu(float u, float v, float t0, float t1) {
	return vec3( esferaPuPu(u - 0.5,  - (v - 0.5), t0, t1));
}

vec3 esferaPvPu(float u, float v, float t0, float t1) {
	return vec3( vec3( compxPvPu(u, v),  compyPvPu(u, v),  compzPvPu(u, v)));
}

vec3 esferaPvPt0(float u, float v, float t0, float t1) {
	return vec3( vec3(0, 0, 0));
}

vec3 esferaPvPt1(float u, float v, float t0, float t1) {
	return vec3( vec3(0, 0, 0));
}

vec3 gPvPv(float u, float v, float t0, float t1) {
	return vec3((( esferaPvPv(u - 0.5,  - (v - 0.5), t0, t1) * ( - 1)) * ( - 1)));
}

vec3 gPuPv(float u, float v, float t0, float t1) {
	return vec3(( esferaPuPv(u - 0.5,  - (v - 0.5), t0, t1) * ( - 1)));
}

float gK(float u, float v, float t0, float t1) {
	return ( determinant( mat3( gPuPu(u, v, t0, t1),  gPu(u, v, t0, t1),  gPv(u, v, t0, t1))) *  determinant( mat3( gPvPv(u, v, t0, t1),  gPu(u, v, t0, t1),  gPv(u, v, t0, t1))) -  pow( determinant( mat3( gPuPv(u, v, t0, t1),  gPu(u, v, t0, t1),  gPv(u, v, t0, t1))), 2)) /  pow( pow( length( gPu(u, v, t0, t1)), 2) *  pow( length( gPv(u, v, t0, t1)), 2) -  pow( dot( gPu(u, v, t0, t1),  gPv(u, v, t0, t1)), 2), 2);
}

vec3 functionParam(vec2 p) {
	if (funPlot==0) {
		return h(p.x, p.y, param_t[0], param_t[1]);
	} else if (funPlot==1) {
		return g(p.x, p.y, param_t[0], param_t[1]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 normalParam(vec2 p) {
	if (funPlot==0) {
		return hNormal(p.x, p.y, param_t[0], param_t[1]);
	} else if (funPlot==1) {
		return gNormal(p.x, p.y, param_t[0], param_t[1]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 tangentParam(vec2 p) {
	if (funPlot==0) {
		return hPu(p.x, p.y, param_t[0], param_t[1]);
	} else if (funPlot==1) {
		return gPu(p.x, p.y, param_t[0], param_t[1]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 cotangentParam(vec2 p) {
	if (funPlot==0) {
		return hPv(p.x, p.y, param_t[0], param_t[1]);
	} else if (funPlot==1) {
		return gPv(p.x, p.y, param_t[0], param_t[1]);
	}

	return vec3(0.0, 0.0, 0.0);
}

float areaParam(vec2 p) {
	if (funPlot==0) {
		return hArea(p.x, p.y, param_t[0], param_t[1]);
	} else if (funPlot==1) {
		return gArea(p.x, p.y, param_t[0], param_t[1]);
	}

	return 0.0;
}

float curvatureParam(vec2 p) {
	if (funPlot==0) {
		return hK(p.x, p.y, param_t[0], param_t[1]);
	} else if (funPlot==1) {
		return gK(p.x, p.y, param_t[0], param_t[1]);
	}

	return 0.0;
}

