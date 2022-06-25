function [net,tr] = train_recnn(ds,train_val_test_split,plot_dir, ...
    max_epochs,layer_delays,hidden_sizes)
%TRAIN_RECNN Summary of this function goes here
%   Detailed explanation goes here
net = layrecnet(1:layer_delays,hidden_sizes);

net.trainParam.alpha = 1e-2;
net.trainParam.epochs = max_epochs;

net.divideFcn = 'divideblock';
net.divideParam.trainRatio = train_val_test_split(1);
net.divideParam.valRatio = train_val_test_split(2);
net.divideParam.testRatio = train_val_test_split(3);
net.divideMode= 'time';
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

