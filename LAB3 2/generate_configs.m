function [combinations] = generate_configs(ranges, scalings, n)
    % generate all possible combs
    
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

