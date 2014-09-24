function [ output_args ] = plot_roc( corrects, correct_negs, threshes, num_outliers )
%UNTITLED8 Plots the roc and the "corrects vs incorrects" graph
%   Detailed explanation goes here
    
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
    %plot (far, frr, 'color', crimson, 'linewidth', 2);
    %set(gca,'XTick', [0:10:100]);
    %set(gca,'YTick', [0:10:100]);
    
    set(gca, 'XLim', [0 100]);
    set(gca, 'YLim', [0 100]);

%    hold on
    x = [0:0.001:100];
 %   plot (x, x, 'linestyle', '-.' ,'color', nice_green, 'linewidth', 2);
    plot (x, x, 'linestyle', '--', 'linewidth', 2);
    xlabel('False acceptance rate (FAR) [%]');
    ylabel('False rejection rate (FRR) [%]');
    title('Receiver Operator Characteristic (ROC)')
%    text(6.475, 6.475, ['\downarrow Equal error rate of 6.475%']);
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
    %plot (threshes, (sum(corrects) + sum(correct_negs)) ./ (size(corrects,1) + size(correct_negs,1) - num_outliers) .* 100,'linewidth', 2 );
    xlabel('Threshold');
    ylabel('Percentage %');
    title('Average of genuine acceptance and imposter rejection');
    goodplot();
    
end

