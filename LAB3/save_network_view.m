function save_network_view(net, path)
    %# neural net, and view it
    net = feedforwardnet(5);
    jframe = view(net);
    
    %# create it in a MATLAB figure
    hFig = figure('Menubar','none', 'Position',[100 100 565 166]);
    jpanel = get(jframe,'ContentPane');
    [~,h] = javacomponent(jpanel);
    set(h, 'units','normalized', 'position',[0 0 1 1])
    
    %# close java window
    jframe.setVisible(false);
    jframe.dispose();
    
    %# print to file
    set(hFig, 'PaperPositionMode', 'auto')
    saveas(hFig, path)
    
    %# close figure
    close(hFig)
end