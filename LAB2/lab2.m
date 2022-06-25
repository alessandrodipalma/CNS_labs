hebb='hebb';oja='oja';snr='snr';bcm='bcm';cov_rule='cov';
rules = {hebb, oja, snr, bcm, cov_rule};
rules = {snr};
data = readtable("lab2_1_data.csv");
data = data{:,:};

n_epochs = 2;
eta = 0.1;
alpha = 0.01;
tol = 1e-3;


for r=1:length(rules)
    rule = rules{r};
    w = 2*rand([2 1]) - 1;
    w_hist = [w];
    w_norm_hist = [norm(w)];

    for e = 1:n_epochs
        p = randperm(width(data));
        data = data(:, p);
        for i = 1:width(data)
            u = data(:,i);
            v = w' * u;

            if strcmp(rule, hebb)
                dw = eta * v * u;
            elseif strcmp(rule,oja)
                dw = eta * v*u - alpha*v^2*w;
            elseif strcmp(rule, snr)
                n = ones(length(v));
                dw = eta * ( v*u - (v*(n*u)*n)/length(u));
            elseif strcmp(rule, bcm)
                dw = eta * v*u*(v - 0.1);
            elseif strcmp(rule, cov_rule)
                dw = eta * cov(data,data)*w;
            end

            w_new = w + dw;

            if norm(w - w_new) > tol
                w = w_new;
                w_hist = [w_hist, w_new];
                w_norm_hist = [w_norm_hist norm(w_new)];
            else
                if i > 10
                    e = n_epochs;
                    break
                end
                
            end
            norm(w);
        end
    end

    C = zeros(width(data)+2) + 1;
    C(width(data)+1) = 500;
    C(width(data)+2) = 1000;
    Q = data * data';
    clf

    [A,B] = eigs(Q,1);

    hold on
    plotv(w, 'r');
    hold on
    plotv(A, 'g--');
    plotvec(data, C);
    legend([ "w" "max eig" "data point"])
    mkdir(rule)
    savefig(compose("%s/vectors_%s", rule, rule))

    
    subplot(3,1,1)
    plot(w_norm_hist)
    title('w norm')
    xlabel("time")

    subplot(3,1,2)
    plot(w_hist(1,:))
    title('w1')
    xlabel("time")

    subplot(3,1,3)
    plot(w_hist(2,:))
    title('w2')
    xlabel("time")
    
    filename = compose("%s/weight_evolution_%s", rule, rule);
    savefig(filename)
    save(filename,('w_hist'))

    clearvars w_hist dw w
end