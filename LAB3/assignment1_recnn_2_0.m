
ds = load("NARMA10timeseries.mat");
x = cell2mat(ds.NARMA10timeseries.input);
y = cell2mat(ds.NARMA10timeseries.target);

n_config=100;
max_units = 10; 
max_layers = 3;
max_delays = 1;
max_epochs = 500;

train_split = [0.4, 0.1, 0];
test_split = [0.5, 0.5, 0];

%ranges = [{1:max_layers, 1:max_delays} repmat({1:max_units}, 1,max_layers)];
ranges = [{1:max_layers} repmat({1:max_units}, 1,max_layers)];

configs = generate_configs(ranges,ones(1+max_layers,1),n_config);
%%
delays = num2cell(ones(n_config,1));
units = cell(1,n_config);
for c = 1:n_config
    n_layers = configs{c,1};
    units(c) = {cell2mat(configs(c, 1+1:1+n_layers))};
end
configs = {delays{:}; units{:}}';

out_dir = "best_rnn";
random_search({ds, train_split,"", max_epochs}, {ds, test_split,out_dir, max_epochs}, ...
    configs, {"delays","units"}, @train_recnn, out_dir);

