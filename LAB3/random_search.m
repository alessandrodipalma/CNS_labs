function [performances] = random_search(fixed_tr_params, fixed_test_params, configs, params_names, train_fun, out_dir)
    n_configs = size(configs, 1);
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
        msg = sprintf('Percent done: %3.2f', percentDone); %Don't forget this semicolon
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
    
    best_config = cellfun(@num2str, best_config, 'UniformOutput', false);
    writematrix( ...
        [params_names "train mse" "val mse" "design mse" "test mse"; ...
        best_config best_train_mse best_val_mse tr.best_perf tr.best_vperf], ...
        append(out_dir,"/best_config.csv"))

end

