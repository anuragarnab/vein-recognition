addpath ../../common

outliers = 13;

%clus_nums = [1:1:4];
%clus_nums = [clus_nums 30:1:length(history)];
clus_nums = [1:1:length(history)];
count = 1;

colours = distinguishable_colors(length(clus_nums));
leg_labels = {};
figure
set(0,'DefaultAxesColorOrder',colours)
hold all

for i = clus_nums
%     plot ((sum(history(i).frr_record) + sum(history(i).wrong_rec_record)) ./(600 - outliers).* 100, (sum(history(i).far_record))./600 .* 100, 'linewidth', 2); % Tested that this is equivalent to the other methods that I have used
    
    far = length(history(i).correct_neg_record) - sum(history(i).correct_neg_record);
    frr = length(history(i).correct_record) - sum(history(i).correct_record) - outliers;
    
    far = far ./ length(history(i).correct_neg_record) .* 100;
    frr = frr ./ (length(history(i).correct_record) - outliers) .* 100;
    
    plot (far, frr, 'linewidth', 2);
    leg_labels{count} = num2str(history(i).centroids_per_cluster);
    count = count+1;
end


ylabel ('False rejection rate')
xlabel ('False acceptance rate');
x = [0:0.01:100];
plot(x,x);
leg_labels{count} = 'EER';

legend(leg_labels);
goodplot();

rmpath ../../common