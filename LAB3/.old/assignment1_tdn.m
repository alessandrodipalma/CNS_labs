ds = load("NARMA10timeseries.mat");
x = cell2mat(ds.NARMA10timeseries.input);
y = cell2mat(ds.NARMA10timeseries.target);

n_config=1000;
max_units = 20; % 50 takes too much time to train
max_layers = 3;
max_delays = 100;

performances = {};
nets = [];
configs = [];
for c = 1:n_config
    delay = randi([1,max_delays]);
    layers = randi([1,max_layers]);
    units = randi([1,max_units], 1, layers);
    
    config = struct('delay',delay,'n_layers',layers,'units',units);
    [net,tr] = train_tdn(ds,delay, units, 'trainbfg', 0.1, 0.5);
    
    nets = [nets net];
    configs = [configs config];
    performances = [performances tr];
end

performances = cell2mat(performances);
[best_mse,best_id] = min([performance.best_vperf]);
best_config = configs(best_id);

[net,tr] = train_tdn(ds, best_config.delay, best_config.units, 'trainbfg', 0.5, 0);

save('best_tdn/configs.mat',"configs")
save('best_tdn/net.mat', "net");
save('best_tdn/tr.mat', "tr");

tr.best_perf
tr.best_vperf
