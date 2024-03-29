a=-0.02;  b=-1; c=-60;  d=8;
V=-63.8;
maxV = 30;
V_coeff = [140 5 0.04];
name = "inhibition induced spiking ";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);

t_end = 350;
tau = 0.5;

dur = 5;
peak = 75; rest = 80;

current = Step_Current([50 250], [peak rest], rest);
model.compute(tau, current, 0, t_end,"figures/model_S_inhibition_induced_spiking.fig");