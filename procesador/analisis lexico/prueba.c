//Ejemplo    
h(w : real) : real = w + E;

var_x : real = E^2 + PI;
var_id : mat3;
var_id[0] = vec3(1,0,0);
var_id[1] = vec3(0,1,0);
var_id[2] = vec3(0,0,1);

mat_rot(t : real)	: mat3 = mat3(vec3(cos(t), sin(t), 0), vec3(-sin(t), cos(t), 0), vec3(0,0,1));

est_pos(a : real) : bool = a>0;

x(u,v : real) 	: real = if v>1 then cos(PI*u) else v*cos(PI*u);
y(u,v : real) 	: real = if v>1 then sen(PI*u) else (if v<1 then v*sen(PI*u) else sin(PI*u));
z(u,v : real,
  t1,t2 : real) : real = t1*h(v+t2);

f(u,v : real,
  t1,t2 : real) : real = vec3(x(u,v), y(u,v), z(u,v,t1,t2) + var_x);
  
g(u,v : real,
  t1 : real) 	: real = mat_rot(t1) * vec3(x(u,v), y(u,v), z(u,v,0.1,0.5) + var_x);

plot f, g;  // Las primeras variables siempre van a ser las que recorren el cuadrado [0,1]x[0,1], 
            //el resto es para controlar las homotopías (modificables en tiempo de ejecución)
