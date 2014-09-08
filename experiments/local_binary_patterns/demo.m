indices = [7,8,35];
rows = 2;
cols = 4;

bars = [];
blue = [79 129 189]./255;
figure

for counter=1:length(indices)
    i = indices(counter)
    lbp = get_lbp(veins(i).filename, 1);
    ulbp = uniform_lbp(lbp);
    ulbp_hist = grid_histogram(veins(i).ulbp, rows, cols); 
    bars = [bars ; ulbp_hist(1,:)]; 
    subplot(3,1,counter);
    bar([0:1:58], bars(counter,:));
    xlabel('Uniform LBP codeword');
    ylabel('Frequency');
    
    set (gca, 'YLim', [0 175]);
    set (gca, 'XLim', [-2 58]);
    set (findobj(gca,'Type','patch'), 'FaceColor', blue)
    goodplot();
end
