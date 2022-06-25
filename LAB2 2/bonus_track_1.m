p1=[-1 -1 +1 -1 +1 -1 -1 +1];
p2=[-1 -1 -1 -1 -1 +1 -1 -1];
p3=[-1 +1 +1 -1 -1 +1 -1 +1];

net = hopfield_net();
patterns = [p1;p2;p3];
net = net.learn(patterns);

p1d=[+1 -1 +1 -1 +1 -1 -1 +1];
p2d=[+1 +1 -1 -1 -1 +1 -1 -1];
p3d=[+1 +1 +1 -1 +1 +1 -1 +1];
d_patterns = [p1d;p2d;p3d];

for i=1:size(d_patterns, 1)
    [reconstruction, e_hist, overlap_hists, x_hist] = net.retrieve(d_patterns(i,:), 20, 1e-8, 15);
    figure(i)
    subplot(1,2,1)
    
    imagesc(x_hist)
    save(compose("bonus_track_1_files/p%dd_activations.mat",i),("x_hist"))
    title("distorted pattern convergence")
    xlabel("time")
    ylabel("j^{th} neuron state")
    subplot(1,2,2)
    
    imagesc(patterns(i,:)')
    daspect([8 1 3])
    title("original pattern")

    savefig(compose("bonus_track_1_files/p%dd_activations.fig",i))
end


