function [ output_args ] = plot_roc( corrects, correct_negs, threshes, num_outliers )
%UNTITLED8 Plots the roc and the "corrects vs incorrects" graph
%   Detailed explanation goes here
    
    if (nargin < 4)
       num_outliers = 13; 
    end
    
    crimson = [0.6, 0, 0];
    nice_blue = [51/255, 153/255, 1];

    far = length(correct_negs) - sum(correct_negs);
    frr = length(corrects) - sum(corrects);
    
    far = far ./ length(correct_negs) .* 100;
    frr = frr ./ (length(corrects) - num_outliers) .* 100;
    
    figure
    plot (far, frr, 'color', crimson, 'linewidth', 2);
    set(gca,'XTick', [0:10:100]);
    set(gca,'YTick', [0:10:100]);
    hold on
    x = [0:1:100];
    plot (x, x, 'green');
    xlabel('False acceptance rate (FAR)');
    ylabel('False rejection rate (FRR)');
    title('Receiver Operator Characteristic (ROC)')
    text(6.475, 6.475, ['\downarrow Equal error rate of 6.475%']);
    goodplot();
    
    figure
    plot(threshes, sum(corrects) ./ (length(corrects) - num_outliers) .* 100, 'color', crimson, 'linewidth', 2);
    hold on
    plot(threshes, sum(correct_negs) ./ length(correct_negs) .* 100, 'color', nice_blue, 'linewidth', 2);
    xlabel('Threshold');
    ylabel('Percentage');
    legend({'Genuine queries correctly accepted' ; 'Imposter queries correctly rejected'}, 'Location', 'SouthEast');
    title ('Classification accuracy')
    
    goodplot();
    
    figure
    plot (threshes, (sum(corrects) + sum(correct_negs)) ./ (length(corrects) + length(correct_negs) - num_outliers) .* 100, 'color', crimson, 'linewidth', 2 );
    xlabel('Threshold');
    ylabel('Percentage %');
    title('Average of genuine acceptance and imposter rejection');
    goodplot();
    
end

