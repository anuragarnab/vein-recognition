num_per_sample = 6;
limits = 0;
num_outliers = 7;

[c, n] = distribution_tester(distances_ulbp_chi, num_per_sample);
plot_pdf( c, n, 25, 200, ' ', 'Chi Square Distance', 'Relative Frequency', {'Genuine scores','Imposter scores'});

thresholds = [200:5:2000];

[corrects, negs] = tester(distances_ulbp_chi, imp_distances_ulbp_chi, thresholds, limits, num_per_sample);
plot_roc(corrects, negs, thresholds, num_outliers);
