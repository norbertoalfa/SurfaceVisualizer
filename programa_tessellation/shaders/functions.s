
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
	return vec3(2 *  vec3( cos(v * PI2) *  cos(u * 2 * PI2),  cos(v * PI2) *  sin(u * 2 * PI2),  sin(v * PI2)));
}

vec3 gPu(float u, float v) {
	return vec3(( vec3(0) + 2 *  vec3(( cos(v * PI2) * (( -  sin(u * 2 * PI2)) * (2 * PI2))), ( cos(v * PI2) * ( cos(u * 2 * PI2) * (2 * PI2))), 0)));
}

vec3 gPv(float u, float v) {
	return vec3(( vec3(0) + 2 *  vec3(((( -  sin(v * PI2)) * PI2) *  cos(u * 2 * PI2)), ((( -  sin(v * PI2)) * PI2) *  sin(u * 2 * PI2)), ( cos(v * PI2) * PI2))));
}

vec3 gNormal(float u, float v) {
	return vec3( normalize( cross( gPu(u, v),  gPv(u, v))));
}

float gArea(float u, float v) {
	return  distance( gPu(u, v),  gPv(u, v));
}

vec3 gPuPu(float u, float v) {
	return vec3(( vec3(0) + ( vec3(0) + 2 *  vec3(( cos(v * PI2) * (( - ( cos(u * 2 * PI2) * (2 * PI2))) * (2 * PI2))), ( cos(v * PI2) * ((( -  sin(u * 2 * PI2)) * (2 * PI2)) * (2 * PI2))), 0))));
}

vec3 gPvPv(float u, float v) {
	return vec3(( vec3(0) + ( vec3(0) + 2 *  vec3(((( - ( cos(v * PI2) * PI2)) * PI2) *  cos(u * 2 * PI2)), ((( - ( cos(v * PI2) * PI2)) * PI2) *  sin(u * 2 * PI2)), ((( -  sin(v * PI2)) * PI2) * PI2)))));
}

vec3 gPuPv(float u, float v) {
	return vec3(( vec3(0) + ( vec3(0) + 2 *  vec3(((( -  sin(v * PI2)) * PI2) * (( -  sin(u * 2 * PI2)) * (2 * PI2))), ((( -  sin(v * PI2)) * PI2) * ( cos(u * 2 * PI2) * (2 * PI2))), 0))));
}

float gK(float u, float v) {
	return ( determinant( mat3( gPuPu(u, v),  gPu(u, v),  gPv(u, v))) *  determinant( mat3( gPvPv(u, v),  gPu(u, v),  gPv(u, v))) -  pow( determinant( mat3( gPuPv(u, v),  gPu(u, v),  gPv(u, v))), 2)) /  pow( pow( length( gPu(u, v)), 2) *  pow( length( gPv(u, v)), 2) -  pow( dot( gPu(u, v),  gPv(u, v)), 2), 2);
}

vec3 h(float u, float v) {
	return vec3(2 *  vec3(u, v,  cos(10 * u) +  cos(10 * v)));
}

vec3 hPu(float u, float v) {
	return vec3(( vec3(0) + 2 *  vec3(1, 0, (( -  sin(10 * u)) * 10))));
}

vec3 hPv(float u, float v) {
	return vec3(( vec3(0) + 2 *  vec3(0, 1, (( -  sin(10 * v)) * 10))));
}

vec3 hNormal(float u, float v) {
	return vec3( normalize( cross( hPu(u, v),  hPv(u, v))));
}

float hArea(float u, float v) {
	return  distance( hPu(u, v),  hPv(u, v));
}

vec3 hPuPu(float u, float v) {
	return vec3(( vec3(0) + ( vec3(0) + 2 *  vec3(0, 0, (( - ( cos(10 * u) * 10)) * 10)))));
}

vec3 hPvPv(float u, float v) {
	return vec3(( vec3(0) + ( vec3(0) + 2 *  vec3(0, 0, (( - ( cos(10 * v) * 10)) * 10)))));
}

vec3 hPuPv(float u, float v) {
	return vec3(( vec3(0) + ( vec3(0) + 2 *  vec3(0, 0, 0))));
}

float hK(float u, float v) {
	return ( determinant( mat3( hPuPu(u, v),  hPu(u, v),  hPv(u, v))) *  determinant( mat3( hPvPv(u, v),  hPu(u, v),  hPv(u, v))) -  pow( determinant( mat3( hPuPv(u, v),  hPu(u, v),  hPv(u, v))), 2)) /  pow( pow( length( hPu(u, v)), 2) *  pow( length( hPv(u, v)), 2) -  pow( dot( hPu(u, v),  hPv(u, v)), 2), 2);
}

vec3 f(float u, float v) {
	return vec3( g(u - 0.5, v - 0.5));
}

vec3 fPu(float u, float v) {
	return vec3( gPu(u - 0.5, v - 0.5));
}

vec3 fPv(float u, float v) {
	return vec3( gPv(u - 0.5, v - 0.5));
}

vec3 fNormal(float u, float v) {
	return vec3( normalize( cross( fPu(u, v),  fPv(u, v))));
}

float fArea(float u, float v) {
	return  distance( fPu(u, v),  fPv(u, v));
}

vec3 fPuPu(float u, float v) {
	return vec3( gPuPu(u - 0.5, v - 0.5));
}

vec3 gPvPu(float u, float v) {
	return vec3(( vec3(0) + ( vec3(0) + 2 *  vec3(((( -  sin(v * PI2)) * PI2) * (( -  sin(u * 2 * PI2)) * (2 * PI2))), ((( -  sin(v * PI2)) * PI2) * ( cos(u * 2 * PI2) * (2 * PI2))), 0))));
}

vec3 fPvPv(float u, float v) {
	return vec3( gPvPv(u - 0.5, v - 0.5));
}

vec3 fPuPv(float u, float v) {
	return vec3( gPuPv(u - 0.5, v - 0.5));
}

float fK(float u, float v) {
	return ( determinant( mat3( fPuPu(u, v),  fPu(u, v),  fPv(u, v))) *  determinant( mat3( fPvPv(u, v),  fPu(u, v),  fPv(u, v))) -  pow( determinant( mat3( fPuPv(u, v),  fPu(u, v),  fPv(u, v))), 2)) /  pow( pow( length( fPu(u, v)), 2) *  pow( length( fPv(u, v)), 2) -  pow( dot( fPu(u, v),  fPv(u, v)), 2), 2);
}

vec3 oscPlane(float u, float v, float t0, float t1) {
	return vec3(u *  fPu(t0, t1) + v *  fPv(t0, t1) +  f(t0, t1));
}

vec3 fPvPu(float u, float v) {
	return vec3( gPvPu(u - 0.5, v - 0.5));
}

vec3 oscPlanePu(float u, float v, float t0, float t1) {
	return vec3( fPu(t0, t1));
}

vec3 oscPlanePv(float u, float v, float t0, float t1) {
	return vec3( fPv(t0, t1));
}

vec3 oscPlaneNormal(float u, float v, float t0, float t1) {
	return vec3( normalize( cross( oscPlanePu(u, v, t0, t1),  oscPlanePv(u, v, t0, t1))));
}

float oscPlaneArea(float u, float v, float t0, float t1) {
	return  distance( oscPlanePu(u, v, t0, t1),  oscPlanePv(u, v, t0, t1));
}

vec3 oscPlanePuPu(float u, float v, float t0, float t1) {
	return vec3(0);
}

vec3 oscPlanePvPv(float u, float v, float t0, float t1) {
	return vec3(0);
}

vec3 oscPlanePuPv(float u, float v, float t0, float t1) {
	return vec3(0);
}

float oscPlaneK(float u, float v, float t0, float t1) {
	return ( determinant( mat3( oscPlanePuPu(u, v, t0, t1),  oscPlanePu(u, v, t0, t1),  oscPlanePv(u, v, t0, t1))) *  determinant( mat3( oscPlanePvPv(u, v, t0, t1),  oscPlanePu(u, v, t0, t1),  oscPlanePv(u, v, t0, t1))) -  pow( determinant( mat3( oscPlanePuPv(u, v, t0, t1),  oscPlanePu(u, v, t0, t1),  oscPlanePv(u, v, t0, t1))), 2)) /  pow( pow( length( oscPlanePu(u, v, t0, t1)), 2) *  pow( length( oscPlanePv(u, v, t0, t1)), 2) -  pow( dot( oscPlanePu(u, v, t0, t1),  oscPlanePv(u, v, t0, t1)), 2), 2);
}

vec3 oscPlaneMed(float u, float v, float t0, float t1) {
	return vec3( oscPlane(u - 0.5, v - 0.5, t0, t1));
}

vec3 oscPlanePt0(float u, float v, float t0, float t1) {
	return vec3((((u *  fPuPu(t0, t1)) + (v *  fPvPu(t0, t1))) +  fPu(t0, t1)));
}

vec3 oscPlanePt1(float u, float v, float t0, float t1) {
	return vec3((((u *  fPuPv(t0, t1)) + (v *  fPvPv(t0, t1))) +  fPv(t0, t1)));
}

vec3 oscPlaneMedPu(float u, float v, float t0, float t1) {
	return vec3( oscPlanePu(u - 0.5, v - 0.5, t0, t1));
}

vec3 oscPlaneMedPv(float u, float v, float t0, float t1) {
	return vec3( oscPlanePv(u - 0.5, v - 0.5, t0, t1));
}

vec3 oscPlaneMedNormal(float u, float v, float t0, float t1) {
	return vec3( normalize( cross( oscPlaneMedPu(u, v, t0, t1),  oscPlaneMedPv(u, v, t0, t1))));
}

float oscPlaneMedArea(float u, float v, float t0, float t1) {
	return  distance( oscPlaneMedPu(u, v, t0, t1),  oscPlaneMedPv(u, v, t0, t1));
}

vec3 oscPlanePuPt0(float u, float v, float t0, float t1) {
	return vec3( fPuPu(t0, t1));
}

vec3 oscPlanePuPt1(float u, float v, float t0, float t1) {
	return vec3( fPuPv(t0, t1));
}

vec3 oscPlaneMedPuPu(float u, float v, float t0, float t1) {
	return vec3( oscPlanePuPu(u - 0.5, v - 0.5, t0, t1));
}

vec3 oscPlanePvPu(float u, float v, float t0, float t1) {
	return vec3(0);
}

vec3 oscPlanePvPt0(float u, float v, float t0, float t1) {
	return vec3( fPvPu(t0, t1));
}

vec3 oscPlanePvPt1(float u, float v, float t0, float t1) {
	return vec3( fPvPv(t0, t1));
}

vec3 oscPlaneMedPvPv(float u, float v, float t0, float t1) {
	return vec3( oscPlanePvPv(u - 0.5, v - 0.5, t0, t1));
}

vec3 oscPlaneMedPuPv(float u, float v, float t0, float t1) {
	return vec3( oscPlanePuPv(u - 0.5, v - 0.5, t0, t1));
}

float oscPlaneMedK(float u, float v, float t0, float t1) {
	return ( determinant( mat3( oscPlaneMedPuPu(u, v, t0, t1),  oscPlaneMedPu(u, v, t0, t1),  oscPlaneMedPv(u, v, t0, t1))) *  determinant( mat3( oscPlaneMedPvPv(u, v, t0, t1),  oscPlaneMedPu(u, v, t0, t1),  oscPlaneMedPv(u, v, t0, t1))) -  pow( determinant( mat3( oscPlaneMedPuPv(u, v, t0, t1),  oscPlaneMedPu(u, v, t0, t1),  oscPlaneMedPv(u, v, t0, t1))), 2)) /  pow( pow( length( oscPlaneMedPu(u, v, t0, t1)), 2) *  pow( length( oscPlaneMedPv(u, v, t0, t1)), 2) -  pow( dot( oscPlaneMedPu(u, v, t0, t1),  oscPlaneMedPv(u, v, t0, t1)), 2), 2);
}

vec3 functionParam(vec2 p) {
	if (funPlot==0) {
		return f(p.x, p.y);
	} else if (funPlot==1) {
		return oscPlaneMed(p.x, p.y, param_t[0], param_t[1]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 normalParam(vec2 p) {
	if (funPlot==0) {
		return fNormal(p.x, p.y);
	} else if (funPlot==1) {
		return oscPlaneMedNormal(p.x, p.y, param_t[0], param_t[1]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 tangentParam(vec2 p) {
	if (funPlot==0) {
		return fPu(p.x, p.y);
	} else if (funPlot==1) {
		return oscPlaneMedPu(p.x, p.y, param_t[0], param_t[1]);
	}

	return vec3(0.0, 0.0, 0.0);
}

vec3 cotangentParam(vec2 p) {
	if (funPlot==0) {
		return fPv(p.x, p.y);
	} else if (funPlot==1) {
		return oscPlaneMedPv(p.x, p.y, param_t[0], param_t[1]);
	}

	return vec3(0.0, 0.0, 0.0);
}

float areaParam(vec2 p) {
	if (funPlot==0) {
		return fArea(p.x, p.y);
	} else if (funPlot==1) {
		return oscPlaneMedArea(p.x, p.y, param_t[0], param_t[1]);
	}

	return 0.0;
}

float curvatureParam(vec2 p) {
	if (funPlot==0) {
		return fK(p.x, p.y);
	} else if (funPlot==1) {
		return oscPlaneMedK(p.x, p.y, param_t[0], param_t[1]);
	}

	return 0.0;
}

