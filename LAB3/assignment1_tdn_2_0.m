ds = load("NARMA10timeseries.mat");
x = cell2mat(ds.NARMA10timeseries.input);
y = cell2mat(ds.NARMA10timeseries.target);

n_config=1000;
max_units = 10;
max_layers = 5;
max_delays = 20;

train_split = [0.4, 0.1, 0];
test_split = [0.5, 0.5, 0];

ranges = [{1:max_layers, 1:max_delays} repmat({1:max_units}, 1,max_layers)];
configs = generate_configs(ranges,ones(3+max_layers,1),n_config);

%%
delays = num2cell(cell2mat(configs(:,2)));
units = cell(1,n_config);
for c = 1:n_config
    n_layers = configs{c,1};
    units(c) = {cell2mat(configs(c, 2+1:2+n_layers))};
end
configs = {delays{:}; units{:}}';
out_dir = "best_tdn_2";
random_search({ds, train_split,""}, {ds, test_split,out_dir}, ...
    configs, {"delay","units"}, @train_tdn, out_dir);

