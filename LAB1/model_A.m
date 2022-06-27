a=0.02; b=0.2; c=-65; d=6; V=-70; maxV = 30;
V_coeff = [140 5 0.04];
name = "tonic spiking";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);
current = Step_Current([10],[14], 0);
model.compute(0.25, current, 0, 200, "figures/model_A_tonic_spiking.fig");

