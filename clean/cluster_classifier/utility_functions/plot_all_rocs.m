% Plots all the ROCs. Must first load the testing data obtained from
% testing different numbers of clusters. 

outliers = 13;

%% The clusters to be plotted
% clus_nums = [23:25];
clus_nums = [11:1:20]; 
%clus_nums = [clus_nums 30:1:34];
%%

count = 1;

colours = linspecer(length(clus_nums)+1);
leg_labels = {};
figure
set(0,'DefaultAxesColorOrder',colours)
hold all

for i = clus_nums
    
    % Compute the ROC for each sample
    far = length(history(i).correct_neg_record) - sum(history(i).correct_neg_record);
    frr = length(history(i).correct_record) - sum(history(i).correct_record) - outliers;
    
    far = far ./ length(history(i).correct_neg_record) .* 100;
    frr = frr ./ (length(history(i).correct_record) - outliers) .* 100;
    
    plot (far, frr, 'linewidth', 2);
    leg_labels{count} = num2str(history(i).centroids_per_cluster);
    count = count+1;
end

ylabel ('False acceptance rate')
xlabel ('False rejection rate');
x = [0:0.01:100];
plot(x,x, 'linestyle', '--', 'linewidth', 2);
leg_labels{count} = 'EER line';

legend(leg_labels);


% Plot the scatter plot on top of the line plot to get data labels.
for i = clus_nums
    
    % Compute FAR and FRR again
    far = length(history(i).correct_neg_record) - sum(history(i).correct_neg_record);
    frr = length(history(i).correct_record) - sum(history(i).correct_record) - outliers;
    
    far = far ./ length(history(i).correct_neg_record) .* 100;
    frr = frr ./ (length(history(i).correct_record) - outliers) .* 100;

    scatter(far, frr, 'filled');  
end

goodplot();
