//Ejemplo    
h(w : real) : real = w + E;

const_new : real = E^2 + PI;

mat_rot(t : real)	: mat3 = mat3(vec3(cos(t), sin(t), 0), vec3(-sin(t), cos(t), 0), vec3(0,0,1));

est_pos(a : real) : bool = if a>0 then true else false;

x(u,v : real) 	: real = if v>1 then cos(PI*u) else v*cos(PI*u);
y(u,v : real) 	: real = if v>1 then sen(PI*u) else (if v<1 then v*sen(PI*u) else sin(PI*u));
z(u,v : real,
  t1,t2 : real) : real = t1*h(v+t2);

f(u,v : real,
  t1,t2 : real) : real = vec3(x(u,v), y(u,v), z(u,v,t1,t2) + const_new);
  
g(u,v : real,
  t1 : real) 	: real = mat_rot(t1) * vec3(x(u,v), y(u,v), z(u,v,0.1,0.5) + mat_rot(t1)[0][0]);

plot f, g;  // Las primeras variables siempre van a ser las que recorren el cuadrado [0,1]x[0,1], 
            //el resto es para controlar las homotopías (modificables en tiempo de ejecución)
