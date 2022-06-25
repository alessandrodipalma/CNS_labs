a=1;  b=0.2; c=-60;  d=-21;
V=-70;
maxV = 30;
V_coeff = [140 5 0.04];
name = "Depolarizing after potential";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);

t_end = 50;
tau = 0.1;
t1 = 10;
dur = 5;
peak = 20; rest = 0;

current = Step_Current([t1-1 t1+1], [peak rest], rest);
model.compute(tau, current, 0, t_end, "figures/model_Q_depolarizing_after_potential.fig");