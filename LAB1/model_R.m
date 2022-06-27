a=0.02;  b=1; c=-55;  d=4;
V=-65;
maxV = 30;
V_coeff = [140 5 0.04];
name = "accomodation";
model = Izi_model(a,b,c,d,V, V_coeff, maxV, name);
model = model.set_u(-16);
model = model.set_accomdodation();

t_end = 400;
tau = 0.5;

curr1 = Linear_Current(0, 0, 1/25);
curr2 = Linear_Current(300, 0, 4/12.5);
curr0 = Linear_Current(0,0,0);
current = Mixed_Current([curr1 curr0 curr2 curr0], ...
    [0 200 300 312.5]);
model.compute(tau, current, 0, t_end,"figures/model_R_accomodation.fig");