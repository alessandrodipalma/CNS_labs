function [performances] = random_search(fixed_tr_params, fixed_test_params, configs, params_names, train_fun, out_dir)
    % perform a random search given the configurations of the
    % hyperparameters.
    % fixed_tr_params: 1xn cell array containing the fixed parameters for the model selection to pass to train_fun
    % fixed_ters_params: 1xn cell array containing the fixed parameters for the model testing to pass
    % to train_fun
    % configs: cell array of size n_configs x n_parameters containing the
    % hyperparameter values for each configuration
    % params_names: column names of the configs array, needed to produce
    % the CSVs.
    % train_fun: function that performs the training cycle for each
    %   configuration. The signature should be composed as 
    %   [net, tr] = train_fun(fixed_param_1, ... fixed_param_n, variable_param_1, ..., variable_param_m)
    %   where:
    %       - net is the network object that will be saved
    %       - tr is a struct containing best_perf (training mse) and
    %       best_vperf (validation mse)
    % out_dir: directory where to store configuration files and plots.

    n_configs = size(configs, 1);

    % preallocate arrays for performance
    performances = cell(1,n_configs);
    nets = cell(1,n_configs);
    configs_structs = cell(n_configs+1,length(params_names)+2);

    configs_structs(1,:) = cellstr([params_names "train mse","val mse"]);
    mkdir(out_dir)

    reverseStr = '';
    for c=1:n_configs
        params = [fixed_tr_params configs(c,:)];
    
        [net,tr] = train_fun(params{:});
        
        nets{c} = net;
        performances{c} = tr;

        % Display the progress
        percentDone = 100 * c / n_configs;
        msg = sprintf('Percent done: %3.2f', percentDone);
        fprintf([reverseStr, msg]);
        reverseStr = repmat(sprintf('\b'), 1, length(msg));
        configs_structs(c+1,:) = [configs(c,:) tr.best_perf tr.best_vperf];
    end

    performances = cell2mat(performances);

    [best_val_mse, best_id] = min([performances.best_vperf]);
    best_train_mse = performances(best_id).best_perf;
    best_config = configs(best_id,:);

    params = [fixed_test_params configs(best_id,:)];
    [net, tr] = train_fun(params{:});

    
    save(append(out_dir,'/configs.mat'),"configs")
    save(append(out_dir,'/net.mat'), "net");
    save(append(out_dir,'/tr.mat'), "tr");
    writecell(configs_structs, append(out_dir,'/all_configs.csv'))
    

    writematrix( ...
        [params_names "train mse" "val mse" "design mse" "test mse"; ...
        best_config best_train_mse best_val_mse tr.best_perf tr.best_vperf], ...
        append(out_dir,"/best_config.csv"))

end

