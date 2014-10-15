% num_outliers = 13;
% limits = 0;
% num_per_sample = 6;
% 
colours = linspecer(8);
set(0,'DefaultAxesColorOrder',colours)

% % 
% thresholds = [0:0.01:10];
% 
% [corrects, negs] = tester(distances_mhd, imp_distances_mhd, thresholds, limits, num_per_sample);
% 
% [far, frr] = get_far_frr(corrects, negs, num_outliers);
% %% Now for the clusters
% 
% thresholds = [0:0.025:20];
% [corrects2, negs2] = tester(distances_centroid, imp_distances_centroid, thresholds, 1, num_per_sample); % threshold are the same
% [far2, frr2] = get_far_frr(corrects2, negs2, num_outliers);
% 
% 
% %% Now for the hamming
% 
% thresholds = [0:10:700];
% thresholds = [thresholds 705:1:2500];
% thresholds = [thresholds 2510:10:4000];
% thresholds = [5000:10:30000];
% 
% [corrects3, negs3] = tester(distances_hamming, imp_distances_hamming, thresholds, limits, num_per_sample);
% num_outliers = 7;
% [far3, frr3] = get_far_frr(corrects3, negs3, num_outliers);
% 
% %% Now for ulbp
% thresholds = [0:10:700];
% thresholds = [thresholds 705:1:1000];
% thresholds = [thresholds 1050:50:2000];
% [corrects4, negs4] = tester(distances_ulbp_chi, imp_distances_ulbp_chi, thresholds, limits, num_per_sample);
% [far4, frr4] = get_far_frr(corrects4, negs4, num_outliers);
% 
% 
% Now for Fourier LBP
% thresholds = [0:10:4000];
% thresholds = [0:10:23000];
% [corrects5, negs5] = tester(distances_fourier, imp_distances_fourier, thresholds, limits, num_per_sample);
% [far5, frr5] = get_far_frr(corrects5, negs5, num_outliers);
% 
% % Now for fusion of Fourier LBP, Canonical LBP and mhd
% %% corrects_fusion and correct_negs_fusion are already stored
% [far6, frr6] = get_far_frr(correct_fusion, correct_negs_fusion, num_outliers);

%% Now raw ULBP
thresholds = [0 600:5:2000 2050:50:20000];
[corrects7, negs7] = tester(distances_ulbp_chi_raw, imp_distances_ulbp_chi_raw, thresholds, limits, num_per_sample);
[far7, frr7] = get_far_frr(corrects7, negs7, num_outliers);

%% Plot

figure
hold all
plot(far4, frr4, 'linewidth', 2);
plot(far6, frr6, 'linewidth', 2);
plot(far7, frr7, 'linewidth', 2);
plot(far5, frr5, 'linewidth', 2);
plot(far, frr, 'linewidth', 2);
plot(far3, frr3, 'linewidth', 2);
plot(far2, frr2, 'linewidth', 2);

ylabel ('False rejection rate (FRR) [%]')
xlabel ('False acceptance rate (FAR) [%]');
x = [0:0.01:100];
plot(x,x,'linewidth',2,'linestyle', '--');

%legend({'MHD', 'Clusters', 'LBP', 'EER Line'});
legend({'Uniform LBP', 'SVM: Fourier LBP + Canonical LBP + MHD', 'Raw Uniform LBP', 'Fourier LBP', 'MHD', 'Canonical LBP', 'Cluster', 'EER Line'});

scatter(far4, frr4, 25, colours(1,:), 'filled');
scatter(far6, frr6, 25, colours(2,:), 'filled');
scatter(far7, frr7, 25, colours(3,:), 'filled');
scatter(far5, frr5, 25, colours(4,:), 'filled');
scatter(far, frr, 25, colours(5,:), 'filled');
scatter(far3, frr3, 25, colours(6,:), 'filled');
scatter(far2, frr2, 25, colours(7,:), 'filled');

goodplot();

set(gca, 'XLim', [0 15]);
set(gca, 'YLim', [0 15]);
