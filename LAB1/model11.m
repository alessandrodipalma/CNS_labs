a=0.1;  b=0.26; c=-60;  d=-1;
V=-62;
maxV = 30;
V_coeff = [140 5 0.04];
name = "resonator";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);

t_end = 400;
t1 = t_end/10;
t2 = t1 + 20;
t3 = 0.7 * t_end;
t4 = t3 + 40;
tau = 0.25;
peak = 0.65;
current = Step_Current([t1 t1+4 ...
                        t2 t2+4 ...
                        t3 t3+4 ...
                        t4 t4+4], ...
    [peak 0 peak 0 peak 0 peak 0], 0);
model.compute(tau, current, 0, t_end, "figures/model_K_resonator.fig");