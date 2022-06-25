a=0.1;  b=0.26; c=-60;  d=0; V=-61;
maxV = 30;
V_coeff = [140 5 0.04];
name = "bistability";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);

t_end = 300;
tau = 0.25;
t1 = t_end/8; t2 = 216;
dur = 5;
peak = 1.24; rest = 0.24;

current = Step_Current([t1 t1+dur t2 t2+dur ], [peak rest peak rest], rest);
model.compute(tau, current, 0, t_end,"figures/model_P_bistability.fig");