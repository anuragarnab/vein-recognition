num_outliers = 7;

% colours = linspecer(3);
% set(0,'DefaultAxesColorOrder',colours)
% 
% thresholds = [200:5:500];
% thresholds = [thresholds 505:1:900];
% thresholds = [thresholds 910:10:2000];
% thresholds = [0 thresholds];
% 
% [corrects, negs] = tester(distances_ulbp_chi, imp_distances_ulbp_chi, thresholds, limits, num_per_sample);

far1 = size(negs,1) - sum(negs);
frr1 = size(corrects,1) - sum(corrects) - num_outliers;

far1 = far1 ./ size(correct_negs,1) .* 100;
frr1 = frr1 ./ (size(correct_negs,1) - num_outliers) .* 100;
% 
% %% Now for the other one
% 
% thresholds = [0:10:700];
% thresholds = [thresholds 705:1:2500];
% thresholds = [thresholds 2510:10:4000];
% 
% 
% [corrects2, negs2] = tester(distances_ulbp_chi_raw, imp_distances_ulbp_chi_raw, thresholds, limits, num_per_sample);
% 
far2 = size(negs2,1) - sum(negs2);
frr2 = size(corrects2,1) - sum(corrects2) - num_outliers;

far2 = far2 ./ size(negs2,1) .* 100;
frr2 = frr2 ./ (size(negs2,1) - num_outliers) .* 100;


%% Plot

figure
hold all
plot(far1, frr1, 'linewidth', 2, 'MarkerSize', 5);
plot(far2, frr2, 'linewidth', 2, 'MarkerSize', 5);
ylabel ('False rejection rate')
xlabel ('False acceptance rate');
x = [0:0.01:100];
plot(x,x,'linewidth',2,'linestyle', '--');

legend({'Vein-enhanced images', 'Raw images', 'EER'});

scatter(far1, frr1, 25, colours(1,:), 'filled');
scatter(far2, frr2, 25, colours(2,:), 'filled');

goodplot();

set(gca, 'XLim', [0 5]);
set(gca, 'YLim', [0 5]);
