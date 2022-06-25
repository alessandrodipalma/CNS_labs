function [net,tr] = train_tdn(ds,train_val_test_split,plot_dir,delay,units)
%TRAIN_TDN Summary of this function goes here
%   Detailed explanation goes here
net = timedelaynet(delay,units,'trainbfg');

eParam.testRatio = train_val_test_split(3);

[Xs,Xi,Ai,Ts] = preparets(net, ds.NARMA10timeseries.input, ds.NARMA10timeseries.target);
[net,tr] = train(net,Xs,Ts);

if plot_dir ~= ""
    plotperform(tr)
    savefig(append(plot_dir,"/learning_curve.fig"));

    Y = net(Xs,Xi,Ai);
    plotresponse(Ts,Y);
    savefig(append(plot_dir,"/response.fig"))

    save_network_view(net,append(plot_dir,"/architecture.png"))
end

end

