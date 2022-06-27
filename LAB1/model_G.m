a=0.02; b=-0.1; c=-55; d=6;
V=-60;
maxV = 30;
V_coeff = [108 4.1 0.04];
name = "Class 1 exc.";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);

t_end = 300;
current_start = t_end/10;
tau = 0.25;
current = Linear_Current(current_start, 0, 0.075);
model.compute(tau, current, 0, t_end, "figures/model_G_class_1_excitable.fig");