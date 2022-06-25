a=0.02; b=0.25; c=-65;  d=6;
V=-64; 
maxV = 30;
V_coeff = [140 5 0.04];
name = "phasic spiking";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);
current = Step_Current([20],[0.5],0);
model.compute(0.25, current, 0, 200, "figures/model_B_phasic_spiking.fig");

