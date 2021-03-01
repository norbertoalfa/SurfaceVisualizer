double h(double w) {
	return w + E;
}

mat3 mat_rot(double t) {
	return  mat3( vec3( cos(t),  sin(t), 0),  vec3( -  sin(t),  cos(t), 0),  vec3(0, 0, 1));
}

bool est_pos(double a) {
	return  funcionIf(a > 0, true, false);
}

double x(double u, double v) {
	return  funcionIf(v > 1,  cos(PI * u), v *  cos(PI * u));
}

double y(double u, double v) {
	return  funcionIf(v > 1,  sin(PI * u),  funcionIf(v < 1, v *  sin(PI * u),  sin(PI * u)));
}

double z(double u, double v, double t1, double t2) {
	return t1 *  h(v + t2);
}

vec3 f(double u, double v, double t1, double t2) {
	return  vec3( x(u, v),  y(u, v),  z(u, v, t1, t2) + const_new);
}

vec3 g(double u, double v, double t1) {
	return  mat_rot(t1) *  vec3( x(u, v),  y(u, v),  z(u, v, 0.1, 0.5) +  mat_rot(t1)[0][0]);
}

