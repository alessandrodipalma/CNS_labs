a=0.01; b=0.2;  c=-65;  d=8;
V=-70;
maxV = 30;
V_coeff = [140 5 0.04];
name = "spike frequency adaptation";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);

t_end = 85;
current_start = t_end/10;
tau = 0.25;
current = Step_Current([current_start], [30], 0);
model.compute(tau, current, 0, t_end, "figures/model_F_spike_frequency_adaptation.fig");