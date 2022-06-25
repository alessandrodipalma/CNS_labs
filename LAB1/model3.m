a=0.02; b=0.2; c=-50;  d=2;
V=-70;
maxV = 30;
V_coeff = [140 5 0.04];
name = "tonic bursting";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);
current = Step_Current([22], [15], 0);
model.compute(0.2, current, 0, 220, "figures/model_C_tonic_bursting.fig");