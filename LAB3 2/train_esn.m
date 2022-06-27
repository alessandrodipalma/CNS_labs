function [net,tr] = train_esn(x,y,train_val_split, plot_dir, n_in, n_readout, sparsity, n_reservoir,  ro, input_scale,penalty)
%TRAIN_ESN Function needed to be called by the random search.
x_train = x(:,1:train_val_split(1));
y_train = y(:,1:train_val_split(1));
x_val = x(:, train_val_split(1)+1:train_val_split(2));
y_val = y(:, train_val_split(1)+1:train_val_split(2));

% train over 10 reservoir guesses
n_guesses = 10;
washout = 500;
train_errs = zeros(n_guesses, 1);
val_errs = zeros(n_guesses, 1);
train_preds = [];
val_preds = [];
for i=1:n_guesses
    net = esn(n_in, n_reservoir, n_readout, ro, input_scale, sparsity);
    [net, train_err, H, train_pred] = net.train(x_train,y_train, washout,penalty);

    val_pred = net.predict(H(:,end), x_val);
    val_err = immse(y_val,val_pred);
    train_errs(i) = train_err;
    val_errs(i) = val_err; 
    train_preds = [train_preds; train_pred];
    val_preds = [val_preds; val_pred];
end
tr = struct('best_perf',mean(train_errs), 'best_vperf',mean(val_errs));

[M,i] = min(val_preds);
if plot_dir ~= ""
    % plot for the best guess
    tr_ind = washout+1:train_val_split(1);
    val_ind = train_val_split(1)+1:train_val_split(2);
    plot(tr_ind, y_train(tr_ind), tr_ind, train_preds(i,:), ...
        val_ind, y_val, val_ind, val_preds(i,:))
    legend(["train target","train prediction","test target","test prediction"])
    savefig(append(plot_dir,"output_response.fig"))
end

end

