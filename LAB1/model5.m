a=0.02; b=0.2;  c=-55;  d=4;
V=-70; 
maxV = 30;
V_coeff = [140 5 0.04];
name = "mixed mode";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);

t_end = 160;
current_start = t_end/10;
tau = 0.25;
current = Step_Current([current_start], [10], 0);
model.compute(tau, current, 0, t_end, "figures/model_E_mixed_mode.fig");