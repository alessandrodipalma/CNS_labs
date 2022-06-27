function [combinations] = generate_configs(ranges, scalings, n)
    % generate all possible combinations given ranges of values.
    % ranges: cell array containing  ranges
    % scalings: 1xlength(ranges) array of doubles containing the scaling
    % factors of each parameter. If you don't want to scale, it should
    % contain all ones.
    % n: number of randomly sampled configurations.
    
    combinations = combvec(ranges{:});
    l = 1;
    
    for i=1:length(ranges)
        l = l*length(ranges{i});
    end

    perm = randperm(l);
    combinations = combinations(:,perm(1:n));

    configs = cell(length(ranges),n);
    for i=1:length(ranges)
        configs(i,:) = num2cell(scalings(i)*combinations(i,:));
    end
    combinations = configs';
    
end

