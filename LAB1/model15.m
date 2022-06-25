a=0.03; b=0.25; c=-60;  d=4;
V=-64; 
maxV = 30;
V_coeff = [140 5 0.04];
name = "thresh. variability";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);

t_end = 100;
tau = 0.25;
peak = 9;
t1 = 10; t2 = 70; t3 = 80;
dur = 5;
peak1 = 1; peak2 = -6;
current = Step_Current([t1 t1+dur t2 t2+dur t3 t3+dur], [peak1 0 peak2 0 peak1 0], 0);
model.compute(tau, current, 0, t_end, "figures/model_O_threshold_stability.fig");