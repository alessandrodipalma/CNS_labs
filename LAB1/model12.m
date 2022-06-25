a=0.02; b=-0.1; c=-55; d=6;
V=-60; 
maxV = 30;
V_coeff = [108 4.1 0.04];
name = "integrator";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);

t_end = 100;
t1 = t_end/11;
t2 = t1 + 5;
t3 = 0.7 * t_end;
t4 = t3 + 10;
tau = 0.25;
peak = 9;
current = Step_Current([t1 t1+2 ...
                        t2 t2+2 ...
                        t3 t3+2 ...
                        t4 t4+2], ...
    [peak 0 peak 0 peak 0 peak 0], 0);
model.compute(tau, current, 0, t_end, "figures/model_L_integrator.fig");