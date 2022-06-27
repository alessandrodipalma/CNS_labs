net = hopfield_net();

% data preparation
data = load("lab2_2_data.mat");
fields = fieldnames(data);
patterns = zeros([length(fields)  1024]);
for i = 1:numel(fields)
    patterns(i,:) = data.(fields{i});
end


net = net.learn(patterns);

distortions = [0.05 0.1 0.25];
epochs = 10;
tol = 1e-8;
patience = 20;

for p=1:size(patterns,1)
    original_pattern = patterns(p,:);

    for d=1:length(distortions)
        figure(p*10+d);
        fh = figure(p*10+d);
        probe = distort_image(original_pattern, distortions(d));
        
        [reconstruction, energy_hist, overlap_hists, x_hist] = net.retrieve(probe, epochs, tol, patience);

        % PLOTTING
        clf

        subplot(3,2,1)
        hold on

        for mu=1:size(patterns,1)
            plot(overlap_hists(mu,:))
        end
        ylim([-1 1])
        xlim([0 length(energy_hist)])
        hold off
        title("overlaps")

        lgnd = [];
        for i=1:size(patterns,1)
            lgnd = [lgnd compose("p%d",i)];
        end
        legend(lgnd, Location='southeast')

        subplot(3,2,3)
        plot(energy_hist)
        xlim([0 length(energy_hist)])
        title("energy")

        subplot(3,2,2)
        imshow(reshape(original_pattern, 32,32))
        title("original")

        subplot(3,2,4)
        imshow(reshape(probe, 32,32))
        t=title(sprintf("probe %f", distortions(d)));
        set(t,'Interpreter','none')

        subplot(3,2,6)
        imshow(reshape(reconstruction, 32,32))
        t=title(sprintf("reconstruction | f1_score=%f", f1_score(original_pattern, reconstruction)));
        set(t,'Interpreter','none')
        % set figure units to pixels & adjust figure size
        set(fh, 'visible', 'off');
        fh.Units = 'pixels';
        fh.OuterPosition = [0 0 3000 2000];
        % define resolution figure to be saved in dpi
        res = 420;
        % recompute figure size to be saved
        set(fh,'PaperPositionMode','manual');
        fh.PaperUnits = 'inches';
        fh.PaperPosition = [0 0 3000 2000]/res;

        % save figure
        if not(isfolder("figures"))
            mkdir("figures")
        end
        
        print(fh,sprintf("figures/p%d_distorted%.2f.png", p,distortions(d)),'-dpng',sprintf('-r%d',res))

    end

end


