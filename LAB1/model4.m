a=0.02; b=0.25; c=-55;  d=0.05;
V=-64;
maxV = 30;
V_coeff = [140 5 0.04];
name = "phasic bursting";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);
current = Step_Current([20], [0.6], 0);
model.compute(0.2, current, 0, 200, "figures/model_D_phasic_bursting.fig");