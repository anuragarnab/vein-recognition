% addpath ../../common

outliers = 13;

% clus_nums = [23:25];
clus_nums = [11:1:20]; 
%clus_nums = [clus_nums 30:1:34];


% clus_nums = [1:1:length(history)];
count = 1;

colours = linspecer(length(clus_nums)+1);
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

ylabel ('False acceptance rate')
xlabel ('False rejection rate');
x = [0:0.01:100];
plot(x,x, 'linestyle', '--', 'linewidth', 2);
leg_labels{count} = 'EER line';

legend(leg_labels);

% Legend title does not go into the box, so fuck it
% l = legend(leg_labels);
% ltitle = get(l,'title');
% set(ltitle,'string','Number of clusters');

for i = clus_nums
    
    % doing it twice is never a good idea'
    far = length(history(i).correct_neg_record) - sum(history(i).correct_neg_record);
    frr = length(history(i).correct_record) - sum(history(i).correct_record) - outliers;
    
    far = far ./ length(history(i).correct_neg_record) .* 100;
    frr = frr ./ (length(history(i).correct_record) - outliers) .* 100;

    scatter(far, frr, 'filled');  
end


goodplot();
%set(gca, 'XLim', [1 20]);
%set(gca, 'YLim', [4 22]);


% rmpath ../../common