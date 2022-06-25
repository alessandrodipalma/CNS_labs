ds = load("NARMA10timeseries.mat");
x = cell2mat(ds.NARMA10timeseries.input);
y = cell2mat(ds.NARMA10timeseries.target);

n_config=500;
max_units = 5; 
max_layers = 2;
max_delays = 4;
max_epochs = 500;

performances = cell(1,n_config);
nets = cell(1,n_config);

% create a ranges vector to generate the spaces of possible combinations in
% order to avoid repetitions
ranges = [{1:max_layers, 1:max_delays, 1:max_units} repmat({1:max_units}, 1,max_layers)];
configs = generate_configs(ranges,n_config);
configs_structs = cell(1,n_config);

reverseStr = '';
train_split = [0.4, 0.1, 0];
for c = 1:n_config
    
    delay = configs(2,c);
    layers = configs(1,c);
    units = configs(3:3+layers, c)';
    
    [net,tr] = train_recnn(ds, train_split, max_epochs, delay, units);
    
    nets{c} = net;
    performances{c} = tr;
    configs_structs{c} = struct('delay',delay,'n_layers',layers,'units',units);

   % Display the progress
   percentDone = 100 * c / n_config;
   msg = sprintf('Percent done: %3.1f', percentDone); %Don't forget this semicolon
   fprintf([reverseStr, msg]);
   reverseStr = repmat(sprintf('\b'), 1, length(msg));
end

performances = cell2mat(performances);
%% 

[best_mse,best_id] = min([performances.best_vperf]);
best_config = cell2mat(configs_structs(best_id));

%%
[net,tr] = train_recnn(ds, [0.5, 0.5, 0], 500, 1:best_config.delay, best_config.units);

save('best_rnn/configs.mat',"configs")
save('best_rnn/net.mat', "net");
save('best_rnn/tr.mat', "tr");
%%
plotperform(tr)
savefig("best_rnn/learning_curve.fig")
%plotresponse(tr)
%savefig("best_rnn/response.fig")
tr.best_perf
tr.best_vperf
