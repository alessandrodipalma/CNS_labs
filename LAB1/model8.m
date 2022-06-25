a=0.2;  b=0.26; c=-65;  d=0;
V=-64;
maxV = 30;
V_coeff = [140 5 0.04];
name = "Class 2 exc.";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);

t_end = 300;
current_start = t_end/10;
tau = 0.25;
current = Linear_Current(current_start, -0.5, 0.015);
model.compute(tau, current, 0, t_end, "figures/model_H_class2_excitable.fig");