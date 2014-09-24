num_outliers = 13;
limits = 0;
num_per_sample = 6;

colours = linspecer(4);
set(0,'DefaultAxesColorOrder',colours)
% 
thresholds = [0:0.01:10];

% [corrects, negs] = tester(distances_mhd, imp_distances_mhd, thresholds, limits, num_per_sample);

[far, frr] = get_far_frr(corrects, negs, num_outliers)
%% Now for the clusters

thresholds = [0:0.025:20];
[corrects2, negs2] = tester(distances_centroid, imp_distances_centroid, thresholds, 1, num_per_sample); % threshold are the same
[far2, frr2] = get_far_frr(corrects2, negs2, num_outliers);


%% Now for the hamming

thresholds = [0:10:700];
thresholds = [thresholds 705:1:2500];
thresholds = [thresholds 2510:10:4000];
thresholds = [5000:10:30000];

% [corrects3, negs3] = tester(distances_hamming, imp_distances_hamming, thresholds, limits, num_per_sample);

[far3, frr3] = get_far_frr(corrects3, negs3, num_outliers);

%% Plot

figure
hold all
plot(far, frr, 'linewidth', 2);
plot(far2, frr2, 'linewidth', 2);
plot(far3, frr3, 'linewidth', 2);
ylabel ('False rejection rate')
xlabel ('False acceptance rate');
x = [0:0.01:100];
plot(x,x,'linewidth',2,'linestyle', '--');

legend({'MHD', 'Clusters', 'LBP', 'EER Line'});

scatter(far, frr, 25, colours(1,:), 'filled');
scatter(far2, frr2, 25, colours(2,:), 'filled');
scatter(far3, frr3, 25, colours(3,:), 'filled');

goodplot();

set(gca, 'XLim', [0 12]);
set(gca, 'YLim', [0 12]);
