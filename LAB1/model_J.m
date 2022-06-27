a=0.05; b=0.26; c=-60;  d=0;
V=-62;
maxV = 30;
V_coeff = [140 5 0.04];
name = "subthresh. osc.";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);

t_end = 200;
current_start = t_end/10;
tau = 0.25;
current = Step_Current([current_start current_start+5], [2 0], 0);
model.compute(tau, current, 0, t_end, "figures/model_J_subthreshold_oscillations.fig");