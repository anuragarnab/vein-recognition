function [] = plot_roc( corrects, correct_negs, threshes, num_outliers )
%UNTITLED8 Plots the ROC, Accuracy graph, and Average Accuracy graph
% corrects is a binary vector showing whether index i was identified correctly or not. correct_negs is the same, but shows if an imposter was correctly rejected or not
% "threshes" is the thresholds at which we evaluated the classifier
% "num_outliers" is the number of outliers which we need to take into account
    
    if (nargin < 4)
       num_outliers = 13; 
    end
    
    colours = linspecer(2);
    set(0,'DefaultAxesColorOrder',colours)
    
    crimson = [192, 80, 77]./255;
    nice_blue = [79, 129, 189]./255;
    nice_green = [155, 187, 89]./255;
    nice_purple = [128, 100, 162]./255;

    far = size(correct_negs,1) - sum(correct_negs);
    frr = size(corrects,1) - sum(corrects) - num_outliers;

    far = far ./ size(correct_negs,1) .* 100;
    frr = frr ./ (size(correct_negs,1) - num_outliers) .* 100;
    
    figure
    hold all;
    plot (far, frr, 'linewidth', 2);
    
    set(gca, 'XLim', [0 100]);
    set(gca, 'YLim', [0 100]);

    x = [0:0.001:100];
    plot (x, x, 'linestyle', '--', 'linewidth', 2);
    xlabel('False acceptance rate (FAR) [%]');
    ylabel('False rejection rate (FRR) [%]');
    title('Receiver Operator Characteristic (ROC)')
    legend({'ROC','EER line   '});
    scatter(far, frr, 'filled'); 
    goodplot();
    
    figure
    colours = linspecer(3);
    set(0,'DefaultAxesColorOrder',colours)
    hold all
    
    plot(threshes, (sum(corrects)) ./ (size(corrects,1) - num_outliers) .* 100, 'linewidth', 2);
    plot(threshes, sum(correct_negs) ./ size(correct_negs,1) .* 100, 'linewidth', 2);
    xlabel('Threshold');
    ylabel('Percentage');
    legend({'Genuine queries correctly accepted' ; 'Imposter queries correctly rejected   '}, 'Location', 'SouthEast');
    title ('Classification accuracy')
    goodplot();
    
    colours = linspecer(1);
    set(0,'DefaultAxesColorOrder',colours)
    hold all;
    figure
    
    % Averag the correct and correct_neg separately as their denominators
    % can be different
    correct_rate = sum(corrects) ./ (size(corrects,1) - num_outliers);
    correct_neg_rate = sum(correct_negs) ./ size(correct_negs,1);
    average = mean([correct_rate ; correct_neg_rate]).*100;
    plot (threshes, average,'linewidth', 2 );
    xlabel('Threshold');
    ylabel('Percentage %');
    title('Average of genuine acceptance and imposter rejection');
    goodplot();
    
end

