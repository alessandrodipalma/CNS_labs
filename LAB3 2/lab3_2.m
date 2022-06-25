data = load("NARMA10timeseries.mat");
x = cell2mat(data.NARMA10timeseries.input);
y = cell2mat(data.NARMA10timeseries.target);


% fixed params for this task
n_in = 1; n_readout = 1;
out_dir = "best_esn_ridge";

% random search
n_config=1000;

max_reservoir=1e3;
max_ro = 10;
max_input_scale = 10;
max_sparsity=10;
max_penalty = 100;
% define the domains for the random search
ranges = [{1:max_sparsity,2:max_reservoir, 1:max_ro, 1:max_input_scale, 1:max_penalty}];
configs = generate_configs(ranges, [0.1,1,0.1,0.1,0.1], n_config);


random_search( ...
    {x, y, [4000,5000], "", n_in, n_readout}, ...
    {x, y, [5000,10000], out_dir, n_in, n_readout}, ...
    configs, ...
    {"sparsity","reservoir","ro","input_scale","ridge penalty"}, ...
    @train_esn, ...
    out_dir);