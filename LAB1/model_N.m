a=0.03; b=0.25; c=-52;  d=0;
V=-64;
maxV = 30;
V_coeff = [140 5 0.04];
name = "rebound burst";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);

t_end = 200;
t1 = 20;
tau = 0.2;
peak = -15;
current = Step_Current([t1 t1+5], [peak 0], 0);
model.compute(tau, current, 0, t_end,"figures/model_N_rebound_burst.fig");